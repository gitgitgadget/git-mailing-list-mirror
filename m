From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/8] merge: rename variable
Date: Tue, 11 May 2010 01:17:48 +0800
Message-ID: <1273511872-4924-5-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWcz-0007lB-Eb
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab0EJRS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:26 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42956 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab0EJRSW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:22 -0400
Received: by mail-px0-f174.google.com with SMTP id 5so1761347pxi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Wt1muXKXAL7uVsDWAr7CSYwsrVByJSDWEJzAB6iBNrQ=;
        b=edHLWqMt3VbDLjlRw213c28VQqPE3/FT2OhCG0W+Xhi7yeG9EGZDNLx6cXZyd0knK9
         8YrzpQ5tX4fRrA0qCK+E+Cg3N/uoQVAtS9TL0TvhaTkOb+o0bQaPYgylv21Kt2JfDAg9
         oKnE09PGwMB2aRdt0YUCaoOlIZetFvqGrCpac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=keX8C8PWJPUt/ZoRhy4XQOWoFg8z/yf1sM/vPx/c1pYtW7EafA33XiPzvMT/7mRcY4
         pQ31swA5RRnBlPoYmhgxCiPTO/GBo85gJKp6fhb/26OeGcy7L82evDZplKOFMmwQHUc+
         MXiwAc+iOHVIIG4fCdNlTfDjztocMgXaek9Zg=
Received: by 10.114.22.6 with SMTP id 6mr3377428wav.177.1273511902096;
        Mon, 10 May 2010 10:18:22 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146837>

It is more accurate to call it 'merge_names' instead of 'msg', as it
does not contain the final message.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/merge.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c2691e8..bc7e5e7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -982,7 +982,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		reset_hard(remote_head->sha1, 0);
 		return 0;
 	} else {
-		struct strbuf msg = STRBUF_INIT;
+		struct strbuf merge_names = STRBUF_INIT;
 
 		/* We are invoked directly as the first-class UI. */
 		head_arg = "HEAD";
@@ -997,8 +997,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		if (!have_message) {
 			for (i = 0; i < argc; i++)
-				merge_name(argv[i], &msg);
-			fmt_merge_msg(option_log, &msg, &merge_msg);
+				merge_name(argv[i], &merge_names);
+			fmt_merge_msg(option_log, &merge_names, &merge_msg);
 			if (merge_msg.len)
 				strbuf_setlen(&merge_msg, merge_msg.len-1);
 		}
-- 
1.7.1.189.g07419
