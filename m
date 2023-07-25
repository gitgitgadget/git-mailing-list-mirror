Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE7C0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGYVJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGYVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:09:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492019BF
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:09:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57059f90cc5so75021277b3.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690319364; x=1690924164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=alZvwmSKWzMDkGFZb3FXruGSH30fZmlycnKWRfLkM1g=;
        b=nAQyyqAsYMCjR5aN7BLi1uaKTDRRV33N41asofkvrqt0+1V7VrRLYnQfD/vkfgrtPA
         9C/NuaGcrP2z9xGChe5jUN6oaft444cU8jyy5kf7y6CnBxYcRNsDCXElMq4mnuhsPjh2
         Qrmb5hndKzisYEY2nVpZ01K9Q6I0S7b9wIzQ+WBh26iTuAD+vGliSxjRurAEV96FbWuk
         BKGb/2hUO5zooI9IP/xnM4y6O7i0KD6O11UX8dX3UUecWHKLGESiMIwNS5Rce4kkLw4y
         RQ0YTNruiQPoky4vhlooQPDg8aWcB9kJYkQgErDJoV+6nPYTPJXNpG2qNXfb8UiaoxWS
         YhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690319364; x=1690924164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alZvwmSKWzMDkGFZb3FXruGSH30fZmlycnKWRfLkM1g=;
        b=iiEP/Or4zEL43//fGCg5hFj+OMK87pSNPx1Rw/dzjxov2TpC/AKszcN0+i4udpBdpq
         3CPI0VQ6VgNaQL5iHHN0n5nE1ZjQUj7Kne4huMtRbBPt9OTGMtvb1PxrYe174gdVOL+9
         lBPC//6styDJEthrUf+4TjnWooz5G1bb7/JsmV/PQpZOLCP+71sSsMj2TJlOoIA2LHv6
         3rpzipPkI4fkbYdX7qhJvtAGiK1xBA40/RAhxQrBh5LnaS9p0nSppTDca6J7KPXTBmDs
         V/ZJZhDJy64x3SW/x3diuHbJk2cOUOvgTs9KRfxQX33z9g/3ZM7hh2dl7BUxVffFqFx5
         eHig==
X-Gm-Message-State: ABy/qLbwd8RZuiXI7yoBCEEOwLtSe0KM84bpFLr/p/omzLe5MuWZNuSN
        GYJqxLJyjVPnM2pZJ0ZDi0KKVEAFbfo8Mg==
X-Google-Smtp-Source: APBJJlFjoTT9HXfRxkaQwLhrIiaufFH2uSK1WRMDkiZlXnOwajDFGqxrdm5YZedD6OLvlaU4QyX/Q4C0JFzKTg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:c794:0:b0:d09:6ba9:69ec with SMTP id
 w142-20020a25c794000000b00d096ba969ecmr919ybe.4.1690319363936; Tue, 25 Jul
 2023 14:09:23 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:09:13 -0700
In-Reply-To: <xmqqzg3jltyr.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqedl3a909.fsf@gitster.g> <20230724194854.3076-1-mirth.hickford@gmail.com>
 <xmqqzg3jltyr.fsf@gitster.g>
Message-ID: <kl6lila7zojq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Credential improvements need review
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        M Hickford <mirth.hickford@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Hi. Is anyone able to help review these changes?
>>
>> https://lore.kernel.org/git/pull.1529.git.git.1687596777147.gitgitgadget@gmail.com/
>> https://lore.kernel.org/git/pull.1527.git.git.1687591293705.gitgitgadget@gmail.com/
>
> Thanks for pinging.  One thing that may help (both patches, my
> understanding is that they are of the same spirit, just one is for
> libsecret while the other one is for wincred) is to describe the
> problem the patches attempt to address a bit more.  For example,
> in one of them:
>
>     Fix test "helper ... does not erase a password distinct from input"
>     introduced in aeb21ce22e (credential: avoid erasing distinct password,
>     2023-06-13)
>
> we can read from the above proposed log message that it is a "fix"
> to some bug, and that the "bug" was introduced by the named commit,
> but there are a few things that it does not explain, that could have
> helped readers to convince themselves that the changes in the patches
> are addressing the right problems and solving them in the right
> way.  For example,
>
>  * how does the "bug" manifest itself in an observable way to the
>    end-users?  "When they do X, they expect Y to happen, but instead
>    Z happens, and doing Z breaks expectation of users expecting Y in
>    this (W) way."
>
>  * what was wrong in the code that led to the "bug"?  Was it testing
>    a wrong condition before making a call to some system service?
>    Was the condition it checked correct but it made a call in a
>    wrong way (and if so how)?

Thanks, I saw the original ping and took a look, but I came away with
exactly the questions you raised here.
