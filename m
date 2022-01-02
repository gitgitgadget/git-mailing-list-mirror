Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14291C433EF
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiABRQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiABRP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EEEC061792
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso17280389wmk.1
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=lGGntqG3bklmGFJkBFUmChcz6BtB7wSX+atZitXduYaX1ySTW8dJ56Du10Z1iYGW3R
         rhKhR3SEV+kfoIKNNO9Wu8Jcz2Wa3Crt2B62K8fEd67XcpL9m9WZdXAf45+wIOsQe+fN
         M2jkCmiCW9VnJ+1yyHX8Kq7bwbMVJTnvVdxM0u8eGz/jSZFUIRHmLcbZpzKQhplIvF+H
         ACwKhNnTHrZmr09uQYYw6J3mTB2wvGtAO4h+BRW6RJfwkd2VKfEXwT6jKP6Vj6z+PpmI
         JY8WERVZDMCBGnzUvNoIdRKqxavC8qSzNdBEywpR5XzPmGMpK+WEfIRkBhmAmz1gbG/F
         ooFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=czyAvvheb/ICXR1LO9ODMGbdIN9UU0JLgsOn1fqdeV0G55466kNtGtq5C9S+k+3I8Q
         hANHSXFn5djNQjujPrpJM/6DaEO2gGTBvtLQM2PgV5zp3GcD0Ui1nZaw22qMLwBqPcMT
         amtxfW3/9COCF45TaGoR8FEHZRKoj/U+i94IGqIc3st1RdDkRJfxSJhFjAmcgDm/0rTD
         NV3jWMEt4JSouiom8ozEEKADahVsbQjTeTuWvJ7JB4+K4XOUukLmOCqsJuUj4D0GeBOh
         gXfORPu9QFtPbqryxuMwfIdBZmjRUAAH7It0p/Bet3sA40E/YKjb775iwPUUgKkQi1KD
         pBwg==
X-Gm-Message-State: AOAM530ZRX87cyz5PAuGOGNNwhW5UVAanmb0O0VGOZCk6NI4gdRAHWot
        Fw22oY+WbcDLrlz98ZyP+S/gEZgqqeQ=
X-Google-Smtp-Source: ABdhPJwXds9AxNj0WMaL4MPqOU53A5U8G+GI4uM9dNXF0GkLA6X3r6h/kPbk54jPjf3WYzQU5IURTg==
X-Received: by 2002:a7b:c243:: with SMTP id b3mr36208456wmj.61.1641143755217;
        Sun, 02 Jan 2022 09:15:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm37745165wru.45.2022.01.02.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:54 -0800 (PST)
Message-Id: <59e1e8aa1b47765f7e914e68a875e62df43f99ef.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:42 +0000
Subject: [PATCH v4 08/11] i18n: refactor "unrecognized %(foo) argument"
 strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
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

