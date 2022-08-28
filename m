Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E3ECAAD5
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiH1UrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 16:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1UrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 16:47:08 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C62B61C
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 13:47:07 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-324ec5a9e97so153536937b3.7
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 13:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MpYDVQ6BaKDY4feKoLdJebj8+HPWWDl5ox8t6pkTrKg=;
        b=0nb8v1bUgWt/XOxVzYou82/Y0AAxEKe59TuK4iPNZqVOiI8B0XgbiWfP8xA1GIzPs5
         LBQiVQAnW7dm8p6lw8BT48uYlSisjiNDF6UzHPEM0w8Ds5ZWaMCrr/tYyUd4FmgCppBW
         hR21B2JyX7cMQTpGPVU2m1ZTPsYexC3C0wPtiVUlQxhwjKqRUuIYEKaCijNkTK4+0bOb
         irzLmhqojDANC1XrBJvGma0KwChFZqP2EznzfzU5E/fMQHSU9l5RQgcHg/30y/ca9o+O
         OyMNozJ9/nfZyPfoC7SckTMVAiyQzk07bC0HXBpJqH+e4ZOrNjxGZjz6Hy24ntiAu3ml
         13Iw==
X-Gm-Message-State: ACgBeo1CQf6xrIyZ9GxMn7ZdHPjjfp3jwD6THaIESFz9jlK0ZCR6qijB
        qfi725AXMIVaNf2qUUoJwB2TlcXetb2bhgzIRYADiMRnguI=
X-Google-Smtp-Source: AA6agR4ZYePFE42vEZkIRJkduOmry+wMrRPqdN+xIKYPTtzVcNDVjPH427lQH3S6f2yH00FFgnEow9lHdyg8f7bknws=
X-Received: by 2002:a0d:c307:0:b0:335:6fff:dc70 with SMTP id
 f7-20020a0dc307000000b003356fffdc70mr7507015ywd.493.1661719626045; Sun, 28
 Aug 2022 13:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com> <xmqq35dgt9ph.fsf@gitster.g>
In-Reply-To: <xmqq35dgt9ph.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Aug 2022 16:46:55 -0400
Message-ID: <CAPig+cSzQAwQLVXbQRLpOJOC=APP-T0DfCzw87xuXKfM8nzSWw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2022 at 4:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >   t4301: account for behavior differences between sed implementations
> >   t4031: fix broken &&-chains and add missing loop termination
> >   t4301: emit blank line in more idiomatic fashion
>
> The second one is off by 270.

Shall I re-roll or will you fix it while queuing (assuming you queue it)?
