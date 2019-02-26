Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D113E20248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfBZA06 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35524 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfBZA0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so11958949wrx.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32aTWrOKLgNRXnOZkuCmjfI4neHybtVGVXDJqac5D7g=;
        b=QKmrFJa9NTWyokerYvJ53zLwlHcJ5+vPa8pIEYrNqyU7nIVbqjT9t46GCIf+9vbOPf
         nq25cyQ0UObw0w+ZDPaoQ95C2kaibSi2bMhLSvXNAlADg68LgxdZIszQbY4nJx6RoUIk
         hEf0NxuUnvjtsc8baebxRePCELemChzUEmA2HC9X3ZUuvCrleW+rpDZQyOuRw68t//l5
         Ll1REom8Dm/gkIZwWFqO9Lota5KJLtVWzI8abc02+Fxrzy0ckbIwt+saxy+bZO4s8D3n
         Yu5e+OXX8oTSjbYNx8wYQrHwTnTr4kc7GSSP4zwYfusc5NJrUHeogAT2L7GQ3bUagpPm
         cNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32aTWrOKLgNRXnOZkuCmjfI4neHybtVGVXDJqac5D7g=;
        b=VyLtvgv+j8HJf7h3rPxLDQFsf37F3ZiiEK4D7Oh2TCWaHdTJcVyv6I5W2lh/2nPAQW
         /t0vZBMQn11SAcbDylb/L3X2BtgJim2jj73vDfLXZVyp5ntzMUfKvSlQiZFEcbe1p7nq
         X74AaSm5Djz44TdCGfJ3HoDuy0cxiL6bcQdM103rj3uCeGlfBmOxVi76AH0HkCTpUMST
         0xlfpmkeCtEQ5pXigg5gKVOVq8j4P6BWIUriYjs33mAVTDElcosyz9wkkI3sGZeDweHM
         5LFauTL+QsrIChjpugjBzvwYpkwJ778P4JzrucMmNXQcGrYqvf4ZMXA59hdqGJaSOu/z
         nsug==
X-Gm-Message-State: AHQUAuYSqrpOd0yrdhmPtBQo6INILVxCNdAMRd7473oAPkt1MrGssHAg
        pdMeldYSEaHvkD+dQhbcMaBUN9tXWIE=
X-Google-Smtp-Source: AHgI3IYv+aQg4AeN7iBIFp7lW0qhqg6XdkbHh7DwEmVmf1jCKcwTTejLc4wA/HUfisecgCPJ1yb3aw==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr15056059wrl.117.1551140813200;
        Mon, 25 Feb 2019 16:26:53 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:52 -0800 (PST)
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
Subject: [WIP RFC PATCH 6/7] clone: stop ignoring dotdirs in --local etc. clone
Date:   Tue, 26 Feb 2019 01:26:24 +0100
Message-Id: <20190226002625.13022-7-avarab@gmail.com>
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

This seems to never have been intentional, just a side-effect of how
the existing code was written.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            | 8 +++-----
 t/t5604-clone-reference.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c32e9022b3..515dc91d63 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -446,8 +446,6 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		}
 
 		if (S_ISDIR(iter->st.st_mode)) {
-			if (iter->relative_path[0] == '.')
-				continue;
 			mkdir_if_missing(dest->buf, 0777);
 			continue;
 		}
@@ -463,11 +461,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
-			if (option_local > 0 && errno != ENOENT)
-				warning_errno(_("failed to create link '%s'"), dest->buf);
+			if (option_local > 0)
+				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file_with_time(dest->buf, src->buf, 0666) && errno != ENOENT)
+		if (copy_file_with_time(dest->buf, src->buf, 0666))
 			die_errno(_("failed to copy file to '%s'"), dest->buf);
 	}
 
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 6f9c77049e..f1a8e74c44 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -262,16 +262,25 @@ test_expect_success SHA1,SYMLINKS 'clone repo with manually symlinked objects/*'
 	test_cmp expected actual &&
 	find S-* -name "*some*" | sort >actual &&
 	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-dir
+	S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
+	S--dissociate/.git/objects/.some-hidden-dir/some-file
 	S--dissociate/.git/objects/.some-hidden-file
 	S--dissociate/.git/objects/some-dir
 	S--dissociate/.git/objects/some-dir/.some-dot-file
 	S--dissociate/.git/objects/some-dir/some-file
 	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-dir
+	S--local/.git/objects/.some-hidden-dir/.some-dot-file
+	S--local/.git/objects/.some-hidden-dir/some-file
 	S--local/.git/objects/.some-hidden-file
 	S--local/.git/objects/some-dir
 	S--local/.git/objects/some-dir/.some-dot-file
 	S--local/.git/objects/some-dir/some-file
 	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir
+	S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
 	S--no-hardlinks/.git/objects/.some-hidden-file
 	S--no-hardlinks/.git/objects/some-dir
 	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

