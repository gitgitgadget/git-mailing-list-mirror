From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 2/5] Name change: other -> commands.
Date: Thu, 27 Nov 2008 21:10:16 +0000
Message-ID: <492F0CB8.2080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5o9G-0004Uv-7u
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYK0VK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYK0VK0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:10:26 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:23072 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYK0VKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:10:21 -0500
Received: by ey-out-2122.google.com with SMTP id 6so505839eyi.37
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Bh5wHf3pCB5WTJ1ocuV5Nm72LA9046tpCkWgH1zcvpM=;
        b=A6HJG070vowohDJM55nnUmQRzVecuCINRrqVm7Ou2QDr6tRBMFDC0B8ZbI2Qee/GIz
         rO5LeZl1UJ01a5CUZZjvhYZY2HcHHf6YoQxInHvVgz+FTvrrlZf/cm3TiM/DAFTuB5nG
         rET4WhH/yv6Rh186FVrdlR2gpp0dOpVwOvGXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=VZqr/Y1dB0/xiGiTSmE581tnGLEKw7oD7OB+/81Uoehd53D/V7m9s/F2Xu3ph15l2X
         V3Wm7QMoqfFIQD3ZslLRvndBiFgT6DMcd4Dn0qg9n4hBkgEj0Isu2hW16jYiTv1u1Nbd
         8oLk5YJPBUK3lpBrp35MweqBlwYc5Fe93c7kY=
Received: by 10.210.49.19 with SMTP id w19mr7963216ebw.149.1227820219916;
        Thu, 27 Nov 2008 13:10:19 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id p10sm241072gvf.24.2008.11.27.13.10.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:10:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101826>



This name more accurately reflects the use of the variable.
---
  git-add--interactive.perl |   30 +++++++++++++++---------------
  1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 6e474d0..b530597 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -878,8 +878,8 @@ sub patch_update_file {
  	$ix = 0;

  	while (1) {
-		my ($prev, $next, $other, $undecided, $i);
-		$other = 'ynad';
+		my ($prev, $next, $commands, $undecided, $i);
+		$commands = 'ynad';

  		if ($num <= $ix) {
  			$ix = 0;
@@ -887,22 +887,22 @@ sub patch_update_file {
  		for ($i = 0; $i < $ix; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$prev = 1;
-				$other .= 'k';
+				$commands .= 'k';
  				last;
  			}
  		}
  		if ($ix) {
-			$other .= 'K';
+			$commands .= 'K';
  		}
  		for ($i = $ix + 1; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$next = 1;
-				$other .= 'j';
+				$commands .= 'j';
  				last;
  			}
  		}
  		if ($ix < $num - 1) {
-			$other .= 'J';
+			$commands .= 'J';
  		}
  		for ($i = 0; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
@@ -913,14 +913,14 @@ sub patch_update_file {
  		last if (!$undecided);

  		if (hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= 's';
+			$commands .= 's';
  		}
-		$other .= 'e?';
+		$commands .= 'e?';
  		for (@{$hunk[$ix]{DISPLAY}}) {
  			print;
  		}
  		print colored $prompt_color, "Stage this hunk [" .
-			 join (",", split( '', $other)) . "]? ";
+			 join (",", split( '', $commands)) . "]? ";
  		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
@@ -947,15 +947,15 @@ sub patch_update_file {
  				}
  				next;
  			}
-			elsif ($other =~ /K/ && $line =~ /^K/) {
+			elsif ($commands =~ /K/ && $line =~ /^K/) {
  				$ix--;
  				next;
  			}
-			elsif ($other =~ /J/ && $line =~ /^J/) {
+			elsif ($commands =~ /J/ && $line =~ /^J/) {
  				$ix++;
  				next;
  			}
-			elsif ($other =~ /k/ && $line =~ /^k/) {
+			elsif ($commands =~ /k/ && $line =~ /^k/) {
  				while (1) {
  					$ix--;
  					last if (!$ix ||
@@ -963,7 +963,7 @@ sub patch_update_file {
  				}
  				next;
  			}
-			elsif ($other =~ /j/ && $line =~ /^j/) {
+			elsif ($commands =~ /j/ && $line =~ /^j/) {
  				while (1) {
  					$ix++;
  					last if ($ix >= $num ||
@@ -971,7 +971,7 @@ sub patch_update_file {
  				}
  				next;
  			}
-			elsif ($other =~ /s/ && $line =~ /^s/) {
+			elsif ($commands =~ /s/ && $line =~ /^s/) {
  				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
  				if (1 < @split) {
  					print colored $header_color, "Split into ",
@@ -988,7 +988,7 @@ sub patch_update_file {
  				}
  			}
  			else {
-				help_patch_cmd($other);
+				help_patch_cmd($commands);
  				next;
  			}
  			# soft increment
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
