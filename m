Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E4C1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeAQSQt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:16:49 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:44342 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeAQSQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:16:48 -0500
Received: by mail-it0-f67.google.com with SMTP id b5so10299595itc.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3DrGDYSiiAaLMaHOtdOS3C1RdgNTLfbut9joAHTfzFE=;
        b=EBGhNBny8KUTGGZVbRYT52mwqMYg0MJVDxZEdMAALbFtpFpCbF9ZELoMSJoE3tv3Sp
         D/W3pIlYnjIfSQ/yfVreD2QV2et7bp5Ac4hUIedLWkdHyYHP51EPplYKoQSBA0XGP5zg
         ucKFebMPLlXi1r6Qe9kmptIh+s9R7EegCBEVY/mEm2q4Gaq1eVJdsyKiAjlFFnYi0cLO
         lK3l8HeBWEUJ86SdQWWrjP8kdHoGBpCTAGoNM+AXRUJ5uSUm5PoFKl82QZd51CADmLS/
         fsQRYC6PvRFSUWhKjIHTkeDNCqON48LPMspgPoZc94aiHNUEecl1quZyl4CA+VXm2nc5
         hufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3DrGDYSiiAaLMaHOtdOS3C1RdgNTLfbut9joAHTfzFE=;
        b=EVQ72389Z9ccjbVJu3kHV2Q85J59mjkH9Wy+8bP34BZzOMf9V5Jfo53A26Np7e4BTu
         ZdwmmF66nRtbFSnovenzeh9CE6qHlVfWZhtFb8DObwR+pQ9tsLFsWzU5R60gvLOse7Zf
         o38yTvBIsWNFlCsJUvUBJByXL5PTnF42kpJ012BUzvUOCS8qZlpw8zrP3BZw8kABr6HA
         rhhbFd1jV91Rsg3S4+N/e3cPtEuOYFPj61lnbYkyRVxNdtpvryi7OtSRS0JfZA5zKjZv
         zWgBiUuvnkEv54QbQvCkoOv73B+A2csan2tHRwBeKT2ACdpvHkDp1GBwrTPRE0Bz46Wi
         W6yQ==
X-Gm-Message-State: AKwxytfruHBEa4m8e7VjYocgEBCsTuMNjDbrMkf8DwYNE3GgUSSIolMA
        /d7YOMmoA2TqqgxpYt1TcdY=
X-Google-Smtp-Source: ACJfBou/MnpKxO/9spDEWEBdEoVMDWtn9iG3EpHB2gNtO212GYOMqYBQhRAnwD8PUFjG7mYpHlouuw==
X-Received: by 10.36.250.203 with SMTP id v194mr23568886ith.83.1516213007158;
        Wed, 17 Jan 2018 10:16:47 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r13sm2809662ioa.4.2018.01.17.10.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 10:16:46 -0800 (PST)
Date:   Wed, 17 Jan 2018 10:16:18 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180117181618.GA112319@aiede.svl.corp.google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <20180116214239.GA3622@google.com>
 <CACsJy8A9AheuBK-mKy9d9m5yfSFFZ9N8=wg8FZD_C6mHHTdqXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A9AheuBK-mKy9d9m5yfSFFZ9N8=wg8FZD_C6mHHTdqXg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> On Wed, Jan 17, 2018 at 4:42 AM, Brandon Williams <bmwill@google.com> wrote:

>>                                  IIUC Split index is an index extension
>> that can be enabled to limit the size of the index file that is written
>> when making changes to the index.  It breaks the index into two pieces,
>> index (which contains only changes) and sharedindex.XXXXX (which
>> contains unchanged information) where 'XXXXX' is a value found in the
>> index file.  If we don't do anything fancy then these two files live
>> next to one another in a repository's git directory at $GIT_DIR/index
>> and $GIT_DIR/sharedindex.XXXXX.  This seems to work all well and fine
>> except that this isn't always the case and the read_index_from function
>> takes this into account by enabling a caller to specify a path to where
>> the index file is located.  We can do this by specifying the index file
>> we want to use by setting GIT_INDEX_FILE.
[...]
>> In this case if i were to specify a location of an
>> index file in my home directory '~/index' and be using the split index
>> feature then the corresponding sharedindex file would live in my
>> repository's git directory '~/project/.git/sharedindex.XXXXX'.  So the
>> sharedindex file is always located relative to the project's git
>> directory and not the index file itself, which is kind of confusing.
>> Maybe a better design would be to have the sharedindex file located
>> relative to the index file.
>
> That adds more problems. Now when you move the index file around you
> have to move the shared index file too (think about atomic rename
> which we use in plenty of places, we can't achieve that by moving two
> files). A new dependency to $GIT_DIR is not that confusing to me, the
> index file is useless anyway if you don't have access to
> $GIT_DIR/objects. There was always the option to _not_ split the index
> when $GIT_INDEX_FILE is specified, I think I did consider that but I
> dropped it because we'd lose the performance gain by splitting.

Can you elaborate a little more on this?

At first glance, it seems simpler to say "paths in index extensions
named in the index file are relative to the location of the index
file" and to make moving the index file also require moving the shared
index file, exactly as you say.  So at least from a "principle of
least surprise" perspective I would be tempted to go that way.

It's true that we rely on atomic rename in plenty of places, but only
within a directory.  (Filesystem boundaries, NFS, etc mean that atomic
renames across directories are a lost cause.)

Fortunately index files (including temp index files used by scripts)
tend to only be in $GIT_DIR, for exactly that reason.  So I am
wondering if switching to index-file-relative semantics would be an
invasive move and what the pros and cons of such a move are.

Thanks,
Jonathan
