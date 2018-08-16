Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031361F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbeHPFfE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:35:04 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:41335 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeHPFfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:35:04 -0400
Received: by mail-yw1-f44.google.com with SMTP id q129-v6so2416365ywg.8
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CbTX8KbLLC21nAcmq4TuBJgLG55UsZHMm2SEkHYNxk8=;
        b=ByPwbqBRcA0qyMCcmCk8k1FsO5vg2iHACQvo+1LWgUPAZqcMXMfadJX1yXpDNHVE3k
         k+XlqKKwKM0aRQRTBBr7Ffp24QPp+AgGAkH8Sl+Z7vVQtnCKqcpEIBWUMnJomTRTuDH2
         0FObdfS2Z97zY9zbWsufPgBsY9RjRewsns8Ro7cjdHAxzXx0zVfiq1koGqqOVkCns7kV
         mJCfQQ9y2XPhKQlEBtfQxzlB9vKckO0Ht8P/nZpIMxFEgf05OMKA1W0niqd2cNDDYLhl
         Wj0mb93TS4cOnPof+ZC86vA235YxeyD4sn/EMi2hbz9EzBv6bmh6pNAg+DT549CGBNdg
         9DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbTX8KbLLC21nAcmq4TuBJgLG55UsZHMm2SEkHYNxk8=;
        b=Xn7FyM10Q5uGr1qCC8FciEl5PnglD/HXNKr63NRHBgD5TUh8/L550E7gocrwm4fQkK
         DsKAy1iwmBegCJ70rgkpfHJTtXk/0rvvF/ncevd/EUJQYndKQj0mm66CKcdxSWgoQNlI
         R57AI4ir8Uqg8L3ADWBgRdWFnMuHMha3yH8pHEg3uh7u8FaLHxPdGelG4IWimrnUiyWD
         2jzPEaWQb6ga7NQ4sNykk8GvUQTQ2Fw+xpNj++XE3AzJKaXWtSQe4DVg4D8yr7frQ2cH
         +bj8c6Jr6tZBzeX2w9qpKrIc73D+PXP7Ucx6fXe7Y2SJvgwyn+1+e+SPUuVnC9DR3A2J
         NuHA==
X-Gm-Message-State: AOUpUlFER13CKgFWI/gyMEvspAfCocBPxmAE3yNvx/CrwgBJDbjq7hC3
        WiP7pfAIUjo5KiDwKptP+0B4JRq1bKZMFD6EliseXQ==
X-Google-Smtp-Source: AA+uWPwaoQQvf0VgdeATgtl34o8RmYDrGk91F5bn4LfuoW9cADhS2miZZEV7ffsu2MiKiYjxEjKCf0QeattkrJxCWXg=
X-Received: by 2002:a25:af08:: with SMTP id a8-v6mr12892898ybh.167.1534387193760;
 Wed, 15 Aug 2018 19:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <20180814185743.GE142615@aiede.svl.corp.google.com>
 <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
 <20180814211211.GF142615@aiede.svl.corp.google.com> <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
 <20180816023446.GA127655@aiede.svl.corp.google.com>
In-Reply-To: <20180816023446.GA127655@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 19:39:42 -0700
Message-ID: <CAGZ79kamoPjX_yWYABLoyTh8jqAPV4iVX0r46q=41B12zku=tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [...]

all good reasons; ship it :-)

> All at the cost of recording a little configuration somewhere.  If we
> want to decrease the configuration, we can avoid recording it there in
> the easy cases (e.g. when name == gitdirname).  That's "just" an
> optimization.

Sounds good, but gerrit for example would not take advantage of such
optimisation as they have slashes in their submodules. :-(
I wonder if we can optimize further and keep slashes if there is
no conflict (as then name == gitdirname, so it can be optimized).

> And then we have the ability later to handle all the edge cases we
> haven't handled yet today:
>
> - sharding when the number of submodules is too large
> - case-insensitive filesystems
> - path name length limits
> - different sets of filesystem-special characters
>
> Sane?

I'll keep thinking about it.

FYI: the reduction in configuration was just sent out.

Thanks,
Stefan
