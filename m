Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4133BC433FE
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhL0XYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbhL0XYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE42C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e5so34903394wrc.5
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=Yv6N6TJ5QmC971CoLLiLi/SUA3QZEILqeGquEJ8B0r37lObBxitPbe+rLYHI3nr14g
         zO45ogCadvwmpVyxnfbthxhefK5mvMNzaQyb+pt6A5UeoGmJ7xiPcjZ3L8XCMwYbT/4K
         /LcSfw3qSF8tvRQqr9S7Jjwnb6PiemG247+OR8epfBcS39Puv2Rlx1EwRkmULkV/7Qye
         v5Rx+8PBwxthl1iwflSHoJCWtkcaY8wGQRA8p9Op6Vb8egrFPRRhn4JZIHQuE3LJu/dP
         1RkCQCcVcXxxYcw0K88KIbwCi0NUb2QYWUtmbwvr8N5fIBguFPJ8ilfiurbUFttd86KF
         jZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=D/72BnAK5ngzp6KxJi+5Pmfx0kTktwlmAV0qVP+XfOINoR4MHncD3QPPy8EyprdmXR
         BNAu5sQIiBuPoAwzZUUfw+07mRyaWOJAzyDnNCWQef5/n1qyLe8u73H4JEDFJv8FVhmO
         klWJCaEmK3F8llqh5FmLVJdtKVrLhve3lMvnEFS3mGQJqwfFIIriF9nVHyZ6LXYrAiYk
         PjAS5PxFE5CiiSKJ+BZcwrhHqums4ApjrdAEt2o5skXgEMMQDF9dX48IT0W4V0uXsye4
         hH4+mZW4UZ7E6EQKXXZI13+NJz1Y4zVBv63BXYJTuSos2zV49cmZQdXgHtR/i8e5XBCh
         24KA==
X-Gm-Message-State: AOAM531HKjngod3s+/Em6MkNUo3VIzFdEeWn6qluSAYDnk/idgVrXde1
        3IOcCV0Uxuo65su3afn+zXcpihe2rOo=
X-Google-Smtp-Source: ABdhPJyGNFGxoSKGSFU9sYmPA2tdaUDj7YM/n82NK9OKiR0428biBDrV8qij7ZrKVb2vf4jF83VG3g==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr13504417wrq.708.1640647444347;
        Mon, 27 Dec 2021 15:24:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm19967389wry.108.2021.12.27.15.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:04 -0800 (PST)
Message-Id: <5f80ac2fa200e996d76f2394481c77f660a2c6e2.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:54 +0000
Subject: [PATCH v2 08/11] i18n: refactor "unrecognized %(foo) argument"
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

