Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1D620248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfBZA07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38687 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so11954801wrw.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKIRNNhDBE5EinqM5VZ4bhKdPIiXbQLoYZbNewwpzfA=;
        b=p+ZB0gsLjTS6fzzvO66rZj3ubHSQgX3Rl1W8PI1PRMZvx7D+jAu00ceL9g+uZDaFc6
         WHnoyefIqoY98wjXJL8UNdcrnUAUwqpQMtSwAmM/ia9Y8LDcrpn3lRVPtcpj6Cb134GV
         njXgEBLjKU+dkAAYkU8OLGEto5TWBRzPoXAzsiYRcj1DyGEvq7FUuejURiSkZ8d+WcU8
         k9JKsF0RlOVZYw406FrDfe7DI6WPUmirk5wEGFotyF6f3lhaqlx3nVxI2Fb7F5DTC6AV
         lrZFQyy9J2ZApkG+ZDOZ05ww2LhdD4nLpTkZAefJNptJuP0NVj7Zg7xie954u2fJvAgJ
         unJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKIRNNhDBE5EinqM5VZ4bhKdPIiXbQLoYZbNewwpzfA=;
        b=njkKizXustTnA87306r6xQO71LNrL0VXaK09x6x2nT9mIoSiGWv7mGpx62OXF53k3y
         BbAtUk0uR/oD3qWJzi5/hQYorqDXDgg8mWyKbm2g9YquI62NXLnumgLdzB1+4FTMslaY
         pKMHmyfT53RGGJ7qjMMbJliPHjgt00ExwRPuhldHR9M+Nkxr6/MCDiEUDlRyW7TQJMFK
         g4iMiD6uOOd+0vPeciLl31r+TaQIXMSapJ4fN43WWa72re/A0LvBaRRv7rXQGUviNEYj
         LtAr28TFF5SnzoYbdxKzLMwNATLDDc39utuiBUlf/hMh3ozwNWq+CYB6yRzgQFvcqOGw
         8oiQ==
X-Gm-Message-State: AHQUAuaAZvRMOCp1wHn3VtOuESiYh8+Lhi7XJ5SIEyz0ITEKa+VuJ+cp
        YgADVGSb98Hk5Kj0xBBdhZLYkCGba7Q=
X-Google-Smtp-Source: AHgI3IYg9vWy1xWgzlJtIjdh8P0ReaK+3028z2pVPzoHzDVlOHl3zW0uM3ZFxxyziFyFZV8KuyALdQ==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr15075359wrm.302.1551140814498;
        Mon, 25 Feb 2019 16:26:54 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP RFC PATCH 7/7] clone: break cloning repos that have symlinks in them
Date:   Tue, 26 Feb 2019 01:26:25 +0100
Message-Id: <20190226002625.13022-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revert back to the lstat() behavior in the dir_iterator interface
we've had since it was added in 0fe5043dad ("dir_iterator: new API for
iterating over a directory tree", 2016-06-18).

No reflog test depends on it, so it's unclear if it's needed. Since
clone now uses this it changes the longstanding behavior of how we
just so happened to support objects dirs with symlinks in them.

Why? I don't know. Just writing this up as an RFC with tests. Insert
rationale here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir-iterator.c             |  2 +-
 t/t5604-clone-reference.sh | 45 +++++++-------------------------------
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 6a9c0c4d08..070a656555 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -149,7 +149,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				continue;
 
 			strbuf_addstr(&iter->base.path, de->d_name);
-			if (stat(iter->base.path.buf, &iter->base.st) < 0) {
+			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
 				if (errno != ENOENT) {
 					if (iter->pedantic)
 						goto error_out;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index f1a8e74c44..a4cd12643e 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -249,45 +249,16 @@ test_expect_success SHA1,SYMLINKS 'setup repo with manually symlinked objects/*'
 '
 
 test_expect_success SHA1,SYMLINKS 'clone repo with manually symlinked objects/*' '
-	for option in --local --no-hardlinks --shared --dissociate
+	for option in --local --no-hardlinks --dissociate
 	do
-		git clone $option S S$option || return 1 &&
-		git -C S$option fsck || return 1
+		test_must_fail git clone $option S S$option 2>err || return 1 &&
+		test_i18ngrep "the remote end hung up" err || return 1
 	done &&
-	find S-* -type l | sort >actual &&
-	cat >expected <<-EOF &&
-	S--dissociate/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
-	S--local/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
-	EOF
-	test_cmp expected actual &&
-	find S-* -name "*some*" | sort >actual &&
-	cat >expected <<-EOF &&
-	S--dissociate/.git/objects/.some-hidden-dir
-	S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
-	S--dissociate/.git/objects/.some-hidden-dir/some-file
-	S--dissociate/.git/objects/.some-hidden-file
-	S--dissociate/.git/objects/some-dir
-	S--dissociate/.git/objects/some-dir/.some-dot-file
-	S--dissociate/.git/objects/some-dir/some-file
-	S--dissociate/.git/objects/some-file
-	S--local/.git/objects/.some-hidden-dir
-	S--local/.git/objects/.some-hidden-dir/.some-dot-file
-	S--local/.git/objects/.some-hidden-dir/some-file
-	S--local/.git/objects/.some-hidden-file
-	S--local/.git/objects/some-dir
-	S--local/.git/objects/some-dir/.some-dot-file
-	S--local/.git/objects/some-dir/some-file
-	S--local/.git/objects/some-file
-	S--no-hardlinks/.git/objects/.some-hidden-dir
-	S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
-	S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
-	S--no-hardlinks/.git/objects/.some-hidden-file
-	S--no-hardlinks/.git/objects/some-dir
-	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
-	S--no-hardlinks/.git/objects/some-dir/some-file
-	S--no-hardlinks/.git/objects/some-file
-	EOF
-	test_cmp expected actual
+	git clone --shared S S--shared &&
+	find S--shared -type l | sort >actual &&
+	test_must_be_empty actual &&
+	find S--shared -name "*some*" | sort >actual &&
+	test_must_be_empty actual
 '
 
 test_done
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

