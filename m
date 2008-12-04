From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch[PATCH 2/2]
Date: Thu, 04 Dec 2008 10:43:40 +0000
Message-ID: <4937B45C.1080801@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com> <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE68.6030009@gmail.com> <7v4p1kalno.fsf@gitster.siamese.dyndns.org> <49377F25.9020005@gmail.com> <7vljuwe2na.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 11:45:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8BiB-0000s1-Ku
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 11:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbYLDKns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 05:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbYLDKnr
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 05:43:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:30544 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737AbYLDKnq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 05:43:46 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1697176eyi.37
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 02:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+/yCL+I75CmojVBjFmuTpGZ9FVGVcBqlJdP7V122IK4=;
        b=rGMXiHScM6Z1WjqxB6PreIivZIYrrAm5mCnqs9IBE9Ha+gs5uTwdQkK3MbXOI0D31u
         ol8YY8rlFf3tmte50/xxGm8YJbK6lm0fwTcq2of69KTqCa01GGzP7NuV/AOa0/dhbGiE
         KUw7BKfxkmJqvBtHpZLcZW6usCu1vsvppxDxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aTAYjGGyTLiHqgZcR2JDZ4eAldMULd/A07mt25jT19WiDuusoLZCoAR11LveHTPlAq
         QqQKnlvce5Ihrrq7Big5avSsBr54hCXISZkjtGhJmsLYhDPy3Z6SXpiPGuRhUNVmTbJN
         sUXs9v3wjQiHKkXbAI/1pd5b8slEU7YtZC1pk=
Received: by 10.210.127.10 with SMTP id z10mr16396233ebc.195.1228387424192;
        Thu, 04 Dec 2008 02:43:44 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id t12sm7325562gvd.1.2008.12.04.02.43.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 02:43:42 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7vljuwe2na.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102335>

Junio C Hamano wrote:
> William Pursell <bill.pursell@gmail.com> writes:

>> Signed-off-by: William Pursell <bill.pursell@gmail.com>
>> ---
> 
> It is customary to explain what you changed since v1 here, after the
> three-dash separator, to help reviewers.

Thanks for pointing that out.

>> +			elsif ($other =~ 'g' && $line =~ /^g(.*)/) {
> 
> I think I fixed this with ($other =~ /g/ && ...) when I queued your
> previous round to 'pu' tonight.

I didn't notice that the first time around.  Fixed here.
> 
>> +				my $response = $1;
>> +				my $i = $ix > 10 ? $ix - 10 : 0;
> 
> This is different from v1.  I understand the motivation (i.e. if you are
> at 73rd hunk of a 100-hunk series, showing hunks 63-83 instead of starting
> from hunk 1-10 would be nicer), but that is something to explain as one of
> the "changes since v1".
> 
> I think you are inside a loop that is controlled by another $i (see the
> context in the hunk before this one) and it would be better to use
> different variable, such as $hunk_no (or just $no).

Agreed.  Masking enclosing variables is a no-no.


>From 03ae1932337c15cdd20e0d8370782a6343efc5aa Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Thu, 4 Dec 2008 10:22:40 +0000
Subject: [PATCH 2/2] Add 'g' command to go to a hunk.

When a minor change is made while the working directory is in a bit
of a mess,  it is somewhat difficult to wade through all of the
hunks using git add --patch.  This allows one to jump to the hunk
that needs to be staged without having to respond 'n' to each
preceding hunk.

Signed-off-by: William Pursell <bill.pursell@gmail.com>

---
changes since v1:
  start the summary list from current hunk - 10 rather than 0
  replace a statement modifier with a conditional block, for readability
  clean up the prompt, so "(<ret> to see more)" appears before '?'
  allow trailing whitespace in the user response
changes since v2:
  s/goto/go to/
  s|=~ 'g'|=~ /g/|
  change loop index name from $i to $no, as $i masks a name in the enclosing
    scope


 git-add--interactive.perl |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index eb11132..ca60356 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -800,6 +800,7 @@ y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks in the file
 d - do not stage this hunk nor any of the remaining hunks in the file
+g - select a hunk to go to
 j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
@@ -945,6 +946,9 @@ sub patch_update_file {
 		if ($ix < $num - 1) {
 			$other .= '/J';
 		}
+		if ($num > 1) {
+			$other .= '/g';
+		}
 		for ($i = 0; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$undecided = 1;
@@ -978,6 +982,28 @@ sub patch_update_file {
 				}
 				next;
 			}
+			elsif ($other =~ /g/ && $line =~ /^g(.*)/) {
+				my $response = $1;
+				my $no = $ix > 10 ? $ix - 10 : 0;
+				while ($response eq '') {
+					my $extra = "";
+					$no = display_hunks(\@hunk, $no);
+					if ($no < $num) {
+						$extra = " (<ret> to see more)";
+					}
+					print "go to which hunk$extra? ";
+					$response = <STDIN>;
+					chomp $response;
+				}
+				if ($response !~ /^\s*\d+\s*$/) {
+					print STDERR "Invalid number: '$response'\n";
+				} elsif (0 < $response && $response <= $num) {
+					$ix = $response - 1;
+				} else {
+					print STDERR "Sorry, only $num hunks available.\n";
+				}
+				next;
+			}
 			elsif ($line =~ /^d/i) {
 				while ($ix < $num) {
 					if (!defined $hunk[$ix]{USE}) {
-- 
1.6.1.rc1.37.g83daf.dirty




-- 
William Pursell
