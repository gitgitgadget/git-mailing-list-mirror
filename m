Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D861FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 14:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFMOrU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 10:47:20 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33379 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdFMOrU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 10:47:20 -0400
Received: by mail-pg0-f45.google.com with SMTP id f185so61816218pgc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FmuyrmWsOFu03HS1HzPFAbkwYR5wjMAyr8RTKjVp0qs=;
        b=IBgV2riAKStmNdhL4jVc68Ap0pdf2N1rpMZwHwq3EyXJHv0CUWMzMczxewFicKhgNN
         tw737SP4P+EpBYX8ooGVJA0lpMrf51NVYDMLU09wlMJCNzRVJ1YO9qtQmtMqSDFRrRTm
         CRI4Ktf62Da1iO8vtmCIv9cfZK6SinjdVXcB2qWVrR9n8BNu2BRTxl2Dev59/fsblBw7
         c+Qw/V7fo0uNz+EmXsKzVjQwDcon6cx6ChTSzo0qLpFcccNcNsVxMi0f9FyLxiHdh/O5
         4YoZ3CKILJhueKV6ATzDUoHU7GfXlsDSWDJqqyEy9meANGucHZOFi15frrosf0X2Zy6R
         nVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FmuyrmWsOFu03HS1HzPFAbkwYR5wjMAyr8RTKjVp0qs=;
        b=nXPaSItNBs5OaULXebFitbkGJN6aYMYFc1iKwIwBmd7XeTOI88RucXBJ3RVxUZy4kD
         7hlyl57mgHlwIv0CK+VVYUFyZ44Rfak8z+Tx9O3dq29kNg1i2zLlFd43KVwdQhfXF3yF
         cAtHWjjtRkAz7yl+bC6mAbzoy/2q0dgs3NxJc7+BRHvT5CgVZH2I1igYEIbYrXSVGHql
         jZOYnQpk6ACUoDgEuMBhHdQ6kl/dM/m0d+k6iE1lhCdhLSl8vGsdbynj8KWS7NXlNorg
         TIvsS9vI1BQ+iAGOMUv/IdH7WDHQ/IbBBLNGW3StT48oFrAFUMoRneyBDZdiitIwmXv8
         ZRWQ==
X-Gm-Message-State: AKS2vOxWqkPcFUH9P0Rbhh1kSpUwQgbKqfR1G9qdnPiFw2npAF9xhb1/
        F4RNuE5fttnBtLw9
X-Received: by 10.98.130.3 with SMTP id w3mr199980pfd.128.1497365239168;
        Tue, 13 Jun 2017 07:47:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd0d:448e:29f9:5e86])
        by smtp.gmail.com with ESMTPSA id x5sm25275676pfi.103.2017.06.13.07.47.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 07:47:18 -0700 (PDT)
Date:   Tue, 13 Jun 2017 07:47:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613144717.GL154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
 <20170613055243.GI154599@google.com>
 <20170613062941.r22r64y5ymdpfhbx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613062941.r22r64y5ymdpfhbx@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Jeff King wrote:
> On Mon, Jun 12, 2017 at 10:52:43PM -0700, Brandon Williams wrote:
> 
> > > >> curious: Why get_git_common_dir() instead of get_git_dir()?
> > > >
> > > > Needs to be commondir since the config is stored in the common git
> > > > directory and not a per worktree git directory.
> > > 
> > > *puzzled* Why wasn't this needed before, then?  The rest of the patch
> > > should result in no functional change, but this part seems different.
> > 
> > there is no functional change, this is what always happened.
> > git_path("config") will replace gitdir with commondir under the hood.
> 
> Of the two callsites you removed, one is git_pathdup(), and the other
> is get_git_dir(). So they weren't matched, though I suspect the one in
> include_by_gitdir probably ought to have been commondir?

Good point, I hope my reply on the other part of the thread answers
this.

-- 
Brandon Williams
