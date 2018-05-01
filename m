Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295AB215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755019AbeEAMHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44208 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754952AbeEAMH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id o15-v6so10636688wro.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=emjKGt5JwT+qcjx2Jhu7n/i775bFOHNjvPW3ltkaPag=;
        b=cfloQgO0XFlbG3w/uGQh9cwZ579oBpGrYy497URXUdUKXrGZGLnqu48ZFZdOvQV+wf
         XKa8SOdASVlXRa7toGrVQgFRZcSO9TJ323eyYR3Onu33zMxYtBRTS3Zrh7u1YTZ2vznN
         gv1QiKSP6elxLwMHHvN357NwWZ+c19feqV/6Dvvs/zej2s5+1FEYBzli3llwIC4Ti9q9
         MO8zJuozFpEWPhfCZAEYRgTAEMZYjN6Aef57rmUCm00YrZCjAhJzAwXimluaxsf8xIWC
         2IhI72ZfLe7Kl/d1gW3lmOllTwshFnlpN5vMkVdkwSPj8ImoEB0xizaInSpwTFz51YO8
         G5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=emjKGt5JwT+qcjx2Jhu7n/i775bFOHNjvPW3ltkaPag=;
        b=kb3cw/CgKMSHN+OB6hJd4KKwNAPIjWr1dGu7NYaokUrJP+vQQBTqtJz20htT5SPiT3
         5nuOFQt13jNUZqhZ0YsDf1kknOArGK/buIPVZGSZi9JgP/xPbPtK7midwu5cIitfl6nN
         EFWm7N5ItFb+bk8bSebLh60IPpLBYW4RP8WWDP3eVTLu1TRfwAHxhis+c6xpAKzVSCrJ
         5Y/4c/xMblhYbSwNfu8FyLT+xQ+fR3aIQsIgeLGz9AUouBniBqj03slSaKwvE1TwVQCx
         KYTXSaZIsVor5DBiZvog+h08NC5X8hM7IdxzBRDO0ud/SvCyN3OEcsQNaqBvidjAkeIo
         l80Q==
X-Gm-Message-State: ALQs6tCIMwtgvij7PaihZSEHdecaOsTbbJhZB9ExlFDSgeUiNFhLI5X5
        tQmtK5sIcYyfKPWtqcMLZhWTRQJ8
X-Google-Smtp-Source: AB8JxZpnddN3LyGYhEjvJO2Cq/pd/LiByYKlGd1NAMkKMN6ASWdgZ/ZmCfm9a//U+yaorr1BgkMjGA==
X-Received: by 2002:adf:e58c:: with SMTP id l12-v6mr11446428wrm.38.1525176448401;
        Tue, 01 May 2018 05:07:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:27 -0700 (PDT)
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
Subject: [PATCH v2 04/12] cache.h: add comment explaining the order in object_type
Date:   Tue,  1 May 2018 12:06:43 +0000
Message-Id: <20180501120651.15886-5-avarab@gmail.com>
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

The order in the enum might seem arbitrary, and isn't explained by
72518e9c26 ("more lightweight revalidation while reusing deflated
stream in packing", 2006-09-03) which added it, but Derrick Stolee
suggested that it's ordered topologically in
5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com. Makes sense to me, add
that as a comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 77b7acebb6..354903c3ea 100644
--- a/cache.h
+++ b/cache.h
@@ -376,6 +376,14 @@ extern void free_name_hash(struct index_state *istate);
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
+	/*
+	 * Why have our our "real" object types in this order? They're
+	 * ordered topologically:
+	 *
+	 * tag(4)    -> commit(1), tree(2), blob(3)
+	 * commit(1) -> tree(2)
+	 * tree(2)   -> blob(3)
+	 */
 	OBJ_COMMIT = 1,
 	OBJ_TREE = 2,
 	OBJ_BLOB = 3,
-- 
2.17.0.290.gded63e768a

