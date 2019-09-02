Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3381F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfIBTFc (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:05:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41616 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfIBTFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:05:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so13722496ljg.8
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KXwQSbTZTpXO1uwUzvZdvK82niR0+KGcdpV8G4e6EU=;
        b=brdu9/GAjD3I8EctEq6W7gQlB/uZTtWh0Ut9sZfln7eHRpU4kYR5C2fcLzhO5TdDQk
         YMOL3fe19OPYS4aIr9/nsGg50T/pTcfe/cb9Z120XkEJbg6tjKuGHbYqQCgwnV5g7PZo
         tz3SmQ+V6yEeW0j9UQSEqu6PhKgxUZUcuYCJWm6DOOSx7oPuWEjVByG9j3lTutZ/71ja
         ONrTcRMrgry+hyKUKjy7FkxVOPPYDFKQkHnH6b6QnChXxGfOOYz0TggBVLGimggIiw1K
         9xOVb81paFp95TDMgho1HT4b55YS9WDUkgrlEUxMG251+dC9niPd3Bgn9Nj1BkjMBsNJ
         pvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KXwQSbTZTpXO1uwUzvZdvK82niR0+KGcdpV8G4e6EU=;
        b=nTfzG6U9rUNcWjXQoB5uw13QD42jI6dOPE+lG6I7m6NYXSUjD8u8HV8S4gsAea83GW
         hodUbMP5iNNlaCMEncBfoMVW/cuFDyEqeSgU9SvoK/1wIyde2CaN7nGL3BqAk2LMMM+X
         mqf+lh0HDrblfJgnvSTWqxxRCvSG6SzwWWZpwBeLyT0kmbvvbPPO5/TZWXWOATNl8aDy
         S/hi31Lhk+QDnnTEidBQ71AvMIaZiIjfhkWzKjyk8aTGouzHYi1BEwrdTlVEE6iv6DYS
         jMgG1yMWH8HDZ3SlpwI+SviBvlUnqc/yaH+x+RPMby0ucSKPmZBY3GGu6evJxfBgTMIB
         reKA==
X-Gm-Message-State: APjAAAXHyI0gnm9revJN7RBEw8H+Gn6nOZQXoVZViM5Jc33oMAE+WAu6
        JE27Jmo1+x5s7GKg4/PJWnUQ2M8ESeTzdPSstEE=
X-Google-Smtp-Source: APXvYqwga6Yh1gyAdF5PKUo04uy82DaYh/Q5S6oDrKx4ePQ058eWSfzGdzkagvBxSWOg/+dicj6eUJFCdgenkyt4UOc=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr718076lji.26.1567451130063;
 Mon, 02 Sep 2019 12:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com> <20190902181954.zcxuyqrdzs3dzjtq@yadavpratyush.com>
 <CAGr--=L64jiE=x_McdfWJuQTz1Qo3wp0nc8xaeKBGe0GgW5Kxg@mail.gmail.com> <20190902185321.m76dffzfc76astar@yadavpratyush.com>
In-Reply-To: <20190902185321.m76dffzfc76astar@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 21:05:19 +0200
Message-ID: <CAGr--=L3eL3L1456uQo=poVqXfxO7PxRpgEA8kvp7DY8KGs2Zw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, sorry I misunderstood you.

Thanks,
Birger
