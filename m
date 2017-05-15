Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C07B201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965216AbdEOTQH (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:16:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33872 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933582AbdEOTQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:16:06 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so18975606qka.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/O6RFbnAfSa3LBG/538L2/mf2+W5bJu9XKAWVvzKAs=;
        b=R6U2ey/ANw89qRPPn1ppwlSR14dMloNWKpqu/trVjxDaBT5g/YMHpitaDrA3cBXX5L
         cPIjnYomLYCn0VGZ5OHIB0fpN/mdMX2G9/nGbOOdttwAmoeP7AfqVqn4dSG2WmxCBNvZ
         WLpCopxbH0UkUYncxLMUv0wo0QZF7wCdMDL3wlBzgZEOZMwvIeVBCKDUaNGeJ/AtaPnr
         YJt1CF7YJ+ji7pizQrqTZmJDqOsjeBd9CJVipC6YlunFb4hvpj9U968q/SRVK8cC4ynI
         d5MX6TdhO4IO7UAy6o4cthXlBIx1xmGKPX5Owaa68KLrOeJa0zHKxuyhudpS73wlRj1i
         VDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/O6RFbnAfSa3LBG/538L2/mf2+W5bJu9XKAWVvzKAs=;
        b=I5Ik7/P+GFKy405Bgb24ysk5GDXg2/6cBDG2gcnvzk6tfKKV5Y/bffkjM/DSZ0JUM5
         bLuB+MnCBZF9hRTv7fbnhwezV9VuVJwCRnG0twoItPNSOr4QH600uS6wzFKPn2K4ccC5
         w5oRduUDGOctt71Nb1OXsfzBj2XOaUCBXNj7EYHl04RUkfJwWKigyvhcx2oi+kULGOSs
         4DkJWO/87/7IDtIV1XlxtyChE6uUM8x3zUV/UQC5IXcyYqxwnc4VdWC/TwSONtF/GH3p
         cPnRpYTQ6gRaG1zVhU/eOJlGZQU0TCfF7Hu01Er9rT3wGU85uQr9NS6Z3YP29jXtszZz
         //dQ==
X-Gm-Message-State: AODbwcALTn+cqD+YCrNqp6txP9Fe5rnrcQK4IEoenGhA44vA0V71AMjH
        UvY8hqtJhCALiw==
X-Received: by 10.55.99.87 with SMTP id x84mr6438137qkb.86.1494875765452;
        Mon, 15 May 2017 12:16:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n19sm9014374qkn.66.2017.05.15.12.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 12:16:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config: match both symlink & realpath versions in IncludeIf.gitdir:*
Date:   Mon, 15 May 2017 19:15:52 +0000
Message-Id: <20170515191552.5193-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277
In-Reply-To: <CACBZZX5nchNUb-V3U8FL9fuhk=3t42Qhz4=Wh9Qk_0C=x85UdQ@mail.gmail.com>
References: <CACBZZX5nchNUb-V3U8FL9fuhk=3t42Qhz4=Wh9Qk_0C=x85UdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the conditional inclusion mechanism to support
e.g. gitdir:~/git_tree/repo where ~/git_tree is a symlink to to
/mnt/stuff/repo.

This worked in the initial version of this facility[1], but regressed
later in the series while solving a related bug[2].

Now gitdir: will match against the symlinked
path (e.g. gitdir:~/git_tree/repo) in addition to the current
/mnt/stuff/repo path.

Since this is already in a release version note in the documentation
that this behavior changed, so users who expect their configuration to
work on both v2.13.0 and some future version of git with this fix
aren't utterly confused.

1. commit 3efd0bedc6 ("config: add conditional include", 2017-03-01)
2. commit 86f9515708 ("config: resolve symlinks in conditional
   include's patterns", 2017-04-05)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Here's a non-RFC patch to fix this bug.

 Documentation/config.txt  | 11 +++++++++++
 config.c                  | 16 ++++++++++++++++
 t/t1305-config-include.sh | 23 +++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..137502a289 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -140,6 +140,17 @@ A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
 
+ * Both the symlink & realpath versions of paths will be matched
+   outside of `$GIT_DIR`. E.g. if ~/git is a symlink to
+   /mnt/storage/git, both `gitdir:~/git` and `gitdir:/mnt/storage/git`
+   will match.
+
+   This was not the case in the initial release of this feature in
+   v2.13.0, which only matched the realpath version. Configuration
+   that wants to be compatible with the initial release of this
+   feature needs to either specify only the realpath version, or both
+   versions.
+
  * Note that "../" is not special and will match literally, which is
    unlikely what you want.
 
diff --git a/config.c b/config.c
index b4a3205da3..0498746112 100644
--- a/config.c
+++ b/config.c
@@ -214,6 +214,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 	const char *git_dir;
+	int retry = 1;
 
 	if (opts->git_dir)
 		git_dir = opts->git_dir;
@@ -226,6 +227,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
+again:
 	if (prefix < 0)
 		goto done;
 
@@ -245,6 +247,20 @@ static int include_by_gitdir(const struct config_options *opts,
 	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
 			 icase ? WM_CASEFOLD : 0, NULL);
 
+	if (!ret && retry) {
+		/*
+		 * We've tried e.g. matching gitdir:~/work, but if
+		 * ~/work is a symlink to /mnt/storage/work
+		 * strbuf_realpath() will expand it, so the rule won't
+		 * match. Let's match against a
+		 * strbuf_add_absolute_path() version of the path,
+		 * which'll do the right thing
+		 */
+		strbuf_reset(&text);
+		strbuf_add_absolute_path(&text, git_dir);
+		retry = 0;
+		goto again;
+	}
 done:
 	strbuf_release(&pattern);
 	strbuf_release(&text);
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 933915ec06..d9d2f545a4 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -273,6 +273,29 @@ test_expect_success SYMLINKS 'conditional include, relative path with symlinks'
 	)
 '
 
+test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
+	ln -s foo bar &&
+	(
+		cd bar &&
+		echo "[includeIf \"gitdir:bar/\"]path=bar7" >>.git/config &&
+		echo "[test]seven=7" >.git/bar7 &&
+		echo 7 >expect &&
+		git config test.seven >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icase' '
+	(
+		cd bar &&
+		echo "[includeIf \"gitdir/i:BAR/\"]path=bar8" >>.git/config &&
+		echo "[test]eight=8" >.git/bar8 &&
+		echo 8 >expect &&
+		git config test.eight >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.13.0.rc2.291.g57267f2277

