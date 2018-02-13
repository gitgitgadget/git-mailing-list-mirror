Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA751F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965711AbeBMTdn (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:33:43 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:47077 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMTdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:33:41 -0500
Received: by mail-pl0-f48.google.com with SMTP id x2so3131923plr.13
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6jaGP4nCP9T37Ob5E8Y+zjaja5IEdMkT1r3gdkjJGE=;
        b=KcNVG8gVq2Pe0Mi7welG+EizDd6OhDc6s1KzQ1LEI2UirXjMkS7acvWb3MnJlHwsfv
         4qBCY/FSOilfQg68HHc+iBncSYjwqeH/jIpa2I2I9dNT9Axgv4m4L83R1lhCDvM3635+
         6OQcEyQDDpAVsM8YkTExfi9SHZItdbZkFS2xwTPSAA54o+ahEI+86e/dBqchK7zN1DEt
         DH7sTXCvmzrnmrQDtD3cHpe60blIIrOFqB1Mv9wabpg1bUf4X21bepukLKfSdI4cKOmk
         KTZh4zu+ES7VdgWA1nWrzKmqGJDmznfkZqJtBBNNeQLFTg9Ab0KFx0lPo0wrledjvYPl
         nZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6jaGP4nCP9T37Ob5E8Y+zjaja5IEdMkT1r3gdkjJGE=;
        b=W+fhw4XxunnT+P8aXy6KjWd2lYLEytPQ67L4C3Xt3fckAdAsYjY6+JJAxgfzub5/P3
         7gbDy/mb6vlWt9hw7FYsoFtuQM84MsWvJ3/RE5klNB58sLoc3Q8saoOfLlKL54KEdzyk
         Hx7/+OlVXTUl5NjBVmvkWPd1WKK7Nq0zKk/wL6hZCAyacZ0R3N4SFzkbzjPDrOaqUEDs
         0ipdzwyjyGQzseq9S3WwDv+E8XKaBxrB2ueLj/u/vKqHO2XUpuoqZs9pnx4UnBPceD4N
         vadMIlB15StRj9GtrqzjIha/cYQRVpUW3Y1s+OZLLqc5Z2Ga9xtuJvCW88YK6LjRqj/C
         AlsQ==
X-Gm-Message-State: APf1xPA9sRIGpmurp4yWYsHCQwrglEM3i/T3Wy1x/Va0fKyCV6tk00Fv
        qoPbWSxYE6QtercIEHLitXaF9L/TMwU=
X-Google-Smtp-Source: AH8x227n1B1uh2IYYgw/7r2hSfse9Rx/P9A+dM+9jXNW1Tne3Cgm1dzljYwI2FDOvl0zFptD2QtADg==
X-Received: by 2002:a17:902:f:: with SMTP id 15-v6mr2045988pla.419.1518550419951;
        Tue, 13 Feb 2018 11:33:39 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v1sm29948684pfg.33.2018.02.13.11.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 11:33:39 -0800 (PST)
Date:   Tue, 13 Feb 2018 11:33:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        sunshine@sunshineco.com, jonathantanmy@google.com
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
Message-ID: <20180213193337.GB108526@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12, Stefan Beller wrote:
> This is a real take on the first part of the recent RFC[1].
> 
> Jonathan Tan suggested[2] that "sha1_loose_object_info to handle arbitrary repositories"
> might be a good breaking point for a first part at that RFC at patch 38.
> This series is smaller and contains only 26 patches as the patches in the big
> RFC were slightly out of order.
> 
> I developed this series partly by writing patches, but mostly by cherrypicking
> from that RFC on top of current master. I noticed no external conflicts apart
> from one addition to the repositories _INIT macro, which was easy to resolve.
> 
> Comments in the early range of that RFC were on 003 where Junio pointed out
> that the coccinelle patch ought to be not in contrib/coccinelle, so I put it
> in a sub directory there, as 'make coccicheck' doesn't traverse subdirs.
> 
> brian had a questoin on patch 25 in the RFC, but that seemed to resolve itself
> without any suggestion to include into this series[3].
> 
> Duy suggested that we shall not use the repository blindly, but should carefully
> examine whether to pass on an object store or the refstore or such[4], which 
> I agree with if it makes sense. This series unfortunately has an issue with that
> as I would not want to pass down the `ignore_env` flag separately from the object
> store, so I made all functions that only take the object store to have the raw
> object store as the first parameter, and others using the full repository.
> 
> Eric Sunshine brought up memory leaks with the RFC, and I would think to
> have plugged all holes.

I've looked through the patches and I think they look good.  At the end
of the series all the #define tricks have been eliminated so we don't
have to worry about them possibly being left and forgotten :)


