Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC941F453
	for <e@80x24.org>; Thu, 21 Feb 2019 19:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfBUT3B (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 14:29:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfBUT3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 14:29:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so10088119wmg.3
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 11:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHvTJ1OY4x4rAVEkAoIEb8c/GvOzNLKcggRUO7F2jEc=;
        b=mAGyog3Nvlcx+OJ2vRRl7hULGnwF9Q/5uURQ6/BgTfw9mSIgEfY9IkZxpk0sTFBRyf
         D2YT3/ksoDo9VgBRAJN/7e8LkAM3lH96HOm3my/C03pOm47FL53ewQIGnRMw/o4APuU8
         2l6Mr1QDXorcF+TMzrkgm8YqOJjf4NSd52wj6O//835Br7nMxJ/F7q5lD5BoAUVQjSZB
         y8esvdCHj7rIam4pNxNqE1/N68pgbpcehADal4c4+hi6A1EKpL2KgHia2BEqC8sqnVRb
         x1YvCflcDdjq8XuYRpFBO8l1hl2Bzo93qBf1/nxoU+j3foB4Pg0rSbGnmp7jrEao0lu1
         PQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHvTJ1OY4x4rAVEkAoIEb8c/GvOzNLKcggRUO7F2jEc=;
        b=tGrm+aOYV6KdAatULq9ZMFssNZpHqLp6zWkiXkQGiDV6Sb0/09X5U4tfP3mw9IkbHd
         fM3FbdVCKVYFhrF4YRDGNMtb706IUKjYCON5S9GIhuGRpCqnk06Uuz8XeDciWyuZvelG
         58W4xYAnPCNMdk0QMbekewJZjzc6C9RQQHV7PuNoCFHLLJrXFva0caxz0cGWmTm6p80l
         9ds7uyM7wBC7s5+gDdYjFZ1b3h7DANdfuumM3ne4FZ3fDTq5tpOpCMkTd5NnCYLFfbxo
         8Yp3GjCQ16Zawm/2j0u93ZD0BR63a1yLJxGBt2nutD3YewP/rxDeoJyKaDwaAovi6xkl
         C0+Q==
X-Gm-Message-State: AHQUAuYRjA6h1W5ACJMRx7A4FLwGiKGqc/h6LTz9sm1Sl0SowGcfxbK4
        RD88tgvPVT614kT5QFXeZSi3DYaW
X-Google-Smtp-Source: AHgI3IYjMREIs9/7qVxcSjEQ6zIyeX67Y3a9H2Fz1B+GnhExnJFTpLsDzs/80XAHGsWjPL26GTdeIg==
X-Received: by 2002:a1c:2d4c:: with SMTP id t73mr79796wmt.142.1550777339352;
        Thu, 21 Feb 2019 11:28:59 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm35237429wrq.58.2019.02.21.11.28.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 11:28:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] BSD portability fixes for 2.21.0-rc2
Date:   Thu, 21 Feb 2019 20:28:47 +0100
Message-Id: <20190221192849.6581-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last-minute fixes for two issues new in 2.21, not in 2.20.

This fixes a NetBSD portability issue I noted in
https://public-inbox.org/git/87d0nm5x1d.fsf@evledraar.gmail.com/
thanks to SZEDER for the help.

Then there's a another fix for a test breaking on OpenBSD due to
recently merged unportable regex syntax.

Ævar Arnfjörð Bjarmason (2):
  tests: fix unportable "\?" and "\+" regex syntax
  commit-graph tests: fix cryptic unportable "dd" invocation

 t/t5318-commit-graph.sh | 3 ++-
 t/t6120-describe.sh     | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e

