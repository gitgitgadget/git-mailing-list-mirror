From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/9] send-email: drop noise comments which merely repeat what code says
Date: Sun, 31 May 2015 18:29:25 -0400
Message-ID: <1433111371-19573-4-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkY-0005cM-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559AbbEaWa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:27 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37374 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758528AbbEaWaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:21 -0400
Received: by igbsb11 with SMTP id sb11so49076267igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cvca8tU/daAfcPe5GVRG3/5JkIERyQRNlHXN4LA1vL8=;
        b=0otGoB/dy1QzFnojiRormvXYo197xgn7uKRMGj+4cE9i4t5BJsGHh8jAexCE1DNiQH
         5ZC225yUJZc7q02mrMWT5Ro2nRd3R0MN1PoIRHC9pQKSvB6UF4OHDYG5lcSZN7NDCqd6
         Ak5w9jz1wU1oomeL4UbCMwfxZdQ7f+LvYwLxCJ92Hbskr2y7eZSDnAV9bNIqh9HxEeYE
         yhn3ojQ2oot0JNgn+oQwUXNl5Zzo2GpuYtx/+1sz771EQEnAU5cq/ktEyGxu7jBkx5kS
         r5extfWMXDR/dZI8RY/3AOY/ibvcTN2DQTN+RN8R6RIy02C9NPL4E4L2sYuoumRZQWDs
         tqqw==
X-Received: by 10.107.47.224 with SMTP id v93mr13259076iov.86.1433111421160;
        Sun, 31 May 2015 15:30:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.20
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270357>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-send-email.perl | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 819f87e..0b18682 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -517,26 +517,21 @@ my %parse_alias = (
 		      } },
 
 	sendmail => sub { my $fh = shift; while (<$fh>) {
-		# ignore blank lines and comment lines
 		if (/^\s*(?:#.*)?$/) { }
 
-		# warn on lines that contain quotes
 		elsif (/"/) {
 			print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
 		}
 
-		# warn on lines that continue
 		elsif (/^\s|\\$/) {
 			print STDERR "warning: sendmail continuation line is not supported: $_\n";
 		}
 
-		# recognize lines that look like an alias
 		elsif (/^(\S+?)\s*:\s*(.+)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$aliases{$alias} = [ split_addrs($addr) ];
 		}
 
-		# warn on lines that are not recognized
 		else {
 			print STDERR "warning: sendmail line is not recognized: $_\n";
 		}}},
-- 
2.4.2.538.g5f4350e
