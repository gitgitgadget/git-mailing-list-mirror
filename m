From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Use xstrdup instead of strdup in builtin-{tar,zip}-tree.c
Date: Sun, 10 Sep 2006 18:10:01 +0200
Message-ID: <450438D9.4000706@lsrfire.ath.cx>
References: <450019C3.4030001@innova-card.com>	<11576347252834-git-send-email-vagabon.xyz@gmail.com>	<4501D0CF.70306@lsrfire.ath.cx>	<7vlkouf32i.fsf@assigned-by-dhcp.cox.net>	<7vk64derfd.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609090810t6fdab535r761636e65205a0f@mail.gmail.com> <7v8xksx1ww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 18:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMRts-0002mv-Te
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 18:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWIJQKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 12:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWIJQKV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 12:10:21 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:3795
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932281AbWIJQKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 12:10:18 -0400
Received: from [10.0.1.3] (p508E47B2.dip.t-dialin.net [80.142.71.178])
	by neapel230.server4you.de (Postfix) with ESMTP id 1944F12276;
	Sun, 10 Sep 2006 18:10:09 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xksx1ww.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26800>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This patch applies to the current 'next' branch.

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index c20eb0e..e8e492f 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -390,7 +390,7 @@ int write_tar_archive(struct archiver_ar
 		write_global_extended_header(args->commit_sha1);
 
 	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
-		char *base = strdup(args->base);
+		char *base = xstrdup(args->base);
 		int baselen = strlen(base);
 
 		while (baselen > 0 && base[baselen - 1] == '/')
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index 4e79633..fdac2bd 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -363,7 +363,7 @@ int write_zip_archive(struct archiver_ar
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
 
 	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
-		char *base = strdup(args->base);
+		char *base = xstrdup(args->base);
 		int baselen = strlen(base);
 
 		while (baselen > 0 && base[baselen - 1] == '/')
