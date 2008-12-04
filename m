From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch[PATCH 1/2]
Date: Thu, 04 Dec 2008 10:43:34 +0000
Message-ID: <4937B456.7080604@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com> <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE63.209@gmail.com> <7vd4g8alp7.fsf@gitster.siamese.dyndns.org> <49377ED8.4050905@gmail.com> <7vvdu0e38a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 11:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8BiA-0000s1-OM
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 11:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbYLDKnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 05:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbYLDKnm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 05:43:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:18578 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbYLDKnk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 05:43:40 -0500
Received: by nf-out-0910.google.com with SMTP id d3so2074950nfc.21
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=qnFm8S/wbRanhvaOiQqPYtIGcy+UAG0Bny8VuthyCb8=;
        b=bFe1UHF5kIArJMIlQzAfgu7pOGAGp9MqkNnX95GlqFLGtHmxtEGg9RMv7vI292KKYR
         uqqk6/t4u5EMxJgbNVTQP4uJO7puJS33HHJHVY+AwlwfYq4Wc8XBaj6exXFWyqOWaZ4X
         GgLhH4SO4kRNcJtova3hSMLT/fVxcIYXqKTYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AYv5Ivs+pmTvloqQyCukx7kjcRpQLiL+5zFEqGE+V46Ocyqa3SzgPXwSiv6m2FwNc5
         F5K5P940JzBH34QvUrNXH5KgiKTrmFstvm6kRrUfYX9HhszhravN44FDSxGqvPL/ktyB
         8NPgCpNKh1JeKR+/AdYyuUdodA1RSLteldT8Y=
Received: by 10.210.54.17 with SMTP id c17mr13552679eba.132.1228387418422;
        Thu, 04 Dec 2008 02:43:38 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id q9sm614116gve.30.2008.12.04.02.43.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 02:43:37 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7vvdu0e38a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102336>

Junio C Hamano wrote:
> William Pursell <bill.pursell@gmail.com> writes:
> 
>>> How well does substr() work with utf-8 and other multi-byte encodings
>>> these days, I have to wonder...
>> Hopefully, it works well.
> 
> "Hopefully" is the last word I'd like to hear from submitters.  It would
> be either "I do not know" or "I studied the topic and I know the code works".

Right.  From what I can tell (30 minutes of research, and I
am by no means an expert), perl 5.8 will handle this just
fine with no changes to the code as long as one of the
environment variables LANGUAGE, LC_ALL, LC_TYPE, or LANG
contains either 'UTF-8' or 'UTF8'.  With that setting,
all file handles will be opened in UTF8 mode, so the
git diff-files pipe should be parsed appropriately.
I think this is not an issue except with older Perl.

> By the way, I noticed that you are sending your patches with:
> 
>     Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> Please don't.  format=flawed tends to destroy whitespaces (I fixed them up
> by hand for the ones I parked in 'pu').

Thanks for pointing that out.  Settings changed.  I do appreciate
you taking the time to essentially hold my hand through this
process, and hope that I'm not causing you too much extra work.

> I would say "$line =~ /^[-+].*\w/" (i.e. match any +/- line that contains
> a word letter) would be sufficient, and it would be much easier to read.
> 
> As you append the entire $line to $summary, there is no need to capture
> with ().

Done.

> 
> I think "$i ||= 0" is more customary.
> 
Also changed.


>From 2d191d7170948246007cbde5afb28eeb666b3427 Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Thu, 4 Dec 2008 10:00:24 +0000
Subject: [PATCH 1/2] Add subroutine to display one-line summary of hunks.

This commit implements a rather simple-minded mechanism
to display a one-line summary of the hunks in an array ref.
The display consists of the line numbers and the first
changed line, truncated to 80 characters.  20 lines are
displayed at a time, and the index of the first undisplayed
line is returned, allowing the caller to display more if
desired.  (The 20 and 80 should be made configurable.)

Signed-off-by: William Pursell <bill.pursell@gmail.com>

---
changes from v1:
  do not print '@@' characters in summary
  pad line numbers in summary to 20 chars to help alignment
  only accept diff lines with a non-space, non-bracket character
  ensure a newline appears on a trimmed line
changes from v2:
  accept any line with a word char (instead of insisting on non-bracket)
  use "$i || = 0" instead of "$i = 0 if not $i"

 git-add--interactive.perl |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..eb11132 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -836,6 +836,47 @@ sub patch_update_cmd {
 	}
 }

+# Generate a one line summary of a hunk.
+sub summarize_hunk {
+	my $rhunk = shift;
+	my $summary = $rhunk->{TEXT}[0];
+
+	# Keep the line numbers, discard extra context.
+	$summary =~ s/@@(.*?)@@.*/$1 /s;
+	$summary .= " " x (20 - length $summary);
+
+	# Add some user context.
+	for my $line (@{$rhunk->{TEXT}}) {
+		if ($line =~ m/^[+-].*\w/) {
+			$summary .= $line;
+			last;
+		}
+	}
+
+	chomp $summary;
+	return substr($summary, 0, 80) . "\n";
+}
+
+
+# Print a one-line summary of each hunk in the array ref in
+# the first argument, starting wih the index in the 2nd.
+sub display_hunks {
+	my ($hunks, $i) = @_;
+	my $ctr = 0;
+	$i ||= 0;
+	for (; $i < @$hunks && $ctr < 20; $i++, $ctr++) {
+		my $status = " ";
+		if (defined $hunks->[$i]{USE}) {
+			$status = $hunks->[$i]{USE} ? "+" : "-";
+		}
+		printf "%s%2d: %s",
+			$status,
+			$i + 1,
+			summarize_hunk($hunks->[$i]);
+	}
+	return $i;
+}
+
 sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
-- 
1.6.1.rc1.37.g83daf.dirty


-- 
William Pursell
