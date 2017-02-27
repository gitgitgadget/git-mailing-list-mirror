Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E146A1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbdB0Szz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:55:55 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34161 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdB0Sze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:55:34 -0500
Received: by mail-pf0-f177.google.com with SMTP id p185so10107381pfb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43Q3BalAY7lR2kFR/4ZimbJlkWYFlaIuzmgJAzwNDpg=;
        b=u8L0OtHec9lOBC0/WNMIsT8WQAVhKRfgcIlGEvFYEoArMawibD3ke8BZ6E9gmXK1S7
         FCdj0mzr8JHIOZWtBLAETYfUn9qhvT0PSaPjfo8VSEGo2kTx7ba2jxRErzEE+JDurS+Q
         3YnxibCZUdrIJpWXxm7lc+8TONLdlRA62S959b3nQmNWOB387PsLmTuNtkEgaGw3m7HS
         du6GUpPhic8b2eMPUTtpygzCGTsNWIt4V8TVujrGhN0apLURiGOtxdO71P+ThKAA2Uo/
         Glj5CWpDzOaPWucZVdqau+fuwcK6s1Z9bIxMi++X7gunoUhuV/QMEscyLXXFrs9IKCK1
         +0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43Q3BalAY7lR2kFR/4ZimbJlkWYFlaIuzmgJAzwNDpg=;
        b=DTTvcDtnZzNyfCaW1RfgQvrYlKbF75GOZinaBBnUmhGLJq7wYBDIbggos4u88Cx9U/
         vdm3DOcM2yCbxkZ7qCH/q6uqJim1vybhze2+r6KzVWJp0NqVvf1ZDzVbAcRmByK1EY9U
         q6dL0IsodT/erOEnPkN7BsPI/aUaXz4Hes7UN/S5YwyrJlxJAK1f4GMa4UN7eSUFQOe9
         OUfcJrhJr0XTQt0m0iitN18YtqYXVk8YS+ZNEIpigVjujz9vk8RW1VRWWj1SMFkr37qT
         qjaIf5Ygzcj2NuJrndh094AdUe319Dd9d50INb2VOIV/LYhy+o5hWVOaCeMu+Lmq+puF
         Q5iA==
X-Gm-Message-State: AMke39kzVn21OQZROA9NTnrOiKXDn0NNJ3aTeTI3VBlVgqHjZBbIc2KZkjHlthHsf363qNhS
X-Received: by 10.98.196.12 with SMTP id y12mr22547485pff.49.1488217938779;
        Mon, 27 Feb 2017 09:52:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:5d0b:b83e:e4b4:f20d])
        by smtp.gmail.com with ESMTPSA id w13sm6102898pgm.27.2017.02.27.09.52.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 09:52:17 -0800 (PST)
Date:   Mon, 27 Feb 2017 09:52:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 0/5] recursing submodules with relative pathspec (grep
 and ls-files)
Message-ID: <20170227175216.GA153455@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/24, Brandon Williams wrote:
> It was discovered that when using the --recurse-submodules flag with `git grep`
> and `git ls-files` and specifying a relative path when not at the root causes
> the child processes spawned to error out with an error like:
> 
> fatal: ..: '..' is outside repository
> 
> While true that ".." is outside the scope of the submodule repository, it
> probably doesn't make much sense to the user who gave that pathspec with
> respect to the superproject.  Since the child processes that are spawned to
> handle the submodules have some context that they are executing underneath a
> superproject (via the 'super_prefix'), they should be able to prevent dying
> under this circumstance.
> 
> This series fixes this bug in both git grep and git ls-files as well as
> correctly formatting the output from submodules to handle the relative paths
> with "..".
> 
> One of the changes made to fix this was to add an additional flag for the
> parse_pathspec() function in order to treat all paths provided as being from
> the root of the repository.  I hesitantly selected the name 'PATHSPEC_FROMROOT'
> but I'm not fond of it since its too similar to the pathspec magic define
> 'PATHSPEC_FROMTOP'.  So I'm open for naming suggestions.
> 
> Brandon Williams (5):
>   grep: illustrate bug when recursing with relative pathspec
>   pathspec: add PATHSPEC_FROMROOT flag
>   grep: fix bug when recuring with relative pathspec
>   ls-files: illustrate bug when recursing with relative pathspec
>   ls-files: fix bug when recuring with relative pathspec
> 
>  builtin/grep.c                         |  8 ++++--
>  builtin/ls-files.c                     |  8 ++++--
>  pathspec.c                             |  2 +-
>  pathspec.h                             |  2 ++
>  t/t3007-ls-files-recurse-submodules.sh | 50 ++++++++++++++++++++++++++++++++++
>  t/t7814-grep-recurse-submodules.sh     | 42 ++++++++++++++++++++++++++++
>  6 files changed, 107 insertions(+), 5 deletions(-)
> 

Turns out that this series doesn't address all of the issues.  This
series also seems to introduce broken behavior when recursing from a
subdirectory.  So I need to think about this problem a little bit more
and reroll.

-- 
Brandon Williams
