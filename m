From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/24] Show usage string for 'git imap-send -h'
Date: Mon,  9 Nov 2009 09:04:51 -0600
Message-ID: <1257779104-23884-11-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfA-0002nn-71
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbZKIOz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbZKIOz1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:27 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbZKIOzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:25 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nFszZoQIN4aoy8gDQtCzD+cjkJszcyyQ5MKEYQHKpZo=;
        b=L51eHY+gZQITYaNY2R+4cS5htTcpdq9cD2EDGGvMSKoyj2PMQ0OcSjR36Ioj3Vp0q8
         kjUiC3KcBm1LGzZmWLliTNrmexEwRFvq755SPrYQEas8FrMGc0J6ZJOY+T/YYKITjfqW
         BQ2yehUgcjqQ5Uu+kmiJcGoFKmevxV9LmH+SA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j7T/4FjnfS28AkqrXoLJQTr4SkZpQ53nPBBDBGY0pp5XzTG2r7eQsLQIKQnX/VC0KK
         V1eohp3fCPQQV6duVp+KCrtxwEyUv/9oYVNBI/wk65CHlg9P3XIy3OJpyaP1qpO2+R6M
         SclC6/XRzJoOkBRnAkR1J7mlEDRLT9O0KGOiU=
Received: by 10.216.87.206 with SMTP id y56mr2443418wee.207.1257778530171;
        Mon, 09 Nov 2009 06:55:30 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:29 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132470>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 imap-send.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..04e5374 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -93,6 +93,8 @@ struct msg_data {
 	unsigned int crlf:1;
 };
 
+static const char imap_send_usage[] = "git imap-send < <mbox>";
+
 #define DRV_OK          0
 #define DRV_MSG_BAD     -1
 #define DRV_BOX_BAD     -2
@@ -1491,6 +1493,9 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc != 1)
+		usage(imap_send_usage);
+
 	/* init the random number generator */
 	arc4_init();
 
-- 
1.6.5.2
