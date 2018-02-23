Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871431F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeBWVdS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:33:18 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33414 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeBWVdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:33:18 -0500
Received: by mail-pl0-f67.google.com with SMTP id c11-v6so2198253plo.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CxJ43RX3vBMfNRAPGfUZ/5FXt0pwASie80aFbWSSNQ=;
        b=Ht3Mxv7V3RUiyAuaSRyfHWumX2Iv5yHltnxjXdFD7sLbcc5qra4PZEW2ICLb0rP9rm
         o7vqwh5CP55CPeWp/qvOQVrzEHayQE1O0t8RZLrt1lFAJznwa+ETcrNSOWWtKwZIm7M4
         dC8K5BJqskUr44gtoRyvEfAZAFhanyBvkDURjhag2W8JrS0MzRPD+GGnzsdNYRz3kntE
         10viZP685ESU9wSeIGzHTUcb4JxoI1wwjyRjidWb3o+pLw5R9zKzUfuSTaLral88Yc3Z
         qr7ssTgbVhi3KIBBXsl1W5Yl4JkjWQP1lvw9T3c/YfYvUB8gwCGBcldIP7Y/vDwZTXfw
         l4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CxJ43RX3vBMfNRAPGfUZ/5FXt0pwASie80aFbWSSNQ=;
        b=q40TOQWIXWRWvQAW4GDOBwtgjcyjcOz1ELPQsZBWIinkBvXwGTVt3NgcFdjwsaKEZr
         WeiqUgADKWTYGMzS36uqP4AXUidukNufk3zGR2c/vvMu5CdiFecEfwarG6QWJjb4vR6K
         5P9gg9Ia441y5Gl+tZ4jqSs8uHeFehnWljU2Jvi6EnmjWozmYhjUSZvR9tp+2/Q0y3ob
         YC3rGheinDxzAUPpsCkXJfpUxweW5qnJmyFeKbwSHf1qZtPUmTkKZN8XGphyv4xthn1F
         J35QMsGfM6aEaKeUkjIFZJhy7yweIHGQbBXU2qBqGhA2LbJwONn5ZeAuWMfSAKtjkMzx
         wrpg==
X-Gm-Message-State: APf1xPD0Q6L7ZWQllRxtyPLpVaHSucjQoCkogy4+4fRp/Tu69Sn91Vwy
        nX9lVVambWq9gP2J8BtsHA6DzA==
X-Google-Smtp-Source: AH8x224sBCyEakPR9Ya5ri04hZtC7Znvto7IBbR8O76vQ+MwsMavOXenGKb/p2EHNdDtPzLAfBHuHg==
X-Received: by 2002:a17:902:28e3:: with SMTP id f90-v6mr2925043plb.355.1519421597271;
        Fri, 23 Feb 2018 13:33:17 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c62sm6740585pfk.127.2018.02.23.13.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:33:16 -0800 (PST)
Date:   Fri, 23 Feb 2018 13:33:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180223213315.GE234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180221144515.d180a26627a33168b19e0a4f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221144515.d180a26627a33168b19e0a4f@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:49 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> >  .gitignore                              |   1 +
> >  Documentation/technical/protocol-v2.txt | 114 +++++++++++++++
> >  Makefile                                |   2 +
> >  builtin.h                               |   1 +
> >  builtin/serve.c                         |  30 ++++
> >  git.c                                   |   1 +
> >  serve.c                                 | 250 ++++++++++++++++++++++++++++++++
> >  serve.h                                 |  15 ++
> >  t/t5701-git-serve.sh                    |  60 ++++++++
> >  9 files changed, 474 insertions(+)
> >  create mode 100644 Documentation/technical/protocol-v2.txt
> >  create mode 100644 builtin/serve.c
> >  create mode 100644 serve.c
> >  create mode 100644 serve.h
> >  create mode 100755 t/t5701-git-serve.sh
> 
> As someone who is implementing the server side of protocol V2 in JGit, I
> now have a bit more insight into this :-)
> 
> First of all, I used to not have a strong opinion on the existence of a
> new endpoint, but now I think that it's better to *not* have git-serve.
> As it is, as far as I can tell, upload-pack also needs to support (and
> does support, as of the end of this patch set) protocol v2 anyway, so it
> might be better to merely upgrade upload-pack.

Having it allows for easier testing and the easy ability to make it a
true endpoint when we want to.  As of right now, git-serve isn't an
endpoint as you can't issue requests there via http-backend or
git-daemon.

> 
> > +A client then responds to select the command it wants with any particular
> > +capabilities or arguments.  There is then an optional section where the
> > +client can provide any command specific parameters or queries.
> > +
> > +    command-request = command
> > +		      capability-list
> > +		      (command-args)
> 
> If you are stating that this is optional, write "*1command-args". (RFC
> 5234 also supports square brackets, but "*1" is already used in
> pack-protocol.txt and http-protocol.txt.)
> 
> > +		      flush-pkt
> > +    command = PKT-LINE("command=" key LF)
> > +    command-args = delim-pkt
> > +		   *arg
> > +    arg = 1*CHAR
> 
> arg should be wrapped in PKT-LINE, I think, and terminated by an LF.

-- 
Brandon Williams
