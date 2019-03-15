Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9C2202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCOUin (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 16:38:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32830 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCOUin (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 16:38:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so7138383pfd.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pw+bJ1XPUGZzB8UAXbXjcgtvxh1MTDL3sEvi7DiedLk=;
        b=Ybl0MksGOe/u/qcYVXn/wY9okUg2R1R/4FWxTzWDhR+ZPY+oL+vYgss8peSFlpzbCx
         M92Ibyw03vmNy0F4yKI0oyKK389h46+N/teSkn4kRjIMfSU60h4fCT5g1YvdxCFcOpnI
         zjKzrM6js8qAAiUosEZDMq3Izbon1caMgi8Ab29SZtVBlYmfDqtEPTBk7r18Ibxjnuv5
         o/aWC/g6iulZDymZYESD6SA99dTFd+xEoUFNicbFVxJKtFOOZ+4xpqpt3KHsTIq5sxMF
         gu67ZhKQM49IunlDF9tBFldpCHG6g+5cuTTcfAXkGV/VOwC5LWVzv6rAOm7xkPmgUJ5H
         sueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pw+bJ1XPUGZzB8UAXbXjcgtvxh1MTDL3sEvi7DiedLk=;
        b=TQOEtPFAn5G7aSO6tW001pC5Lvug/JCC2mICaweIfxmSF9QSk8tp9O/LNcBQQAMub2
         rr8KSjA5NRFU1w0GiojQ1UgzNR/pSgJrnbXBagL29DERRRGVcnErX9vmpX7gFa+1xjB7
         1NppR3VNZkXYoKXiJzL12JNCXr0pNrxx8cYNUOyK5LMDO/GoSj8nEcQeynVB4imd+Gl9
         NVUmMzvBn2V4mAdSiSRyBnMEHhDpTQ/omRdVk0Sh+rXIDxBFO3bz5BsiRsHJmSDLtNyR
         smAo9TesV9vIIiIHBR+qpofac49tBBTqEyeWscu96kwSkM8UhnCCViVKlS49FUVJhEe6
         9oMA==
X-Gm-Message-State: APjAAAWaPsmFcrpbMBVpMkV6qFNet/NSBJAaSst8F0s/p/cUTdh2Fm2P
        Zrm6igfDd5I6eQD1q9Ckmgz6EAWZ7JT2Lg==
X-Google-Smtp-Source: APXvYqz5NRxjBFIkr1SgIqGmzoW5oLwC4xN1gbMf1O07rXtLFaku/8bF+mxKHIbLo2kqTWwIJQoICQ==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr5401410pgr.48.1552682321822;
        Fri, 15 Mar 2019 13:38:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id z67sm8940171pfi.152.2019.03.15.13.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:38:41 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:38:36 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] Randomize / timestamp trace2 targets
Message-ID: <20190315203836.GD47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
References: <cover.1552519463.git.steadmon@google.com>
 <366839dd-7470-bda0-d84e-4169842c7852@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366839dd-7470-bda0-d84e-4169842c7852@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.15 15:18, Jeff Hostetler wrote:
> 
> 
> On 3/13/2019 7:33 PM, Josh Steadmon wrote:
> > Persistently enabling trace2 output is difficult because it requires
> > specifying a full filename. This series teaches tr2_dst_get_trace_fd()
> > to randomize filenames when a directory or filename prefix are given as
> > targets in the GIT_TR2_* envvars. It also allows expansion of a
> > timestamp template string into the current UTC timestamp.
> 
> 
> Does the use of envvar cause issues?  Or is it just the fixed absolute
> pathname?  When I started this, I was trying to keep the GIT_TRACE
> model.
> 
> As was briefly discussed in [1] I was thinking of adding a way to
> have a personal and/or system setting, but not a git config variable,
> that would let you setup tracing without relying on environment
> variables.
> 
> It's something that I've been wanting to do, it just got buried by
> $DAYJOB stuff.  I can try to bump it up if there's interest.
> 
> Thanks
> Jeff
> 
> [1] https://public-inbox.org/git/pull.108.v4.git.gitgitgadget@gmail.com/T/#mcce3b088aabc42e9867f8a9e09dd7dea5f9a773a

Yeah in our case it's the fixed filename that's the issue. It's more
convenient for us to have lots of small files that are "finished"
relatively quickly, rather than one that is constantly appended to.
