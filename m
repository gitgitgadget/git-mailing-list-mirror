Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5161F453
	for <e@80x24.org>; Wed,  6 Feb 2019 02:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfBFCv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 21:51:27 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:34800 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFCv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 21:51:27 -0500
Received: by mail-pg1-f174.google.com with SMTP id d9so2300756pgl.1
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFHvxvoFIc1c27ERWJ8r8SWNd8RmGGxdLUrzzpjLpvE=;
        b=ZXdul5Kc8L8P0aYsOPfNAar7IUYGbHZ8svXS4BPvZiXi25Vjq+ii8Fn+b73bUZs+qL
         bOvjVeu1RbhhrGgGPXdpLh0TNggL6mEZEKwtwzaE8z1pDv/NIzx67hVCsJo61CpJYl/Q
         pO1651I+lg6nRF+baWz8bYiDdhM1P5icFDVSc6Vr63vNhJLKmP0awI0NnwmPyhgnp/gH
         ufmTadScqodm6UyaFJ190WDoMToBUHzmz0jXeZMj7VyWDiPNiP8RqufBFqNw6qPfltLz
         WvLUfdgcsdoPTB4qKwc2YKngZdnVQFUdJGYz/NBZdiP0Ai/OHKRqmVH0dDBlFaDehguo
         zwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFHvxvoFIc1c27ERWJ8r8SWNd8RmGGxdLUrzzpjLpvE=;
        b=nXLwwL1bQ/Ooq+UmF6t4lgHC6hCLhrO8t3YEffB4SdsnV6rhsaqKinBU7x1arIVTWE
         1dN2t273gydSz6PgaUFe4re5JlckgP7ZNZNATgL3PnCH3DpmfcX2URZu1lK2NCT7Znfp
         4/QWjt9STjIPv4m5+5OYeOqoWwp+G//+5v9nbi9ZunoxYziqVV+MNAJBtuN4REuz0G/e
         mU+po0L1NC77e3WiTfP92TjAJY1ZLN04nIuXoPe3LXw6yftL3p8A8bu0eGvR22YRqrY8
         Fv1DRPAYkWhhxWechwiLrVVLX3Q2o4eOgyweA4u5fg0om8Wqdb7KLr7I3ribk0CCub0a
         EmCw==
X-Gm-Message-State: AHQUAuYPY4STvb11C7QcisDQnY34maft1YtYX12ZP+kCO4Xt84Dtwudf
        UWkcms4vLSQp8GGg3P6DYhs9x+ia
X-Google-Smtp-Source: AHgI3IZ3nqJlf3EjIvGPQQ1mAcBEVHYiuHl3uNSPyS5caWFwRZVxNGSrVTDXT3b9eXo2QXjggwLJeA==
X-Received: by 2002:a63:9402:: with SMTP id m2mr7261132pge.93.1549421486106;
        Tue, 05 Feb 2019 18:51:26 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l8sm273193pfb.68.2019.02.05.18.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 18:51:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 06 Feb 2019 09:51:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] nd/checkout-noisy updates
Date:   Wed,  6 Feb 2019 09:51:13 +0700
Message-Id: <20190206025115.26163-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
References: <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the misleading message from "git checkout -m". I also
rephrased the original messages a bit so that when
tg/checkout-no-overlay is merged, fixing counting file deletion is one
line change.

Nguyễn Thái Ngọc Duy (2):
  checkout: update count-checkouts messages
  checkout: count and print -m paths separately

 builtin/checkout.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.20.1.682.gd5861c6d90

