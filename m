Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7F7202BB
	for <e@80x24.org>; Fri,  8 Mar 2019 00:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCHAI0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 19:08:26 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:37574 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCHAI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 19:08:26 -0500
Received: by mail-pf1-f179.google.com with SMTP id s22so12718259pfh.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 16:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grande.coffee; s=omgwhathaveyoudone;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xixvbhClKOvhbbFEefkTFqOncLrK4e6eZqH1gea0OoI=;
        b=J+7xHA4atzp7JesQ2/gTN74OkPQKDl06Ibr/sIjwKa96puWIhMKAmQxbshfZYyW+VV
         eLRV9hjHAigDwRWoiOzgSUc/Kqxi1/frLRdnFVFx0I472VyHcje+Qt75cG9jRVvi7EN2
         l4EjTkNHwO/KcIVeD+bcTtkg2C5qicTtvQAil5p0WtApcNlqVJGnkiLuHS7m7PuNWHYk
         GVG1jgt/oWfeaKWwp6noamkiZaEY/FkgftyW/JQpvgNXunG878m4HPNYPKfqIZseSW/M
         TyhOYiUn3KY4xl9mwUT4jsJzpPCEPWVp3ybiXsGbaE7ftmXcfjSizwYNEqU6Ngrz3ru8
         xExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xixvbhClKOvhbbFEefkTFqOncLrK4e6eZqH1gea0OoI=;
        b=cUJvYCfcJfQ3AhA60R3yFYeGFyC2HwyovvhS2NbHlosW5/rIXbFY3rayZVg7DDHCvD
         NAihFWt87RkJXYFQlgwmZqO/bln1IWwpSgo9HAoHVlplYEaiTXVkJmjOaicPQQSUepra
         SbOOO2zU5UVLVb92maFh+XPnmBCgWGDaphPWv+cEskfthmSSLft43RDS2Ku3UTrQQ/sH
         /Vrh/82m+FtnQwzTE+gNT+JzEbW3NSTyYkMf1wmkyHB1xWeC+c/iAjit2Z1vaFOk+cmQ
         TqSmeL8Vvs28yowXcEZFPMtI4BX4FTYCiNmSiFENdTMfDsoXBUvOaOKZ5+JmWcOEw4QH
         43nw==
X-Gm-Message-State: APjAAAU0MdDYpDjM4cB5g4k/viSAd+MgBrU2392TJePnTJRTpR7s+USc
        33g1HChjtY7eRZuddfoW9KKmtw==
X-Google-Smtp-Source: APXvYqwG+mpnp06g6nY+O/s3DwUVdDUf2snP9Jl8EzljYVu6jprbmHWeH2xCeBSAH2UZW5WiSQrhMg==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16mr16167120pls.49.1552003705284;
        Thu, 07 Mar 2019 16:08:25 -0800 (PST)
Received: from chabuduo ([198.41.129.1])
        by smtp.gmail.com with ESMTPSA id l7sm17601048pfj.162.2019.03.07.16.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:08:24 -0800 (PST)
Date:   Fri, 8 Mar 2019 00:08:10 +0000
From:   Alexander Huynh <alex@grande.coffee>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] fetching all remote branches results in failed multiple
 updates
Message-ID: <20190308000810.GA8044@chabuduo>
References: <20190307214447.GA4909@chabuduo>
 <20190307234015.GD28939@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307234015.GD28939@szeder.dev>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 12:40:15AM +0100, SZEDER Gábor wrote:
> On Thu, Mar 07, 2019 at 09:44:47PM +0000, Alexander Huynh wrote:
> >     [git-test@chabuduo ~]$ cat > ~/.gitconfig
> >     [remote "origin"]
> >     	fetch = +refs/heads/*:refs/remotes/origin/*
>
> Why do you do this?
>
> First, this is the default refspec configuration that clone will fetch
> and set up in the clone's config file anyway.  You don't have to set
> it.

My mistake. I was under the assumption that this configuration variable was
needed for git to fetch all remote refs, and that this behaviour wasn't
default.

> Anyway, this is a side-effect of 515be83382 (clone: respect additional
> configured fetch refspecs during initial fetch, 2018-11-14).  Since
> then the same refspec comes up twice in remote->fetch, once from the
> configuration and once the explicitly added default refspec.  And
> since 'git clone' doesn't run a fully-fledged 'git fetch' and has its
> own simple refs-to-refspec matching logic, it ends up trying to write
> each ref twice, once for each of the two refspecs, in a single ref
> transaction.

Thanks for the clarification! One question: should we update the documentation
at https://git-scm.com/docs/git-fetch#CRTB to not list this as an example to
follow?

Thanks again,
Alex
