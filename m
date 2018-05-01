Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD0D215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeEAMHW (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37169 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbeEAMHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id c14-v6so10642456wrd.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5Prnr6gVzoaDi0OEFGAOCRl9RbY2eQ6UNNL5A29Q1II=;
        b=NY6w0FSwiYrG73vPlfZlPsFICHsKqM1TRgUwAlIA6Ps5iwKsgYFr4TBeReB+NXR8sK
         AEygBl/C9aS0ZwZcjC3ZVX1a+jsPpnj5XSS2xLSYwMcl36QW8sahleCZbvwQ/60PMgts
         kkOAKTAyVr5U/K8jb82jf2Morr7NGzUMRYHAJ29V11ZhN2Xjz8hmx6cJfSHOk4uJ/OXw
         VjUro+ntya2OmaXNVgw/Gd2vkzHC8lkKCLZreaCJKH6mpYPTvfmNl7FufNKtOBJARQjf
         0H8hRHf/JV3NO/jS8pk0EBDeSu3h79CaZgy/R0TaONQPHZePx0vL3SbiSpBTrzGasfo+
         k5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5Prnr6gVzoaDi0OEFGAOCRl9RbY2eQ6UNNL5A29Q1II=;
        b=VB3jjFPy/+2k32UKIixAS3s01tpfnSj+molEbZhn2A2IZSxDfAbEuRwsqxS3xPdc6y
         EOI66SDM8fALrG6qa5eRLhjluSqRZzrMTt2siOTq9A8eY0WeT8t2Z0wBU1mOUfUM4/uY
         2Wb3T3pD4yzTU2RGm5MPNdKYqiGz1RitskQQdUt8ErTOOtO7qIq2x2NQQ4JtNrZa91mL
         7Tpc+Wq6rUP+1BLJ3uOmfu1RjmeKTG8AAqD+8qi1R9y9chxwub0YSTdVZTY8uSgBiGap
         gHnmO3pYKqVj6z3D4THVBvRJHHYG9Mve6rV0HQPm6d6RiwfCEtdAtSdn0cIvcxsPrumY
         S6Og==
X-Gm-Message-State: ALQs6tAwMmZ0lC/FH0S94sQgZ6mocT/JK5DFJAQHFP4Hvf4OO7JE9oy5
        NimoTIainVU3AYjqhcSVACtmfDRV
X-Google-Smtp-Source: AB8JxZo2dRDSFgD3ySguqmL+S6OV+AtlPVKWz/DWUQgzo8uod9XNHvY05szIwd49S6nrmlvQVssJVQ==
X-Received: by 2002:adf:85dd:: with SMTP id 29-v6mr11626273wru.120.1525176439761;
        Tue, 01 May 2018 05:07:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/12] sha1-name.c: remove stray newline
Date:   Tue,  1 May 2018 12:06:40 +0000
Message-Id: <20180501120651.15886-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This stray newline was accidentally introduced in
d2b7d9c7ed ("sha1_name: convert disambiguate_hint_fn to take
object_id", 2017-03-26).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5b93bf8da3..cd3b133aae 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -346,7 +346,6 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-
 	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-- 
2.17.0.290.gded63e768a

