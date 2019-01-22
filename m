Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EC71F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAVAar (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:30:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36124 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAaq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:30:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so10860888pfc.3
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1uIQwHvteRPzbzY2C5xGAPsQ4iqNiTqi7bc0xIxUh0=;
        b=OVQOWNz9qId5hYMK4q7VIHkESXB3SXOXX35+kqRvBG21NBs1VhgCHGPUD3K6tl5Qwu
         X96ClK+NNOwUVS7LeUzzwcWstwexc+cSK8uGOHk5OSCd+UrIp7tktAwo31OaN3hGoC4n
         nT/mqWTn/7MRER/Q2clhmU2cTal1QhXs59KkLWVZBwzVmNZgZs4bDSgQewYrF6skAP3Y
         V0n0/BEosAA88R4Iepp23Bmk+op8Jf9Lr9koLjjLnOCy0Lu0T+/73Wx2pF92NpQNYGo0
         SiT0D8Hgt9JrSphVXIl1LL06T6/nZtIXxANi6GxYAZTDKxHegCxJf4d/gt4yRwTkfNnd
         MUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1uIQwHvteRPzbzY2C5xGAPsQ4iqNiTqi7bc0xIxUh0=;
        b=N6dYsBhvEcFzXB4EMDQ2RXFy6co+MzLb2cYLrQJAE1+kn4qF0G/MaWV/cJFVUQjQDD
         RGGdfswNmuOrGbkTtrNmdtP0VmWykwdpCm6VxI7TgBKfBbcrDBroWFU/0QSLDIASxm1s
         s2ySqysUK6nw2bwmYVUpSK0nVUNVjrsQmWt+vPNGcD7EQXk0nLmTlsfFY97tbHEWevFR
         vFV8nzRRLq9wq95VSm/phjpPKaXtAexx8XVk4ni2926wixCAbsfK/wxVFOvZ89Uxoi+1
         NGVLNC9bTcIrZHvAMAtcvz/oNpEt7d4YrFqDVl7EJKdlCg5QfTTeAaFdQpB0Z8JrDxIV
         DE/w==
X-Gm-Message-State: AJcUukf9tLrCl2HYojEuKCxTl9WTv03AQWMTPibI9+PXd8oIaRjX7i3M
        9cWGXYPDxNwB8SzJQvLuhyGhkPTc
X-Google-Smtp-Source: ALg8bN5nEibnSJzpIaXlJ9B0yi237U0Cd6FP4QcthAd2XUjrOeP8UYIoOfYSp48Bt7rqL4PJe6GwKQ==
X-Received: by 2002:a63:381c:: with SMTP id f28mr30173389pga.330.1548117045985;
        Mon, 21 Jan 2019 16:30:45 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p77sm26157897pfi.85.2019.01.21.16.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:30:45 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/3] diff.c: simplify diff_opt_break_rewrites()
Date:   Tue, 22 Jan 2019 07:30:20 +0700
Message-Id: <20190122003020.9672-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122003020.9672-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
 <20190122003020.9672-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index da5ba835ce..2351571251 100644
--- a/diff.c
+++ b/diff.c
@@ -4814,20 +4814,15 @@ static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
 	int *break_opt = opt->value;
-	int opt1, opt2;
+	int opt1, opt2 = 0;
 
 	BUG_ON_OPT_NEG(unset);
 	if (!arg)
 		arg = "";
 	opt1 = parse_rename_score(&arg);
-	switch (*arg) {
-	case '\0':
-		opt2 = 0;
-		break;
-	case '/':
+	if (*arg == '/') {
 		arg++;
 		opt2 = parse_rename_score(&arg);
-		break;
 	}
 	if (*arg != 0)
 		return error(_("%s expects <n>/<m> form"), opt->long_name);
-- 
2.20.1.560.g70ca8b83ee

