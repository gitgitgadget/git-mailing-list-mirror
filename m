Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663CCC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiAEUC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbiAEUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:33 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644FC061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso61189wmf.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=JoSuTCuiFSIf5LS+lcYSfFHwZWzY0Il4ZMg577JKMqy6s7DLzPWBA1QhQbXnCxdndD
         a8XruauaUDL8ZcsP9NgMNS+pqoPcFw1jeZj/D3kUAZUl4/fhi5lkkmafd99cTbMAnX/+
         LSY1hnryeS5pGkBS9N18QA395o0dUnPaMLhHWOEQH5K/X38mV+4TpllmJg4aRAjsx+EH
         g7f9WfQYdN+t4YkAChmKFZsKsCYtPgBqpski3PTfZ+nQyYvbDZNrPGKaC0gUtxPZwCuB
         d71jgLP/SzLZzygiPtif4RlFtyUouaQMhOsi2O1X/ONHsiX6CzmcZa7fUvOQLPTTj9Xf
         lxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lJ3JP/DgW2qFrsjmp5khrg3BgbmcWXCzjZiWjRlHLBc=;
        b=k/3yHRkJDE+u3N2BWzfVY0vosHekhdCBsOu99jiUBhRCPlpc8LWSkmakjuacZ3I2WO
         g3V3ak4ZJtkiUFckBjKJY+qlfnHXP0q1HOqKRZuc9szztUk1GdSR4YgDjl2P3cPjktfm
         9zekJaBjzgKYIHwkzXFGTs36/UbN/EJZJxcoD3ZvJCcLlymG4UmYyJhnFFBwtj4LRBpG
         3wJObjD4RA8h6HbAhWU1bUzLyl3BhQYIVbr9BpuIJN56vGp5iHZPraRYx2jhrwxwyvn1
         lKMYuosGvJ/EgLEN4Ug6bLUVtrt4F6RV4Fmy0nhJPaFrH/1Y4bp7ivnU4ZQEDZ34TYbI
         3Prw==
X-Gm-Message-State: AOAM53320CSyDF/0+NtHgoAO0nEnCo87LPBvhZmgBUML4esbElSMrXXn
        1SDjry9GXkzh1iIsdvyMjgvTs3EfBg4=
X-Google-Smtp-Source: ABdhPJxeRoYiI7iGWilR8lPXhLIlhLDzbrzW2CiOSvTJP/T38VUCquQaeexMvok8KTQxbAyvPOZdOQ==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr4286651wmj.99.1641412951979;
        Wed, 05 Jan 2022 12:02:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm46690989wrc.69.2022.01.05.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:31 -0800 (PST)
Message-Id: <437aadbc2c9f4469d8fd22bb4433d69f085600df.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:21 +0000
Subject: [PATCH v5 08/11] i18n: refactor "unrecognized %(foo) argument"
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

