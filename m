From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 30/34] mailinfo: move definition of MAX_HDR_PARSED closer to its use
Date: Mon, 19 Oct 2015 00:28:47 -0700
Message-ID: <1445239731-10677-31-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tA-0002y8-MS
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbJSH3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:45 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35109 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbJSH3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:30 -0400
Received: by pasz6 with SMTP id z6so22269636pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=43+Ws6RTcvcTdiecO6L3Bpkn17t+NJh2e2Bf0NS4gyU=;
        b=Vs7e5Cz9RJDk9JDqxomzNf6luwzJIblO/DoYU0622doFHA13/u7w9SvDTnwUNUoKkO
         9lf9dloT5ZNOAVAoQw4t0wfaXaU+t3R+FiQRiocQt5SaWckjAXO7Q0MXTHrqseGINLjN
         xKv1ZPmKUwqiDs2K/ouQjuOSnT8zIyMRg1/2nNEKGiIiCfsM4AjQWSLU/yWKB6C0Yj89
         OSqq8jCLb44VJGgXxwWencJvf6krtdv6FuKr+njbzB2RIePpwGtwz2gIdsMdSv76HsJj
         nyAVnmD1q3zH5T0o7ZFa2jS4OdTe5aTDFEt+AFfMW61sDryxVwMCf5NO+UH0JARouFg6
         Cz6A==
X-Received: by 10.66.97.102 with SMTP id dz6mr33755162pab.29.1445239770175;
        Mon, 19 Oct 2015 00:29:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id st5sm34888409pab.42.2015.10.19.00.29.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:29 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279847>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 104d3d9..4eabc11 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -39,8 +39,6 @@ struct mailinfo {
 	struct strbuf log_message;
 };
 
-#define MAX_HDR_PARSED 10
-
 static void cleanup_space(struct strbuf *sb)
 {
 	size_t pos, cnt;
@@ -290,6 +288,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 	strbuf_trim(subject);
 }
 
+#define MAX_HDR_PARSED 10
 static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
-- 
2.6.2-383-g144b2e6
