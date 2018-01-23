Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BF91F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeAWWN7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:13:59 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36405 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeAWWNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so4879797wmc.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TkkrwHDi1W0C8pgUO+YTd+ieHDWl8PgD9ggMEburkCY=;
        b=kDl5D3sysuZYj4wFaPawW4Zi1bnTKNmeaTsf9F7tBQKpIlxrxMWjO6klxKSR3QbHSl
         oKiw7iJNLRIub4Qy4n/ZB6cujX8Q1lnbKbirDfjurEMN9UBpano0N9cDEZMpau7vjvt8
         561tj0ORozhQvvXse3H5ngFE3OEqrNc1HPaz3U5OHAxzAMDEjH3ne3Z/dGECOs9hSh0a
         lAa82FrOVw0qjCTttL1/J10fZh/+U+NsHtEKNN4uFOJjAi52vUgV6cUX56C0nrsrvR2K
         Aqvff4mBoOF88ScAo7J/vrVjDFYrCsRcsIkF9H1XD/g1faNshacafuG34mRbhhGnJHc3
         wCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TkkrwHDi1W0C8pgUO+YTd+ieHDWl8PgD9ggMEburkCY=;
        b=BzsNSIVcnvls4NNhpF+7xOURQCTRu30RNYiauTGSGipuwvjoLLd1CgDXu90LyO4m6s
         YB6mn+5LAApyTfMt+jZRRAnHOlztFqt2kDQPSCWcoCh93UJy7h7EoLIoKmFhxLFpNzpk
         E6VhMbDug/uYWG26hF8i3yItWxkfTqgP1QGC3e9ssphLqiYCAkDhm/HcoQwqp5vo1kpj
         zAexch8p2O1CUyxxPmbsQu0XIM+YRrknFHBGvWYPCWmKPdYycnW33E5x0k95xy/6Gm8A
         EloSQAi3bxuhtjIzmaBpCnWRPNffDvaYei8LzBuR4T1LnCbWFHB/79M1QR8GOUmWl/B1
         5zug==
X-Gm-Message-State: AKwxytfiBa4XVjtJ9cIpsnXGBP20NfVA+ogVk4hWQbfMXl7RJ1dmQDCE
        u199ett/CkM5bQ/GfBuGaa3D+mUe
X-Google-Smtp-Source: AH8x2262UPjBtZ7jqTrBqTS+ZllWwLtkK18dcjdwCHfhz5Q9/liAZVZSHyhIOued6Tkqk95NI6xEDA==
X-Received: by 10.80.245.92 with SMTP id w28mr21114223edm.73.1516745630749;
        Tue, 23 Jan 2018 14:13:50 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/11] fetch: stop accessing "remote" variable indirectly
Date:   Tue, 23 Jan 2018 22:13:17 +0000
Message-Id: <20180123221326.28495-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Access the "remote" variable passed to the fetch_one() directly rather
than through the gtransport wrapper struct constructed in this
function for other purposes.

This makes the code more readable, as it's now obvious that the remote
struct doesn't somehow get munged by the prepare_transport() function
above, which takes the "remote" struct as an argument and constructs
the "gtransport" struct, containing among other things the "remote"
struct.

A subsequent change will copy this pattern to access a new
remote->prune-tags field, but without hte use of the gtransport
variable. It's useful once that change lands to see that the two
pieces of code behave exactly the same.

This pattern of accessing the container struct was added in
737c5a9cde ("fetch: make --prune configurable", 2013-07-13) when this
code was initially introduced.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b34665db9e..a85c2002a9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1280,8 +1280,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 
 	if (prune < 0) {
 		/* no command line request */
-		if (0 <= gtransport->remote->prune)
-			prune = gtransport->remote->prune;
+		if (0 <= remote->prune)
+			prune = remote->prune;
 		else if (0 <= fetch_prune_config)
 			prune = fetch_prune_config;
 		else
-- 
2.15.1.424.g9478a66081

