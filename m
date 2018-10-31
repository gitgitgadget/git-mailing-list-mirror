Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB691F453
	for <e@80x24.org>; Wed, 31 Oct 2018 06:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJaPiB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 11:38:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaPiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 11:38:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so15123952wrn.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VK5aW9EQBPFrguSzSRZHVM/Jy3QtHh7Y8q4czhzEw3I=;
        b=Hp4Jf9+k4mIYxI9Ch+D2eaQ6uVj/bsn/sVX6rLN3s3R3W7TyqZLj42R5YosBw9PKH3
         VhV7ZsdEApTxiqIeZZPnscdP4Ngdb07o6lJigHEaBnVJFXTeppiezrfDzZexpIzZt0G4
         iOV8SHeRMI5hDkGOmEkmcKQwUtnEvzAbmIBZoyDT9I1M3LrHo1f4gwmdebZCkeg+L7t5
         orByoS2QtwKAjHzYSsVFP7SNMZrwK65aSwg2g84IbhCvt0hxJp9S+Dr85/5KDnZ9YU+r
         n9TLD1C/EPd0Yain2VT3+Mup+wieWfP2hUT/SglJtKvM8yMitmijXjCyd6gnr2pnQEpJ
         +D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VK5aW9EQBPFrguSzSRZHVM/Jy3QtHh7Y8q4czhzEw3I=;
        b=WxCIFIwzFkdSucIY1RMOG89whMf9D6vdA7I94lgmjbuaUiEs41wioRbK+IHAw0aKJM
         B1RqdcvvjF6oZlOY9hejF2sxrY5/BnK9XoTTxROk2hzP8Z4ecAQmUIODiur7A8w4Z1zr
         nC1tkTujNRWGOrDBmrFbNemX4nFps3O/KGc16TsyoAbOwj/GTnbVAvTNoLOYETIw32wo
         WswVjn/YDRmBtoi7c9du0U90S5uFmU6/Oxldb/Iz8F6ntwHrM2K8FB0l3gfQWMFVnH+r
         XuhLBAyre2fLBhGMs1ecbcCU4gXl9Q8gT8iKHB0+2f6kMgEDyNQXavc92F0D85i6nAzk
         TN+w==
X-Gm-Message-State: AGRZ1gIXp8GGR8r5U7wQMsLD9W3q272U9+HSU3vNQGPT3hiCncwN7nKv
        1sgC+jo5pEFilpyvG+EOQCY=
X-Google-Smtp-Source: AJdET5ca7xyZhBnbS5IDvnq1ULQHbPgH87RnMa1NoQfVmsTFfp6Z/gzZAT22HWAaz9xqHleA2UeGbQ==
X-Received: by 2002:adf:826b:: with SMTP id 98-v6mr1495724wrb.312.1540968071861;
        Tue, 30 Oct 2018 23:41:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y138-v6sm11926584wmd.2.2018.10.30.23.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 23:41:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCHv2 00/24] Bring more repository handles into our code base]
References: <20181030220817.61691-1-sbeller@google.com>
Date:   Wed, 31 Oct 2018 15:41:09 +0900
In-Reply-To: <20181030220817.61691-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 30 Oct 2018 15:07:53 -0700")
Message-ID: <xmqq4ld2wrcq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I also picked up the patch for pending semantic patches, as the
> first patch, can I have your sign off, please?

I find this step quite lacking.  

What was posted would have been perfectly fine as a "how about doing
it this way" weatherbaloon patch, but as a part of real series, it
needs to explain to the developers what the distinctions between two
classes are, and who is to use the cocci patch at what point in the
development cycle, etc., in an accompanying documentation update.

So can we have both sign-off and write-up (perhaps cut&paste from
the original e-mail discussion)?

