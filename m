Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7C120248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCRQPU (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:15:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34030 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCRQPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:15:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so17268129wre.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSf9p0wnG9SD9rIAiaQUadLh5xdeaOQHCnci9LKfWSA=;
        b=o1Rpq/NDe7ICYMzoNUW0lTJd0tj7nfd8uZsN96o1H9DGj8Zt16tBpjSjcBelJVGsJY
         gBMVvpPmS0RzbMvj2hnHZo6XucuHVlJmvvNNmWDQto3v6dLd6NHqeyav0utPvqUGyL69
         Huqa90pgds50kZdifD3qXsS578d59tnBmZjXShRtaKPOrYGO8PGkl+SqIb1z2IPnoIhe
         9bK+zsCRvRxJoaVxFI1664DImCKkUsUY4//nqdRkKle+WHtviql3nTXeR4XxlFZIKUPm
         +LyoV0ka/Ep40KWAS5isd0WyIn8kYRsrwVSreOFuuYCeAwBqING/EKlRqtg6yBLx1s+l
         V60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSf9p0wnG9SD9rIAiaQUadLh5xdeaOQHCnci9LKfWSA=;
        b=f+sOjAaXfNMNHyaU2auP8CfD6Htq3mZbgmTyW62AWClEgJdzijPIWoEwWafUKNKoQt
         BmQSindF8VRvOjGhWTZ8htvRlq7y8G/+zWKhWxJX1DBIrk/wWaatBusKOe0QOwn+SJTC
         bKzfTYNTHodNJzZ2r7mMOahr0YjQv0vUC63apiXwG+yRB2GO3+Uae3B9YSjbBReQVkVk
         NtSANrwgSxSbBLjYyrwbF/3FUd71c0obv59513354aeWSwlNCOGfdt02cmJ/vCkKsd3Y
         cXVN/sdtviDtXk6YhOcM73zkrqspKMGek+6NyaPhBIL5V1eZ2olNhzza6van7ZUO1sIh
         gBjQ==
X-Gm-Message-State: APjAAAVCJJIDJmr1O36qjh9if48cO+NrAj1uynI9TN6ENnionAMoqN5P
        ERU542WLgRA3xynRAonJIC+umz3SBfo=
X-Google-Smtp-Source: APXvYqyvHsFTO41PgzmqgMpP16QRyLyQHDl81isOR7UrWsDFVRKNuTp2B4wUK8JkZ6ZwXf4jVpGmkQ==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr12301618wrn.77.1552925717599;
        Mon, 18 Mar 2019 09:15:17 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z9sm3269728wmf.12.2019.03.18.09.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:15:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] gc docs: modernize the advice for manually running "gc"
Date:   Mon, 18 Mar 2019 17:14:59 +0100
Message-Id: <20190318161502.7979-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs have been recommending that users need to run this manually,
but that hasn't been needed in practice for a long time.

Let's instead have this reflect reality and say that most users don't
need to run this manually at all.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7c1b0f60ed..cc82971022e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -20,13 +20,17 @@ created from prior invocations of 'git add', packing refs, pruning
 reflog, rerere metadata or stale working trees. May also update ancillary
 indexes such as the commit-graph.
 
-Users are encouraged to run this task on a regular basis within
-each repository to maintain good disk space utilization and good
-operating performance.
+Most users should not have to run this command manually. When common
+porcelain operations that create objects are run, such as
+linkgit:git-commit[1] and linkgit:git-fetch[1], `git gc --auto` will
+be run automatically.
 
-Some git commands may automatically run 'git gc'; see the `--auto` flag
-below for details. If you know what you're doing and all you want is to
-disable this behavior permanently without further considerations, just do:
+You should only need to run `git gc` manually when adding objects to a
+repository without regularly running such porcelain commands. Another
+use-case is wanting to do a one-off repository optimization.
+
+If you know what you're doing and all you want is to disable automatic
+runs, do:
 
 ----------------------
 $ git config --global gc.auto 0
-- 
2.21.0.360.g471c308f928

