Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666C31F404
	for <e@80x24.org>; Mon,  9 Apr 2018 23:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDIXZk (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 19:25:40 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:45376 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeDIXZj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 19:25:39 -0400
Received: by mail-pf0-f169.google.com with SMTP id l27so6662964pfk.12
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DpVREYqrIdiPm165vZ2FhCjC9lY4srrmojXWaONpCWk=;
        b=TmHdJPWFj4F3InxZWbgIP+M+L/XQru+Z5EB0tyVyBcm0oQISh+pyRT3cJJZST/wk7I
         8kfPUCAd+qh829f+xBuyteTJoJTo1FwtbNeghcrzFf+fY/SeCblX7affPLaCOPcCHZYW
         Nji8VX9PtW2BiBxiB7QmNOQ55O7XSK8sgEZnQwAL5kxgdwxQDsekV0OMm71k51dehvva
         UYdb2Tr+1DN5iXOWfbp6PkGGM+7HMSIHPopbSVFIdZ/8wNNpha22nTqnQOkRi9XJ5IaT
         lAvJ7RupAdgInYozclcSYvdKPEGEN1V8vW0Sntq6WGnzB5eCjJNhUqn3+Wnjz1Dq+kjc
         N/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DpVREYqrIdiPm165vZ2FhCjC9lY4srrmojXWaONpCWk=;
        b=bSff/NZQuTfmAM6fQ7ibzCql7glppJJkl9Oj/AM2oF54/EntjYwFceNjacQIzC07+y
         EjTjhiLaXHvq3DqysiTa904R3QfFtXKkH/aHnTtpU8v9mrARJGSjxXA+gmUJDfmrO5Ly
         NcxjT6YwufpecPnKVb5YW8nfs7CbqtexwKxVjSGhve93Q6zn/BsXKMGE+7ZdVqq9pqXC
         266DiekrjLn8VrThZKVIQ3GvYL6dT/tLD0evKUXRuiHLgOw0x0f42a4Siw1SW+ygMEFZ
         +dVYHTZQsfxu5Y8MmnXoZhi27eT3jAhnGgSJSDu0oVIvGCrqN754Xv6eLfqX9esEickd
         2VYQ==
X-Gm-Message-State: AElRT7HVmkDdrHwUVRU2jDsEHmO/9D6u7bv8f74KR7jy4s1UWUWP+v0X
        z0iCm3A9YpEhwjTsmZCM9tanUA==
X-Google-Smtp-Source: AIpwx4+HgjutLG67qX01SiqfvVsz81PSmWlT0o223W+f2sMy9ZyP7BuKmM2SmkGpoCN/SOnZeqE3ug==
X-Received: by 10.101.96.47 with SMTP id p15mr26408015pgu.430.1523316338956;
        Mon, 09 Apr 2018 16:25:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d4sm2715895pgc.43.2018.04.09.16.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 16:25:37 -0700 (PDT)
Date:   Mon, 9 Apr 2018 16:25:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv2 00/16] object-store refactoring 3 (replace objects,
 main ref store)
Message-ID: <20180409232536.GB102627@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09, Stefan Beller wrote:

I've looked through the series and it looks good.  My only concern is
making sure that the ref-store is in a good place to be embedded into
the repository struct.

> v2:
> This applies on top of a merge of
> origin/bc/object-id and origin/sb/packfiles-in-repository,
> both of which are pending merge to master. It is also available at
> https://github.com/stefanbeller/git/tree/object-store-3
> 
> * removed whitespaces as noted by Stolee
> * incorporated Renes patch as the first patch of this series
>   (It may go independently if this series takes too long)
> * Adressed Erics concern regarding sloppy commit messages
>   (removed #Conflict markers), typo in comment
> * I did not drop the main_ from the ref store, yet, as asked by Duy.
> 
> Thanks,
> Stefan
> 
> v1:
> This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
> (sb/packfiles-in-repository).
> It is also available at https://github.com/stefanbeller/git/tree/object-store-3
> 
> This series will bring the replacement mechanism (git replace)
> into the object store.
> 
> The first patches are cleaning up a bit, and patches 6-19 are converting
> one function at a time using the tick-tock pattern with the #define trick.
> See cfc62fc98c (sha1_file: add repository argument to link_alt_odb_entry,
> 2018-03-23) for explanation.
> 
> Thanks,
> Stefan
> 
> René Scharfe (1):
>   replace_object: use oidmap
> 
> Stefan Beller (15):
>   replace_object.c: rename to use dash in file name
>   replace-object: move replace_map to object store
>   object-store: move lookup_replace_object to replace-object.h
>   replace-object: eliminate replace objects prepared flag
>   replace-object: check_replace_refs is safe in multi repo environment
>   refs: add repository argument to get_main_ref_store
>   refs: add repository argument to for_each_replace_ref
>   replace-object: add repository argument to prepare_replace_object
>   replace-object: add repository argument to do_lookup_replace_object
>   replace-object: add repository argument to lookup_replace_object
>   refs: store the main ref store inside the repository struct
>   refs: allow for_each_replace_ref to handle arbitrary repositories
>   replace-object: allow prepare_replace_object to handle arbitrary
>     repositories
>   replace-object: allow do_lookup_replace_object to handle arbitrary
>     repositories
>   replace-object: allow lookup_replace_object to handle arbitrary
>     repositories
> 
>  Makefile                  |   2 +-
>  builtin/mktag.c           |   3 +-
>  builtin/pack-refs.c       |   3 +-
>  builtin/replace.c         |   4 +-
>  cache.h                   |  19 ------
>  environment.c             |   2 +-
>  object-store.h            |   8 +++
>  object.c                  |   3 +-
>  refs.c                    |  80 +++++++++++++------------
>  refs.h                    |   4 +-
>  replace-object.c          |  73 +++++++++++++++++++++++
>  replace-object.h          |  36 ++++++++++++
>  replace_object.c          | 120 --------------------------------------
>  repository.h              |   3 +
>  revision.c                |   5 +-
>  sha1_file.c               |   7 ++-
>  streaming.c               |   3 +-
>  t/helper/test-ref-store.c |   3 +-
>  18 files changed, 183 insertions(+), 195 deletions(-)
>  create mode 100644 replace-object.c
>  create mode 100644 replace-object.h
>  delete mode 100644 replace_object.c
> 
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

-- 
Brandon Williams
