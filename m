Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A10C1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756661AbeDZQab (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 12:30:31 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:47101 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbeDZQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 12:30:30 -0400
Received: by mail-pg0-f43.google.com with SMTP id z4so3404181pgu.13
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3OpAoJaPV0KxGS4/GkmSbQtHShssd4591HAKEXW8j4=;
        b=dbPxPzAOXrufOKIlrNSmxdBKGRtLt+zxieVlR+q380regVOnyUMy3YEeUveyQRCeuU
         XmFCL248cOiXByTh2ILPUpqRh24tQyl0e5N+cy0K3DZtOn/giTezNL9xmTRZqEuGmamj
         +7XnFkRkA6Lf/LijycKAlQjJWzch04dIleUhHRsb5KbiKBwRSt8tZeSnW28oVBmSdctK
         0HW4PRUhuwMVuMQm2dp3og420kFPwPd8h03yAfK9QvbStHviZPWwxrH5bjHG1Ig+hHl0
         97kuIoUh8N2P6q8Zu7HtWYdtJqnspP2GipvLFcrw2hTnGEHeUAjOgJuHUDIwFbZ3B7BA
         0AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3OpAoJaPV0KxGS4/GkmSbQtHShssd4591HAKEXW8j4=;
        b=j/4G9/3kDmir3GKVEWsbYnsISfhfNWxmeevrekdQpag1RoSPzovaa8mY/dR2yaHchp
         wv9lVcnKpwrh3TsDmkD7XEmJsKuRQXc9If07dIvhQIrc7mhBhjdU8l4N97Fq+w2UnnuV
         1yMojmihNWOVDgqV00YcIZ1ZGkLidegK0tNirKWhAnQADKmxznJn5C+0IzIZvv7rO/0M
         O13kMTJOVfqWu06MwIdkj9Q325HcH8y2CGGvffwscnKfNxkW/V8RbZWoabKppGYrX6us
         PuhnRv1iNWw0xHS2ZJGxpKSfozI8MV9Qexk+a9vNX5ELh+DuoB07RYS6m4bcfcgYuoa0
         9bGQ==
X-Gm-Message-State: ALQs6tDzYEC8ATBgfTfF8iqomSDviaaLeZP3c1JC8v5K5BktY6zOM2X/
        3FX1/xLP/lyyakDY4s6i5ZWVaQ==
X-Google-Smtp-Source: AIpwx49uq/eFcOwjqta+hQxU3BqOhbbFNuy5DyzWmFkw07HfH9Hl7xz9w+CguvPxZzT9mSnSJLQf6w==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32-v6mr34907782plb.123.1524760229409;
        Thu, 26 Apr 2018 09:30:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a23sm8724056pfi.176.2018.04.26.09.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 09:30:28 -0700 (PDT)
Date:   Thu, 26 Apr 2018 09:30:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv3 0/9] object store: oid_object_info is the next contender
Message-ID: <20180426163027.GA101170@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/25, Stefan Beller wrote:
> v3:
> * fixed and extended the commit message of last commit
> * fixed the last patch, as Jonathan Tan suggested, see interdiff:
> 
>     $ git diff remotes/origin/sb/oid-object-info (which is v2)
>     diff --git c/sha1_file.c w/sha1_file.c
>     index 94123e0299..dcd6b879ac 100644
>     --- c/sha1_file.c
>     +++ w/sha1_file.c
>     @@ -1289,14 +1289,13 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
>      
>                     /* Check if it is a missing object */
>                     if (fetch_if_missing && repository_format_partial_clone &&
>     -                   !already_retried) {
>     +                   !already_retried && r == the_repository) {
>                             /*
>                              * TODO Investigate having fetch_object() return
>                              * TODO error/success and stopping the music here.
>     -                        * TODO Pass a repository struct through fetch_object.
>     +                        * TODO Pass a repository struct through fetch_object,
>     +                        * such that arbitrary repositories work.
>                              */
>     -                       if (r != the_repository)
>     -                               die(_("partial clones only supported in the_repository"));
>                             fetch_object(repository_format_partial_clone, real->hash);
>                             already_retried = 1;
>                             continue;
>     
> Thanks,
> Stefan

v3 looks good, thanks for taking care of this.

> 
> v2:
> 
> * fixed the sha1/oid typo
> * removed spurious new line
> * Brandon and Jonthan discovered another dependency that I missed due
>   to cherrypicking that commit from a tree before partial clone was a thing.
>   We error out when attempting to use fetch_object for repos that are not
>   the_repository.
> 
> Thanks,
> Stefan
> 
> v1:
> This applies on top of origin/sb/object-store-replace and is available as
> https://github.com/stefanbeller/git/tree/oid_object_info
> 
> This continues the work of sb/packfiles-in-repository,
> extending the layer at which we have to pass in an explicit
> repository object to oid_object_info.
> 
> A test merge to next shows only a minor merge conflicit (adding
> different #include lines in one c file), so this might be a good next
> step for the object store series.
> 
> Notes on further object store series:
> I plan on converting the "parsed object store" next,
> which would be {alloc, object, tree, commit, tag}.c as that is a prerequisite
> for migrating shallow (which is intermingled with grafts) information to the
> object store.
> 
> There is currently work going on in allocation (mempool - Jameson Miller)
> and grafts (deprecate grafts - DScho), which is why I am sending this
> series first. I think it can go in parallel to the "parsed object store"
> that is coming next.
> 
> Thanks,
> Stefan
> 
> Jonathan Nieder (1):
>   packfile: add repository argument to packed_object_info
> 
> Stefan Beller (8):
>   cache.h: add repository argument to oid_object_info_extended
>   cache.h: add repository argument to oid_object_info
>   packfile: add repository argument to retry_bad_packed_offset
>   packfile: add repository argument to packed_to_object_type
>   packfile: add repository argument to read_object
>   packfile: add repository argument to unpack_entry
>   packfile: add repository argument to cache_or_unpack_entry
>   cache.h: allow oid_object_info to handle arbitrary repositories
> 
>  archive-tar.c            |  2 +-
>  archive-zip.c            |  3 ++-
>  blame.c                  |  4 ++--
>  builtin/blame.c          |  2 +-
>  builtin/cat-file.c       | 12 ++++++------
>  builtin/describe.c       |  2 +-
>  builtin/fast-export.c    |  2 +-
>  builtin/fetch.c          |  2 +-
>  builtin/fsck.c           |  3 ++-
>  builtin/index-pack.c     |  4 ++--
>  builtin/ls-tree.c        |  2 +-
>  builtin/mktree.c         |  2 +-
>  builtin/pack-objects.c   | 11 +++++++----
>  builtin/prune.c          |  3 ++-
>  builtin/replace.c        | 11 ++++++-----
>  builtin/tag.c            |  4 ++--
>  builtin/unpack-objects.c |  2 +-
>  cache.h                  |  7 +++++--
>  diff.c                   |  3 ++-
>  fast-import.c            | 16 ++++++++++------
>  list-objects-filter.c    |  2 +-
>  object.c                 |  2 +-
>  pack-bitmap-write.c      |  3 ++-
>  pack-check.c             |  3 ++-
>  packfile.c               | 40 +++++++++++++++++++++++-----------------
>  packfile.h               |  6 ++++--
>  reachable.c              |  2 +-
>  refs.c                   |  2 +-
>  remote.c                 |  2 +-
>  sequencer.c              |  3 ++-
>  sha1_file.c              | 37 +++++++++++++++++++++----------------
>  sha1_name.c              | 12 ++++++------
>  streaming.c              |  2 +-
>  submodule.c              |  2 +-
>  tag.c                    |  2 +-
>  35 files changed, 124 insertions(+), 93 deletions(-)
> 
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 

-- 
Brandon Williams
