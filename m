Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F89F1F461
	for <e@80x24.org>; Mon, 13 May 2019 22:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEMWnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:43:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41717 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEMWnT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:43:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so19826588edd.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 15:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qhjtK7LpmzKkJmAtVBNaXmOco5h7c8GOlIXTebZwwvQ=;
        b=ZcegeqW/v2aDdEbEkGDMVeJIQvS0f+/I4v64AP5e0pe1pKolIiFL02uADvXXHJoWNo
         8tuJiGxxgdW3a5qu55iy1ckYbEB6gLWjD5W2sreTK/t25sfxSPi1pyu6FLmkjPrYkNkG
         8doXZ+C+EbhlDncp4UKgKX1j171/tdMCyH8eMbiA3Kd3F4B/4ZIdpzyuVol1cfX3cHRH
         GqgYYVEnwIrS7SG4vZUiYXYSZ3vkuppwQCUBIGwbrAszuZo4poB8wH0cjqI0D+ZIWBUF
         wiFQKzD5U/z1D0PEgPio6Zt373AdhutgzjvdmwuYhdTn0O9HwpNQU19rSIwc6p/FpqsR
         L0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qhjtK7LpmzKkJmAtVBNaXmOco5h7c8GOlIXTebZwwvQ=;
        b=BXMmAVQ+8EqDGBdOidmS58Lf1hSVluUBdXAuU61/Ug+U53gUlMx4ptLGmexewMsVXl
         +lYqqUjtvaaKm0x9lzJg8AV3qeMotcMBVQxsl0lOq8TTTa+SGgOQ6qCv/c7TmXCTh6yi
         9g3qENDQ0C5wZgis2Dci+cmnVE/2uFeReTc88ZXAYgX5OUmBS8MDWDUOUriVbZjSkI9z
         h/UvCN8/db5wbfqzE9LqEr9hgzFHi9TcCc4kFpQqny8ZtMTSmRmfCoGb0JYqMlAcMAzf
         DuXFuLtU8JA/i0ZRqkRCCowI0IOdQiOfz/bCy/xL8koFE25Tl7q3lAWZP4dk+9qyTigC
         vNWA==
X-Gm-Message-State: APjAAAVKNeWx4Feg9U8Dr1BBma1xTV7Laptvn4pnQJcaIcE4jDumjx88
        mesqeU/DwJ158Ynes9ij41sG9/Hx
X-Google-Smtp-Source: APXvYqwlajqfqFuysw8Dyr0jugj3apfw0aUbj2Jl0U9FYQVBANQdXSoZELMiwnpKTXxu38kM4u/G+A==
X-Received: by 2002:a50:bb24:: with SMTP id y33mr31913622ede.116.1557787397614;
        Mon, 13 May 2019 15:43:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a61sm4048843edf.8.2019.05.13.15.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:43:17 -0700 (PDT)
Date:   Mon, 13 May 2019 15:43:17 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 22:43:14 GMT
Message-Id: <dd283736b72d3e52bd298b0360ab66ffd15c1cf9.1557787395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.192.git.gitgitgadget@gmail.com>
References: <pull.192.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] parse-options: adjust `parse_opt_unknown_cb()`s declared
 return type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In f41179f16ba2 (parse-options: avoid magic return codes, 2019-01-27),
the signature of the low-level parse-opt callback function was changed
to return an `enum`.

And while the implementations were changed, one declaration was left
unchanged, still claiming to return `int`.

This can potentially lead to problems, as compilers are free to choose
any integral type for an `enum` as long as it can represent all declared
values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 parse-options.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index bd00cf0049..cd756833a9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -286,7 +286,9 @@ int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
-int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, const char *, int);
+enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
+					   const struct option *,
+					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 
-- 
gitgitgadget
