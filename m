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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1B1201A4
	for <e@80x24.org>; Tue, 16 May 2017 08:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdEPI3B (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 04:29:01 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35019 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdEPI26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 04:28:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so21459139qke.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCp+7QRaGBHKLFIQ4GJLWp1/mIHDKPuVkbNf+tkuJjo=;
        b=f03xhJdzMo8ZWFwvYxUOYv2TJsvXZ/DnyYZ0LH7WCnmMwgOmWMC2sJGKVNd0+8SHeq
         T4TOI5X/LtaUNrc7QQrDolTAHcoRvBJI3eFofF2T1VXt+DjRw8fMGxGk6+mz4QMNk1oK
         7MrQ/sUI2hQnOZ35RbGBO3aPwP0hXcztvnJWSMshuSRCfFynSKvBIj8R0cf5LN9UQ/nP
         PfkPNm9gNfJRSzyedBWRWsGpSn27bLXz7glcvquN4hR+HpjZvy75JzZXmB9NrjxHIR5p
         eQANtXkqdjFqig0vKXotLXB460cYrKcFnkaKBIdsJAHh6DBxYXeNYrqC7OpF40PWttPw
         gORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCp+7QRaGBHKLFIQ4GJLWp1/mIHDKPuVkbNf+tkuJjo=;
        b=BK0nkf+ilgUNdRHH8/NehLxo5daNe0aB+7JAiD6++tbOdh41w7zU7bBkVpt5gFMWMl
         S+mUw/UDveBTPbG6WPRkGrfZzQBgbUbP81Ihxk+MwFeiJiEpqLPMPRnfIVKSj2DtDON+
         YqqsXH0GY+QxkFDt3nEYl1rQzGFee0mqpReVzoeGnX4dTNDFi40+KPbP0y0+lL/W1NT1
         vrv6DuAaPP+UUYG5YJqYx0gmcwBuROzcc/xOyqScGAfWglaf/gTELBoreYLygGv9i62s
         CibTfVdACu+jj8es0F09wUTcJtUHKhiJFw+5mcFuEaRTl694mSPzjDf/pAezHaIsR8kH
         jMHg==
X-Gm-Message-State: AODbwcDE3E52xeDcc9OIX02LTrJ55rWlQwTjcaw3TyXVL111qxAhXuCd
        CDLu8Ix9LWKpFA==
X-Received: by 10.80.184.117 with SMTP id k50mr7830179ede.113.1494923337015;
        Tue, 16 May 2017 01:28:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s40sm364704edd.21.2017.05.16.01.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 01:28:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] config: match both symlink & realpath versions in IncludeIf.gitdir:*
Date:   Tue, 16 May 2017 08:28:46 +0000
Message-Id: <20170516082846.26191-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <xmqqlgpx4n5v.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgpx4n5v.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the conditional inclusion mechanism to support
e.g. gitdir:~/git_tree/repo where ~/git_tree is a symlink to
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

Thanks. All fixed in the v2 below.

 Documentation/config.txt  | 10 ++++++++++
 config.c                  | 16 ++++++++++++++++
 t/t1305-config-include.sh | 23 +++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..302b8af192 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -140,6 +140,16 @@ A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
 
+ * Both the symlink & realpath versions of paths will be matched
+   outside of `$GIT_DIR`. E.g. if ~/git is a symlink to
+   /mnt/storage/git, both `gitdir:~/git` and `gitdir:/mnt/storage/git`
+   will match.
++
+This was not the case in the initial release of this feature in
+v2.13.0, which only matched the realpath version. Configuration that
+wants to be compatible with the initial release of this feature needs
+to either specify only the realpath version, or both versions.
+
  * Note that "../" is not special and will match literally, which is
    unlikely what you want.
 
diff --git a/config.c b/config.c
index b4a3205da3..f978428695 100644
--- a/config.c
+++ b/config.c
@@ -214,6 +214,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 	const char *git_dir;
+	int already_tried_absolute = 0;
 
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
 
+	if (!ret && !already_tried_absolute) {
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
+		already_tried_absolute = 1;
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
2.13.0.303.g4ebf302169

