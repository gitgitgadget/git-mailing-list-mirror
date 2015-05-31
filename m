From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/9] send-email: fix style: cuddle 'elsif' and 'else' with closing brace
Date: Sun, 31 May 2015 18:29:26 -0400
Message-ID: <1433111371-19573-5-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkq-0005p2-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619AbbEaWak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:40 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35310 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542AbbEaWaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:22 -0400
Received: by igbyr2 with SMTP id yr2so49047201igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6sFY5/mR07NBDMYeRFF/0gHbyOUcsO0AVZhShZdD0oY=;
        b=ipc/wqT7iu8QJMY3Ctdy0low6dDQoed7wj8Hef+kbKmxOtbgGsZyW102ALgPpdTD9o
         WHIQX35yaW8yk1B3sKskwiX9mFFdpEH6LhPDl5ykCzHZGvQu6UYqBOqQiOevsYXi7n9R
         j8KXM0GEnWr7hZO7QH80mR5S7qMlxAfPomRDxpGpMoagRVR3XGULY3iM7ITeDMKxhAxK
         NQLA/+Hro2q3fU+od5FBRFyi3fZU3Ba9vwMMa3dW3y/cFFHXDVx9zKi+ErbTDHRqu2KA
         X+Fl7S+77xcfsOjbsP0kqOI3+dz3KuBg9Y78vocYDM5G0sob0pfAFD/oPHd8kX45/KLW
         thqw==
X-Received: by 10.107.133.154 with SMTP id p26mr22901195ioi.7.1433111421962;
        Sun, 31 May 2015 15:30:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.21
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270363>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-send-email.perl | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0b18682..1380e6e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -517,22 +517,15 @@ my %parse_alias = (
 		      } },
 
 	sendmail => sub { my $fh = shift; while (<$fh>) {
-		if (/^\s*(?:#.*)?$/) { }
-
-		elsif (/"/) {
+		if (/^\s*(?:#.*)?$/) {
+		} elsif (/"/) {
 			print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
-		}
-
-		elsif (/^\s|\\$/) {
+		} elsif (/^\s|\\$/) {
 			print STDERR "warning: sendmail continuation line is not supported: $_\n";
-		}
-
-		elsif (/^(\S+?)\s*:\s*(.+)$/) {
+		} elsif (/^(\S+?)\s*:\s*(.+)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$aliases{$alias} = [ split_addrs($addr) ];
-		}
-
-		else {
+		} else {
 			print STDERR "warning: sendmail line is not recognized: $_\n";
 		}}},
 
-- 
2.4.2.538.g5f4350e
