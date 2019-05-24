Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11851F462
	for <e@80x24.org>; Fri, 24 May 2019 22:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404345AbfEXWae (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 18:30:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38769 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXWae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 18:30:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so16345426edl.5
        for <git@vger.kernel.org>; Fri, 24 May 2019 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bFAho95KtRQQLVNLPy8oZhEs9zhBfdkH++RJLVCMw1g=;
        b=rNrdiu6uhdV3MzQHgI/bM1k6xGYMjiAARHlxHPcaJ8C3vrflvR5L0DD19rYJJjmYkS
         c1uFpizTWj+inXz7GDtSEK1Vx2qSpqhUa7uzn2WTUoGmCNT665VohHXT0wZbFsWTGqBI
         JLv7IgVzi7ktulgcD9ipjVo1eXs5s8Wg73U63xfcTbRLTcvahoRrAXMuOWj/QdadqHba
         yO0WcG5ES9IQxE3wKgR6c0f2/IsaSJNqkeEPqkFRjtI/4ANRUcYFHDBGV7sPhDvKAQj7
         p38+c+j1qhJySpQ4vXnfcBjjN7E1wq3xDCYde0CTF6FJOSEKWgeDaMdb/Fcr8AwlltH1
         0M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bFAho95KtRQQLVNLPy8oZhEs9zhBfdkH++RJLVCMw1g=;
        b=ej1cVzdKAYUEVfZc4Kzpny5yiYLniVMo0DZoAquiDqzSNUKHU1dDQCraDKtrV5GTlj
         hk4fdWm87YyPP1v3NaopVzuV84cr+YqV7zvpHpdMOn4C0NLKnX3an/n3r8CLL7bL+SHf
         NiZvrHNzkCuiO1q8VVlGzYrXbM9k9t+Pxvqq0s9S2Nr2a+YvecRemuVsE3Av//RTafr4
         xSCXCwPX8srloTMhUIM7KIMl15pKj3OdWqUbc5Q5G24UVsWYO9C76crwb3L511m89f9u
         LjOGUYVdrm89n0S0PTPIAQpuCfnuEoXZ50lucNf+bW6aR8uJcOu7XFBrgxQOldyNvVXr
         8m3w==
X-Gm-Message-State: APjAAAUCjzGujmzjV84gZWnZ8+yO4j4oCUwDE8jjjMgQgh+kLouyyXSL
        BykTSECkMwNOeg9DiW49lAA=
X-Google-Smtp-Source: APXvYqwdO9DYyhHR+fiSSrtbPP6I1PJFe1pxUDX8QN2CyEpQhv1GFBIA554YWE9iE9uhjwxw6w9nOA==
X-Received: by 2002:a50:9430:: with SMTP id p45mr105247129eda.257.1558737033110;
        Fri, 24 May 2019 15:30:33 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b6sm1007258edi.72.2019.05.24.15.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 15:30:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 00/52] fix some -Wmissing-field-initializer warnings
References: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
Date:   Sat, 25 May 2019 00:30:31 +0200
Message-ID: <87a7fbfptk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Ramsay Jones wrote:

> [No, I won't be sending 52 patches to the list!]
> [...]
> This series does not fix any problems or add any new features, so it
> is not important (hence the tendency to 'slip'). I don't want to
> flood the mailing list with patches that nobody wants, so: is there
> any interest in these kinds of patches? If not, I will stop now!
> (I have a 2-3 year old branch that addressed the '-Wsign-compare'
> warnings, but that is probably beyond salvaging by now :( ).
>
> This series is available from: git://repo.or.cz/git/raj.git with the
> branch name 'warn-master'. A trial merge to current 'next' and 'pu'
> branches can be found at 'warn-next' and 'warn-pu' branches. (The
> merge to 'next' went without problem, and 'pu' only required a fixup
> to the builtin/commit patch).
> [...]
> What do you think?

I think just send it to the list. We've seen worse, and it's easier to
review than needing to get out of the normal E-Mail workflow.

I'm keen on getting us to stricter compiler warnings in general, but
we'll see whether this specific thing seems worth it in review.
