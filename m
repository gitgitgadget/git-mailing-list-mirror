Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3597EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjF1Qbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjF1Qam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:30:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73B2694
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:30:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40079620a83so1281cf.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687969841; x=1690561841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtMVHsa6kVZFjjAIuuPgtpk80p8hx93Ma+7EQOROnF0=;
        b=FJnidI4fXeP1q2lWw67hEzuM2oN3WIQCafRLlzmABPyS+dWtkd7p94VyIjYXn772j5
         0fPUYOkD5JnpM5ESnNrZjqEnK6NwlDr4XUZU1C1M+VbtqEpVHPGqpEZgZdsDtDYxfSNX
         DiKoUpYJcGRBRzFFkV10Up96m1LuYdtWwbcfXpgo2OI5O5tYzbiHo1o2RAg3kZJIevOh
         LfB3+xm+trJ3COIl3NIB8buO6hPj4Nlu04x/LYvATf+GJWA4hyVqbZsN3280Sug129Hb
         9ApuZR5lokAIOlhY7kDPdFjDVVng0K4sfbbBP8yv5t6RHi/orBV8Rfvf1hdoYLvXcXOB
         nYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969841; x=1690561841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtMVHsa6kVZFjjAIuuPgtpk80p8hx93Ma+7EQOROnF0=;
        b=XmIr3OiC5laDwrHgXkV0GEc7sXF9hUrnD7YxSJVoXGzcWphIWmpc4P2sVEPb9qs81t
         efJYCZsYrSSYLSby2Frvp16N5cp/zSjBUyqjl74oz+FwWQwltLJGvRxcdl9nkx2CCN3l
         rNLJFmjWAO4o9suOAhaSlIGDvXjG+4+7X/HmbNfsXHySDINU3CBuPT2rUEU3YVS9++5/
         M2WrPTtrGuvzixiAdrEeloHPwjhpD0IZXnkkFyntbVdhTrmUdtcpd9HP90K3ymS8gVw8
         Xy7Wa8/hEJg+maufYuTAao577h3vLQN0GH5VPhxoziCCoXmpHam18csW/H4ZT/ccvi9k
         sXRA==
X-Gm-Message-State: AC+VfDwUti7P66xXoccfgUhYU0vMGPFA6260oOL9sX6ocFx0JJmAG8te
        5UFTEGOO73fHQiaVex2iyXrFLjDSH9fgu5YKD7zcHw==
X-Google-Smtp-Source: ACHHUZ5nIWsUlhy/NGM7DaCup3X9QfrU3CYMVOdPWktMMNhgtizus7wLCI28LuQVGWSPZJBTdWvNn09b7FYCLyPRVic=
X-Received: by 2002:a05:622a:185:b0:3f8:8c06:c53b with SMTP id
 s5-20020a05622a018500b003f88c06c53bmr296673qtw.0.1687969840734; Wed, 28 Jun
 2023 09:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com> <kl6lzg4kqw7v.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lzg4kqw7v.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 28 Jun 2023 09:30:05 -0700
Message-ID: <CAFySSZDkc5xN5cNz0UyKyKpS8Eq2y_517hrLe8HixzAwQ+E4Dg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Introduce Git Standard Library
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah I failed to mention that this is built on top of 2.41. You can also
get this series with the correctly applied patches from:
https://github.com/calvin-wan-google/git/tree/git-std-lib-rfc
