Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE2B1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 21:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeAPVmn (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 16:42:43 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32873 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAPVmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 16:42:42 -0500
Received: by mail-pg0-f47.google.com with SMTP id i196so10188458pgd.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQaawwQCq5yvfauSPlueYP41MZ9RAhlWCojsZWmpEL4=;
        b=g+Jb2XILuxohPNLWESUpwtqCH3/pDDsukyzudUHx07gi2hhqgBgYER2dOmkK1sgyis
         Prd6WmOb3ZZkNwZH6W9vWWMzzi0JDwf8yaf4eqt/TY5kypjVG7boGteBXg+Ct+zjGELT
         a25ChieusXDv8Jo6qvIL/W2YSAj5FMSXUTjSvW6RdZu5sKz/MfjmSx11R0hRBoaCbswz
         ljkItsOmqnnO+Qw1Md4dDmcCghL4Skt48vnooBivCmKMDJ2GLowBMd53ylAaQHVMdR9g
         iD1W7OH2fc6Kre9nxMLMvEhmFhVjiv1v8C7XQ7Svkxq+eHtMOQZb3Bd7dg605y6UwVKj
         /rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQaawwQCq5yvfauSPlueYP41MZ9RAhlWCojsZWmpEL4=;
        b=iBqCONQ+VqO53vTlqG+FPkzUmJib8d+fQotUvHigjsZLoDgkhQ0K1TxfWHGDdr8kWu
         N/5oFZ/ZMxZBeP/5kwriu+axJyPfgBgYE9Wt7m6gxjauoF/M+nosqIQIoZaB9hwth0/I
         xTnzQZsgZrER5YMli5sQvMbFwNy5x98+WGJnywPZjm+0qFt57MUcHoqCdVcebw2BzZwi
         xO6rdOKKWw1kYyNaHB5Sk7mkMfPapeuXEpoudHUS2e+EE+PPPUaKia8VHx0bx3LTf10N
         k747Ds5QsHqJSPZkeFUxaM+GPpEk1uLUaPGJXAh2Oeii5UQEmQFPUWC4bkspgX6ToV/l
         mGJw==
X-Gm-Message-State: AKwxytdNq6vaNNb26bDvYVov747UxvtbUgtfEv2Q+BhC9L6bZBi6r8Md
        ZfNjoqJOSmFnUi6BqMdJ9sSBuayMauM=
X-Google-Smtp-Source: ACJfBovW5tMCBIjjE5GQrI11tt/bOuxrp0YS/XpO1GnXy21PpdXXqNCgw7omq5bvJwnYrsbLzh0uTQ==
X-Received: by 10.101.77.146 with SMTP id p18mr6069889pgq.75.1516138961676;
        Tue, 16 Jan 2018 13:42:41 -0800 (PST)
Received: from google.com ([2620:0:100e:3010:80fa:b782:3b81:6dc7])
        by smtp.gmail.com with ESMTPSA id c83sm5541209pfk.8.2018.01.16.13.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 13:42:40 -0800 (PST)
Date:   Tue, 16 Jan 2018 13:42:39 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180116214239.GA3622@google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180107223015.17720-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07, Thomas Gummerer wrote:
> read_index_from() takes a path argument for the location of the index
> file.  For reading the shared index in split index mode however it just
> ignores that path argument, and reads it from the gitdir of the current
> repository.
> 
> This works as long as an index in the_repository is read.  Once that
> changes, such as when we read the index of a submodule, or of a
> different working tree than the current one, the gitdir of
> the_repository will no longer contain the appropriate shared index,
> and git will fail to read it.
> 
> For example t3007-ls-files-recurse-submodules.sh was broken with
> GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
> object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
> broken in a similar manner, probably by introducing struct repository
> there, although I didn't track down the exact commit for that.
> 
> be489d02d2 ("revision.c: --indexed-objects add objects from all
> worktrees", 2017-08-23) breaks with split index mode in a similar
> manner, not erroring out when it can't read the index, but instead
> carrying on with pruning, without taking the index of the worktree into
> account.
> 
> Fix this by passing an additional gitdir parameter to read_index_from,
> to indicate where it should look for and read the shared index from.
> 
> read_cache_from() defaults to using the gitdir of the_repository.  As it
> is mostly a convenience macro, having to pass get_git_dir() for every
> call seems overkill, and if necessary users can have more control by
> using read_index_from().

I'm not saying we need to change this again but I got to thinking about
what the root cause for this bug is and I think it's a design flaw in
how split index is implemented.  IIUC Split index is an index extension
that can be enabled to limit the size of the index file that is written
when making changes to the index.  It breaks the index into two pieces,
index (which contains only changes) and sharedindex.XXXXX (which
contains unchanged information) where 'XXXXX' is a value found in the
index file.  If we don't do anything fancy then these two files live
next to one another in a repository's git directory at $GIT_DIR/index
and $GIT_DIR/sharedindex.XXXXX.  This seems to work all well and fine
except that this isn't always the case and the read_index_from function
takes this into account by enabling a caller to specify a path to where
the index file is located.  We can do this by specifying the index file
we want to use by setting GIT_INDEX_FILE.

Being able to specify an index file via the environment is a feature
that has existed for a very long time (one that I personally think makes
things difficult because of things like additions like the sharedindex)
and I don't think was taken into account when introducing the split
index extension.  In this case if i were to specify a location of an
index file in my home directory '~/index' and be using the split index
feature then the corresponding sharedindex file would live in my
repository's git directory '~/project/.git/sharedindex.XXXXX'.  So the
sharedindex file is always located relative to the project's git
directory and not the index file itself, which is kind of confusing.
Maybe a better design would be to have the sharedindex file located
relative to the index file.

Anyway, some food for thought.

-- 
Brandon Williams
