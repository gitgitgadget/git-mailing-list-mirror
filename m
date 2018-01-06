Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63BD1F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753570AbeAFALz (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:11:55 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:40327 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753550AbeAFALx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:11:53 -0500
Received: by mail-pf0-f180.google.com with SMTP id v26so2824307pfl.7
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6EXdLF8ebwf4u9F0v17No/w9bTs2IEmSuXemGqeO29M=;
        b=Dj/wB/n4aYa574aSwTLQrZXXzlsNfpHVknH0YZC69SsDnlJ8AfTDN33B8kYiLZNKxj
         vSAMUVXa5zE02vDQYRJBpLqN+6jPd40SXK+E6c1cFQglnyTI1QK4MSBK4KqFLfwDYxwQ
         NJkuny9lPXmlCw4Ho0um3A9StpXF5i0eK/zQPojip+YPQEb/cA9MfWO9arXKjK26++FF
         SQD0N2bzqepOJswF5kQp1MMV72cynbTzGdoHOc3XD7By+S6TWwR74toZT1n3BgTHzeBq
         BxPozPbXeQmXqkRCDmyEoFWC+e/t3ee0KOE0FmLsg+dvjor+w0vNRYUrZEJU/7YT5s8k
         piRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6EXdLF8ebwf4u9F0v17No/w9bTs2IEmSuXemGqeO29M=;
        b=fG7dBrAG+f2xC69d84uJea7SbUhVT4Ok8Qir5vywYKmSIQu8HRdl5dglziJ8EF/ZUn
         HU/a7+J7LQQGycDfaBDaBh8g9rR+v0qfH41S8arydSy3hYBSPdEgzEdUyGzjgAa5EFO3
         Phrl+MphwU8kDy+FkuAJBf/3V5xUvY9ac6R3K40IU3LWcOpJ546lSh6v5bBDpQ4f8iVe
         bG4RRhdUuhcc2W96zaS+WQYBYF8r6Np5UbRGPxP0EhtmayVg0O7kvzYqqIWTRi5RTS5P
         TiOKhCHVqstLZhlNlM4qkcCDr0bxBzr+mCgvUo63fkHdbahdZXRFJrjdjxEDz1Q6qQvr
         9HxA==
X-Gm-Message-State: AKGB3mL/boIa9JwtJweKDJIVhQxtrB/a8mGr/M+wcg5V4QZj8H/PvCGZ
        QTNE/3Qx8FgMOg8fKPmqq5s=
X-Google-Smtp-Source: ACJfBouIzvLuoq4qS8IfC+u2SfT2cEtIvp7sQI0glCstdiF75MgfqJVX50QDumZLT1wgXlD0jRPwfQ==
X-Received: by 10.99.43.137 with SMTP id r131mr3849519pgr.205.1515197512734;
        Fri, 05 Jan 2018 16:11:52 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l8sm12826604pgr.49.2018.01.05.16.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 16:11:51 -0800 (PST)
Date:   Fri, 5 Jan 2018 16:11:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Subject: Re: Can't squash merge with merge.ff set to false
Message-ID: <20180106001131.GA54183@aiede.mtv.corp.google.com>
References: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert Dailey wrote:

> Not sure if this is intended or a bug, but with the following configuration:
>
> $ git config --global merge.ff false
>
> I am not able to merge my topic branch into master with squash option:
>
> $ git checkout master
> $ git merge --squash topic
> fatal: You cannot combine --squash with --no-ff.

I see two issues here:

 1. The check and error message really only make sense when you passed
    --no-ff directly, not implicitly using config.  The problem you
    are running into was presumably introduced when merge.ff was added
    in v1.7.6-rc0~67^2~1 (2011-05-06).

 2. Whether it comes from an alias or config, --no-ff and --squash are
    not fundamentally incompatible.  --no-ff says not to do something
    and --squash says to do a different thing, so --squash should win.

So I suspect that making --squash override --no-ff would be a
reasonable behavior.

Care to write a patch?

Thanks,
Jonathan
