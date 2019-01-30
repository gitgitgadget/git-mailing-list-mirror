Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7935E1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfA3Jt0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfA3Jt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so11198275pfg.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x81kYxZXfTj2NC7DU898ufi4IvEhU/i2OI+vrB7QF2k=;
        b=de1yIiHomHcS2Zj9Y+jnpo7ZcyuiF8PuJOccUA/Aw+YheqsTEr683f+W2JPpgD/CZp
         PtrkRQs0BfzNUlbQtoMqyT1aML+x+CedTAGbX6fWKwGDYaQLKjp5fU1eDzcvivaCzxYB
         JS79g78eGxI/J7DEy6MCQcCCmzD5wApU1cpkAErFizZD4N14moYb0SDAuUtFCUjoP8eX
         H3LSjWwML1ZjOEHWFkFTsFDDfjOIhmZk7Mx99ydtFkge0/9L7H4vjJ4by8Y+44Q+dSEK
         srGMa/DhhhLHlVZ5nGn8blUyjugPJ4qdG3M30D9jEgeT/auMd2Bo+MhAWkc1+ZIk5ag5
         j+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x81kYxZXfTj2NC7DU898ufi4IvEhU/i2OI+vrB7QF2k=;
        b=FedPSQJkuFhqf08EsrJ7yOMq8oaV31q8WFeowmE+JCCStFWVkbxOSxpf8/dC0geJDy
         /yvMzw1/kqbQF9xTOEqON18fzRrprwofCneOtQ8U7biMYXzZounIWmvXezqsCWTbT3B2
         mNRPoyXfxPBu2kGkTOzzl5DLIrBZqRlhgZmCSHu+kmP/Y/0u42VgpwWCub7jlmhsLs+h
         Jv4phiclqAgum3tT5DuK3Go2ljfLwnneSMaQaSoKsxndG3Bv35tzSY7e+bLTlkz9zUNI
         0OcjpzM8TckxoCCzjYrZd4vXM85Up2ZUyiprh6pGwyZGQfXEYXaHHRsIt1q2z2F6JsQr
         JHlA==
X-Gm-Message-State: AJcUukeyC0xHyGL05fh6vZmeXlIYe8Pvp2Hes+x9f2WWSU7zQvIcTKzi
        rE+A4bAA9RsGuJYa4/yzJoXvuXDX
X-Google-Smtp-Source: ALg8bN5p9RflAzSwkXLIB/tgPGAtq5ukKrrxVtPYzBz2VLl5Nl2eFRKh/Ve0C1dzm2XHuKWiU7EqTA==
X-Received: by 2002:a63:7c41:: with SMTP id l1mr26571868pgn.45.1548841765303;
        Wed, 30 Jan 2019 01:49:25 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r76sm2002678pfb.69.2019.01.30.01.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/19] switch: remove -l
Date:   Wed, 30 Jan 2019 16:48:22 +0700
Message-Id: <20190130094831.10420-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is ancient. Nowadays reflog is enabled by default and
automatically created for new branches. Keep it in git-checkout only.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2251883a88..db9a2692db 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1357,7 +1357,6 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
@@ -1558,6 +1557,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_END()
 	};
 	int ret;
-- 
2.20.1.682.gd5861c6d90

