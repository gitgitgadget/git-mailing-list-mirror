Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028881F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIOViL (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:11 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34887 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeIOViK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:10 -0400
Received: by mail-lj1-f170.google.com with SMTP id p10-v6so9875305ljg.2
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6q7CG3imODW/U8g9sFno2NA4F0oi0KNaWxR4Y0lHIcI=;
        b=oQseuVoXS8CBWQuyY+Aqv8kWMU+5oqxpXaVvKBr8iw0JUOHBGgpAqhpqJIFVeeSjcx
         zBYQiynjQToCV/7/7kDtl1egBGlG9c6xVrcpf7x2045znWCK+9Zictkli/gb8Kx/ko1r
         eTB6JId1tf3nsD3f1Jsc9k/ZX3uj9fNWPH26/Ua+Xpyw8+otvZ9m9Y4zS0cqVHjKHpVm
         i5W0Ep3J4BjxPfyHUKuz7rThZD+ekoGpClHDbyMeYXiuSzkd4Av0ZN9w0DfhbQJzj/44
         8nJ2gifaZnirzI7yzO4m+QMUgL1yIf3MjRRTFiCmuD27gt/r5o5dgJGJiGSUF2qE8947
         2Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6q7CG3imODW/U8g9sFno2NA4F0oi0KNaWxR4Y0lHIcI=;
        b=G/F6aMPIRn9ntm5fPJB80Kj9kSUZ5n6o8+UjFIVAwjJmI2yiVz7ZeAAtDBdFx2Ih51
         fo4QyC5EL+Wxaavsp6gmuwchCWSBWdk7+si/WOase9Def4XDK53Ar4lW/CJp7MuDrQBw
         /H25bxh0OqOF0zk4BSMLCC29jtY5eKCq59b9K0QHbw1cagkmE9TMWc/z9NEoPE/IFweS
         hePGImLdN+46lzbQ0qua1FO5h0co35vV1XIqPODEe6POxJmnwtRfC+sNB/SJkxbxg70X
         NAEdEfHzPbi5zYeMMjODjNCdEC15QDjmIfOdkRS4crIevoy5VAFYbHVoLsl9YHyVs4D1
         g7fw==
X-Gm-Message-State: APzg51DFKrz2CDiuPg8vqVzPf1On14WZdBnbX6WbUBEqEc4YYgyw9zzd
        afds4dwIkzULvdhqTv8jYFwJ67Bx
X-Google-Smtp-Source: ANB0VdbsGRZad7h1Kc+9plgA+ZPN12oK8JZjgP2l2Xd/F2F3B5OH5mtnyNz1Eo+x6ldL8n+AGE2W2Q==
X-Received: by 2002:a2e:5810:: with SMTP id m16-v6mr11568245ljb.134.1537028319507;
        Sat, 15 Sep 2018 09:18:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 01/23] archive.c: remove implicit dependency the_repository
Date:   Sat, 15 Sep 2018 18:17:37 +0200
Message-Id: <20180915161759.8272-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "repo" field in archive_args has been added since b612ee202a
(archive.c: avoid access to the_index - 2018-08-13). Use it instead of
hard coding the_repository.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 0a07b140fe..994495af05 100644
--- a/archive.c
+++ b/archive.c
@@ -391,7 +391,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_oid(name, &oid))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
+	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.oid.hash;
 		archive_time = commit->date;
-- 
2.19.0.rc0.337.ge906d732e7

