Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD00C1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfHXI05 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:26:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36021 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfHXI05 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:26:57 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so25644600iom.3
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IUxUkhQu8IKRPJnJfvXqpZRjIm/zAINbPLEtvMCz0aY=;
        b=VN8qaCaVvTpri60jmeSdezVjhsbWV0urNRBaHYXRT1jNvaO/JDiKRmd0pTbGlMSQpb
         JuWkZOE/68bIZhpM2UnM+H/VD0AWWWhteDvPA/xuhc8NiZKcAddFQPvLGIFEt4jYRB/4
         qOGtlakxPaIr8d8M8HR4qTu8b5/daHCAXn+uji4ZxZPYqtm3G5HrJiHjphCQT0E5Tt33
         F5fuqiOB2KrYO6hOb5vhbuyFdIghZfQRu92lrstTA4axnrahPjE3ROuImv9Wt5PyjDyL
         OaOzGTlVsZZdCJJYNK5LUx8toYGR9uU+OpCjGHbFdO8zX2+awChN9ydalb4RFHVQ6oQw
         lj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IUxUkhQu8IKRPJnJfvXqpZRjIm/zAINbPLEtvMCz0aY=;
        b=mJCvLs2H8qsmmG1SK+GDUdkNiq2qlSKruyloHj8lGcMSEyi8OTaoDninBKMI+GRvGc
         XVcPT7Ku4fpVF1nRRIEIoSWdrSH+KJw8cHKX98DG8y4DUHJ7kodPQa1l1jQc4PI0Y2/a
         VPU2FHFkQZp5oXjPRmuLWFh8Ziq0PUiA5THM8/7hj7MD+Hp83nVs6LZ8x7RH1d1a8mhP
         5p9zvwpG8c//HH+B+JAsueasMvKbKEg58d1LaFpbUzfebeiHv8KCuUEbCBBRcVV999Dr
         Smhtu8oRU+dXOYaAKUGaFENY2+G46Mor9l+9gKcTWBfVeu/zSRf7zp1Ff6M0UhDhd6+8
         HV2Q==
X-Gm-Message-State: APjAAAVFCtJ+9037MC2DMPKPVHK5ZBqLaBIS6dqFRQzSE0Ui5aaDb3QR
        XDniDsswlkcrI2n3jvrs7LEC9ndn
X-Google-Smtp-Source: APXvYqxj0dmDpN3ZibGJgXj+gMabyPLbtZ0gqHm0UzsvBzUIFimieL+85GBaEGQ/xJKox/D6uRJMeA==
X-Received: by 2002:a6b:731a:: with SMTP id e26mr5218753ioh.188.1566635216090;
        Sat, 24 Aug 2019 01:26:56 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id m20sm3917032ioh.4.2019.08.24.01.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:26:55 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:26:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 03/13] t4014: move closing sq onto its own line
Message-ID: <5c49703aa4fd3741d1685d25b647d775003f9962.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention for test cases is for the closing sq to be on its
own line. Move the sq onto its own line for cases that do not conform to
this style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 62f5680f05..5e8eb6fb27 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -790,11 +790,13 @@ test_expect_success 'options no longer allowed for format-patch' '
 	test_must_fail git format-patch --name-status 2> output &&
 	test_i18ncmp expect.name-status output &&
 	test_must_fail git format-patch --check 2> output &&
-	test_i18ncmp expect.check output'
+	test_i18ncmp expect.check output
+'
 
 test_expect_success 'format-patch --numstat should produce a patch' '
 	git format-patch --numstat --stdout master..side > output &&
-	test 5 = $(grep "^diff --git a/" output | wc -l)'
+	test 5 = $(grep "^diff --git a/" output | wc -l)
+'
 
 test_expect_success 'format-patch -- <path>' '
 	git format-patch master..side -- file 2>error &&
-- 
2.23.0.248.g3a9dd8fb08

