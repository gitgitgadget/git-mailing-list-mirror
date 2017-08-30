Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF77C208E3
	for <e@80x24.org>; Wed, 30 Aug 2017 23:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdH3XH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 19:07:59 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33571 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdH3XH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 19:07:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id r62so23226586pfj.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kxxSTjayhBnpj/eft2AK7Hp28H0QIl3zz2H124x75TQ=;
        b=i5MnHw8/UsFXKaPQztKwBwgWZZ21MqkZNC+hU0nXxjKj+KWB6HyAXRizDD+V15CQW9
         2CArDmowCiAEwcDGA8va1XqcUaVDD4WZB//8d5X6e8/2S+rfx9YmkFnu8J9d7IU8saJm
         dLyKtXHuyBSTE8cKFo0AIqossRlfkTZYiC+cDeKDF8dCjjYHwzlyf9Ngtc0PvGhYIbcp
         CV9U2QtF7MXs8brZMcTQIkhb5zkZmva2dQDy0WAcMO7HeVFHBmF/4quYuNb9zN9xBMV5
         s0gdL/eTotVKOok2Tt+24y5bnR/XqXqe9SbNiscEydP1TBJKTm4+9PcAzKz9cyLjDPRu
         MHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kxxSTjayhBnpj/eft2AK7Hp28H0QIl3zz2H124x75TQ=;
        b=TSLRk+oy8t70wNgiNgxQeztu3ERB6ezozqkxllxVBrQ6k1tHtDbu8XeI9A/ZrpwXfo
         tF69J4ZAg9q0RT01BQ+QGBMQ8cP3kN7A8m0pkUk63AFTZc4h3pL6xHHxlSN66rH1koqt
         NiOsuLK9EUfqJbV8glYyOwENavxmfiRVZNjQtPKoYz6JR1Ide6oeh4jgqWleubNWwV0D
         IQrC6zVa2jU6ToXmwijj+ZqF9cCxNPbInD57jvvTWEsTxBxJewXKBEXHORwNb+zcudnH
         sLRZWXo9Mgq8YRbSEkb1Q1XNtMBL4/KFlXSe4iZ86GGhHxioWeeIo+eMqnYMICPg2w4b
         gOYA==
X-Gm-Message-State: AHYfb5jC2wwxqu4ObF8lCKFvyfh0rW5tZ985N+k+ZYW/SFOTFMq0a69F
        XvwFeNmeJiMuTjkT
X-Google-Smtp-Source: ADKCNb5ZpnumNAfF7Lroclu4U5Nos1h8JDTg8GYN938lzJT6Ob9Rmnr9npzfFtfk3Z/H8YuPMBR8eA==
X-Received: by 10.84.238.134 with SMTP id v6mr221636plk.187.1504134477615;
        Wed, 30 Aug 2017 16:07:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:81c4:afb0:c46d:bc75])
        by smtp.gmail.com with ESMTPSA id z7sm9543343pgb.24.2017.08.30.16.07.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 16:07:56 -0700 (PDT)
Date:   Wed, 30 Aug 2017 16:07:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/39] per-repository object store, part 1
Message-ID: <20170830230755.GF50018@google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Jonathan Nieder wrote:
> Hi,
> 
> Most of the credit for this series should go to Stefan Beller.  I just
> decided to pull the trigger on sending out what we have so far.
> 
> This series is about API.  It makes no functional change yet.
> 
> Today, when a git command wants to operate on some objects from another
> repository (e.g., a submodule), it has two choices:
> 
>  A. Use run_command to operate on that repository in a separate process.
> 
>  B. Use add_to_alternates_memory to pretend the repository is an
>     alternate.  This has a number of downsides.  Aside from aesthetics,
>     one particularly painful consequence is that as alternates
>     accumulate, the number of packs git has to check for objects
>     increases, which can cause significant slowdowns.
> 
> Brandon Williams's recent work to introduce "struct repository" points
> to a better way.  Encapsulating object access in struct repository
> would mean:
> 
>   i. The API for accessing objects in another repository becomes more
>      simple and familiar (instead of using the CLI or abusing alternates).
> 
>   ii. Operations on one repository do not interfere with another,
>       neither in semantics (e.g. replace objects do not work correctly
>       with the approach (B) above) nor performance (already described
>       above).
> 
>  iii. Resources associated with access to a repository could be freed
>       when done with that repo.
> 
>   iv. Thread-safe multiple readers to a single repository also become
>       straightforward, by using multiple repository objects for the same
>       repo.
> 
> This series is a small step in that direction.
> 
> At the end of this series, sha1_loose_object_info takes a repository
> argument and can be independently called for multiple repositories.
> Not incredibly useful on its own, but a future series will do the same
> for sha1_object_info, which will be enough to migrate a caller in
> submodule.c (which uses the object store for commit existence checks).
> 
> This series has a few phases:
> 
>  1. Patch 1 is a cleanup that made some of the later patches easier.
> 
>  2. Patches 2-6 create a struct object_store field inside struct
>     repository and move some globals to it.
> 
>  3. Patches 7-24 are mechanical changes that update some functions to
>     accept a repository argument. The only goal is to make the later
>     patches that teach these functions to actual handle a repository
>     other than the_repository easier to review.  The patches enforce
>     at compile time that no caller passes a repository other than
>     the_repository --- see patch 7 in particular for details on how
>     that works.
> 
>  4. Patches 25-39 update the implementations of those functions to
>     handle a repository other than the_repository.  This means the
>     safety check introduced in phase 3 goes away completely --- all
>     functions that gained a repository argument are safe to use with
>     a repository argument other than the_repository.
> 
> Patches 2-6 and 25-39 should be the most interesting to review.  I'd
> particularly appreciate if people can look over 25-39 carefully.  We
> were careful not to leave any calls to functions that assume they are
> operating on the_repository, but a triple-check is always welcome.
> 
> Thanks as well to brian m. carlson, who showed us how such a long and
> potentially tedius series can be made bearable for reviewers.
> 
> Thoughts of all kinds welcome, as always.

