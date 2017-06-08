Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC2B1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 16:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdFHQho (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 12:37:44 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34827 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdFHQhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 12:37:42 -0400
Received: by mail-pf0-f181.google.com with SMTP id l89so18982076pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+iK5r8s8syf2WRwIm9l5Z2ShVzNZSBrcshUOWewMVM4=;
        b=CpueG14RcxEdvFH6pbD95oYrLUD4hW2dWXjTYZ/m93VTO9ddw6ncKoGjgx2qTz1SRk
         edBv5B1bC9BPMk55SMe2N/8plvQItAlywXqx1T7SnX63GoFNG0yZcI8I/LmdZ20bATlZ
         5BjliwNP/iGrscs03MwPeA9H8tPuZOWX8rebm2dFen73OkToNgXqAt75SBbEpeHMSvbW
         lbuRJiHDRWQJ6MbgGFVwm4cEcslkZk+zk5tQBOnW/QV/fOpnQUMojz+4G0SZv3X61CxT
         sceORVlMAaLpE/SJT2yw3d5tPyETrL8H4SPmXg2txEe6wvA/2Pi5fVA77x4OVoLgvToQ
         yPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iK5r8s8syf2WRwIm9l5Z2ShVzNZSBrcshUOWewMVM4=;
        b=hOQEiufw/BOlKZZXPfXqXFjzMvHQ9OqF3vbs+FAlDrKTojoJZ0XrSjtFJoWwg4lmGb
         h6eypV6srUPMq7lDZ1n0XM3U5lh37yhmiXkkTbPYLA3Wv5PsIi4Q+odT7xNY34OVfqjp
         ofZPffEkZl8NZY4HmV+QuSt/Q1kPNtha+97OuOCgqOI/9zoBxi0zkFRbhuqmf/cBMzls
         KiESsuTPSnG5sA8nQXF5ybN8zxKNTzlCeXee9QTow+rIEjFq8AalFl8x6l2zyvwa+Xju
         jKo7W7bl6Dbf6+NxAieRANU06zuSv7qM7eTq8mKcZENzdtdjKxooprGkDzddB0L19BJp
         WIqQ==
X-Gm-Message-State: AODbwcBOPmkVbD6Wt4pPJMTS7mqWEee8URj/SD+TET7preH14i3GzglF
        DYSwCFnYz37NmAZm
X-Received: by 10.84.245.2 with SMTP id i2mr31606700pll.284.1496939862136;
        Thu, 08 Jun 2017 09:37:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id g86sm10328456pfk.101.2017.06.08.09.37.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 09:37:40 -0700 (PDT)
Date:   Thu, 8 Jun 2017 09:37:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 03/31] config: don't implicitly use gitdir
Message-ID: <20170608163739.GM110638@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-4-bmwill@google.com>
 <alpine.DEB.2.21.1.1706081235130.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706081235130.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 31 May 2017, Brandon Williams wrote:
> 
> > Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> > not set up) added a 'git_dir' field to the config_options struct.  Let's
> > use this option field explicitly all the time instead of occasionally
> > falling back to calling 'git_pathdup("config")' to get the path to the
> > local repository configuration.  This allows 'go_git_config_sequence()'
> > to not implicitly rely on global repository state.
> 
> Oh wow. `git_pathdup()`...
> 
> Sadly, I lack the time to review the entire patch series, but this here
> change definitely looks correct to me.

Thanks for taking a look.  I understand you don't have time to review
the series in whole but I should also mention that patch 04/31 may be
of interest to you as it deals with setup being slightly more robust and
since you've spent a great deal of time in that bit of code any input
would be nice.  Last prod I promise ;)

-- 
Brandon Williams
