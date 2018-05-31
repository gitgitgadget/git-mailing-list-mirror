Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFF61F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeEaTxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37072 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbeEaTxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id l1-v6so56082929wmb.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dnJ7tgmd8XI4rg+F/Ty8hVkRBdPI+V9HKyON6aCrMSs=;
        b=s1YztfI+MOAQxK4jaqgVjUeBMQv8K+tOm+HN6URPx+pk/McR2lp+c9mCOLZ/7fMWU3
         AHRx82AZrwRmCbJicBKAQJQ0fThmU/ADGg0YJA8pT20AdntyyzhfNifxNNKLtDYOQFis
         r+fyCYL7EQINLkoqknfs4Gf4AHgw3p0rEooIyZiXb+BvdrkX5J67hoqB2AnmHG9RZ/ms
         cfDYU4YsfbSQn2qqR3dHeVDhl7Wm/mXNHWBIla6i2KRVFqVGfLN0WxZquYvPRQp70Vfy
         dmkS+7b+lqmljkfpTyVFaQXchIvNSzT0bFV8nhCmLxGtUlizIyAYVs172/sZVS2qqYLJ
         6BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dnJ7tgmd8XI4rg+F/Ty8hVkRBdPI+V9HKyON6aCrMSs=;
        b=hc0tDAkLj/+WgwyUaJ7UEqFebPnYSPCnNsPSaDvjIMFik8Hc5F7ssH05KSv6WszxHp
         JzQdOtuSLeIOPRThoWJPkGQ7D5RtgF2Fms09eYqEnDa0h+NF7QG7Wl/X9QFmRVWwDwf2
         k6ZFHHnO++q9fNaVZfxrJW3P2n5stPUfADMoD97ux1KhtQkBJTEn6qx7MklKA7ZACUNk
         j6mXdYigOwjaBnSNOoh9vEhU1yCqYUeXIR8A5NSBfVDM5q53C+iLImjHs7vVN5IJQHit
         HXo8BJnZvFLo5RVEFiGgblAqLe71wpVQfrkzF+kbENG3mJPA3VGP56mZusEIkBKDymWF
         JWRA==
X-Gm-Message-State: ALKqPwd1I61dqrPp1ucGwd/KJrPFHEFaIoQn0DUbqJRYxi94GIbWaK+N
        PYxrxt3qXtoJ9lPs6dTwNGqiK471
X-Google-Smtp-Source: ADUXVKL/wFCdQcNYJbE+j5pYKIKLeqHhubUIvUgAtVDS8u9gHkrOuNz6QbZ1CU3ED9rl1tjRyHTAJg==
X-Received: by 2002:a1c:d9d3:: with SMTP id q202-v6mr746106wmg.84.1527796408764;
        Thu, 31 May 2018 12:53:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/9] checkout.[ch]: introduce an *_INIT macro
Date:   Thu, 31 May 2018 19:52:47 +0000
Message-Id: <20180531195252.29173-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an *_INIT macro for the tracking_name_data similar to what exists
elsewhere in the codebase, e.g. OID_ARRAY_INIT in sha1-array.h. This
will make it more idiomatic in later changes to add more fields to the
struct & its initialization macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 2 +-
 checkout.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkout.c b/checkout.c
index 8d68f75ad1..629fc1d5c4 100644
--- a/checkout.c
+++ b/checkout.c
@@ -25,7 +25,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 
 const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
diff --git a/checkout.h b/checkout.h
index 04b52f9ffe..a61ec93e65 100644
--- a/checkout.h
+++ b/checkout.h
@@ -10,6 +10,8 @@ struct tracking_name_data {
 	int unique;
 };
 
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
-- 
2.17.0.290.gded63e768a