Just finished looking through the series.  Thanks for keeping each
commit very short and to the point, it made reviewing it much easier.  I
couldn't see anything wrong these transformations and I am very happy to
see this work getting done.

One thing that needs to be noted is that currently the object_store is
only really being used by the_repository so this series didn't need to
create any object_store_init() or object_store_clear() type functions.
So these types of functions will need to be added once submodules are
using their own object store, in their own struct repository.

> 
> Thanks,
> Jonathan Nieder (24):
>   pack: make packed_git_mru global a value instead of a pointer
>   object-store: move packed_git and packed_git_mru to object store
>     struct
>   pack: move prepare_packed_git_run_once to object store struct
>   pack: move approximate object count to object store struct
>   pack: add repository argument to install_packed_git
>   pack: add repository argument to prepare_packed_git_one
>   pack: add repository argument to rearrange_packed_git
>   pack: add repository argument to prepare_packed_git_mru
>   pack: add repository argument to prepare_packed_git
>   pack: add repository argument to reprepare_packed_git
>   pack: add repository argument to sha1_file_name
>   pack: add repository argument to map_sha1_file
>   pack: allow install_packed_git to handle arbitrary repositories
>   pack: allow rearrange_packed_git to handle arbitrary repositories
>   pack: allow prepare_packed_git_mru to handle arbitrary repositories
>   pack: allow prepare_packed_git_one to handle arbitrary repositories
>   pack: allow prepare_packed_git to handle arbitrary repositories
>   pack: allow reprepare_packed_git to handle arbitrary repositories
>   pack: allow sha1_file_name to handle arbitrary repositories
>   pack: allow stat_sha1_file to handle arbitrary repositories
>   pack: allow open_sha1_file to handle arbitrary repositories
>   pack: allow map_sha1_file_1 to handle arbitrary repositories
>   pack: allow map_sha1_file to handle arbitrary repositories
>   pack: allow sha1_loose_object_info to handle arbitrary repositories
> 
> Stefan Beller (15):
>   repository: introduce object store field
>   object-store: move alt_odb_list and alt_odb_tail to object store
>     struct
>   sha1_file: add repository argument to alt_odb_usable
>   sha1_file: add repository argument to link_alt_odb_entry
>   sha1_file: add repository argument to read_info_alternates
>   sha1_file: add repository argument to link_alt_odb_entries
>   sha1_file: add repository argument to stat_sha1_file
>   sha1_file: add repository argument to open_sha1_file
>   sha1_file: add repository argument to map_sha1_file_1
>   sha1_file: add repository argument to sha1_loose_object_info
>   object-store: add repository argument to prepare_alt_odb
>   object-store: add repository argument to foreach_alt_odb
>   sha1_file: allow alt_odb_usable to handle arbitrary repositories
>   object-store: allow prepare_alt_odb to handle arbitrary repositories
>   object-store: allow foreach_alt_odb to handle arbitrary repositories
> 
>  builtin/count-objects.c             |  10 ++-
>  builtin/fsck.c                      |  15 ++--
>  builtin/gc.c                        |   8 +-
>  builtin/index-pack.c                |   1 +
>  builtin/pack-objects.c              |  23 +++--
>  builtin/pack-redundant.c            |   8 +-
>  builtin/receive-pack.c              |   4 +-
>  builtin/submodule--helper.c         |   4 +-
>  bulk-checkin.c                      |   3 +-
>  cache.h                             |  50 ++---------
>  contrib/coccinelle/packed_git.cocci |  15 ++++
>  fast-import.c                       |  10 ++-
>  fetch-pack.c                        |   3 +-
>  http-backend.c                      |   8 +-
>  http-push.c                         |   1 +
>  http-walker.c                       |   4 +-
>  http.c                              |   9 +-
>  mru.h                               |   1 +
>  object-store.h                      |  71 ++++++++++++++++
>  pack-bitmap.c                       |   6 +-
>  pack-check.c                        |   1 +
>  pack-revindex.c                     |   1 +
>  packfile.c                          |  94 ++++++++++----------
>  packfile.h                          |   6 +-
>  reachable.c                         |   1 +
>  repository.c                        |   4 +-
>  repository.h                        |   7 ++
>  server-info.c                       |   8 +-
>  sha1_file.c                         | 165 ++++++++++++++++++++----------------
>  sha1_name.c                         |  11 ++-
>  streaming.c                         |   5 +-
>  transport.c                         |   4 +-
>  32 files changed, 344 insertions(+), 217 deletions(-)
>  create mode 100644 contrib/coccinelle/packed_git.cocci
>  create mode 100644 object-store.h
> 
> -- 
> 2.14.1.581.gf28d330327
> 

-- 
Brandon Williams
