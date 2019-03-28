Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEAC20248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfC1QOt (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36434 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1QOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so5938294wrd.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Azel+emmJoppX1wRkVgtkK2y/tr9G+gEDkKxNECillo=;
        b=WfnM7I/5PerRUniulbxpQAVqX6dotMPRWGptUSVR4xRcM3PwkGH0quUxYJCMFUXMxf
         ZTfnNltcMXLGHKs1a7xvFYJ4B8kLwtK2LGGSPp/pOLHYtKggCSmjQg9lzxJC3juIz4tw
         SjluL90HUkyh8G85++e0joluhPBdbwgvpWBAji0jqSuidMER80nDv044cSYbP6gop3TK
         6DXOF5MKahvHhL1KK5tUX55lwfgvJmaOLlfL4n5X72gje/5sGRutjARWmydZcS5Ja42L
         n5PYogZOJu/htlMYShvQVedpOvvq7eZGjG5iw5ny+6+IUcxMfPR9pBGo7ndPdoOc0/pr
         Vpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Azel+emmJoppX1wRkVgtkK2y/tr9G+gEDkKxNECillo=;
        b=AgUIrtgTuV22xV2G2BY6/RdpLM52x291TMVg0j6qthq6k7DoEq2/2LFMIUQruPDCwF
         x63WFx/VlNNWpdLfpE4q1XbFU31/4z3/ajTVjlgfjNKcZLUCWCF7bA3DRVYa7fUd8R1B
         HkB42C//lWKkvnAAKz3yU5UcFYmgilbTsDQMoGTgH1LlcrVyub0/F7lxiTNliIr9jwne
         KEievsABzdde9r5TcYBJwInD96f8awYgmDhEd6Tn7QDfIPoCilc94kCYSPQRABD8LI2s
         AURLG8abSa419gbwlvaKduRzd1HRKH/s4jLHUSyrofA2ZH7ONeKbed/B73z97e6PVPwi
         MlQg==
X-Gm-Message-State: APjAAAVyYo1Q19o4aBO779fz6GzklI03loutTGSxXFAFEuczQ1li4hMO
        X3NHvLtS+kLsOVyJG1n60hPYLeoX
X-Google-Smtp-Source: APXvYqy0fyiTkFTN94SrVSuocX39OybvBg6HhZeCYXG8poAUqeP068e8vjqWJrGo6+/KdYiwmaGQyA==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr27382615wru.195.1553789686545;
        Thu, 28 Mar 2019 09:14:46 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/7] gc: remove redundant check for gc_auto_threshold
Date:   Thu, 28 Mar 2019 17:14:28 +0100
Message-Id: <20190328161434.19200-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking gc_auto_threshold in too_many_loose_objects() was added in
17815501a8 ("git-gc --auto: run "repack -A -d -l" as necessary.",
2007-09-17) when need_to_gc() itself was also reliant on
gc_auto_pack_limit before its early return:

    gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0

When that check was simplified to just checking "gc_auto_threshold <=
0" in b14d255ba8 ("builtin-gc.c: allow disabling all auto-gc'ing by
assigning 0 to gc.auto", 2008-03-19) this unreachable code should have
been removed. We only call too_many_loose_objects() from within
need_to_gc() itself, which will return if this condition holds, and in
cmd_gc() which will return before ever getting to "auto_gc &&
too_many_loose_objects()" if "auto_gc && !need_to_gc()" is true
earlier in the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..8c2312681c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -157,9 +157,6 @@ static int too_many_loose_objects(void)
 	int num_loose = 0;
 	int needed = 0;
 
-	if (gc_auto_threshold <= 0)
-		return 0;
-
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
 		return 0;
-- 
2.21.0.392.gf8f6787159e

