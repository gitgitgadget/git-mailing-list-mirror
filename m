Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23601F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeHPVTy (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:19:54 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:56379 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeHPVTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:19:54 -0400
Received: by mail-ua1-f74.google.com with SMTP id u26-v6so2302770uan.23
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qTuJCp4pvr6LvjyRCqv81/wSYcBckvQ26shcvNITf4M=;
        b=G9ZHJLEF5qZK5V8u9zNZ/oGxv0MX72mxAOtZbyVWFQW+uvFtnwDhE2gd3n0EYJk1/o
         l8UK/sW2y8Fx6sG78NPFa7OZUQu8lnrOGHO3ahGpnG/fKuHVlLrJE8QzoLpHHf+D6UiN
         0ve8DvPm2TkYe0VVVYb84ABI5R3QPfIrozQqz9Jqcjdm70Cd8jYihM9LUngH54uios3A
         mg71tQ7V3JGqGKcrCpqd0QOuKIo9OUo6UACmfgIewyBwwa18FeXQ6ZdJWftaccQLcqan
         hoXAO7Mh6lUJsFoXxbSTLN7KmvKwxMQwFLavqlqUDo0IyDpTjrRfbiN0jNB5WbcMZQbZ
         7bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qTuJCp4pvr6LvjyRCqv81/wSYcBckvQ26shcvNITf4M=;
        b=sHP/pCq9hoionWlGymG3hI9eGg65vZ/IXR2tD1rNNzIS6gKq9N211i8dt7+rA4NsN5
         q2J75WC/5c8QsrEZaCRJRwmuHq9vgzCxQoJn1z85kKlQ2oxdPoBjpjViaVkWa/dtsVFD
         tLHD0E8HALK4BotvWTiiwGM7FueJFmwAgwGRqKwCLCtpwdtTOW6SjaTiS0PgQDX9LXo+
         5PeI5lcAfpl2YjxIy3evHN1VDgCLeInSlFMqRaA/VGF3HKSNyy4VuzQsxH4xbSgNjx61
         r5E90Uv0NiIxtKSxAOQSb9oWCAUk3Id9iCCRWrfvtqNriVEmKRvKdCEcgsd4xgpz+ms5
         cQvw==
X-Gm-Message-State: AOUpUlG3N6DemeCDe7uu36D7RfGMy11iEKZW47ueBSrGGFs2j8V4yj1f
        Srq/592jh51E6nEIDIXvaeTEp7g67nLExBkhwcVpebfIhxxQphm0pb6teeDZuMAWsq3j1OLXoFf
        9RtVgVvU5RvipSQiwK56nVhSb99Iim4EHyJXOLRCTmHH/fS0cAcLd6glcmQ==
X-Google-Smtp-Source: AA+uWPxTgNK/z3FZYDJtdvF/WaD++2BKwBP3VccDMFILSdFl7lD6yshWgTmjoxIYah9yg1FaHwVNDMtdrFg=
X-Received: by 2002:a1f:be53:: with SMTP id o80-v6mr18258921vkf.83.1534443591916;
 Thu, 16 Aug 2018 11:19:51 -0700 (PDT)
Date:   Thu, 16 Aug 2018 11:19:40 -0700
In-Reply-To: <20180816024733.GB127655@aiede.svl.corp.google.com>
Message-Id: <20180816181940.46114-1-bmwill@google.com>
Mime-Version: 1.0
References: <20180816024733.GB127655@aiede.svl.corp.google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH] submodule: add config for where gitdirs are located
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the config "submodule.<name>.gitdirpath" which is used to
indicate where a submodule's gitdir is located inside of a repository's
"modules" directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Maybe something like this on top?  Do you think we should disallow "../"
in this config, even though it is a repository local configuration and
not shipped in .gitmodules?

 submodule.c                | 13 ++++++++++++-
 t/t7400-submodule-basic.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 4854d88ce8..0cb00a9f24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1966,16 +1966,27 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
 	size_t modules_len;
+	char *key;
+	char *gitdir_path;
 
 	strbuf_git_common_path(buf, r, "modules/");
 	modules_len = buf->len;
-	strbuf_addstr(buf, submodule_name);
+
+	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
+	if (!repo_config_get_string(r, key, &gitdir_path)) {
+		strbuf_addstr(buf, gitdir_path);
+		free(key);
+		free(gitdir_path);
+		return;
+	}
+	free(key);
 
 	/*
 	 * If the submodule gitdir already exists using the old-fashioned
 	 * location (which uses the submodule name as-is, without munging it)
 	 * then return that.
 	 */
+	strbuf_addstr(buf, submodule_name);
 	if (!access(buf->buf, F_OK))
 		return;
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 963693332c..1555329a2f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1351,6 +1351,16 @@ test_expect_success 'resolve submodule gitdir in superprojects modules directory
 	$(git -C superproject rev-parse --git-common-dir)/modules/sub/module
 	EOF
 	git -C superproject submodule--helper gitdir "sub/module" >actual &&
+	test_cmp expect actual &&
+
+	# Test using "submodule.<name>.gitdirpath" config for where the submodules
+	# gitdir is located inside the superprojecs "modules" directory
+	mv superproject/.git/modules/sub/module superproject/.git/modules/submodule &&
+	cat >expect <<-EOF &&
+	$(git -C superproject rev-parse --git-common-dir)/modules/submodule
+	EOF
+	git -C superproject config "submodule.sub/module.gitdirpath" "submodule" &&
+	git -C superproject submodule--helper gitdir "sub/module" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.18.0.865.gffc8e1a3cd6-goog

