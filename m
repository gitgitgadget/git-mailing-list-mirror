Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601DB1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBINCR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:02:17 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36645 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeBINCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:02:15 -0500
Received: by mail-vk0-f68.google.com with SMTP id m197so4774763vka.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JN7Jew1TM4yM9la2I+rX+IBv0MfUiecrY8xy6FKaYfY=;
        b=KUk51Ca07vpYMgYTelNR77fATSrg42ywvyC4BZJwyASp9/73i2zuAod2FjkgcPsTOZ
         4CgsvrnrXFpQuUUclG5JZMhQP0NDHKujAG+HjwkuoJS/lVzsNVR9EtZZa0xb3iAXn4Vt
         c1DmYJb789+7SuvdANFFsXo6fsjnnHq7e/Pu5u+DeuMu3EbfhVTwHfRRjiXNF7NDwm7g
         LTSCZvO3md138bTxgOxR9L8tsFuxca0WHH5gQU25wihZVJ8lBZg/vJYqySJjYhUq0kTg
         0t8tSt7+YwkbqRQ1/T1vzTpi4+WfwGeSZ/J3yX+rbEy2kFYx7vOfzRhoxofb8XTdlCQ4
         tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JN7Jew1TM4yM9la2I+rX+IBv0MfUiecrY8xy6FKaYfY=;
        b=JMYIpehZBt1RGhd2aJM1A6LeqoshUQeWJ4dinudtwZKXrFk/eJPHARdRbCgrqQRWfk
         bT5lAWDK/8F5HnHj3IwbsVJBwLNq0d53iIg4QnpO6Jqd2KTV//cpIokPq4ad2rcXlieW
         TZ1h3nGBc4sSOSVd78LVRHPH64pxFa0p0Prpro1LdDwenkluVnZd8yQLcbGyR3bQbHb5
         eoSqrcKgDiELSdsLDauZIGAmkDcRQhJoixkj/4gIIlGK799lNssPiThD07DS6lokHPxX
         fd7y0BH1NWPW4kuKzn3P0Qi09DYECStBYLfAwXquQgXxDoCp0Y6nOxa48i9aaGwaYs0r
         Ig2g==
X-Gm-Message-State: APf1xPClVu4Tdp5R+DrEExIr+E6RtyUu/lBFbPqQbP6u495Qz33/QzlY
        fnAeh8g6WCbl/3O89TUNLM+NBiyS+nECYK7rRhE=
X-Google-Smtp-Source: AH8x2246FiCirpKmLgVkJAE784pMhvhI9xdLVrdGDTV0B9k5cPw4quiYYVauYPnv7r9zIdA9bqfNRbs11l+1DNLeiek=
X-Received: by 10.31.198.135 with SMTP id w129mr2403413vkf.39.1518181335199;
 Fri, 09 Feb 2018 05:02:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 9 Feb 2018 05:02:14 -0800 (PST)
In-Reply-To: <1518122258-157281-15-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com> <1518122258-157281-15-git-send-email-dstolee@microsoft.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 9 Feb 2018 14:02:14 +0100
Message-ID: <CAM0VKjk-JvCNebTiHVm16vtwKpLF+N-gfGNL=7sYR=OVTb979w@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] commit-graph: build graph from starting commits
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 9:37 PM, Derrick Stolee <stolee@gmail.com> wrote:
> Teach git-commit-graph to read commits from stdin when the
> --stdin-commits flag is specified. Commits reachable from these
> commits are added to the graph. This is a much faster way to construct
> the graph than inspecting all packed objects, but is restricted to
> known tips.
>
> For the Linux repository, 700,000+ commits were added to the graph
> file starting from 'master' in 7-9 seconds, depending on the number
> of packfiles in the repo (1, 24, or 120).

It seems something went wrong with '--stdin-commits' in v3, look:

  ~/src/git (commit-graph-v2 %)$ time { git rev-parse HEAD | ./git
commit-graph --write --update-head --stdin-commits ; }
  ee3223fe116bf7031a6c1ad6d41e0456beefa754

  real  0m1.199s
  user  0m1.123s
  sys   0m0.024s

  ~/src/git (commit-graph-v3 %)$ time { git rev-parse HEAD | ./git
commit-graph write --update-head --stdin-commits ; }
  ee3223fe116bf7031a6c1ad6d41e0456beefa754

  real  0m30.766s
  user  0m29.120s
  sys   0m0.546s
