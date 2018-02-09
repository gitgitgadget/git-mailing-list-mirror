Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE3C1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeBILDZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:25 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44372 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBILDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:24 -0500
Received: by mail-pg0-f65.google.com with SMTP id j9so2837339pgp.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnNuvk7DUdoEE2xtY9AFez1VBTBuy85JQNLiXo3lTY8=;
        b=T6VMWZRCUvz/qieR41pV2Q8ksTvXdLVXavMVYLIn9CZnrMfgeY17d6A0VsesXdmlTt
         iv1jV9k6nMXz4ed3s72SIacIroBZaBS6qTZSzK6OLbvZ4zPhqXK0JfriBrIpTnQgo+ZM
         0KNL9kFJrVpqePxCbesw2WurMPJhLyDUg/Gs0+xOppW/IDkLuAh3YNPWA5on1bn8Ivgt
         WXE92/uqoo15a9Cl5s1Z+LeF8mxBV7iXhw4iGDPxyyS6CteUr73zkgyoZhzfLBT+VIry
         D5SW4eXqjvlZS3Fa77rBoaJvTuhAuUcOAZzFTWKv6IyrGhxoSr5443qLqJ6M266ryMAk
         W7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnNuvk7DUdoEE2xtY9AFez1VBTBuy85JQNLiXo3lTY8=;
        b=bbbKB7NL+X/l5vp42CHn4tIH0nYHKQ8eZyLtwiapbeYyYDhZG0wZHdg/ER/CH0gDMH
         8zPiFGh0txgYS0vPNlSlg2wPWqv5hDZkodLfdSWwtUwNF7O5dsW14VorKKOA50CLWU+O
         B66cpTomb0l6dPBzxvIiNBtvPWvbIAYLb3f7tioQQSdZzeygdXpxrTYse+NnBI8uSKUD
         JlNaOIN+LIJ7p1PGb2R00k+RFsqovd3P1fGJS/bk2BwbXY4GaPcM/lzxrpQjyzrQ1Lzq
         3Ee9FC1EVsjCY8Rw6gnXMkUVwd3tT9GIDDQkVzXdlw8VShTVxTBBwgylLWSuhw/W0cIV
         5hEw==
X-Gm-Message-State: APf1xPA0c651Xw1sI7VLEAYuqfQKKQzNcVbBWk/Rm37V58bSwmNr5z3x
        U0lws+sibr0JUJc+UvWcw/nDKg==
X-Google-Smtp-Source: AH8x226lMhZm/1vwtXI12YDyXQQwGlBuDPQnghgc/3GP+hUAHM5jqCQxYPBQVpF7ZmDS6NH0pY/MVA==
X-Received: by 10.101.73.72 with SMTP id q8mr2083745pgs.66.1518174203647;
        Fri, 09 Feb 2018 03:03:23 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e67sm4961385pfd.23.2018.02.09.03.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 09/42] completion: use __gitcomp_builtin in _git_checkout
Date:   Fri,  9 Feb 2018 18:01:48 +0700
Message-Id: <20180209110221.27224-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--ignore-other-worktrees
--progress

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c                     |  7 +++++--
 contrib/completion/git-completion.bash |  6 +-----
 t/t9902-completion.sh                  | 12 +++++++-----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a96358eb7..a6218024a6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1118,9 +1118,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
 			    3),
-		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"), 0),
+		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL(0, "overwrite-ignore", &opts.overwrite_ignore, N_("update ignored files (default)")),
+		OPT_BOOL_F(0, "overwrite-ignore", &opts.overwrite_ignore,
+			   N_("update ignored files (default)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d926518fb7..7e312f95e9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1263,11 +1263,7 @@ _git_checkout ()
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
 		;;
 	--*)
-		__gitcomp "
-			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch --detach --ignore-skip-worktree-bits
-			--recurse-submodules --no-recurse-submodules
-			"
+		__gitcomp_builtin checkout "--no-track --no-recurse-submodules"
 		;;
 	*)
 		# check if --track, --no-track, or --no-guess was specified
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index fc614dcbfa..e6485feb0a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1237,17 +1237,19 @@ test_expect_success 'double dash "git" itself' '
 test_expect_success 'double dash "git checkout"' '
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
+	--detach Z
+	--track Z
+	--orphan=Z
 	--ours Z
 	--theirs Z
-	--track Z
-	--no-track Z
 	--merge Z
-	--conflict=
-	--orphan Z
+	--conflict=Z
 	--patch Z
-	--detach Z
 	--ignore-skip-worktree-bits Z
+	--ignore-other-worktrees Z
 	--recurse-submodules Z
+	--progress Z
+	--no-track Z
 	--no-recurse-submodules Z
 	EOF
 '
-- 
2.16.1.207.gedba492059

