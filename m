Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A382C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiCTV4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbiCTV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2911164
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so18480385wrp.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tjrvtqkr+nl9gmML/KfR/cFoT7TmHJLUsLTa738DfhI=;
        b=bjO89K2nJ5oVruXjn3Da2AXtZLjmi24TK3KAGAO+HF/y9Z//parewxynzyxaDBVMWz
         Kj7BLdnYoh9zlFntBL1VtQQs/soy2ZVwzC3xXOwGzplhsDFvzI/c2KIzAoSqGEv9Zcrq
         Bnry/mcK/xIWib58FkbL0Ks92nHc6EqOQQJPug4MF0bqIujh00Xjont0GXg2U6aYw+Dp
         TMF4ZeOB2QGPZItLDYGChOuyWVBCHKIwKTshwUs93bP4ct4boYDlXpzTFAzGJhotblxI
         a/76ETMJU94dKzf/JBkZKTJj6PbXMkswqINALBGHQK3KINFxFIM0NzWjDRdfl1b2dru0
         FRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tjrvtqkr+nl9gmML/KfR/cFoT7TmHJLUsLTa738DfhI=;
        b=Irw4J/RIw7cPTUT70sNR1rVKRxXUAcvnQ64WdbLTsve1PfIRDZJpjV4SKkuebwSVCs
         2Jbvt1pjYvHGrNLxmvtxuEyOIcK2FuP714CMo04P9rVEeEUhQk6XCe1OsfrnWpm/6HKQ
         lYFImtfj12zwLnleZW2F3OK7TxQG+S6WHWytLtdXDKjpTJMzv3sn11ow15SgBs4Nj/+c
         HXH+Sz3PDnlNz2mYd0fg3fTmVfnWEGvj4ker4r0qh7lDPfiDtFd4H3UeaqNKCszvsQ6R
         PGPHCxBpXkW/X7QKrDs7kmlJBs9f+j2mTxQElG4ifpHJaOljZ8E61dvixO6twX0ueW5F
         BquQ==
X-Gm-Message-State: AOAM531+uzdjUzuriX/LdWyXZ+rZFqwZmuYqXvXOw987BRgG3ov7IcaG
        gjT6oeZSfgoDPcbRy5/YZHwhD2U/OG0=
X-Google-Smtp-Source: ABdhPJzm6Qc5ipwBVnxrUpsaxfp7aKAwylLv3QI62lvq+lTy0uATVlVFEz/qzfPdIknZ5nP4Fq6tFw==
X-Received: by 2002:a5d:59a4:0:b0:203:914f:52fa with SMTP id p4-20020a5d59a4000000b00203914f52famr15854315wrr.257.1647813298100;
        Sun, 20 Mar 2022 14:54:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000184800b002040e925afasm2300856wri.59.2022.03.20.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:57 -0700 (PDT)
Message-Id: <2e1bd504673e8e2ec77ac8e99edb9aac0fb82db2.1647813292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:49 +0000
Subject: [PATCH 5/7] i18n: factorize "foo does not take arguments" messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 contrib/scalar/scalar.c | 2 +-
 ref-filter.c            | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7db2a97416e..1aeecea1daa 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -502,7 +502,7 @@ cleanup:
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
-		die(_("`scalar list` does not take arguments"));
+		die(_("%s does not take arguments"), "`scalar list`");
 
 	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
 		return -1;
diff --git a/ref-filter.c b/ref-filter.c
index 7838bd22b8d..74f84cc0ed7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -317,7 +317,7 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 				  const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(objecttype)");
 	if (*atom->name == '*')
 		oi_deref.info.typep = &oi_deref.type;
 	else
@@ -349,7 +349,7 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 				 const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(deltabase)");
 	if (*atom->name == '*')
 		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
 	else
@@ -361,7 +361,7 @@ static int body_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(body) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(body)");
 	atom->u.contents.option = C_BODY_DEP;
 	return 0;
 }
@@ -565,7 +565,7 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(rest)");
 	format->use_rest = 1;
 	return 0;
 }
-- 
gitgitgadget

