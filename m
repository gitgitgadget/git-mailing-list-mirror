Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FB91F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeACUtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:49 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47087 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeACUtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so4841130wme.5
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rU1YlcLsRTPvOoTjrcXcNAhbZILS2t2F+6mLUr/tXQI=;
        b=dgVqydRUVu179OdL5NrdP3kyl6ijx7fH9LKyyjqlXPvbHtMcEoTX/HE7VsfzJ2i+c4
         PrBro1kxkMjf+J4pkSJsr6xanC2mzqUcK54sWSs/N+ACvD0HYBz1rN4jJDbMNpCn18us
         qxyYnShu/9fu9gRCM3oXXbu3zt2J0lDWj7qKyujNhnzZgly1u3wTKUVwdtKj7T2WL0UN
         5J0yWKYdTfCBH46gBCHFu/t25UH81imSfPvbdqE6FrdqzMKiGmiQjMC42RRNCzt+UPFe
         nhvRNR8qt5HhejBrXkJtL1Ddc5aKQKtBu6jKs5NmiVLDLMseb26D/zxm3BOoMLRKN7Fs
         rgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rU1YlcLsRTPvOoTjrcXcNAhbZILS2t2F+6mLUr/tXQI=;
        b=EC7b85tesf8qME+f6GbJggEAttIAP/cdLjK8zFjdEFC+RZUqrx4fh123AhIMbIsTrs
         FPnj4dO94sXYoN0wQsPmpOi5yj+WDELw1hwXZjDO7y8iKrrdFJnBb/bXWB1fMtc1q4CF
         oqB0Utc4G/Yp04TVtMw/F4sbjby31cT3qp1KtwlGZq8qcK5cqqeV7fG2IdtBFnG2Ie+7
         8tpDHucii7eMvpgCQFrnPQElOaP1z1WgtmxaY0wv8V7AlGOfYuCY/MFJW04TkjtEaSl/
         ECxMejz0SAEFGSaD7Nyfz2VNuKl1N21+AVtlAuQaEVzewMB/I/KcgGHEWRyOGqIXm5mz
         vfGA==
X-Gm-Message-State: AKGB3mI8xururnkUEVfWFuea4eE36b8EUsmbEKmXDv/4r9pKuyUcIVFn
        P3NFdp2JIY/t4/8F6xQ5v4Ecrlh5
X-Google-Smtp-Source: ACJfBouZwCUzcQGqjoEIRj0yz2yYdfFJSHdTVFHjaj10zfqI74uLadxibwLqKSPByMZNJbv4bSdc7g==
X-Received: by 10.28.48.4 with SMTP id w4mr2386283wmw.16.1515012585756;
        Wed, 03 Jan 2018 12:49:45 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l9sm1908443wrb.45.2018.01.03.12.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 12:49:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] update-index doc: note a fixed bug in the untracked cache
Date:   Wed,  3 Jan 2018 20:49:27 +0000
Message-Id: <20180103204928.3769-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180103204928.3769-1-avarab@gmail.com>
References: <20180103204928.3769-1-avarab@gmail.com>
In-Reply-To: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the bug tested for in my "status: add a failing test showing
a core.untrackedCache bug" and fixed in Duy's "dir.c: fix missing dir
invalidation in untracked code".

Since this is very likely something others will encounter in the
future on older versions, and it's not obvious how to fix it let's
document both that it exists, and how to "fix" it with a one-off
command.

As noted in that commit, even though this bug gets the untracked cache
into a bad state, we have not yet found a case where this is user
visible, and thus it makes sense for these docs to focus on the
symlink case only.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-update-index.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index bdb0342593..128e0c671f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -464,6 +464,22 @@ command reads the index; while when `--[no-|force-]untracked-cache`
 are used, the untracked cache is immediately added to or removed from
 the index.
 
+Before 2.16, the untracked cache had a bug where replacing a directory
+with a symlink to another directory could cause it to incorrectly show
+files tracked by git as untracked. See the "status: add a failing test
+showing a core.untrackedCache bug" commit to git.git. A workaround for
+that was (and this might work for other undiscoverd bugs in the
+future):
+
+----------------
+$ git -c core.untrackedCache=false status
+----------------
+
+This bug has also been shown to affect non-symlink cases of replacing
+a directory with a file when it comes to the internal structures of
+the untracked cache, but no case has been found where this resulted in
+wrong "git status" output.
+
 File System Monitor
 -------------------
 
-- 
2.15.1.424.g9478a66081

