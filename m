Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AD9C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5392964DD4
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 13:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBGNZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 08:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhBGNZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 08:25:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C411C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 05:24:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so13826972wre.13
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dartmouth.edu; s=google1;
        h=mime-version:from:date:message-id:subject:to;
        bh=boSZZYi/mPLlS6Wh2diCDafFAzwtgciTRZNXy8/i1tI=;
        b=syE4KXvRB8oJrdKRVSKvp7l7aCebLMycRR3Sp3zG43D0imSwjSK39Nfft9FHdfANVL
         iUtW5aeVUOzfU54gqEnFsWhz6ccOzsR1x69upXPPr55mqD5V5lwHRyZ0n97FoEHUZSjJ
         5oc0qClW00FV92lR0TnoyV+jNTNmRHYRuXf82FMaPnKNg6DnqKdKKsUcLXqxPZ+1v827
         Rr6MWHaKyQigsm+GAqE6DPXUJ7vZKsyxdYgN2gnXG490Kv9nqtxQD60Sp8Bmf36wTYjg
         rexVCli+7ItBjBjMJ+pUvMSDxX5IsQWzZc1F+dmZMFXGHrCjp4ZgGVLHSNS6SnHuCiOS
         398w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=boSZZYi/mPLlS6Wh2diCDafFAzwtgciTRZNXy8/i1tI=;
        b=jWwXywTOLTVN4N1aHvLL1Xk6RaZZybNwvNe2Q/p9FP8nVa3si0l/7zjux0DW1Vv9y7
         PKlot5az12D/0D71oOfdAIMj43esXrmyGG4GtVctjHO4jLUBGnL6CZIvt8++06r3rHMZ
         UM9bMUhsR02W1TqG36lGBspOYaGJTmikSyseRsJLUNQOH4tDBFM1EqoFcFaY3Z/bnqKX
         CRkgGNYfRUFy0Q7oqtjDSduFbG0l7VCtHCKEMCgXLsr/jAfIS2/m9RKCIsiFKyojfben
         +swVqOhPm6QkPXMbA2A0FAqbSRFv5F1hN/KolRLv0PSbqtE5NpMh/kEx1GuQAi1hR7bi
         Vd7A==
X-Gm-Message-State: AOAM5336ZYY4ArlDi1R/UTVbEuah2JtkZXs94z6i9Cyjj4GlvgaXm6p7
        Yuk4UcE8L1U12uEMaMS4W0HDGBxxivbNjHP1u5ndcYdFRy8=
X-Google-Smtp-Source: ABdhPJw23QRt0Z9snmX49oEp5XHnGfARKYHCLa3O9UvlBmTXaz5GQwIujY13NJYEM1HiKOcwRy4joIcoJUdoKyr2rWc=
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr15352231wrz.109.1612704262305;
 Sun, 07 Feb 2021 05:24:22 -0800 (PST)
MIME-Version: 1.0
From:   M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>
Date:   Sun, 7 Feb 2021 08:24:07 -0500
Message-ID: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
Subject: default editor
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While downloading git, I was asked to name a default editor, which I
did: ed. from cygwin. It worked in the enuing test, but was rejected
because it returned an error. I suppose this is because
cygwin return  conventions are those of Unix, not Windows. That raises
the question: does it matter? Does any other part of git depend on the
editor's return value?
