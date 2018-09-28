Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F391F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeI2ByI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:54:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41830 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI2ByI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:54:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so9103579edd.8
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7d9hQvf/Pj3zhuetyNHF9Wbpa45edd2CXQRglXTMOEI=;
        b=pgzcULk8FT3DCJv+0zdMwnVmQh5cChCN3MJeYyOvGqi3PpLFQAV6jjHSYP8U9PIt6S
         3zGtGTHDyD+MAJTpZkethxFuRO03JxbjKB/Stvs3t6o1qBuNa3HGbmpsVeT1FUXtT5kH
         HJIKdLDXd0g5JaenXpaAtLBQ23ZlFlCtzW7S/z8sIZvxfaBalr3dsaaxC31hIW7n5rVq
         xGBwG1YO36VlvCwTY2RfF+566qOERWsy5hrP/TZnx0dpnkZGV6VqzqA1g3ZelAF8HjVf
         HTBiSHsEDMOmTjK/Q4jKjedpZTCDXHfxIHu1kBZt/fIPvR7Y6/pJZeKI9npT8/HGi5+Y
         P0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7d9hQvf/Pj3zhuetyNHF9Wbpa45edd2CXQRglXTMOEI=;
        b=Vepq1ofnbmOCu5gtKycUbZx6RfJ8l77yDvbHgWpHtcIc3HYO3Wl0Ursczkjy7mdBGQ
         CIxlRENJ2JTlkgHekx8jmQEtePRDLt4h238dR3uXNa25who3hFCxfDCB1PGe+eiCvxk4
         oHZilwy4JdO6aKC/tfugkYv6TvGoxjIZ2jiRZUpmGrVmqk7hj4NuY2oWf/KGNVgQu1NI
         2gC6UYufAGjsn/4Qak9u67FSBhp625kiZvHJYqkqSYDFLlDQKfIQjblhAHtg1NeUxIHV
         Ewndo8lNBXMVrlmQr1707arnpMD///stdzg48NN8ehVbvaXmilGzCbGA3CToaNF1NpxZ
         TXMA==
X-Gm-Message-State: ABuFfoje8t2tTqfz5h7ucUIT8LxIguVVsiZJJX26+QLXKoEfPGzMFf2A
        /lknZBeyFASbneHqw3oqgCffCsGK
X-Google-Smtp-Source: ACcGV60nOSO4RZZrZu5LyoSOe0j8SsO2x/QY0IdYa4uQC/B47cgd2hkNHrBKXrU6iM02ofhTwdluYA==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr4537651edb.237.1538162932991;
        Fri, 28 Sep 2018 12:28:52 -0700 (PDT)
Received: from localhost (cable-94-139-7-24.cust.telecolumbus.net. [94.139.7.24])
        by smtp.gmail.com with ESMTPSA id r44-v6sm4011459edd.87.2018.09.28.12.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 12:28:51 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] git-rebase.sh: fix typos in error messages
Date:   Fri, 28 Sep 2018 21:28:49 +0200
Message-Id: <20180928192849.30792-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.19.0.599.g22e244bd67
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7973447645..45b6ee9c0e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -553,15 +553,15 @@ then
 	# Note: incompatibility with --interactive is just a strong warning;
 	#       git-rebase.txt caveats with "unless you know what you are doing"
 	test -n "$rebase_merges" &&
-		die "$(gettext "error: cannot combine '--preserve_merges' with '--rebase-merges'")"
+		die "$(gettext "error: cannot combine '--preserve-merges' with '--rebase-merges'")"
 fi
 
 if test -n "$rebase_merges"
 then
 	test -n "$strategy_opts" &&
-		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy-option'")"
+		die "$(gettext "error: cannot combine '--rebase-merges' with '--strategy-option'")"
 	test -n "$strategy" &&
-		die "$(gettext "error: cannot combine '--rebase_merges' with '--strategy'")"
+		die "$(gettext "error: cannot combine '--rebase-merges' with '--strategy'")"
 fi
 
 if test -z "$rebase_root"
-- 
2.19.0.599.g22e244bd67

