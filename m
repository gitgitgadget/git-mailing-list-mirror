X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Remove --syslog in git-daemon inetd documentation examples.
Date: Thu, 26 Oct 2006 06:33:07 +0200
Message-ID: <20061026063307.45872277.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 04:26:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30138>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcwop-000495-HS for gcvg-git@gmane.org; Thu, 26 Oct
 2006 06:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422909AbWJZE0K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 00:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423397AbWJZE0K
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 00:26:10 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:34007 "EHLO
 smtp2-g19.free.fr") by vger.kernel.org with ESMTP id S1422909AbWJZE0I (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 00:26:08 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net
 [82.243.130.161]) by smtp2-g19.free.fr (Postfix) with SMTP id 404A275D5B;
 Thu, 26 Oct 2006 06:26:07 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

It is useless because --inetd implies --syslog.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/everyday.txt   |    4 ++--
 Documentation/git-daemon.txt |    6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index b935c18..f1b2265 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -377,7 +377,7 @@ Run git-daemon to serve /pub/scm from in
 ------------
 $ grep git /etc/inetd.conf
 git	stream	tcp	nowait	nobody \
-  /usr/bin/git-daemon git-daemon --inetd --syslog --export-all /pub/scm
+  /usr/bin/git-daemon git-daemon --inetd --export-all /pub/scm
 ------------
 +
 The actual configuration line should be on one line.
@@ -397,7 +397,7 @@ service git
         wait            = no
         user            = nobody
         server          = /usr/bin/git-daemon
-        server_args     = --inetd --syslog --export-all --base-path=/pub/scm
+        server_args     = --inetd --export-all --base-path=/pub/scm
         log_on_failure  += USERID
 }
 ------------
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index d562232..4b2ea2d 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -165,8 +165,7 @@ git-daemon as inetd server::
 +
 ------------------------------------------------
 	git stream tcp nowait nobody  /usr/bin/git-daemon
-		git-daemon --inetd --verbose
-		--syslog --export-all
+		git-daemon --inetd --verbose --export-all
 		/pub/foo /pub/bar
 ------------------------------------------------
 
@@ -179,8 +178,7 @@ git-daemon as inetd server for virtual h
 +
 ------------------------------------------------
 	git stream tcp nowait nobody /usr/bin/git-daemon
-		git-daemon --inetd --verbose
-		--syslog --export-all
+		git-daemon --inetd --verbose --export-all
 		--interpolated-path=/pub/%H%D
 		/pub/www.example.org/software
 		/pub/www.example.com/software
-- 
