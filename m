Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F1C1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeFEOlH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42750 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeFEOlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so2711040wrk.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Iw2YiB/ZkIh4oCVAMKTf2c/oj+UFgHHJJM7iLMD06Cw=;
        b=d2JIKOcbreJkZWMzEboN/FM871A1Azc+8NKbKTKhjQrdcL2JqRNmj/bmJ3g9//TTmF
         bucCiwleF8/43JfmQy/LzJlx7ohGuhDIIYGpUY2zwDpqVb62LGe2ccS9StkkDr3SOzPO
         vzcoJXN3T+lweR/Mmji0yoeZy6D2H+icMbwVTjdAT08QeX8ryWtw+QpsiCdKkZnH9l1w
         N6ZAOsef2LgZX1HdVC7gAaKjj1gsW2aP6OTyPq7VocvkH51z2fVLYeVQ+dWuiPQrvXg2
         KlKyzbBvBPl4Eq4NUFhZz6mpaoycMI9VyaYtHBQYwmBRgiPKzrqkEi51EOe4iLy/ASIw
         N2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Iw2YiB/ZkIh4oCVAMKTf2c/oj+UFgHHJJM7iLMD06Cw=;
        b=kNuWT/NjrLOU2sCHO9upH9b6FackFFXPuBQNMSOyOKY7iV/4i5w0HKNcwdgZnXqRjS
         Cre9Ddbkki+CIbvysyfEkCW+LhiazM7/QFcutYvZ44BFIXyGPRhrJIAjDaoN5vscKr2A
         mlhG7DjvrDs8kK32CheS05eXdB2g7tqICOctifHj0K5JXksFjgt8QeX4aj8V0nwJjVUI
         IY0WWKVdqhC33AnJN/9XTMGWyITO6p4lZVlm0mCmPONPVhPk+H7AX+znki9eJJxb4iPr
         b/+T7wNLmma2WZlyXcF5eUDDDNIpqok1zJgJaK6UMaxqujD2O99zXZEeNf7Xd6nid180
         RILQ==
X-Gm-Message-State: ALKqPwcZD2s1EyjlR3qKgrWzguIFHtVDEuYVy9HfzlpN/azJ07/xk0YP
        w0br+EvhX2b6OZ6E/1z4Qr2udbqU
X-Google-Smtp-Source: ADUXVKKGisf3ZVc5M0xhh1IvFsAXeapmG3vePz7P3s+LFLuEELR72pksS1DUpLdLCl1OyYMXaxdTYQ==
X-Received: by 2002:adf:8bdb:: with SMTP id w27-v6mr20293108wra.169.1528209664187;
        Tue, 05 Jun 2018 07:41:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:03 -0700 (PDT)
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
Subject: [PATCH v7 3/8] checkout.c: introduce an *_INIT macro
Date:   Tue,  5 Jun 2018 14:40:44 +0000
Message-Id: <20180605144049.26488-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605144049.26488-1-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com>
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
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
 checkout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkout.c b/checkout.c
index bdefc888ba..80e430cda8 100644
--- a/checkout.c
+++ b/checkout.c
@@ -10,6 +10,8 @@ struct tracking_name_data {
 	int unique;
 };
 
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
@@ -32,7 +34,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 
 const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
-- 
2.17.0.290.gded63e768a

