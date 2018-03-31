Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBFB81F42D
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeCaKDY (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40115 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeCaKDX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so15127792lfb.7
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nWBabZJ/1KOdOj6eFyhtDYpDdMTeg/oL57KprlLmjE=;
        b=D86l++owbJUhd4NoGYouOZLEnFRRLdwFbWDo39Ajp+ycWq+MaMCjGtJMByfEGISo30
         EPQCq4f3nC4jqVGODPPuGMom093K8hnEls4T3sd+gNzZ/ht8s4uWUfgotuSVHAmpSUr+
         QNGae0Yz8QlVjMbNwZJIaNVcoSkZ1soC8ggJMTsQ96WjbSNTBVtl6Ntnjmj7DogZKEkR
         1/Dh1uNdgSXovlB1yHhfS9rHukCYKdug/wKNP8T+j68cZTJexiXIT35EBDhHtnKlwUR3
         Cd6RZS9U5/A30Bh38nVf8wpuq4p7NFRBruDNCq4oi7A/lnjg1VmxiNy4v8sCpGWwL410
         hWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nWBabZJ/1KOdOj6eFyhtDYpDdMTeg/oL57KprlLmjE=;
        b=JnM5P8xnNyqO2c21uArbWLqdE/+HkZtnPzObRY/a9fW+EaUv5S0kGnA/JVx1LbKTjT
         xjlgzv0kdU9ZkPITZ5TkMRuwmkMhLJ4TaB/VbtbYoQTEVc5N53gdtbFhaR3YyMDLisKK
         RDTsSM/T++erpoJO08wc6mmrwLxIhObJ4FJaOVu4/IxODyzKEVa2jjZDn1zbvh1hgpYm
         jHTVASwC9XdKDCG3L6rppjHtDLXcpAhESRyf/LiKYIbTZT4PB1LnEhhV1eqm8ObswGsv
         jzGV2dNIHwuehIgKUvbNU3NG6Eq3heoPnX8IeR4MplAPT/Z1j4OqRxgz36jlYAEwqgrp
         QIsg==
X-Gm-Message-State: AElRT7GLPL+gICDGVGuCULhuZ1TKD6ZbKlrHCElR9xKp15vBA/AhDT05
        vCYg9YhTKdvVJiaD/Q3jF3Q=
X-Google-Smtp-Source: AIpwx48Y+lz2OO7AjjpjICIAOrsKT+65C0mH4ULdH4y7edGuhjhRhz1oCnAde1KGmDAEYjozmxf3/g==
X-Received: by 10.46.2.134 with SMTP id y6mr1404613lje.118.1522490601731;
        Sat, 31 Mar 2018 03:03:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 01/15] t/README: mention about running the test suite in special modes
Date:   Sat, 31 Mar 2018 12:02:57 +0200
Message-Id: <20180331100311.32373-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

There are features that would benefit from running the whole test
suite instead of just a few test cases written specifically for
them. Split-index mode is one of them. Document it.

This step is required because a few patches later, we will be
introduce more test modes like this to test some corner cases of
pack-objects as much as possible.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/README | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/README b/t/README
index 1a1361a806..09eb2b9768 100644
--- a/t/README
+++ b/t/README
@@ -292,6 +292,16 @@ and know what setup is needed for it.  Or when you want to run
 everything up to a certain test.
 
 
+Running tests with special setups
+---------------------------------
+
+The whole test suite could be run to test some special features
+that cannot be easily covered by a few specific test cases. These
+could be enabled by running the test suite with correct GIT_TEST_
+environment set.
+
+GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
+
 Naming Tests
 ------------
 
-- 
2.17.0.rc2.515.g4feb9b7923

