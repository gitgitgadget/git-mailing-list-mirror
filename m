Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CEC215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeD3WHv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:07:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36733 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeD3WHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:07:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id n10so16523337wmc.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Prnr6gVzoaDi0OEFGAOCRl9RbY2eQ6UNNL5A29Q1II=;
        b=s2arloAEVAIkT7yu7Ww2UcwJkNWbosDSKKymlZ7vip5ZzWC+ve7NUp52RJKrN95ryo
         KEgVkH12GSW7ERxa12vrZIN65VTQTDei0K/O+E0LZdXz4GEChFqmnoB3d6YAPUG3lRTE
         sTvDL86O49aTxeKYGeF9ZH4lR9WpDMpWXr67sGIXA0S+wrRtF4SumVbevw7NVB3maPK4
         e2pu+XrVselBmcui3UVL/yuvJvpHwpexUuTRB04rLMM9OuwaqbajLY4K45gE8qA1sROs
         I4Gj5rNAtqhexncLR/G/hJE3PtZAeAwRdLctfmWavDgztmL9G+v5vqiOwbrSGcxvOrSs
         ueuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Prnr6gVzoaDi0OEFGAOCRl9RbY2eQ6UNNL5A29Q1II=;
        b=C0cN6WK32twzOutQs69KPP0ju4gfh8S367puggqeIBIqOSbUgD3mCIt2R9c1k4FL8+
         S43JVOXdm8ZkqBuqOfYtKJwxxCz+OizeqGVbqH3i3JX4PENr4oN2X6lAl1ieStL3MPfA
         bEu7LVBNcrRALEkT5yTjfCcV5AvRGD2fCnnXcL/Tx+HoS2SSynrpvpCz4zYjcI8LEuzY
         rQaPErfpShmRHu3qLyYGzfi6HhD52OtLDjhBhJ/MUKOS6ONMEDvHfnXGwbwQHoFfZNHI
         mx2Z10ZzxXIbcdfVkYioRiCFPsZX4SKpp1JnMcOeJyjxly++/rLErTuU/6Eb4cg0QkDV
         Nx7A==
X-Gm-Message-State: ALQs6tDPZJqtqaeU4ePvu+EQzTBeydmN4PjX5pC/UTWFal7EMjNtuwO8
        572O7sQPcXnm7BbefFRU1gmTJgxu
X-Google-Smtp-Source: AB8JxZp14lN/Mg6kY0+qnJKkTYKYutpyNPBfLWlGp1rQTDupFhFKR7MTuGB7RHGvMEpUvBlKQ+uvJw==
X-Received: by 10.28.122.11 with SMTP id v11mr8828444wmc.58.1525126068805;
        Mon, 30 Apr 2018 15:07:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:07:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/9] sha1-name.c: remove stray newline
Date:   Mon, 30 Apr 2018 22:07:26 +0000
Message-Id: <20180430220734.30133-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
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

