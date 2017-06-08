Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778E91FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdFHTTj (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:19:39 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35211 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHTTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:19:38 -0400
Received: by mail-pf0-f176.google.com with SMTP id l89so20337310pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hrq1Ha9+2qmwrb63cVNxof5/e8LO0WdimUlz/JH6bTo=;
        b=EvpV7nIiIBeKss13sd7NMZq6W6uok4FNO9P8N0k9qPy7pd/2S4zExvkx+BqRsYsb9P
         a5vvCVwT35qN2h+RbhBThw2XQGymOCJy7RF1nrQyTQOg6MD85gkbxUyBbtWAvMoGnmnK
         7A0yVDjw3E0QFaraXO099+ZgNBo/JTlQeYGxwIt7o9LiJWTBv2zlfdnJyOK1B7dKh5ys
         rucaKmq3L/BQ0eZLJo8xmbfcxVOXBT4LhLwkRtp0kA9VZeHIo13JODAG6dRAN35vZuT2
         lZLOLTSCdhrciUNaLooMMiTMGwWFywbhPRqXCwlC4ZfGnvZzjlN1E6H/M8khZ7T2NS/q
         2vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hrq1Ha9+2qmwrb63cVNxof5/e8LO0WdimUlz/JH6bTo=;
        b=Ma68gVGBtTguZy1pYee77cEgtzsim1wr55BIJ3Grb5i1exHffFAhGyIe9+pAbZp1Fi
         7OP9DWDq0pWP5jan51bndbsGAz57znYfW7EVLieE9oZ6QBfGrOjIskSj2/IdDSpcjc7h
         +gUIVwdrOvkZ7v2ltZFn3f4J+z04abyawtyGApPnQ45cqxh2ogwwcRpKQQCz6bD310ds
         KpBenyDolkcguVpyc39FMlSS/lPIhCJ7mCsQ91rjHftp6wXqL7FjNdnnxLVLf4FEs92S
         6461zRKf/xlq7g7HlZRt8NGOS+b2fKD7vLuaaKUtC1VqfOuxC7msBG2QAc8XHo8ag0R3
         5hLg==
X-Gm-Message-State: AODbwcA9xw3HMjzfOGKKnT0j++VCC1hpg2tjx/UFNm7JOU8MuZacsWv6
        zbRp7o+bW7xkgpRMiULtrA==
X-Received: by 10.84.198.3 with SMTP id o3mr35821855pld.60.1496949577781;
        Thu, 08 Jun 2017 12:19:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id 69sm10202450pfy.119.2017.06.08.12.19.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 12:19:36 -0700 (PDT)
Date:   Thu, 8 Jun 2017 12:19:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 03/31] config: don't implicitly use gitdir
Message-ID: <20170608191935.GB41637@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-4-bmwill@google.com>
 <alpine.DEB.2.21.1.1706081235130.171564@virtualbox>
 <20170608163739.GM110638@google.com>
 <alpine.DEB.2.21.1.1706082056560.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706082056560.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Thu, 8 Jun 2017, Brandon Williams wrote:
> 
> > On 06/08, Johannes Schindelin wrote:
> > > 
> > > On Wed, 31 May 2017, Brandon Williams wrote:
> > > 
> > > > Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> > > > not set up) added a 'git_dir' field to the config_options struct.  Let's
> > > > use this option field explicitly all the time instead of occasionally
> > > > falling back to calling 'git_pathdup("config")' to get the path to the
> > > > local repository configuration.  This allows 'go_git_config_sequence()'
> > > > to not implicitly rely on global repository state.
> > > 
> > > Oh wow. `git_pathdup()`...
> > > 
> > > Sadly, I lack the time to review the entire patch series, but this here
> > > change definitely looks correct to me.
> > 
> > Thanks for taking a look.  I understand you don't have time to review
> > the series in whole but I should also mention that patch 04/31 may be
> > of interest to you as it deals with setup being slightly more robust and
> > since you've spent a great deal of time in that bit of code any input
> > would be nice.  Last prod I promise ;)
> 
> I had a quick look over the patch and I like the direction.
> 
> I also briefly scanned the discussion and have to admit that I am not
> knee-deep in those exceptional code paths that do strange^Wuncommon
> things, so I feel a bit unqualified to comment about those.

All good, thanks for looking!

-- 
Brandon Williams
