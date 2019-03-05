Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A45C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfCEXpT (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:45:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36324 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfCEXpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:45:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so4208713wmj.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=86BZkTi9QcB+9RrXeS5u1EsGI3EQDjbYRtI2qjh6+oo=;
        b=onLJXCvRvDn3VrulRNDLJeVOSbTu2Z42D1OxB8Er/HBH8duf9qDckJjgZdpPuwyZJM
         wHwJ+bkYYsRGR9omaIPw7ggvxjD+bomLRi/YKqQR2VTntamKcqkVPbXcN/3YahTBUjtt
         YLpy4+3xGzlooavlvCdpQGfTguAysAfwcHYnU/TIAlLg+ML1Ce8JgMCzSOdnnyPimK3w
         Rb6GKdmlX+73uQcqZnIMWfSQp1QuDd9EzBkXXY7hXmD7+UIWsxeuQAhQfdjs4GqzEs2X
         mE//fm6thTBS9UGZP1OW110acq8N/Azt8APjuMlNaw4sOP08srXt3S+FgR/PcamRB17F
         qPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=86BZkTi9QcB+9RrXeS5u1EsGI3EQDjbYRtI2qjh6+oo=;
        b=bjr9r3Gw5A+iQ6WanENopQWxJviu8SWayfMFQRL4TuSLBYwHB6j700F3zp1oOk6P8c
         a+iUSz7r3YWbHXV3xxmXLWOtM5emw65uMRUTB7ui69iczSgF9I92a7Atk4aFWrRFJZvE
         6kOHCoc1Cxk68ZUtzvqesk+oL60ZQnTrsIktprAwjGLRPOabHOmlZnR2eyjZKpJ34uEs
         0eB8IDhKZZdeVeQkSuIWheat8C3QPhEr8R9mRL+N434LXBElZVxfzfHh4S9YujtCmwxs
         VO3Q/RYm7XHIkaB/ZNVMEjNYUQ2BAPXYr2CczYLyZgZ5tVh5W+yGDd+3rIIdKlzwwrfZ
         a/KA==
X-Gm-Message-State: APjAAAXV36bp6SE24oOVyDmR5WDDNlohTVjiK47cxVy6f7vE7fkxlqFn
        k4MT3BDjKvgIyMT594JfKp1pSxrszzQ=
X-Google-Smtp-Source: APXvYqzN1sW1ydmNrQZ/VoEycxnmTsUB+fu9CL53a9LCQ0O1y2eF/qvu304/kLTnpIR7aOzoRpWWoA==
X-Received: by 2002:a1c:a6c9:: with SMTP id p192mr569821wme.58.1551829516917;
        Tue, 05 Mar 2019 15:45:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v2sm226050wme.29.2019.03.05.15.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 15:45:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] remote-curl: mark all error messages for translation
References: <pull.157.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Mar 2019 08:45:15 +0900
In-Reply-To: <pull.157.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 05 Mar 2019 15:20:39 -0800 (PST)")
Message-ID: <xmqqtvggsx6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> As suggested by Jeff King in a nearby thread.
>
> Johannes Schindelin (1):
>   remote-curl: mark all error messages for translation

Does this come on top or below the anonymize patch, or it does not
matter which goes first?

>
>  remote-curl.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
>
> base-commit: c1284b21f2436de24c9559fcc5f4badb04f47773
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-157%2Fdscho%2Fl10n-remote-curl-diag-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-157/dscho/l10n-remote-curl-diag-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/157
