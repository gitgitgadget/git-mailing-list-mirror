Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5D81F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeH3BN0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:13:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34346 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:13:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so4805119eds.1
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APDrtiUFt07ewOD8NX6i3NM7sMZ4mCNVMUN5HuClAkE=;
        b=HlRZ/Q7csvti5e2YuJfhiPvJbfzzukpMPlIHCisEpAxwDK2oH25n19n1CBQg2Nehja
         Jdrrh8PCFjk4HrIQzSyphpyQo0bm7Al9hqUMiWD6EmHiGC7L5nRO5IWrtgECxyIVpm5x
         +vcPShHzjZCZE8vFTqFXCT1QtmfKZgXp2k2Clo9/v7IcplSOfS+RgJzxmn80y7xx+RU2
         VHmoNrVXNjROfPP97O74Ob9iAcVvXNEy4zG9oC+AfAuBFkJs1HtG/VcJtHTFj0XgtZhp
         KS3XlR0EMOsYdN0EFFJ9UarzBf/qiFlO2j0dJMiDFLFn3cKYI2FcUAAGeWl6ptrNfX5Y
         aAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APDrtiUFt07ewOD8NX6i3NM7sMZ4mCNVMUN5HuClAkE=;
        b=YxZkrX3TPFi+ZcfUHYzK4hWeMkC75tcOjL2ddlibNdCXhiC5OaQ+7IHXKgZWgv3RfJ
         IHJXRdh/WGvhQDuXSGhKNCbGoHt+xIFFMUo/kYQiW8juIPh6bs8tgjut4SxI7S35AfEZ
         bCiObzLY3MV/RGHCL5/Yc2qthENhMIMJVLGPAbmd1Rvn2O/vNX+gn+4qGf6zp39fmQHH
         Lx8kM1MqjCVYt3D1OonUBmbzGY/Q9fQQ7onDzYpLsNsPfj6n8uALc3a94E7FNE6H57F9
         CCVDa8bTT2PCpwvgqnj/EIEcwVJL7id4ZiNz5Lmbid+H0IVW1nPiY8exfdv5kgK0CRaF
         NrhQ==
X-Gm-Message-State: APzg51BbGPywCrHMOBtvYQIgNeQWUBA0C72+HD/TTfa3uy+jEATwr8Na
        WnBRQdFqn+oTjGT0WrQkAu7eF3OY7g6Qnzt6W5BOqdel
X-Google-Smtp-Source: ANB0VdafMZm+UGyuWnSrdddXz1XMCbZuExDN+bigVaQQ1PMs2WTn+X5xG9nIksjcEojG1wLnz2AF+Bd08OVqOaZwrXU=
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr9431457edd.243.1535577281944;
 Wed, 29 Aug 2018 14:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net> <20180829210913.GF7547@aiede.svl.corp.google.com>
In-Reply-To: <20180829210913.GF7547@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 14:14:30 -0700
Message-ID: <CAGZ79kafLRXag0DBmw57sJ0WdTUEckCejKFz0j6UJVNdG7_UDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 2:09 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jeff King wrote:
> > On Tue, Aug 28, 2018 at 02:35:25PM -0700, Stefan Beller wrote:
>
> >> Yeah, then let's just convert '/' with as little overhead as possible.
> >
> > Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
> > colliding)?
> >
> > I'm OK if the answer is "no", but if you do want to deal with it, the
> > time is probably now.
>
> Have we rejected the config approach?

I did not reject that approach, but am rather waiting for patches. ;-)

> I really liked the attribute of
> not having to solve everything right away.  I'm getting scared that
> we've forgotten that goal.

Eh, sorry for side tracking this issue.

I am just under the impression that the URL encoding is not particularly
good for our use case as it solves just one out of many things, whereas
the one thing (having no slashes) can also be solved in an easier way.

> It mixes well with Stefan's idea of setting up a new .git/submodules/
> directory.  We could require that everything in .git/submodules/ have
> configuration (or that everything in that directory either have
> configuration or be the result of a "very simple" transformation) and
> that way, all ambiguity goes away.

I would not want to have a world where we require that config, but I
would agree to the latter, hence we would need to discuss "very simple".
I guess that are 2 or 3 rules at most.

> Part of the definition of "very simple" could be that the submodule
> name must consist of some whitelisted list of characters (including no
> uppercase), for example.

Good catch!

Thanks for chiming in,
Stefan
