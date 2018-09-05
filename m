Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40361F404
	for <e@80x24.org>; Wed,  5 Sep 2018 21:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIFBg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 21:36:58 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34108 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeIFBg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 21:36:57 -0400
Received: by mail-wm0-f46.google.com with SMTP id j25-v6so14945834wmc.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OQ2G4ajkTVQo0SpKM3jjIcd+D7wi7oT6tUMEaNxaLjU=;
        b=bIDVb1tcabipRps5sa80Hj8vT+zkFCbBrBWENrMiGS8R/ZZUkbL0ApkPbpQ/mjxgEE
         XmM3tY2HbyvXxCz7DiPafiYIGHAwRV5Rc7F5Fts7M6Cs9V9HJdg52lyc3Wg0CJSXeylk
         lBehHV/6/KcPobemtcsS8u1dT326xAIHwKIGqEj7/rqbvLaRHebaAaVlE4De0k8XLcWJ
         zH0cF73yp1KLTKiLT+hJ9EZjUC4BPrWbGGKx4KQKtwXeRu63UuPnXwWj8syZ5Xr1ctj4
         v9IRNVfrCj+RSGi+o8bKekS4Rod88sjz6Kz2Af2Mufs0mwoCtgp0K0sv2TPXpckap/fY
         z/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OQ2G4ajkTVQo0SpKM3jjIcd+D7wi7oT6tUMEaNxaLjU=;
        b=hC6AkPlKAEGxpY/GTEewaP/C6epFXdULzbVjcF8jJBmKFNi9EQi8RVzu79FgJrF6ep
         fPk5JtC7JIlKZ6AYyBOcGCWFWE+5PWlzbZRCD+2PMlsbtjyfvu2ZFwAFZQx1mLpPHRHK
         U0MFlWQETj4Il2mgwipyT9ZWRU2dlN9e9U4EOi3CzWsOdt4iYmvNGAtxkn5rKIOXdgHB
         /AesFNfXOPlj283bN+eeiZARQXeOGPIH+8CExdGlarsS825thFHdUgtRKVF4ryKJCLEk
         a0Rb2vOdvIW+Q06bfmvwd01gXJL9YDjULKG8DL03p+qOmxP5nqEutrvhxJbn3njZmZhG
         JSPw==
X-Gm-Message-State: APzg51CQDBAGyANX6/DGH3N69J+5XAntlffh5K4CVBKe2oZbiwuwmlxc
        ooSahihDzjnqU97dDbK1P38=
X-Google-Smtp-Source: ANB0VdaBJmDnaHYa/2rQnzsuKufnfSdq09/2AzaN/tshbUkipBQIkOSv2AS+QFWgebA286pv9/9A1g==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr124626wma.4.1536181498537;
        Wed, 05 Sep 2018 14:04:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2706888wmf.34.2018.09.05.14.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:04:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
References: <20180826100314.5137-1-pclouds@gmail.com>
        <20180903180932.32260-1-pclouds@gmail.com>
        <20180903180932.32260-25-pclouds@gmail.com>
        <xmqqo9dd6kx1.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZhQJ7TbTuuDO_k-p80rGnOTjVcHf0aoq2+=pG4bwetNA@mail.gmail.com>
Date:   Wed, 05 Sep 2018 14:04:57 -0700
In-Reply-To: <CAGZ79kZhQJ7TbTuuDO_k-p80rGnOTjVcHf0aoq2+=pG4bwetNA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Sep 2018 14:12:02 -0700")
Message-ID: <xmqq7ejz4pvq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Presumably you merge the tip of this series (which contains 24/24)
> with the other in-flight topics, that make new uses of
> init_revisions(revs, prefix), which 24/24 allows. Going on either
> parent side of such a merge will have working commits, that compile.
>
> So from that POV it doesn't matter when the #define is introduced.

But that is not a very interesting point of view anyway.

> now and here, but at some later date, we would want to
> 'git revert 24/24' after fixing all in-flights of today.

No.  We do not want to revert the whole thing.

If the function that takes a_repository is called repo_rerere(), as
opposed to just rerere(), it should keep that name after we
deprecate the function rerere().

We will want to get rid of #define that gives a thin wrapper and
make everybody use the API that requires a_repository parameter.  

And from that point of view, it is backwards not to introduce
repo_rerere() when rerere.c gains a variant that can work in an
arbitrary repository, not limited to the_repository, and fix it up
saying "oops, we were wrong and this will break topics in flight" at
the very end.

