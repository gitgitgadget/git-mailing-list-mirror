Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347891F51C
	for <e@80x24.org>; Fri, 18 May 2018 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeEROSK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 10:18:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55603 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeEROSH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 10:18:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id a8-v6so14379215wmg.5
        for <git@vger.kernel.org>; Fri, 18 May 2018 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvzpEO9EI5vPJMZo1Ccaa2FqIo1pLyIj0Wa1jxG+zKU=;
        b=tA0lVGvt9eCrHBMzyEdtAiL1bML5SQOAuW0jZLZ0lmeOEs8L2pkxZSetYJcX2R69Up
         NBIFKm5zhUVubSbaU6pGeTQZ/M7Ad4DB3ZS42KLfOBuCI3vKf6G3xECjXzWLes7ZCTnZ
         kwPdTehCqyBkHeteq+It+VCFPJNUnxYndl8Yp4LIVSjcIEqUAiC9/sElgZkAK58t1B+i
         DfsYbGE0TP6dxCQsoGzJ50qAZT36r0wGMXcqtQSNHIOpkqhFhs5wT4YHuS1yKejm/pdD
         GbRdohClHk2vzFfie+ywVQDggW48o8OZkP5+nYNVpDemo+1aDDnZWrzUzuQr0opI9eZY
         4vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvzpEO9EI5vPJMZo1Ccaa2FqIo1pLyIj0Wa1jxG+zKU=;
        b=UjAKFJpCETqJ8m3seq7kTSdSDOD1l5wwRvSKrKo1CELPVldy4CoYm7c97mrKOMyTUV
         JBFQl4bk+CNhSrj2GETovqeIT3ACQPv+C3WZSOhFpjBi57xNSMe4KiSL5IbUmxoHtWrb
         GUZrqHdbNMqbICdMFr1r1HPuKaemK5noJIzOArI1BbBLHLa97xxyEsdk1OsqfFV3RXSA
         nS+TDdwemrAIW62XyCpKvNV8aLQi0+x7v0BtxWaaQcr55P1jzOmEALYBHrEKCXci2nJi
         wZGTkjuRq42zZtWVgaxh/oqmEBQg0CjWD4bN/9IFUpDI/6xMKatKVh+UseTpt0zgMWgO
         kbRw==
X-Gm-Message-State: ALKqPwc1uYEMWmx44hrbkSKhuYqBDYxiQUE9Cq6rTEVGnwihbIUeTIox
        wRnSNIGoJ002BAFzMLvS06g=
X-Google-Smtp-Source: AB8JxZqT1rV/fd6PuDnhVKuTvulGFh42gV+9818Tu0X/GBAWHrWGpo43HFkNw4xmJunGiaYLzHg6kA==
X-Received: by 2002:a1c:87d4:: with SMTP id j203-v6mr4572353wmd.119.1526653086721;
        Fri, 18 May 2018 07:18:06 -0700 (PDT)
Received: from localhost.localdomain (x4db17294.dyn.telefonica.de. [77.177.114.148])
        by smtp.gmail.com with ESMTPSA id u37-v6sm7606937wrb.53.2018.05.18.07.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 May 2018 07:18:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] Test improvements for 'sg/complete-paths'
Date:   Fri, 18 May 2018 16:17:49 +0200
Message-Id: <20180518141751.16350-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > So, I think for v2 I will rewrite these tests to call
> > __git_complete_index_file() directly instead of using
> > 'test_completion', and will include a test with spaces in path names.
> 
> Quite well thought-out reasoning.  Thanks.

Unfortunately I couldn't get around to it soon enough, and now the
topic 'sg/complete-paths' is already in next, so here are those test
improvements on top.


SZEDER Gábor (2):
  completion: don't return with error from __gitcomp_file_direct()
  t9902-completion: exercise __git_complete_index_file() directly

 contrib/completion/git-completion.bash |   6 +-
 t/t9902-completion.sh                  | 225 +++++++++++++------------
 2 files changed, 122 insertions(+), 109 deletions(-)

-- 
2.17.0.799.gd371044c7c

