Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238DD1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbeGWOEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:04:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35267 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbeGWOEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:04:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id e6-v6so894336edr.2
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVlV/dCgSvWBvP7TOCoQtc+hKdhqgOZni0uqd6mmCDo=;
        b=IoJQg9wsgvv0DzJmEHSpCRD9DpERS9MjQi7T1ZAM7IjrCTX8GSdQVWIEGj1jjffjP3
         wiomfKlXlj2NRJIu9w0HzVpQ2+uH2i3cpIDs42WD7zy9nJPareAkJ6cb+z2nmZTXgc/P
         VsF0D9yAqLvlEWYIRn3Ut3ThQobRRowPaMzSPctetkEn1PX4PIoNut5jkV9GVHIyO+vQ
         z0xMiftiybYiSUMppIVzB88TfvStX/mLEctXgxBRytjWiv064zTutw1aQejXcp3Z8S3E
         lj5s9MtNKsGEauqXQSPVs88Yvoy6QyHk9o1glNdgZ/6vniRrpVRwMm4rdvrj6U26Tzg4
         1dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVlV/dCgSvWBvP7TOCoQtc+hKdhqgOZni0uqd6mmCDo=;
        b=Dx3NWOBfW84ZocCqyUKBebhnGyMEakeLi6zpdh1PvhaYN1ar4h+jLhIm0H0MZiIFKT
         Qj+LLgfmtABGcESgByLv/jKhTPaUXEbVDHG0IZ1XHdRV7yHi3SO79SJJO8a3vcZY60hy
         SpFKWBIDsK9nWKLCj+jRXqDiLOtdJ88zo0luT2Kyn/WOujBAjBWHBYgeyYm4op2a8/3i
         m9SoZ/pNLiRtzjLdvLE03IuPU6/9+2F+imI1kdSlMZCnOxepRJoYzmNb7U4q2h3T6nr7
         eoPKPXFg5Et3UBVmgOk7dSzGjiGnf5W1DXpyt9uR0DsXDqCVsHa9r14LbXzSanmEATYk
         pZOw==
X-Gm-Message-State: AOUpUlENiBu99kGtXQlG1AqhcuxVCniY6q17o39vE9bvpSaqCvblwkpK
        lkYqFUYlvaWPp69Va1E4wVotyr9W
X-Google-Smtp-Source: AAOMgpfw0KYSovoFZyMxMz+e0hhbqdkPknbU/cVb1Lzgil/6m3+L3WSrBZUVyIBB2Ao3IDKGO+O89g==
X-Received: by 2002:aa7:d4c1:: with SMTP id t1-v6mr14361142edr.121.1532350971110;
        Mon, 23 Jul 2018 06:02:51 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a5-v6sm8834263edr.1.2018.07.23.06.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:02:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] travis-ci: run Coccinelle static analysis with two parallel jobs
Date:   Mon, 23 Jul 2018 15:02:29 +0200
Message-Id: <20180723130230.22491-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723130230.22491-1-szeder.dev@gmail.com>
References: <20180723130230.22491-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the static analysis build job runs Coccinelle using a single
'make' job.  Using two parallel jobs cuts down the build job's run
time from around 10-12mins to 6-7mins, sometimes even under 6mins
(there is quite large variation between build job runtimes).  More
than two parallel jobs don't seem to bring further runtime benefits.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-static-analysis.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index fe4ee4e06b..fa719c9ef9 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -5,6 +5,6 @@
 
 . ${0%/*}/lib-travisci.sh
 
-make coccicheck
+make --jobs=2 coccicheck
 
 save_good_tree
-- 
2.18.0.408.g42635c01bc

