From: larsxschneider@gmail.com
Subject: [PATCH v6 2/4] rename git_config_from_buf to git_config_from_mem
Date: Fri, 19 Feb 2016 10:16:00 +0100
Message-ID: <1455873362-66998-3-git-send-email-larsxschneider@gmail.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 10:16:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhAv-0004kV-I4
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948528AbcBSJQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 04:16:22 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34996 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948519AbcBSJQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:16:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id c200so65814971wme.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WBnwLLImqeFzYkxa3oDPDVhHauqBymav0kYaPNW8mw=;
        b=0n8VDlCyIbtn/VkshW/qaljvUbfCBojsgeswOqclek/OpR/JvuQ0jwCTGTW+WpjSff
         /d4SvpervcumYt7oa0Kts7yVox0EsQq9HRUiKvckdk2MjdfIYzk0xaC/8zBmX75G8NgS
         krIGnfP/S4o4QibYM/BpPhLRpEdSFF08NRhE0Lft+SUtxW+Udvt4geKkk6A2HWF9IOd6
         NJS6XHhsAPdQHP5m2d8BP5zAdJDPZAenreEVTDc8EgJk1Sgrseq1kp7dGVnRiDKz+6bB
         E6YrVPZe/XfiyPLAvWbgfquHyEJmg8rqsAROCC/Lq2MA4KAVfKi/FLbwUv73UHpnLvCb
         FIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WBnwLLImqeFzYkxa3oDPDVhHauqBymav0kYaPNW8mw=;
        b=E2ezsKJ98KzroiJjRLwBRICc0NhNWQkqH9nSprjTxuuunt/7Y3qXyGEpJ1747M9AIi
         8TNvhFn5Iw66kfYxqd9Tsc7bxCfkHDxkrv9cOx4NTq80dNYWnD5LsOGLMvARrSi3aB9k
         7YcAFnvIyzPs9VHbMw37RVX0mXyWSRlQ6SeEXqm6pHTYAF2fdyOXqtsEuzcLZ1RMGhxY
         wNH0KibMKzewdBP8vVLBOWwbys4rrSkPRO142OXwX6bmWdeBKe67eS/kFbsOZYHfDssq
         qu+0WvRqqI7NXLPv4WK3tcic5NMcoP56PUmTT1pvO/s32+U/WOCxGcqgPbWJaQUuJM4c
         FcsA==
X-Gm-Message-State: AG10YOSCGkV4b8RmurKORpWohm/WK05yvEJBbmJoV7GiXBTs+DPxqyyy3LXEoo1e1OFWfg==
X-Received: by 10.194.189.7 with SMTP id ge7mr11902225wjc.72.1455873367842;
        Fri, 19 Feb 2016 01:16:07 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB455F.dip0.t-ipconnect.de. [93.219.69.95])
        by smtp.gmail.com with ESMTPSA id ks5sm10301204wjb.13.2016.02.19.01.16.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 01:16:07 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286674>

From: Lars Schneider <larsxschneider@gmail.com>

This matches the naming used in the index_{fd,mem,...} functions.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 cache.h            | 2 +-
 config.c           | 4 ++--
 submodule-config.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index c63fcc1..6679bb4 100644
--- a/cache.h
+++ b/cache.h
@@ -1485,7 +1485,7 @@ struct git_config_source {
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_buf(config_fn_t fn, const char *name,
+extern int git_config_from_mem(config_fn_t fn, const char *name,
 			       const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
diff --git a/config.c b/config.c
index 86a5eb2..36b0ddb 100644
--- a/config.c
+++ b/config.c
@@ -1096,7 +1096,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return ret;
 }
 
-int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
+int git_config_from_mem(config_fn_t fn, const char *name, const char *buf,
 			size_t len, void *data)
 {
 	struct config_source top;
@@ -1132,7 +1132,7 @@ static int git_config_from_blob_sha1(config_fn_t fn,
 		return error("reference '%s' does not point to a blob", name);
 	}
 
-	ret = git_config_from_buf(fn, name, buf, size, data);
+	ret = git_config_from_mem(fn, name, buf, size, data);
 	free(buf);
 
 	return ret;
diff --git a/submodule-config.c b/submodule-config.c
index fe8ceab..b85a937 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -427,7 +427,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_buf(parse_config, rev.buf, config, config_size,
+	git_config_from_mem(parse_config, rev.buf, config, config_size,
 			&parameter);
 	free(config);
 
-- 
2.5.1
