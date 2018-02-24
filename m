Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37211F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeBXDfD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:35:03 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47070 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752996AbeBXDfD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:35:03 -0500
Received: by mail-pl0-f68.google.com with SMTP id x19so6019201plr.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFYlGDjLPyvdI/6eMf1yMgUeKZteZw0ThlzuAKLRX2o=;
        b=GKRHuIAd41/e0XALIBWYLYZxMFWwoTqsdG71fGyh+e1qblH6QzQv8udLAPRs7fWkfB
         EGrD0Gcajte2YhTDuSfEr89d7bB1b+b7fqKsqrbKQX38GAKyR7GiQzvXnFj2xpWM2Xca
         5bWujpdoOhYXkLiIaOkiPydITVk622WgZNlpXAo53/Ubb/vF5YDnC+qR680u37MkgTRD
         VwEgNESvFUhToCX2N5CaerJaGeciyzAfiE8XAREn6tRyE7AwzgMxQ3SmE8JCpNB7XqJA
         GYQZ5R14CpglgedlAiTdoFeRWq9OV3apxNNeB3giJdNaEjWhzS11ZcDUjS3QcN39exXW
         6L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFYlGDjLPyvdI/6eMf1yMgUeKZteZw0ThlzuAKLRX2o=;
        b=ibS/N46zKPW63+LxbIBDmiBNH6NSx2XhAYxC2N+KYDp0eb7cR+XbHvCItSILZzWPxO
         vSeRXiqwa56Kj763QJkSDeb37gmZXFaYMx0nEe3AjcjkPXBXx1mNpkWNbhVIQxBCb4o9
         FGagg4+JwvV+ZnbQrTfyAtDVVYvkthvdYPPZ08wvQdZoIK/nEFsknKv9f+seZWE70tot
         suv7mnfbWyRYl4rrNwsqGTcvYNQjBdNkqjzqy9vR+umZrB/EGR0AKXprcWyB/vtyx1E6
         ktCes1g4uEpg17l7wZKvfRpbvBKjJQMpPdbDZbRfvbSi7A3yCowc2Pk8wJ/3MMJo31Gz
         zzRQ==
X-Gm-Message-State: APf1xPDhRLzzElaaI1YTu9Kdioj9ivsZaAw8mcEAmCjYgwZXQwu+Sane
        mUCweQ9BczgUs92qaYe4OalkSg==
X-Google-Smtp-Source: AH8x224QiHgp7sEY/pUVe4lpsJ5y0O2wRDJ9l4NdRUGStbDtcEMC5JSgg1/FJwfXpd1szhAQ9XRWFA==
X-Received: by 2002:a17:902:34f:: with SMTP id 73-v6mr3602083pld.55.1519443302400;
        Fri, 23 Feb 2018 19:35:02 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f80sm7575235pfa.176.2018.02.23.19.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 19:35:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 10:34:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/5] diff.c: initialize hash algo when running in --no-index mode
Date:   Sat, 24 Feb 2018 10:34:28 +0700
Message-Id: <20180224033429.9656-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224033429.9656-1-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our "git diff" command supports running as a standalone tool. In this
code path, we try to hash the file content but after
18e2588e11 (sha1_file: switch uses of SHA-1 to the_hash_algo -
2018-02-01), there is a chance that the_hash_algo (required by
index_path) may still be uninitialized if no repository is found.

Executing index_path() when the_hash_algo is NULL (or points to unknown
algo) either crashes or dies. Let's make it a bit safer by explicitly
falling back to SHA-1 (so that the diff output remains the same as
before, compared to the alternative that we simply do not hash).

dòng được

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/diff.c b/diff.c
index 21c3838b25..f5755425b6 100644
--- a/diff.c
+++ b/diff.c
@@ -3995,6 +3995,18 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		return;
 	}
 
+	/*
+	 * NEEDSWORK: When running in no-index mode (and no repo is
+	 * found, thus no hash algo conifugred), fall back to SHA-1
+	 * hashing (which is used by diff_fill_oid_info below) to
+	 * avoid regression in diff output.
+	 *
+	 * In future, perhaps we can allow the user to specify their
+	 * hash algorithm from command line in this mode.
+	 */
+	if (o->flags.no_index && !the_hash_algo)
+		the_hash_algo = &hash_algos[GIT_HASH_SHA1];
+
 	diff_fill_oid_info(one);
 	diff_fill_oid_info(two);
 
-- 
2.16.1.435.g8f24da2e1a

