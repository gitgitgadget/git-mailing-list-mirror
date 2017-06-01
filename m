Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C4020D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdFASLE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:11:04 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36051 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFASLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:11:03 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so33918206pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KmXSpwPa9SAU/Wi854hq+jIYaWc+axezlLJnMQFLeeQ=;
        b=cZA1Ui3HMwNd0mLA288p2zqu6vI4boF23pzXgQUo52QR6WDT61TUy0cjPCmE0gtFzs
         6mi863G0vx/TJMIvfokOW3m9BCjKUeq0BSHP55Cj9xZq1O4pPIMDCsbiTp8hLQoqXQq0
         0BHIfkuLHhuoUc819I3l+butYS34xSdt9VXgN/7OsyTBXbDo4IHa1BM0rZuSaJx5E6nW
         THz4KluHWY9+S+y03tYrvf/MhAnCzkyirYDXENtpXjxD9o6341uDj45X5c9ZhZWmfQrc
         Zfkjkbh5w4EZHy77YxlX+OuOaPJ/vdGBWD/jWPAGWjOavLIGrfoIfjq8iD+AnyyztTwK
         g9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KmXSpwPa9SAU/Wi854hq+jIYaWc+axezlLJnMQFLeeQ=;
        b=i5NECH9tUHe3EdjxVkwJwy59jOK+u6r0+MOgGcV7pVo/NcqPC0e23FzAcnHciG5LLG
         Drr+QtkCPUzXeK2hR8zNzern9yWN2tj5xHln+6+JgrHIrFBLGgd23yyoLIavEfS4NHMt
         paBpWAKx3/fsMwLM9IntlJmzDrUIDu65keDSVm97Vfe0szxE4kr8AEv/yyuzw6dXW9FS
         RdWTvZ2D3dCTzc/rCYHvANxVF1JKW3tkfx9xT0DjCyckR7dYN7PJa3J+Pkoz39g4LT6S
         0dPwpAkgQa63KJBH7/LHavURq4VomTHdisFxk0GyGqjI4itYUaFVWaamOdx+PVlvtrd5
         Pi9g==
X-Gm-Message-State: AODbwcDaCB+KKYNgK+WTcUwQ4LQejJ8e6WDqd12XctsqFavJjNr/zSfr
        fl961I9sHEZMO1a5
X-Received: by 10.84.139.3 with SMTP id 3mr96421175plq.79.1496340662438;
        Thu, 01 Jun 2017 11:11:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:21ee:55f5:50a0:9409])
        by smtp.gmail.com with ESMTPSA id e76sm35439891pfb.92.2017.06.01.11.11.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 11:11:01 -0700 (PDT)
Date:   Thu, 1 Jun 2017 11:10:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 00/31] repository object
Message-ID: <20170601181059.GB127481@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, Brandon Williams wrote:
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
> 
> Since this is a v1 I'm fairly certain that it still has a lot of rough edges
> (like I think I need to write better commit messages, and we should probably
> have more comments documenting object fields/contract) but I want to get the
> review process started sooner rather than later since I'm sure people will have
> opinions (e.g. should it be called 'struct repo' or 'struct repository'?!).
> 
> So here it is!  Thank you so much for taking the time review this, any and all
> comments would be appreciated.
> 
> - Brandon
> 
> Patches [01-14] -> Introducing the Repository object and migrating some state
> 		   to be stored in 'the_repository'.
> 
> Patches [15-31] -> Converting ls-files to use 'struct repo' in order to recurse
> 		   submodules in-process.

For those who don't like reviewing patches in email form, you can find
this series at:
https://github.com/bmwill/git/tree/repository-object 

-- 
Brandon Williams
