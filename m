Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44281F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 21:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeKZIrN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 03:47:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54155 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIrN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 03:47:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so13064190wmi.3
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yuVd9hDMg1XYTFyLAjLEuwb2r6ZC78NoZneMTDL21I4=;
        b=bIXy8EaD0ZCKNMOHL6lmzmab90X/yAghPbVpq2augkbtj728POEQyJWuRpDiZXjqgj
         Ge7ivSg/vyaLYB4OmGiLTOKgTmkX1T64GvnIghfX06+q2i1XuPao6djootN9KmrqTGE2
         Ko4hEyxTW3yKivrkslenZ1QrXpb9gOsO0fTp2AA327uYMpfZdf5d52z71aqjoiTnOgPr
         EhDP6q7KCl5vNbGlUBQcHnvFKGbqu/ELK1MLh7DYf5cGG9zZ6kMBQKTe3GHMvtHqKWul
         9Y7kI31MOi/5C9ZUJZB+39SJI4U4nqWDCk+Lm2Y5ONfnzGyZEosBe4ebGxrgBbQ4l3gZ
         CzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuVd9hDMg1XYTFyLAjLEuwb2r6ZC78NoZneMTDL21I4=;
        b=cinBd1OTLtkek2L1X4Rf8GMKW82xtY8BNCPEAfZdi7HjbR1OnH9L8/q0BoFFBO5DTO
         qdBatI+wV52XwSmuXODOBoj9FRJG0To3JE/b3XR3kcM3FOTLRuVYmr5ISV8lXuH+ut8w
         Y+tYCKR2VIhmBG+Zj/f++13NTnRHR6JBdxIWFoPJ0BCA0Kdsww0kHok0OZtcEzJAchyw
         ZHIi8VEJ17Axw/CJHp7xY6NdnmHLiKs/ijMN+gNLzylcUx3f9/6XWBx0Hctkz1HhWiZl
         NcYFqzWouRu2nY7JujAh4p7IDnBDJt5DMA2+kS1RONy1wvp+z53ND1DfqA8NCjd61sUn
         tqiw==
X-Gm-Message-State: AGRZ1gKdCVRWKau2e91DUpsNGSpA7W6uIY6YoRp0k3DErETkP9Kp0bwQ
        6goIKA16+1ZdWBai7U3kOOHZzR7x
X-Google-Smtp-Source: AJdET5dJcmWNsyMVZEvZxAo4n/MEMeUakZ104a4+c4MN5+auF7rUhoBgAKmg4P6LxTmfub5YCyMxbw==
X-Received: by 2002:a1c:1109:: with SMTP id 9-v6mr20811188wmr.146.1543182906696;
        Sun, 25 Nov 2018 13:55:06 -0800 (PST)
Received: from localhost ([31.127.45.106])
        by smtp.gmail.com with ESMTPSA id 60sm36009355wrb.81.2018.11.25.13.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:55:05 -0800 (PST)
Date:   Sun, 25 Nov 2018 21:55:04 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v11 00/22] Convert "git stash" to C builtin
Message-ID: <20181125215504.GJ4883@hank.intra.tgummerer.com>
References: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>
 <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/23, Paul-Sebastian Ungureanu wrote:
> Hello,
> 
> This is the 11th iteration of C git stash. Here are some of the changes,
> based on Thomas's and dscho's suggestions (from mailing list / pull request
> #495):

Thanks for your work on this!  I have read through the range-diff and
the new patch of this last round, and this addresses all the comments
I had on v10 (and some more :)).  I consider it
Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>

> - improved memory management. Now, the callers of `do_create_stash()`
> are responsible of freeing the parameter they pass in. Moreover, the
> stash message is now a pointer to a buffer (in the previous iteration
> it was a pointer to a string). This should make it more clear who is
> responsible of freeing the memory.
> 
> - added `strbuf_insertf()` which inserts a format string at a given
> position in the buffer.
> 
> - some minor changes (changed "!oidcmp" to "oideq")
> 
> - fixed merge conflicts
> 
> Best regards,
> Paul
> 
> Joel Teichroeb (5):
>   stash: improve option parsing test coverage
>   stash: convert apply to builtin
>   stash: convert drop and clear to builtin
>   stash: convert branch to builtin
>   stash: convert pop to builtin
> 
> Paul-Sebastian Ungureanu (17):
>   sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>   strbuf.c: add `strbuf_join_argv()`
>   strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
>   t3903: modernize style
>   stash: rename test cases to be more descriptive
>   stash: add tests for `git stash show` config
>   stash: mention options in `show` synopsis
>   stash: convert list to builtin
>   stash: convert show to builtin
>   stash: convert store to builtin
>   stash: convert create to builtin
>   stash: convert push to builtin
>   stash: make push -q quiet
>   stash: convert save to builtin
>   stash: convert `stash--helper.c` into `stash.c`
>   stash: optimize `get_untracked_files()` and `check_changes()`
>   stash: replace all `write-tree` child processes with API calls
> 
>  Documentation/git-stash.txt  |    4 +-
>  Makefile                     |    2 +-
>  builtin.h                    |    1 +
>  builtin/stash.c              | 1596 ++++++++++++++++++++++++++++++++++
>  cache.h                      |    1 +
>  git-stash.sh                 |  752 ----------------
>  git.c                        |    1 +
>  sha1-name.c                  |   19 +
>  strbuf.c                     |   51 ++
>  strbuf.h                     |   16 +
>  t/t3903-stash.sh             |  192 ++--
>  t/t3907-stash-show-config.sh |   83 ++
>  12 files changed, 1897 insertions(+), 821 deletions(-)
>  create mode 100644 builtin/stash.c
>  delete mode 100755 git-stash.sh
>  create mode 100755 t/t3907-stash-show-config.sh
> 
> -- 
> 2.19.1.878.g0482332a22
> 
