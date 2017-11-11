Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E04C1F42B
	for <e@80x24.org>; Sat, 11 Nov 2017 05:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750886AbdKKFZe (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 00:25:34 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37918 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdKKFZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 00:25:33 -0500
Received: by mail-wm0-f50.google.com with SMTP id p75so6141891wmg.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 21:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CNOEwolecSnFICOuWsl2ZHmV3kXTBY09oUj2lWl2tMc=;
        b=qidPgZxVZGXrDkMaOEqttORFd1It1DoQJyfNkevae8nJE7ejoyUOqHiToyusJtwnoz
         p8sMyNK2i2hPtc9UXCmZUAFmsmQHdeJtgcpykrvGldHlQVhvYTnpKssLx9yru3Vp5goy
         PgaOewEUGc+3cc4E7dCDI44+fK9ga6PDycHtZUzhaazkqeJvR8gihiGCEClir96Ryv+I
         nvtyi0YoCPDGX7SihtUvg95taMxAVPNTYZPvnEvYtNN9Q2Kc/W/c4nc8n/jLr0eYMCPj
         XdgSW06vAuWHt2abClal1QOzw4kQMEuz0Rh+Q4Y8u3h9JOzCYq7CEoWBIPFkDDyZyCUB
         tbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CNOEwolecSnFICOuWsl2ZHmV3kXTBY09oUj2lWl2tMc=;
        b=G+mrHmSAkz1/1Jfft37vYQ0wz93iQ966o1PHfijcqWnDI6NjmYiKo0iU6nlIuhJy1O
         e5hpZ5cMiZFTSggpGPP93vucSR7jJ8WaK2Oi5pfbXrUGBoXBamdlXPKg7SAw3e3E3bOe
         GASqphJJkjrqFcp4hf9vWBO+HMkGHiI5f1Jxqs9+tMONWm95w/sApE3+3o+vhSYdQkHQ
         vDN0pmpg0ZsriBaUyImeqBI+thLHsgv9az/vjDXc4QKAAfHeNgkYFQyrEi7Dg9IEBB3E
         Zd+QyTRREfw1quE8XO0pzWlIjEEG3iHP0F/t6SYCc3KjJZA2ORDlzWw74PRo1jOJxpmN
         LCNQ==
X-Gm-Message-State: AJaThX64GKtImDuo75gZN9Dx5vgAy6Dg3XZReUes06po/8h3z9/tZGYu
        YzqxlpleFb7yhtNTsb121H1SXDL0e8eXeY+Ht2Y=
X-Google-Smtp-Source: AGs4zMYWYs/Ez8SL6BzRRpg5248Fg8z2H0sspaDJUFLvQv46sVCOhPOw3oNBzpFP+GfdBN8r7+CZxMenGZnTw5hlAOo=
X-Received: by 10.80.181.90 with SMTP id z26mr3576561edd.76.1510377931938;
 Fri, 10 Nov 2017 21:25:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.136.103 with HTTP; Fri, 10 Nov 2017 21:25:11 -0800 (PST)
In-Reply-To: <CAGZ79kbBypJfDn28j2Z_SCFG9iCZnx-sWmH6D2vqnS+tNKpnBw@mail.gmail.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
 <20171109001007.11894-1-sbeller@google.com> <CA+P7+xpTCHHNG1tAhysOFV5jFHpXdzRk5zfYNHUUVdYiGY55cA@mail.gmail.com>
 <CAGZ79kZAvMKQUjbqWZkhy39sE5e9k1DmkiA42ywiw2NgY1+Xig@mail.gmail.com>
 <CA+P7+xoA5KNW7PEiW0wZp-aohsKbnH8AGAvkk3Y3Ghv=Jhp+hw@mail.gmail.com> <CAGZ79kbBypJfDn28j2Z_SCFG9iCZnx-sWmH6D2vqnS+tNKpnBw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 10 Nov 2017 21:25:11 -0800
Message-ID: <CA+P7+xp64ESHnQgt-9odhGKeCA6VurOozbFa6Qi2sQKmcQtZwQ@mail.gmail.com>
Subject: Re: [RFD] Long term plan with submodule refs?
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 12:01 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>>>> Basically, a workflow where it's easier to have each submodule checked
>>>> out at master, and we can still keep track of historical relationship
>>>> of what commit was the submodule at some time ago, but without causing
>>>> some of these headaches.
>>>
>>> So essentially a repo or otherwise parallel workflow just with the versioning
>>> happening magically behind your back?
>>
>> Ideally, my developers would like to just have each submodule checked
>> out at master.
>>
>> Ideally, I'd like to be able to checkout an old version of the parent
>> project and have it recorded what version of the shared submodule was
>> at at the time.
>
> This sounds as if a "passive superproject" would work best for you, i.e.
> each commit in a submodule is bubbled up into the superproject,
> making a commit potentially even behind the scenes, such that the
> user interaction with the superproject would be none.
>
> However this approach also sounds careless, as there is no precondition
> that e.g. the superproject builds with all the submodules as is; it is a mere
> tracking of "at this time we have the submodules arranged as such",
> whereas for the versioning aspect, you would want to have commit messages
> in the superproject saying *why* you bumped up a specific submodule.
> The user may not like to give such an explanation as they already wrote
> a commit message for the individual project.
>
> Also this approach sounds like a local approach, as it is not clear to me,
> why you'd want to share the superproject history.
>
>> Ideally, my developers don't want to have to worry about knowing that
>> they shouldn't "git add -a" or "git commit -a" when they have a
>> submodule checked out at a different location from the parent projects
>> gitlink.
>>
>> Thanks,
>> Jake
>>


It doesn't need to be totally passive, in that some (or one
maintainer) can manage when the submodule pointer is actually updated,
but ideally other users don't have to worry about that and can
"pretend" to always keep each submodule at master, as they have always
done in the past.

Thanks,
Jake
