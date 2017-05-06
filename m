Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D581E207D6
	for <e@80x24.org>; Sat,  6 May 2017 10:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdEFK0h (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 06:26:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33890 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdEFK0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 06:26:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so3873915pgb.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fw9GYaQIrYIIcFJDzxUu/2EfiyLqiaunKdUzDMLZUyo=;
        b=rWcHc+eocjAydHY/yVbgKoFLCdko+FJrLh3CWxKQKd6zXSX12P5HOcNLzlGz9lHJ9D
         sr+zoFXBuMrqZj1+/+lmqBea/bOTq6cqzpE/ZFXFzgsmtrRqkRk5CrE/ri4rmdcIKyP7
         am5h37XVJhrq6QIHCW+uzZYb8on7S27Mk+MLVyrRu1pij1BLKlPmuXtR6IqoaDqY/RwY
         RHyJed3ZEvFQHLk+3LnnS1JurnyudboG5qGF0EjPtWs7ksOlWasSG6tgSSr2ZUcUzpl5
         LHVHM4XBS/nkSP6yfYn1oTFjuTuAVwGaU4kN0+v7leRFoSoB51MlXA+W1iqu+fMmc7Pg
         Zuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fw9GYaQIrYIIcFJDzxUu/2EfiyLqiaunKdUzDMLZUyo=;
        b=rE8EC6jd6Bo9ngkv+aglIFPKN66nP6zRFp4Kao1qf+chT/JMUl0yodnvkq+tbcmiSi
         of7xup/z2LgaBoB4v4sRxbYnZ2miHDVFtWhpu23bxLPMVzTiQHB7gQbvHHkALt3M66Dw
         VCsMjxtDNRptYPnhd4zmfi3ooDwAsUGgEHQDp9CToTf/GhDBE08e3D8Eta7gA0Kv84kA
         y+cUFfqtw9FZj/pHuQ8Up+lXyNvFEzrIKCyoy/4UQZdtpFjBOOdtz2oBqdUlfwckcYV3
         OfGOBsvI8HLwMJQcu+B64gsu6Q0iTFnkQ/O0/49sZaBK26zQWPTr5LSYsCpFOM4+fbcG
         hiiw==
X-Gm-Message-State: AN3rC/49OuEk+vj5JDiOV8MIF53FIZHSlr/RuhESjh7EDTWmUrwLiUR2
        dWABHK53fmeIVw==
X-Received: by 10.84.213.2 with SMTP id f2mr51783328pli.22.1494066395057;
        Sat, 06 May 2017 03:26:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:6e:7c24:6026:f8b7])
        by smtp.gmail.com with ESMTPSA id z21sm8975921pgc.15.2017.05.06.03.26.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 06 May 2017 03:26:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
Subject: Re: [RFC 00/14] convert dir.c to take an index parameter
References: <20170505195334.121856-1-bmwill@google.com>
Date:   Sat, 06 May 2017 03:26:33 -0700
In-Reply-To: <20170505195334.121856-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 5 May 2017 12:53:20 -0700")
Message-ID: <xmqqmvaq702u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> One of the things brought up on the list in the past few days has been
> migrating away from using the index compatibility macros.  One of the issues
> brought up in that thread was how simply doing that conversion doesn't
> eliminate the reliance on global state (specifically the_index).  If one day we
> want to have a 'repository object' passed around then we first need to convert
> different subsystems to be prepared to handle that.  This series provides a
> first step, converting the code in dir.c to take a 'struct index_state' and
> using that instead of implicitly using 'the_index'.

Very nicely done (I only skimmed "dir.c" in the end result and didn't
go through the changes with fine toothed comb, though).

I would have done this without the first step and then instead had a
final patch that only inserts a single

    #define NO_THE_INDEX_COMPATIBILITY_MACROS

at the beginning of dir.c once everybody in dir.c loses the
reference to all "cache" macros at the end, if I were doing this
series, but it is a personal taste.  

The resulting dir.c does not even refer to the_index, which is very
nice.

Thanks.

> Brandon Williams (14):
>   dir: stop using the index compatibility macros
>   dir: convert read_skip_worktree_file_from_index to take an index
>   dir: convert directory_exists_in_index to take index
>   dir: convert get_dtype to take index
>   dir: convert dir_add* to take an index
>   dir: convert last_exclude_matching_from_list to take an index
>   dir: convert is_excluded_from_list to take an index
>   dir: convert add_excludes to take an index
>   dir: convert prep_exclude to take an index
>   dir: convert is_excluded to take an index
>   dir: convert open_cached_dir to take an index
>   dir: convert read_directory_recursive to take an index
>   dir: convert read_directory to take an index
>   dir: convert fill_directory to take an index
>
>  builtin/add.c          |   7 +-
>  builtin/check-ignore.c |   3 +-
>  builtin/clean.c        |   4 +-
>  builtin/grep.c         |   2 +-
>  builtin/ls-files.c     |   4 +-
>  dir.c                  | 200 ++++++++++++++++++++++++++++---------------------
>  dir.h                  |  27 +++++--
>  unpack-trees.c         |  10 +--
>  wt-status.c            |   2 +-
>  9 files changed, 151 insertions(+), 108 deletions(-)
