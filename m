Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CEFC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 04:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1EA6117A
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 04:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhJTErm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 00:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhJTErl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 00:47:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778DC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 21:45:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so15241142plk.10
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 21:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qdu2eO/e98tyNJ80cfTemOdfT4s31Ft9VRTAtWESHfQ=;
        b=ntqvIiKLk1qrhd1JrDS4tJp+Yvpws48GDm4w16sxEVc3v951mwxAA0RKbv09CYfEc9
         FkPVuXhKlN6hj2ZxeDXNguZxWRuH6PJcz5Zx8a1qlbsotZ/4I50Fp2jdCbcGFramKvQS
         0itK+4MpWUVFwOPbghJvoVLWm5Bh8LZWeu/Q3V36CiQVhg0O1vpjztJSE4LthxiDdE/h
         FoiF+45OqLyHd0jle7tyAEDrtt3MMMl3ByhJeP7Rl+ANNP1D82J0VM+Mi0lGJfq7XpMW
         5djyTW5bSHmiSvviVLr0M7NyM5HfN/exWcapv6f0oitKK/iqAsqh5NcWqJFi14Y+wAGe
         oz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qdu2eO/e98tyNJ80cfTemOdfT4s31Ft9VRTAtWESHfQ=;
        b=hosKh3j0yGaJfgD2zQIHkWNGowFS5TuY4lNGNQfbVsFPFQbJhkktUlgAgIbErTAcGP
         qsC/gfphdYb0CkGnfODarBr13xjRbnQVeq1AI0nmp4AYS03nhc25gBL9YWEU41tEcp8B
         /M32iMF+tvwEPaRsXGEOm2KymOU38MHtyvTyMw0DhhS59LGeLxepT3l61NMqbXxkyIkI
         JMs557sw6rSt2LP45HiZfjR8iaA4YfXO6R7K8rfQl0zS10+4Bc1rDzTLp47LFCBC8hbv
         a+6btBLLAzu0IajpdY/oouMhOu3DnK3TXTMJhF2T2F9vYRk9+ijegMdkBW7NuoTtKl8f
         5v8Q==
X-Gm-Message-State: AOAM530ymp/1cRQEBeuos7WgfVEDvAFdRUnlQ3oq0PJ/+2NSICdm6VDE
        N+qRxaPEnFKy3Z71MjyFjyzFF0j8sIb+sA==
X-Google-Smtp-Source: ABdhPJzlRIzF18wv6eXpy7aaG85xqYVpMWveflCP7qK11mSrlaTGv9xnSn1FVBA+JYf+TpdMkzr+HA==
X-Received: by 2002:a17:90a:fa91:: with SMTP id cu17mr4727292pjb.91.1634705126244;
        Tue, 19 Oct 2021 21:45:26 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id h3sm812384pfr.98.2021.10.19.21.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 21:45:25 -0700 (PDT)
Message-ID: <9652166a-9db3-9e14-5fad-ef0deede9f28@gmail.com>
Date:   Wed, 20 Oct 2021 11:45:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-2-sandals@crustytoothpaste.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20211020010624.675562-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/21 08.06, brian m. carlson wrote:
> +[[monorepos]]
> +Should we use a monorepo or many individual repos?::
> +	This is a decision that is typically made based on an organization's needs and
> +	desires for their projects.  Git has several features, such as shallow clone,
> +	partial clone, and sparse checkout to make working with large repositories
> +	easier, and there is active development on making the monorepo experience
> +	better.
> ++
> +However, at a certain size, the performance of a monorepo will likely become
> +unacceptable _unless_ you use these features.  If you choose to start with a
> +monorepo and continue to grow, you may end up unhappy with the performance
> +characteristics at a point where making a change is difficult.  The performance
> +of using many smaller repositories will almost always be much better and will
> +generally not necessitate the use of these more advanced features.  If you are
> +concerned about future performance of your repository and related tools, you may
> +wish to avoid a monorepo.
> ++
> +Ultimately, you should make a decision fully informed about the potential
> +benefits and downsides, including the capabilities, performance, and future
> +requirements for your repository and related tools, including your hosting
> +platform, build tools, and other programs you typically use as part of your
> +workflow.
> +
>   Merging and Rebasing
>   --------------------
>   
> 

It seems like recommending to split repo, right?

Ultimately, if people choose split repo instead of monorepo, it will 
only delay the necessity to use advanced features (partial/shallow 
clones, sparse checkout, etc.) when the repos become large.

For balanced view, we should describe benefits and drawbacks of both 
monorepo and split repos.

-- 
An old man doll... just what I always wanted! - Clara
