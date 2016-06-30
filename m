Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4081FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbcF3QCO (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 12:02:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36513 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbcF3QCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 12:02:11 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so8851870lfe.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 09:02:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgqHqnXTdIhTD6lu+zIP/CoIyXAxiSasuj8TWS5y+QA=;
        b=KCOnFi5LYbKurrZIYVpUNUaFzgs8JJa7x3W5Cwvd92iI/zRblrqgpvKgnVfTe7JvYW
         BVBHLdY0osO51RdHSELuQWRVBB1R9Q5j2oUcDBh4LXDXRgcxFTPlNKvpwkEzSYEl1opS
         lXs3qie4u7Tj5xCoAupB6upw/tW5EPA8+L/U0uYO9UzPmrY6KUYfkM6lXJgiBU4AIgzA
         qjvoHwo8BwdoywwaARqObNvOFZ9vuE+mAzZOqUncB83IhIh+fSzMR2egcJ+HGoaV0lMz
         TLqNaYUV2vgnVgTU/wqouGSICUHO4lQIIvYr81ZMTkPLjLVb3iPg3UDNCKGYXtPgKVId
         BeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgqHqnXTdIhTD6lu+zIP/CoIyXAxiSasuj8TWS5y+QA=;
        b=CuzVJZAgNOcn3Sym+EOAW83wY+zMtJFveQmsRDTo20xFBrYTbaKRrOK43IvO071scP
         9/WNuLTsunfRWU/vS5lzqYXSuKKt40DG39m8r3BHhcTgGdgYz1oihBGb2g5ag0Ghat2Q
         AWUP83J6D97jgHVvqytMoV92FFDujBUfPlOgTMxw2foDIvPrLsOvVoM6i/xE2BKsE2E5
         2/tqoIs7xCkxi0z/ZdakRa9CruJo3JE8hLYrr86gipjZKNaXhIoiG1mGIerBrOExV09g
         D+4r02fjBvb12v9BSTIiBcqsV4wRqRGn2aJ3km6tPulRYUp3YB0mbtLTLdaN6EOUkrc8
         d7Jw==
X-Gm-Message-State: ALyK8tKhVcdp/Yii5Dy+ECz4ZrA5Um/MDmhnOkkA1D3hpF3ovZMaL6Q6PwK4U7Ugq77Iag==
X-Received: by 10.25.90.209 with SMTP id o200mr4578348lfb.193.1467302529402;
        Thu, 30 Jun 2016 09:02:09 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u124sm1593715lja.11.2016.06.30.09.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2016 09:02:07 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	tboegi@web.de, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fixup! worktree: add "lock" command
Date:	Thu, 30 Jun 2016 18:01:36 +0200
Message-Id: <20160630160136.4819-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <914a6ad8-94d7-d26e-8c6f-f9656d912818@web.de>
References: <914a6ad8-94d7-d26e-8c6f-f9656d912818@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Torsten, this seems to fix the symlink problem for me. How many times
 have I got similar reports from you and still managed to forget ...

 t/t2028-worktree-move.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 68d3fe8..8298aaf 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -9,8 +9,8 @@ test_expect_success 'setup' '
 	git worktree add source &&
 	git worktree list --porcelain | grep "^worktree" >actual &&
 	cat <<-EOF >expected &&
-	worktree $TRASH_DIRECTORY
-	worktree $TRASH_DIRECTORY/source
+	worktree $(pwd)
+	worktree $(pwd)/source
 	EOF
 	test_cmp expected actual
 '
-- 
2.8.2.531.gd073806

