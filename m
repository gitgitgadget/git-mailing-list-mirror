Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7668D1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfGAUUa (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:30 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51357 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:30 -0400
Received: by mail-qk1-f202.google.com with SMTP id s25so14613479qkj.18
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jSQvFaYx8OknHgkQjx11dVbZwuTNKQ0OGKIEhOezOSc=;
        b=tcu32lbgfhr/V4kBI3vJYVa1WX42CwaqjjXPb49oDSYoufjlARA2XW9J/AYg/eSlM2
         H3Hz4e/EaZhUsMRdPt5OKCKi34Dzi1SEWVEL6F47boAxbAtgcOy3c09AAScTF2KniaAW
         ZbF9sgfWx7qyjxZA/BJXUW8vXf3tFUn8qAE3c9mFirv03FqIzmBKRDuG8TYtZ/OgI5Bh
         SmBMNaLYjnhJobO0KC/81ZZyemgRuhNL9FRQgxJwgbQ7KbqJMjEsarszbNr/LSR2whXq
         kaeS38hWwMkIFFa+zKpTmvarAE8yQmhw2iG/MGCIbT7H/CepMMIR5O+L9IuB5TvjMcVC
         TkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jSQvFaYx8OknHgkQjx11dVbZwuTNKQ0OGKIEhOezOSc=;
        b=CZF1zOIKoeihhhbLGsmEHDi0a7Ee3dCRea43UEnKXH1felL7Mn0h12hHcixJ21MT6G
         ix9yTI6Yw67DhNMPe8WN9ZA26WekgroZdZ3TDB58IHTUL9XeHq/VtItPwT3bQIoLnlGo
         pSb5xXdzwB2jveNYrHJsj2I82RWgkUVS2xguklPw47pelesSuWKNL0x1l7b/+W1FPPtg
         fCJDjl1Bk9QYSrO+zPfisHAgloge2KfcWOKciYO097y2FWbOpsOSM0DnBgeLdl03JYNN
         tmlkJXgP8CKFOGIgGcvpy9dwo8SjCzwjP8x77ARHUwJ9MBHu5zOVego3sjRaVP9CrPaK
         6y6A==
X-Gm-Message-State: APjAAAXjYPqDl1Lx7uORnVll8iM++6hgSv9EhYgg3u3HjybLoMrUn8iX
        A4khL+sLq+VpEaDrhIwgdLEvC3HaI8hJTCU+EGkMWFsLCTG8eNa0JDP4JElobP3SFrFQwhVeh0C
        E9ASPAUpArRRQTOsICJQNzPbtJdY3uyc6JzpqdQCWG2gss6yxa8beDpZjojsM5vzAMw14A100qA
        ==
X-Google-Smtp-Source: APXvYqx7DwHpPTRbgX31B1k0sEHUL987WqrHykXif3uEoKBPdReguVa0CRecElvOs92vxM9D5/mX7UM6wShztCl/TSU=
X-Received: by 2002:a37:c45:: with SMTP id 66mr22014245qkm.31.1562012429511;
 Mon, 01 Jul 2019 13:20:29 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:04 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 03/13] walken: add placeholder to initialize defaults
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventually, we will want a good place to initialize default variables
for use during our revision walk(s) in `git walken`. For now, there's
nothing to do here, but let's add the scaffolding so that it's easy to
tell where to put the setup later on.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index dd55f3b350..19657b5e31 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -8,6 +8,19 @@
 #include "parse-options.h"
 
 
+/*
+ * Within init_walken_defaults() we can call into other useful defaults to set
+ * in the global scope or on the_repository. It's okay to borrow from other
+ * functions which are doing something relatively similar to yours.
+ */
+static void init_walken_defaults(void)
+{
+	/*
+	 * We don't actually need the same components `git log` does; leave this
+	 * empty for now.
+	 */
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	/*
@@ -29,6 +42,8 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
 
+	init_walken_defaults();
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

