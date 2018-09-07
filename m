Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECD61F404
	for <e@80x24.org>; Fri,  7 Sep 2018 20:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeIHA5P (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 20:57:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44797 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeIHA5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 20:57:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so7489736pgp.11
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VY0nGoKDfnb9Yf8FKW8wUTMZR8R6xZVKus1dARO8ZKU=;
        b=SBVqnw5oY1j0hrkjo9CkjgtRIZTKpj9n7Em0sI1b9FUgCRWfXMB9jbkktyzU/ObD4v
         WDLaq7V1l2vO8cbjmQN8pTVuUseSzUe/3xfRsrQVEf922Aa9DEyWouuAeelTkgWSZcof
         hJF3mkXWfzUA9zzp+k/CCZ/a0vUisgCAv9JH3PtXfjABs71mNIm1K96bqBvZ/u100Kzp
         NDh1YTHwbUo2IvFH73PhVyLlOg8MniLw7uSuqfPBDPxixFGAZzb1osQ0BxzPh1nbemTA
         6nk45F4vWue+8oy3oPPoc1lJSD+4FSalf7mzXPW4gfrHbPjiVGTTsZgLwBq0luyp6aqk
         4Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VY0nGoKDfnb9Yf8FKW8wUTMZR8R6xZVKus1dARO8ZKU=;
        b=EWiWzEhvJSuPZ0lsb3Xmfqyc1AmgzemZVKVgvMg7xSlsTy5MC7+39bUSk87o5mfqU9
         5uacrYHhwz8QpUFcdUrZmfR2987eOgbcHKFNW8LHCZEvtYlMksrwtGa2xO7OgFP0wagU
         gkNJKGJr1e6BSYmfeEWrg+Tp31+FxY/lnqT5KO6lENV/t7xtxAZtxPMGMctXUe2eE1dw
         42NP9+4qk3WI6MkekIwnDOTlS0TieO3gr8hKxZpbJRBL+P3+wMDsgIONhXhFrNF27UKU
         cRusLjKdB0Ceb5jgls2I43Sioo1cFn9zuwcH7Sx1Fw81guKQ1peOYonbbjAy6kSV7yYa
         QSCA==
X-Gm-Message-State: APzg51CN1VGdMi+cJTD9WLg81ZWuHeWECwknYMGaPrae+iZnDdyJFMCT
        GGGZvzCtTpKiEsLMsFPANRQ=
X-Google-Smtp-Source: ANB0VdY11Z82DE9Q9sbIIH0bpR2luYl/zhzQ+z88O9sDl0fFGrz7oq+0anDoQG0K7tJnjgcLkjy2Kw==
X-Received: by 2002:a63:f002:: with SMTP id k2-v6mr10016703pgh.8.1536351282315;
        Fri, 07 Sep 2018 13:14:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g5-v6sm13543589pfc.77.2018.09.07.13.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 13:14:41 -0700 (PDT)
Date:   Fri, 7 Sep 2018 13:14:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Allan Sandfeld Jensen <allan.jensen@qt.io>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
Message-ID: <20180907201440.GB103699@aiede.svl.corp.google.com>
References: <2659750.rG6xLiZASK@twilight>
 <20180907150327.GB26719@sigill.intra.peff.net>
 <1591523.hyI6sBWrkQ@twilight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591523.hyI6sBWrkQ@twilight>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Allan Sandfeld Jensen wrote:

> I discovered it by using Debian testing, and it is shipping the 2.17rcs for
> some reason.

I believe you mean Debian unstable.  Debian testing has 2.18.0.

>              The example is just an old checkout of qt5.git with submodules, 
> it is rather large.

Do you have a reproduction recipe I can use (starting with a "git clone"
command I would run using an old version of Git, etc)?

> I could try bisecting, but I am not sure I have the time anytime soon, I just 
> wanted to report it to you first incase you knew of a change that suddenly 
> assumed the new structure.

This is definitely not an intentional change, so more details would be
very welcome.

Thanks,
Jonathan
