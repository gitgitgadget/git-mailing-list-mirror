Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8971F453
	for <e@80x24.org>; Wed,  1 May 2019 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEAKbb (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:31:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41335 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:31:30 -0400
Received: by mail-io1-f67.google.com with SMTP id r10so14503527ioc.8
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/hrXM6foWBqT6op7j1sFY1RxOhOSoAe5Sis5qi07/k=;
        b=CGds5fo5zGIpASu4EQICvvxwvCfbfaOLrMeRxihx6MQfEcNJFRqgFoc41H3eoHJE1D
         aNlL5m2wRSKWTsz43qhvG0sc/Wf0Jwsz7rXVloNdm9AMOpbR31hmyGu7pols1JMZ5Jlr
         qWUS/gyWcfLJ6HVJm7AQa/6NZM3AapJ8bQsR97MP+9nP/Nfzx325f904AmHs8hwJ3hER
         eys0RksPap/JMeWOAMLtKOav2i2vl4afd+Q42wLlGmr+alH25OTFRDyD3NMJCY4qV1fg
         mvh1gdN1pE3GcSnRUvd9Mm833NtUaAzyn+iIzG3kT8HmrmU5TIDtVOOGx/JzvCqFTzbk
         0y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/hrXM6foWBqT6op7j1sFY1RxOhOSoAe5Sis5qi07/k=;
        b=JJIJ0v0GjMTsHprlerVzG5mDLpEkPiFtp+5AG48InkOvVy3u+zB7uch/Xq6dwl3S9R
         TXeM4nTnqdFCNb7m24wCPdC9DDG+oEEiu9ulOHDitY0601uvQY34veDGKfLZqaM3yF5Y
         aShcMx9ucQKRCSYt00Spmy+EvFUppzBGoX9IESIi3dhnzaQCEMyZEaEEYAPC1so1EPs5
         GTSmB7yni5hDw5nuJFjKk/iPtjSeFhz3IJbNnRBFfk0Hk/mx4eiZVNE6GE8d+sPD9NYN
         IxYTWR7ih6lTM0OxciECxfd/cke8KjHlJUX+e3F4RQsehnSL31X7QO4sVt3Y0cvx8fj9
         ENew==
X-Gm-Message-State: APjAAAVc3ixlDRoqyTFnO8stfjQjsBSZRoJVzwq7FpnRaHwzuqj74Qdi
        J0GHyNLI8IbZduXkpcSh9u+MRf2vhVO6rh5cajxWSw==
X-Google-Smtp-Source: APXvYqzMJZpdjX6iTrIkVK9cwOwowqfvb29gbTdeNoJqT/sJ135Ab2iO2nNHL/dT1bd+1FBC8qo4h3+3yjC9MLLv4Gg=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr4412096iod.282.1556706690086;
 Wed, 01 May 2019 03:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
In-Reply-To: <20190501101403.20294-1-phillip.wood123@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 17:31:03 +0700
Message-ID: <CACsJy8CNUEBXmBcQnRHqdeFJtTvBuZ9thP7QPAw-ZOD+2ty3VA@mail.gmail.com>
Subject: Re: [PATCH 0/2] read-tree: improve untracked file support
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> These two patches teach read-tree how to avoid overwriting untracked
> files when doing '--reset -u' and also how to respect all of git's
> standard excludes files. I'd like to see the porcelain commands stop
> overwriting untracked files, this is a first step on the way. I'm not
> sure if we want to add options to the porcelain commands to protect
> untracked files or just change their behavior and add an option to
> override that. I'm leaning towards the latter but I'd be interested to
> hear what others think.

For new commands like git-restore, it's definitely a good thing to not
overwrite untracked files. For existing commands I guess we have to go
over them one by one. For "git reset --hard", it should really just
overwrite whatever needed to get back to the known good state. "git
checkout -f" , not so sure (seems weird that we need force-level-two
option to override the protection provided by -f, if we change default
behavior)
-- 
Duy
