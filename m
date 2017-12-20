Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34541F404
	for <e@80x24.org>; Wed, 20 Dec 2017 19:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756058AbdLTTjA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 14:39:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37106 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755740AbdLTTi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 14:38:59 -0500
Received: by mail-wm0-f65.google.com with SMTP id f140so11820818wmd.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QqV2v91aHFb/Jtgl3zr0stsDQ6xWgmsfBeEC0kWqSA=;
        b=bNyxxs3MEdJsb6TixZo10PCQcYJb5JXvZTfduH7O4JLITumYiB//2RcUVgAo6SBB1L
         XD0MlCeovErnyCwtVUmoeMeKxD1QHLfD4IQy4htr2TGxHNmUNCypgf1n1Ym2XojwFIrj
         cuSNqFarqsfE+4izVJ9LXueWDrN35NHjtJZVopWhVQJvXiTFNaw7/NuLL9r2To9C7m5i
         OI4P3sxq11o6l5zLzpEx6fv4khsEsf0dy62OJZjWLhlYsFOz1+i+QLHKBV+RKV5NuWxT
         9ZNk6zY13d6x3djg10F9cF0uxL27zVQBVl/tRYtJmMd6l2S+TZsCbzWZKWO3lX44zX5B
         NVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QqV2v91aHFb/Jtgl3zr0stsDQ6xWgmsfBeEC0kWqSA=;
        b=TAMTqqVkYvKhwbk8/gGBBQT1XYnr/Pz2wa1ZcG+oPFXNo0p1at3ASAIRtvGWUp9v/J
         YZ04YlF2bebUsh/JRNBCw5txFtqltv+JF19K5AyNN71VJOd8hpbvB/DRDh2Wy+1X4I++
         2+h0mtDG+7+7s8uoHnv10phpscJNbcjN/dXrXEnqP7lBk4kB99ZGB4pZlW5LSVZ+4Gxq
         PJRUgX6bsIaeitAFCAFlE41H6nFMaomf1gqPr9EmcZK2f6b8gRyWiM7iEYAkAKeqiluE
         yl82ewbQ8gpDsmKI81NtWg6JlcvitDUU6RqXpc//Z2T+/iDrd3oyz/J9nxt0RTiYlX8R
         ogXg==
X-Gm-Message-State: AKGB3mK4Uu0VKEbwtiXbhArw+DN3eNB/1A2NOcgPi5AeIX9qwN7hsx/q
        wFA9FxhdaKGz2wKeDJL4KIFgasJW
X-Google-Smtp-Source: ACJfBov53mDGJ6Zg9wOdIFCUKYdApmDU33Q5gpvm8TCJPrOkXn11xgHmGrYsH55ekEJyM84x0JPdmQ==
X-Received: by 10.80.240.80 with SMTP id u16mr7004588edl.5.1513798738401;
        Wed, 20 Dec 2017 11:38:58 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k42sm15509500edb.94.2017.12.20.11.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 11:38:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Pat Notz <patnotz@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] commit doc: document that -c, -C, -F and --fixup with -m error
Date:   Wed, 20 Dec 2017 19:38:44 +0000
Message-Id: <20171220193845.11754-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that providing any of -c, -C, -F and --fixup along with -m
will result in an error. Some variant of this has been errored about
explicitly since 0c091296c0 ("git-commit: log parameter updates.",
2005-08-08), but the documentation was never updated to reflect this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-commit.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8c74a2ca03..df83176314 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -144,6 +144,9 @@ OPTIONS
 	Use the given <msg> as the commit message.
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
++
+Combining the `-m` option and any of `-c`, `-C`, `-F` or `--fixup`
+will result in an error.
 
 -t <file>::
 --template=<file>::
-- 
2.15.1.424.g9478a66081

