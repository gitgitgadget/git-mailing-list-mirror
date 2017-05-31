Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997A71FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdEaW4Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:56:16 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33068 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdEaW4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:56:15 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so19931278pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5n+H4cksD8wqk7pzJ6pwyZrl1nTkU8+3a5pOPLZZbKw=;
        b=Esh6V0I8pVY1dRqRQvdrY8nt8GJ/tLk3+VjdpOxEnzWKakt1fsPCN+ChW1AGM8hREe
         Fd3SHYtRZb0w7cHQLPMKjJ43o3J6lpWTf+SOJeqG2pbb0jeeIwfnQVDmvl3j0Bl3PxyW
         9A8Nq5J4cU4k8n4HlJTWD1ULx4r+oZuQdy/04Ayhtc52J4B8MWq0LZu2H09ZCBVtc26m
         BkthlgQpeCm2JAyGC7KcYKmQz5KSZi1NYO6T1NoY2kndK2hu+ca7wTo5iQ/+vEBDeStF
         Vl88/VXyLhe0L7dLa2E40jBEQNoZGzFw2cCXL3cRTjXEbHTD+YicPEePR4sjxIagv8OU
         LeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5n+H4cksD8wqk7pzJ6pwyZrl1nTkU8+3a5pOPLZZbKw=;
        b=HTdKsfqnHZvuqemXKu7FiBZNBIRLmIk6Xa+Dbl1rDU+LXt49vzY7S5mVYKOc7+yTt3
         9i5VsZDXyU+kFcMCkGA1BVn+hS+R6KJQHfbABeJF/fPloTRefBZnm5N1TEMXKeIwQzNU
         MgDC8GjjqHyYqT3hVFoqm3DxshHGb9y1qV0SkWRqZwcHeyBYHM+1SSqTKEiEVXMBWtZ9
         JMAXKhxzRz9ALWuYGK67XHOoLV8eN8PGVUUYrIgDE2DlYuT83W51VwNnh+5b31S5sV5D
         rHrsN5LIibkkkPqBqu0aiaxH9yjlXCJggWXnprv7/LIjNo31+zmnsiUypmN4coP6hCbm
         zkPw==
X-Gm-Message-State: AODbwcAGjwJikLQoFc4upBTiACI5KZarl3lGDmx2Jl4KgiXLVg582s3q
        w0kRlFD8VRZHLC2Wuyr5rFplqGqQj06P
X-Received: by 10.84.231.206 with SMTP id g14mr91273433pln.12.1496271374935;
 Wed, 31 May 2017 15:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 15:56:14 -0700 (PDT)
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 15:56:14 -0700
Message-ID: <CAGZ79kYMs6XS8kcoWVZDes7W_J1B86dYm-8rhkJPzUmoqjyTng@mail.gmail.com>
Subject: Re: [PATCH 00/31] repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> Given the vast interest expressed when I sent out my RFC series I decided it
> would be worth it to invest more time to making a repository object a reality.
>
> This series is an extension of the last series I sent out (in that ls-files is
> converted to working on submodules in-process using repository objects instead
> of spawning a child process to do the work).  The big difference from the RFC
> series is that I went through and did the work to migrate key repository state
> from global variables in 'environment.c' to being stored in a repository object
> itself.  I migrated the bits of state that seemed reasonable for this series,
> there is still a lot of global state which could be migrated in the future.
>
> I do think that we need to be slightly cautious about moving global state into
> the repository object though, I don't want 'struct repo' to simply become a
> kitchen sink where everything gets dumped.  But this is just a warning for the
> future.

Or in other words:
You want to have another struct e.g. 'the_command_line_arguments',
which would carry the verbosity/color options for example as they are
not related to a repo object, but to the current command being run?

> Since this is a v1 I'm fairly certain that it still has a lot of rough edges
> (like I think I need to write better commit messages, and we should probably
> have more comments documenting object fields/contract) but I want to get the
> review process started sooner rather than later since I'm sure people will have
> opinions (e.g. should it be called 'struct repo' or 'struct repository'?!).

IMHO this is the most obvious, but bikesheddable part of the series. ;)
Keep it short as everyone knows what a 'repo' is.
