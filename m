Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADDC1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeACUty (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:54 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41345 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeACUtt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:49 -0500
Received: by mail-wr0-f196.google.com with SMTP id p69so3014079wrb.8
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=olxd02ArNVNeDAKLhRya3NoFoHwiSSvCT0kuZcxHwGo=;
        b=XC01loA0k5qPN2ZGgqTOEBQnirABODv+TK9w/wOrFn9g7CU/7vK+/pRuUQ0DyvuX8d
         0fnfcwxUVKlD/2afm5hoxdFkc5rFyu80RvWKybXDgR3THHdsCwqc6ZjE9/NK1znMhRMU
         2BMVvHeeMk5ZXL/IIfALv5dacixhcCncHySFlvhX0xezFth+18xVQ0ncA0mUA35e5n4L
         F768umIQ6s0JjLUMffA4Do03EW48Y5A9+5f79ObOy7sYMrJr5iy/d6NnORx76+djfDkU
         sJIGZf4GTOStd9XoepErhNfS74BVXBwhfIlFxUeNXxrDKU8EnmvlLTPOsqE0Z8iYHb5o
         FoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=olxd02ArNVNeDAKLhRya3NoFoHwiSSvCT0kuZcxHwGo=;
        b=KgPj35vI0kPlMl+e3Jvzw1Ch0cm7uFxmnIB8yws+V0xPOxywF1dAd41/Lo9eCYwv7j
         Ew/j9a/aCIrdWUweDTPQ9FQR+q32KQW84y0UQcuZPi215LHwhABvQUT9ip/hnFjbfsCG
         6PbRoud2uO2RE8KmbotdMLoTYv+UYgPKM9kryCqkvxy3r3XwAqP9J1BPerGd4plm4M11
         N2+FF4SPQYLDcAw55z9YpNaxLUxvcr2UpD8e4lFCRtW5kLFh4g/fgWC+1ciDmEchKYdL
         uJVtQ4s8fgPD0ULwRjbpW8LfTEcOfNReZSJov/jSAzqW3qVFJcVLKZlJvcxs4pQ0bDYx
         XSCw==
X-Gm-Message-State: AKGB3mKyP4kCy0G20DoZ09nWBNvn+aV24d33zyT0HnvpJ4Lw5rnH+mex
        89UoGmhD0pNVP1HTigW4efb73oMZ
X-Google-Smtp-Source: ACJfBotU8ONB4D0XUSPr1PO2jSUYLb2tMqtYpZKMcrjRDlXLgHx6WYWOHyBRkkR3/E1LyAsMhdL9lQ==
X-Received: by 10.223.131.132 with SMTP id 4mr2454397wre.217.1515012587743;
        Wed, 03 Jan 2018 12:49:47 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l9sm1908443wrb.45.2018.01.03.12.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 12:49:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] dir.c: stop ignoring opendir() error in open_cached_dir()
Date:   Wed,  3 Jan 2018 20:49:28 +0000
Message-Id: <20180103204928.3769-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180103204928.3769-1-avarab@gmail.com>
References: <20180103204928.3769-1-avarab@gmail.com>
In-Reply-To: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

A follow-up to the recently fixed bugs in the untracked
invalidation. If opendir() fails it should show a warning, perhaps
this should die, but if this ever happens the error is probably
recoverable for the user, and dying would just make things worse.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 163ca69df0..a605e01692 100644
--- a/dir.c
+++ b/dir.c
@@ -1857,17 +1857,22 @@ static int open_cached_dir(struct cached_dir *cdir,
 			   struct strbuf *path,
 			   int check_only)
 {
+	const char *c_path;
+
 	memset(cdir, 0, sizeof(*cdir));
 	cdir->untracked = untracked;
 	if (valid_cached_dir(dir, untracked, istate, path, check_only))
 		return 0;
-	cdir->fdir = opendir(path->len ? path->buf : ".");
+	c_path = path->len ? path->buf : ".";
+	cdir->fdir = opendir(c_path);
 	if (dir->untracked) {
 		invalidate_directory(dir->untracked, untracked);
 		dir->untracked->dir_opened++;
 	}
-	if (!cdir->fdir)
+	if (!cdir->fdir) {
+		warning_errno(_("could not open directory '%s'"), c_path);
 		return -1;
+	}
 	return 0;
 }
 
-- 
2.15.1.424.g9478a66081

