From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/3] daemon.c: added upload-tar service
Date: Thu, 31 Aug 2006 14:35:22 +0200
Message-ID: <11570277232250-git-send-email-vagabon.xyz@gmail.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 31 14:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIllb-0003S9-U7
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWHaMfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWHaMf3
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:35:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51562 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932076AbWHaMf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 08:35:27 -0400
Received: by nf-out-0910.google.com with SMTP id x30so387462nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 05:35:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MPt71qxr/H+iWew4lbx14Al3wrgmEy1ia8PjFIzRZBrV4Qk0kW1mJ/S+aNFOYh+L+g0ZjKpB9/LG1syVm1x26cFUio1z73xNEzQ3cII8b4EWGVSi9KH1o8+2jhbmsSWv/yzBHu2dWk+9ahjGy2/8nskNr2UxE5OM46TKoqnsF8E=
Received: by 10.49.29.3 with SMTP id g3mr1256112nfj;
        Thu, 31 Aug 2006 05:35:25 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k9sm1559483nfc.2006.08.31.05.35.23;
        Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id D075B23F76F; Thu, 31 Aug 2006 14:35:23 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26258>

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 daemon.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index ed3a13d..381e6ae 100644
--- a/daemon.c
+++ b/daemon.c
@@ -247,6 +247,12 @@ static int service_upload_pack(const cha
 	return -1;
 }
 
+static int service_upload_tar(const char *dir, const char *args)
+{
+	execl_git_cmd("upload-tar", dir, NULL);
+	return -1;
+}
+
 /* service options */
 #define NEED_REPO	(1<<0)
 
@@ -258,6 +264,7 @@ struct service_info {
 
 static struct service_info services[] = {
 	{ "git-upload-pack", service_upload_pack, NEED_REPO },
+	{ "git-upload-tar", service_upload_tar, NEED_REPO },
 };
 
 static int run_service(char *cmdline)
-- 
1.4.2
