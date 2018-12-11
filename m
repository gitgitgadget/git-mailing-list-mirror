Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7613A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKVVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:21:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:21:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so15583994wru.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8B/lUHgmJQRyGZjfpNr0WYw/C3yi+6Hc28uYPUEqqmI=;
        b=rjQgtQu0iL6WwTEqnLqemXtDl0OU7BZo6sX+7YkwedlVRFEv3n2j1Sr3EUTF8mRSmu
         smoHMDec4SbVwPi92ydS/ZAqjYGiK0vZKOApb+boyw2Lq7s61wyg0QoU8BqZQAS6n7It
         knvw6sapGiUVghSjA2rxo0DXVklzrbKSNFvr5sD8+ndsnepRdt95Dw8jVorK4tvzDWzk
         bjSTnquvgSDGjCr67lyK9LvulMKqjb1hxH1dF6qxJprShMa7L39g2uB41k+gVyFqycTw
         j9K5uwUcYi5drzBKlT/25BUbXgc9/pl4V8eiOGpIiwssYvCr7LFr8m9i0hcbyQ+izxSg
         Rkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8B/lUHgmJQRyGZjfpNr0WYw/C3yi+6Hc28uYPUEqqmI=;
        b=csl0QW/+tf8Zj1M9Ai6tJYbvZsDSoDO3W/MQv6qPpUdxMno+qjNIuF9ibQmb7ATOf3
         u9BcEVBqVAhIUFV+d8fcnBeklXun8dgBJj/y7b29DwOivR+4/LMBATd8xiQ9pzHhd/g6
         OvWFdOZbJ6j7V91pcVD/7w5dQBdUnqwjj+QtmI24UbSBAliNBAP0Tsjh3u0o7FCGN6mQ
         Q0NtG30N2B0ivVGqCfdjSYJbF5t8w5MRcko0SIVLNgaYYAXe0mjQ5JwGBsRZv6GvIX1E
         pW5rWT5+YVTta04CJSLG4mmkFqJNhtqgHfXoGrlyxw+7Uqbpdzg5lbDTGhaSjL8Yw39c
         99mA==
X-Gm-Message-State: AA+aEWbsqyViE5BAVL1eUbsQPBhF99G2AQuTNHnYFTn2GV3UQ25I5ct3
        8szEXXf7FZZTkXGb2QGtDyEwQ60s
X-Google-Smtp-Source: AFSGD/UaK0cD5TRHtMF+fa0jBi7Ez7Ps5ZKR3FNXksIFxdDd2BIElzjW/8g0/BJSdPu50fUrhInhTw==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr14699198wrw.215.1544563305699;
        Tue, 11 Dec 2018 13:21:45 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm1698118wmd.23.2018.12.11.13.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:21:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Add a GIT_TEST_PROTOCOL_VERSION=X test mode
Date:   Tue, 11 Dec 2018 22:21:32 +0100
Message-Id: <20181211212135.21126-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181211135501.GA13731@sigill.intra.peff.net>
References: <20181211135501.GA13731@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11 2018, Jeff King wrote:

> On Tue, Dec 11, 2018 at 12:45:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> >     I don't know if there's a good solution. I tried running the whole
>> >     test suite with v2 as the default. It does find this bug, but it has
>> >     a bunch of other problems (notably fetch-pack won't run as v2, but
>> >     some other tests I think also depend on v0's reachability rules,
>> >     which v2 is documented not to enforce).
>> 
>> I think a global test mode for it would be a very good idea.
>
> Yeah, but somebody needs to pick through the dozens of false positives
> for it to be useful.

Here's that test mode. As noted in 3/3 there may be more bugs revealed
by this, but let's first start by marking where the behavior differs.

Ævar Arnfjörð Bjarmason (3):
  tests: add a special setup where for protocol.version
  tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=1
  tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2

 protocol.c                           | 13 ++++++++++++-
 t/README                             |  4 ++++
 t/t0410-partial-clone.sh             |  1 +
 t/t5400-send-pack.sh                 |  2 +-
 t/t5500-fetch-pack.sh                |  4 +++-
 t/t5503-tagfollow.sh                 |  8 ++++----
 t/t5512-ls-remote.sh                 |  8 ++++----
 t/t5515-fetch-merge-logic.sh         |  1 +
 t/t5516-fetch-push.sh                |  4 +++-
 t/t5537-fetch-shallow.sh             |  3 ++-
 t/t5552-skipping-fetch-negotiator.sh |  1 +
 t/t5601-clone.sh                     |  1 +
 t/t5616-partial-clone.sh             |  3 ++-
 t/t5700-protocol-v1.sh               |  1 +
 t/t5702-protocol-v2.sh               |  1 +
 t/t7406-submodule-update.sh          |  3 ++-
 16 files changed, 43 insertions(+), 15 deletions(-)

-- 
2.20.0.405.gbc1bbc6f85

