Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8561F405
	for <e@80x24.org>; Tue, 18 Dec 2018 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLROfT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 09:35:19 -0500
Received: from mail-yw1-f51.google.com ([209.85.161.51]:34268 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLROfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 09:35:18 -0500
Received: by mail-yw1-f51.google.com with SMTP id g75so6757237ywb.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=qHaa1GN8gNWKuCRK2ZXLSbLJHkz4mi0YIMUiu/u1IOg=;
        b=UlzbejoWQf1n2wLSEeJzlls3SxA4lxpr4ogJRe5j4LvgmLG62hBfGeSDcXdPT6kJzM
         rAT82lCFxst1a7Hk8T8b5H+a5RU9DYK+6JHyaxGMbhtNPyrBekHCUQyzYaJ6UYYVgaDz
         QVn+BTkTo10j2r5mmELZudO7AC6lnd1DYwZRacSLlLsHKDbLvLasd6gmO7lZLQ0FVF6s
         P2MkoK1+R0h3UxkRz9dIVRyd/hnrXACjgLIEel3O/7JUTdOzGZBa7vFb2UYNoOdjcbla
         sH1cuuJMpgUsOOo98Cu48bdsnTZ5GenUiVgIOirdfR2jLRyRWzb7mMG7XbBsUshO/FS6
         v40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qHaa1GN8gNWKuCRK2ZXLSbLJHkz4mi0YIMUiu/u1IOg=;
        b=jOLOMa/dRzs2EZmGh3b6iT8T8Kcwcof77mXrzY+pflzKdwRUDwT7AcTTDjnvuDSJbj
         8qSYO6NE0J/sNiKRRzE73a+cvL3fC1HawTZAuO0X7j6DhimSaUcRvFnOOu7tj6k+HspX
         KRK+pbVH8X+MZ/lUyTi1mKnSG18p2Ky79mxavngPdNmJT8FfZ0fzhIAi7CJHLuu1BuJv
         WLO4UcGPRS1KJESA4uvyHp53rDSd/Rif/pz+OhSQDWqguYDNEO86HMWbhQNQCQCy+2ha
         05FqXU4DmDrnkwkb4+aJXfl7vpeptXZtGOoc4/8IEU+0kIYBTPVAx2uv2brGoMkCVq+9
         uTXQ==
X-Gm-Message-State: AA+aEWawJ/JcwkvV6mRXTgrpHmn+Bw/e+TVhLTJ2T8grngr02481a3Sr
        qNA2Mdl2UMDPaQXboGv94dorUhWy
X-Google-Smtp-Source: AFSGD/U+oNBAq5ZO6D8T7YtLZJYjr9HKVsd2qweKsHyFo1w+mZiY70HAz89173bC2l6NeOxgJ66MmA==
X-Received: by 2002:a0d:ccd6:: with SMTP id o205mr18183592ywd.339.1545143716489;
        Tue, 18 Dec 2018 06:35:16 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v9sm9375845ywh.2.2018.12.18.06.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 06:35:15 -0800 (PST)
Subject: Re: commit-graph idea: warn when disabled for incompatible
 repositories
To:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAEcj5uXJC3Za0YCyazJi82JdF-tLCDs5OrzCwyD8Y155GnJa6Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b74bab07-dd77-5195-aaee-a324e9a6b824@gmail.com>
Date:   Tue, 18 Dec 2018 09:35:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CAEcj5uXJC3Za0YCyazJi82JdF-tLCDs5OrzCwyD8Y155GnJa6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2018 9:22 AM, Thomas Ferris Nicolaisen wrote:
> Hey there,

Hi, Thomas!

> Accidentally, my first use-case was a local copy of a big repository
> (chromium source) that another developer had cloned shallow (I wasn't
> even aware of their clone being shallow at that point).
>
> After spending a little time trying to figure out why no commit-graph
> file was being created, I noticed that it worked just fine testing in
> a fresh git repo.
>
> Then I discovered the .git/shallow file in the big repo. So I did
> fetch --unshallow, and commit-graph started working. Taking a 20
> second log --graph operation down to less than a second (wooo!).
>
> I saw some recent release notes that mentions that commit-graph is
> disabled in incompatible repositories (graft, replace). I assume this
> also be the case for shallow clones.

The commit-graph feature is not designed to work well with these 
features, and the "easy" fix we have so far is to completely avoid the 
interaction. The tricky bits come in when the commit parents can 
"change" according to these other features. The commit-graph would need 
to change at the same time, and this is actually very difficult to get 
correct.

> Here's the idea that may help others on the same path: Some warning
> output when attempting to use commit-graph when it is disabled (either
> by configuration or automatically).
>
> I think others that come across commit-graph may have tried such
> tricks (like shallow clones) to better work with their repositories,
> and it could be frustrating that commit-graph has no apparent effect.

This is a good idea, and I would happily review a patch that added such 
a warning.

The warning would want to be in builtin/commit-graph.c, and use the 
commit_graph_compatible() method from commit-graph.c. (You'll need to 
expose the method in the .h file.)

Thanks!

-Stolee