> Stefan Beller (23):
>   sha1_file: allow read_object to read objects in arbitrary repositories
>   packfile: allow has_packed_and_bad to handle arbitrary repositories
>   object-store: allow read_object_file_extended to read from arbitrary
>     repositories
>   object-store: prepare read_object_file to deal with arbitrary
>     repositories
>   object-store: prepare has_{sha1, object}_file[_with_flags] to handle
>     arbitrary repositories
>   object: parse_object to honor its repository argument
>   commit: allow parse_commit* to handle arbitrary repositories
>   commit-reach.c: allow paint_down_to_common to handle arbitrary
>     repositories
>   commit-reach.c: allow merge_bases_many to handle arbitrary
>     repositories
>   commit-reach.c: allow remove_redundant to handle arbitrary
>     repositories
>   commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary
>     repositories
>   commit-reach: prepare get_merge_bases to handle arbitrary repositories
>   commit-reach: prepare in_merge_bases[_many] to handle arbitrary
>     repositories
>   commit: prepare get_commit_buffer to handle arbitrary repositories
>   commit: prepare repo_unuse_commit_buffer to handle arbitrary
>     repositories
>   commit: prepare logmsg_reencode to handle arbitrary repositories
>   pretty: prepare format_commit_message to handle arbitrary repositories
>   submodule: use submodule repos for object lookup
>   submodule: don't add submodule as odb for push
>   commit-graph: convert remaining function to handle arbitrary
>     repositories
>   commit: make free_commit_buffer and release_commit_memory repository
>     agnostic
>   path.h: make REPO_GIT_PATH_FUNC repository agnostic
>   t/helper/test-repository: celebrate independence from the_repository

It seems that this topic is full of commits with overly long title.

>
>  Makefile                                      |   6 +-
>  builtin/fsck.c                                |   3 +-
>  builtin/log.c                                 |   6 +-
>  builtin/rev-list.c                            |   3 +-
>  cache.h                                       |   2 +
>  commit-graph.c                                |  40 +++--
>  commit-reach.c                                |  73 +++++----
>  commit-reach.h                                |  38 +++--
>  commit.c                                      |  41 ++---
>  commit.h                                      |  43 +++++-
>  .../coccinelle/the_repository.pending.cocci   | 144 ++++++++++++++++++
>  object-store.h                                |  35 ++++-
>  object.c                                      |   8 +-
>  packfile.c                                    |   5 +-
>  packfile.h                                    |   2 +-
>  path.h                                        |   2 +-
>  pretty.c                                      |  28 ++--
>  pretty.h                                      |   7 +-
>  sha1-file.c                                   |  34 +++--
>  streaming.c                                   |   2 +-
>  submodule.c                                   |  79 +++++++---
>  t/helper/test-repository.c                    |  10 ++
>  22 files changed, 459 insertions(+), 152 deletions(-)
>  create mode 100644 contrib/coccinelle/the_repository.pending.cocci
>
> git range-diff origin/sb/more-repo-in-api...
> [...] # rebased to origin/master

I offhand do not recall what happened during these 100+ pacthes.
DId we acquire something significantly new that would have
conflicted with this new round of the topic?  I do not mind at all
seeing that a series gets adjusted to the updated codebase, but I do
dislike seeing it done without explanation---an unexplained rebase
to a new base is a wasted opportunity to learn what areas of the
codebase are so hot that multiple and separate topics would want to
touch them.

>   -:  ---------- > 116:  4ede3d42df Seventh batch for 2.20
>   -:  ---------- > 117:  b1de196491 Makefile: add pending semantic patches
>   1:  1b9b5c695e = 118:  f1be5eb487 sha1_file: allow read_object to read objects in arbitrary repositories
>   2:  33b94066f2 = 119:  9100a5705d packfile: allow has_packed_and_bad to handle arbitrary repositories
>   3:  5217b6b1e1 = 120:  a4ad7791da object-store: allow read_object_file_extended to read from arbitrary repositories
>   4:  2b7239b55b ! 121:  5d7b3a6dd9 object-store: prepare read_object_file to deal with arbitrary repositories
>     @@ -19,10 +19,10 @@
>          Signed-off-by: Stefan Beller <sbeller@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
>     - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
>     + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
>       new file mode 100644
>       --- /dev/null
>     - +++ b/contrib/coccinelle/the_repository.cocci
>     + +++ b/contrib/coccinelle/the_repository.pending.cocci
>      @@
>      +// This file is used for the ongoing refactoring of
>      +// bringing the index or repository struct in all of
>     @@ -36,6 +36,7 @@
>      +- read_object_file(
>      ++ repo_read_object_file(the_repository,
>      +  E, F, G)
>     ++

Is it necessary for this file to end with a trailing blank line?



Thanks.
