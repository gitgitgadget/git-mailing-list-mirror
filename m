Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60AC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhL2SzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhL2SzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62AC061746
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o30so11680081wms.4
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=Y+uEoq4sia+UTkxyivuaQWL4+9gtr8CjXCAFcbzlm8R/mjeN4FTceK+xAtzwwCcpO/
         OIloNFRHPFJtlx/0QGqo/OUM4Jz4QFbXFpjFQqbIIZ/mTJdWiUPw4tZcyz5VzipsYrWK
         DwBBJJC1mT0uOrbTm7PsSnRZ/wkbqRoA9mmkNUQ1RUM+51cUJXckHULjA2yLl8rXvUAh
         oymMt90yXYahjJrby85GEtmg7Wj3vjGrbEfb6wGHVygIgkYnxQg3KqU3/2rlGx9rx+gM
         GLzldrep+3pfIsYj0isTv+0IQmAdo+flyLfv8FBnQswTAMfD4gZrHKR9DFR+KIXlY5wu
         z8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=nP8WkDRB7O2Aeay+gpVh4mwFV39A5nApmiyTDsvJ2z++greNlmKwG/U8e10Bx7sTez
         At+t07/O/hBcZfV0ZuvqRWoyrmsJeNrfjKVAMnbtQpUzDeS5bA5CNSS7hGHjVZDlTBgU
         Nb9edj2rYzvBHJn9haS27mvrrLhuwUgbP4GIY6hAH86czrEeoyHikc2mMuNdjzISoBoi
         ZHXLZrIMZc+ax+LNHklvl09xThiuDGZ78OBeWZDM/rbUMc7bMhebUmLoGg9IwZFBwFoj
         liNGzk+s3WBciougTpzy3ohgHE0dB2YARPvcNMBU+3lDnpvz+XXxKWY1u2NhXwJfUdsL
         ovXQ==
X-Gm-Message-State: AOAM533uGm8gNikSxZjlImAjgFrvROd9i3OAiBNn5nk0BUFbwX7HoPra
        c+jHSTiwPpiN+mbi4TGojCw3xtdIF64=
X-Google-Smtp-Source: ABdhPJzm+uhGhTmoV5far8gmdHh7jOckeanQQgN7yiAJluFcjIJOa/kr4xmOw14mgaYScA0HQ+W6bA==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr23029305wmc.87.1640804114604;
        Wed, 29 Dec 2021 10:55:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm27942108wmf.9.2021.12.29.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:14 -0800 (PST)
Message-Id: <b75c5b1ce35a1d4159e5210781b5194b5e6027e2.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:04 +0000
Subject: [PATCH v3 08/11] i18n: refactor "unrecognized %(foo) argument"
 strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 ref-filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7260fce31d0..adbcc680812 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -341,7 +341,7 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 		else
 			oi.info.disk_sizep = &oi.disk_size;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "objectsize", arg);
 	return 0;
 }
 
@@ -374,7 +374,7 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
 	else if (!strcmp(arg, "sanitize"))
 		atom->u.contents.option = C_SUB_SANITIZE;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "subject", arg);
 	return 0;
 }
 
@@ -428,7 +428,7 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
 			return strbuf_addf_ret(err, -1, _("positive value expected contents:lines=%s"), arg);
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(contents) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "contents", arg);
 	return 0;
 }
 
@@ -440,7 +440,7 @@ static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 	else if (!strcmp(arg, "size"))
 		atom->u.raw_data.option = RAW_LENGTH;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "raw", arg);
 	return 0;
 }
 
@@ -459,7 +459,7 @@ static int oid_atom_parser(struct ref_format *format, struct used_atom *atom,
 		if (atom->u.oid.length < MINIMUM_ABBREV)
 			atom->u.oid.length = MINIMUM_ABBREV;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized argument '%s' in %%(%s)"), arg, atom->name);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), atom->name, arg);
 	return 0;
 }
 
@@ -531,7 +531,7 @@ static int align_atom_parser(struct ref_format *format, struct used_atom *atom,
 		else if ((position = parse_align_position(s)) >= 0)
 			align->position = position;
 		else {
-			strbuf_addf(err, _("unrecognized %%(align) argument: %s"), s);
+			strbuf_addf(err, _("unrecognized %%(%s) argument: %s"), "align", s);
 			string_list_clear(&params, 0);
 			return -1;
 		}
@@ -557,7 +557,7 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	} else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.str)) {
 		atom->u.if_then_else.cmp_status = COMPARE_UNEQUAL;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(if) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "if", arg);
 	return 0;
 }
 
-- 
gitgitgadget