Thanks for getting the ball rolling on this.

> 
> [1] https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
> [2] https://public-inbox.org/git/20180207143300.ce1c39ca07f6a0d64fe0e7ca@google.com/
> [3] https://public-inbox.org/git/20180206011940.GD7904@genre.crustytoothpaste.net/
> [4] https://public-inbox.org/git/CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com/
> 
> Thanks,
> Stefan
> 
> Jonathan Nieder (8):
>   pack: move prepare_packed_git_run_once to object store
>   pack: move approximate object count to object store
>   sha1_file: add repository argument to sha1_file_name
>   sha1_file: add repository argument to map_sha1_file
>   sha1_file: allow stat_sha1_file to handle arbitrary repositories
>   sha1_file: allow open_sha1_file to handle arbitrary repositories
>   sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
>   sha1_file: allow sha1_loose_object_info to handle arbitrary
>     repositories
> 
> Stefan Beller (18):
>   repository: introduce raw object store field
>   object-store: move alt_odb_list and alt_odb_tail to object store
>   object-store: free alt_odb_list
>   object-store: move packed_git and packed_git_mru to object store
>   object-store: close all packs upon clearing the object store
>   sha1_file: add raw_object_store argument to alt_odb_usable
>   sha1_file: add repository argument to link_alt_odb_entry
>   sha1_file: add repository argument to read_info_alternates
>   sha1_file: add repository argument to link_alt_odb_entries
>   sha1_file: add repository argument to prepare_alt_odb
>   sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
>   sha1_file: allow prepare_alt_odb to handle arbitrary repositories
>   sha1_file: add repository argument to stat_sha1_file
>   sha1_file: add repository argument to open_sha1_file
>   sha1_file: add repository argument to map_sha1_file_1
>   sha1_file: add repository argument to sha1_loose_object_info
>   sha1_file: allow sha1_file_name to handle arbitrary repositories
>   sha1_file: allow map_sha1_file to handle arbitrary repositories
> 
>  builtin/am.c                                    |   2 +-
>  builtin/clone.c                                 |   2 +-
>  builtin/count-objects.c                         |   6 +-
>  builtin/fetch.c                                 |   2 +-
>  builtin/fsck.c                                  |  13 ++-
>  builtin/gc.c                                    |   4 +-
>  builtin/grep.c                                  |   2 +-
>  builtin/index-pack.c                            |   1 +
>  builtin/merge.c                                 |   2 +-
>  builtin/pack-objects.c                          |  21 ++--
>  builtin/pack-redundant.c                        |   6 +-
>  builtin/receive-pack.c                          |   3 +-
>  cache.h                                         |  46 ++------
>  contrib/coccinelle/refactoring/packed_git.cocci |   7 ++
>  environment.c                                   |   5 +-
>  fast-import.c                                   |   6 +-
>  http-backend.c                                  |   6 +-
>  http-push.c                                     |   1 +
>  http-walker.c                                   |   4 +-
>  http.c                                          |   6 +-
>  mru.h                                           |   1 +
>  object-store.h                                  |  75 +++++++++++++
>  object.c                                        |  26 +++++
>  pack-bitmap.c                                   |   4 +-
>  pack-check.c                                    |   1 +
>  pack-revindex.c                                 |   1 +
>  packfile.c                                      |  64 +++++------
>  packfile.h                                      |   2 +-
>  path.c                                          |   2 +-
>  reachable.c                                     |   1 +
>  repository.c                                    |  17 ++-
>  repository.h                                    |   7 +-
>  server-info.c                                   |   6 +-
>  sha1_file.c                                     | 135 +++++++++++++-----------
>  sha1_name.c                                     |  11 +-
>  streaming.c                                     |   5 +-
>  36 files changed, 321 insertions(+), 182 deletions(-)
>  create mode 100644 contrib/coccinelle/refactoring/packed_git.cocci
>  create mode 100644 object-store.h
> 
> -- 
> 2.16.1.73.ga2c3e9663f.dirty
> 

-- 
Brandon Williams
