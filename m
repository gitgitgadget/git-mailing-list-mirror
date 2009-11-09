From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/24] Show usage string for 'git stripspace -h'
Date: Mon,  9 Nov 2009 09:04:57 -0600
Message-ID: <1257779104-23884-17-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vfw-0003Gv-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058AbZKIO4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756055AbZKIO4s
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:56:48 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:34957 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbZKIO4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:56:47 -0500
Received: by ewy3 with SMTP id 3so3181481ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=946wQ/aJ1wStwsiBhfuTgV5vy/de6i5Mm2ZN6KBWATc=;
        b=lHveuyA6b2iiyR2jCgpEMjepIK+0UKOmidFBGdGDDsMlmDht+7KOWEIN/OCDx6iB74
         1gwXTPHMXPQlTQ6Eo7Nb3LolvmkAQ/QAzI8iAcU908c4UW3/3F6C66NKr8Nml+ad/HzN
         Ph4KildJ6ywPyXxA5TOZ1Vw2St4ql+u9mxChU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UR/xJuZswCOhTNbhn6gIX+UWDWPXlp8X2EFweiOzZOGdtVp/Am26k+9ZVsPPzXZpYd
         +7wtvLmn1LV2j3DKzX0btMSHBDYmxTktlZ9lD4fUrZh24mAOu1C2hSHMP9XriWX+TuTo
         E9gbjv6kf4wBMnF/eLqgaJun86BB4sXD+xUgA=
Received: by 10.216.87.132 with SMTP id y4mr690231wee.99.1257778543740;
        Mon, 09 Nov 2009 06:55:43 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:43 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132486>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-stripspace.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 1fd2205..4d3b93f 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -73,9 +73,11 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int strip_comments = 0;
 
-	if (argc > 1 && (!strcmp(argv[1], "-s") ||
+	if (argc == 2 && (!strcmp(argv[1], "-s") ||
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments = 1;
+	else if (argc > 1)
+		usage("git stripspace [-s | --strip-comments] < <stream>");
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
-- 
1.6.5.2
