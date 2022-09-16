Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CA5ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIPQbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIPQb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:31:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3192872F
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:31:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a3so24412461lfk.9
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5qJ21qllWRh0FzqroFKtzPkkXOm37fz6CTYS58Qba3c=;
        b=nxmrmN9iH3KVr0uM8lYZ59RQpjlmkmbU3HQ/I/2U2D47JlAPV3gZ1mrK1/2Mf0hc4J
         BxiIEIHrurA2u/qlqkjjbqscHZNv8+fVd1tYp/SpyHSmOa9vjs3mqrHBPRP5Ys+NWu8w
         RyH3PcEmGTOaTqyxWCfpx6IIowBIWk49i9X8DWKsP+Slzt/CLV+tYd1pP3MD1mySSi7L
         JuBywrN9D8sVnnaW/ZMrQsc6kzAKpK/oZweFyaSnEISQ3ga1Rq6hKKqbs2rrImhUvW02
         N9M8ZkU51MQFIIfk78hciQXJQLbLy4xKqZYEDitRKDzvkcq0DiAKEL4KoIiOLyRM4dQ6
         mQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5qJ21qllWRh0FzqroFKtzPkkXOm37fz6CTYS58Qba3c=;
        b=CsB2+cXKuADP3b2T3jVNU5QxmER1Tn4auQOwEwMF7nx20nAIhGzj22uIroEbAjuJCG
         70JnfFPl5mMPun6f2nnjz/Yb86xjjPzLGf60rmh0GousbFhiTkP3yiqHcclpL5oGXSyH
         BDmMpOrA2G6Eeg6CSK4gGHlIJy/KcBwxtvfRfwpuzEv92X34pyNjrndqI8DhS19+90bU
         dkr8YOweZ8qcMX5yzKmYPKmFChFCxawonwUftOI4ITHowT0RYHQWKDMZGHBv3tJeFIfr
         OZSurkcKqd5ryMhi6HiPx0er3lHLCMF8GIHZeS/iPMxIZ3GOQlC+1mkJ79dGs/Febybb
         YiKw==
X-Gm-Message-State: ACrzQf04KuMfxXSHsWO4O3bSF7/Es1zoN+Ec0mZwaSdvMmyqP5MBw+hd
        Ywgj+6nQcX32Pr1fZPd7GDY4CU8E58vIR96zm5w8dw==
X-Google-Smtp-Source: AMsMyM7xBpZAWNhJ4WAJdYS+Ajmvyn2GnphWxcJyL/Nmx+CgeQqh+6qCWfzPYjX2Mfkiv9C5CR+S28fnC1RDjtweqm0=
X-Received: by 2002:a05:6512:2304:b0:49b:24a:f0cf with SMTP id
 o4-20020a056512230400b0049b024af0cfmr2021559lfu.373.1663345886079; Fri, 16
 Sep 2022 09:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1329.git.git.1663326823401.gitgitgadget@gmail.com> <xmqq4jx7joez.fsf@gitster.g>
In-Reply-To: <xmqq4jx7joez.fsf@gitster.g>
From:   Fangyi Zhou <me@fangyi.io>
Date:   Fri, 16 Sep 2022 17:31:15 +0100
Message-ID: <CAEpW-9=o2nmanc6GyeRVhwZNsU-g0A=uSYvNJZQkFg9rvkJ2_g@mail.gmail.com>
Subject: Re: [PATCH] bugreport: add missing closing bracket in usage line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fangyi Zhou via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 16 Sept 2022 at 17:04, Junio C Hamano <gitster@pobox.com> wrote:
>
> An identical fix already exists as 63407051 (doc txt & -h
> consistency: add missing "]" to bugreport "-h", 2022-09-05).
>

Thanks for pointing this out. I'm sorry that I wasn't aware of the fix.

> It may help the project more to help move the topic that contains it
> forward by reviewing them, than independently coming up with an
> identical fix.  The topic with the existing fix appears at
>
>   https://lore.kernel.org/git/cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com/
>
> Thanks.

I did a quick search on the mailing list webpage and didn't find
anything immediately. Apologies for the noise.
I only work with l10n every once a few months, and I hope that is not
too unhelpful when I submit minor patches of i18n text when I find
issues.

Best and Have a nice weekend,
Fangyi
