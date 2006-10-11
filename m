From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Fix zebra coloring flip introduced by eeef88cd2
Date: Tue, 10 Oct 2006 19:09:03 -0700 (PDT)
Message-ID: <20061011020903.63831.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 11 04:10:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXTXe-0006JM-Dy
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 04:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWJKCJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 22:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWJKCJF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 22:09:05 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:15444 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932140AbWJKCJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 22:09:04 -0400
Received: (qmail 63833 invoked by uid 60001); 11 Oct 2006 02:09:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZWjYCB7CMeiIuY+Jhlny0fFf4yrhGnHBQe4VC3HV18XxFmo/kKSLwA2KljYAIR9Iv5aHeicNxhZETAXaEbrEIm72s7iFu239C4vPQggA3gZLk8dv/i/E9FWOfYUMdq6ceTpi+MTDkkJry/IwYtAkVE9/f3fYeHIjKySntxiwORw=  ;
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 19:09:03 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28690>

Commit eeef88cd2 introduced $group_size which
inverted the meaning of $current_color.

Normally we start with white (same as background) color
for the zebra coloring, and flip to dark shade only when
another commit changed some lines of the file.  (Thus
if there are no changes, the file appears black on white.)

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 173f521..77063f0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2583,7 +2583,7 @@ sub git_blame2 {
 	git_print_page_path($file_name, $ftype, $hash_base);
 	my @rev_color = (qw(light2 dark2));
 	my $num_colors = scalar(@rev_color);
-	my $current_color = 0;
+	my $current_color = 1;
 	my $last_rev;
 	print <<HTML;
 <div class="page_body">
-- 
1.4.3.rc2.gd2a59
