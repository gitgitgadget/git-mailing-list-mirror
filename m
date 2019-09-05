Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6597A1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbfIETBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:01:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39831 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfIETBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:01:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12so4331873wmj.4
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebDxXi9tWZnceiI0g4zfeGXz/Sld6Bxduqqc80E3RbE=;
        b=rUZliXDuaU5AAFgVXpew3WnbUbADhkUXdQxtR1+pBSfJ/DePdnU8123WdAK8ZYt1J8
         HMCYw0+Ith3dM1UIr3XTk4ToAV+Xwdb0wN5qZmJHzu636xsd9h4USY3v6QCHtosgO2Vq
         MyG3qDWeVTLtOz7aLEaxA2foC9dD6IRmKgvR0D/ZY2xdXnhYi0eqXLg/zt9MIq/2hRCH
         VRku6MAmHiCalnrkf308Q7kZHUxrCAor37hqgQUqLuqZmLtqDs0gWch3vw7iG3QLgJ6g
         D6WnwwdYJ0Op5gMEISoHsB9B32nYZIY1Jefs+IRL160Gujc0rRVRZ2qNi1h4Q1IOfniX
         ILfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebDxXi9tWZnceiI0g4zfeGXz/Sld6Bxduqqc80E3RbE=;
        b=tzLnTzXO9lzif8RAKvEm5OAUFsA3pqWi4MW0X7jEqbrG6cwuQaPt5PvN+rnQuNQewg
         Pw9q7p6aRAR4unUjKPuQuZgUQ8ithocfy+Em1hKncbZHyHode7XKxVArSmwro+/zv7dZ
         d0AoqGnu/PYn36jOQAEf+Vd5DR15/Pr5fVKjI8HnsQp5KP4EsCDqPZ9nq96UIDCFi4P9
         V3F6q29LY0hvIDnjaQVH6tvSDmVKqV4jDaQKAmhfOWoqBf/P25R69XTwGTrjt4ovEs56
         moZRc0NcoJ8SUpSShKd4IFcP+mcNAZWccUp3dyUOUKZ5Eai7DVasVvI4J6Yfvez77PSm
         lR2A==
X-Gm-Message-State: APjAAAUggoPIt2kyk3IyrdFR9iJuO39VLq0GmCWX25GgTxpDBRlaRv4M
        OG4Q7kdyavHURdboQM0EbsrYahgu
X-Google-Smtp-Source: APXvYqwKPc4LeevUQqpeDlMPQqk+6och/c6V84ZAtmj6VoQwbXya2GOWtXwTTiw6J/XPIs/aA60MqQ==
X-Received: by 2002:a1c:7d03:: with SMTP id y3mr4052314wmc.71.1567710093108;
        Thu, 05 Sep 2019 12:01:33 -0700 (PDT)
Received: from szeder.dev (x4db65166.dyn.telefonica.de. [77.182.81.102])
        by smtp.gmail.com with ESMTPSA id b1sm3837862wmj.4.2019.09.05.12.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 12:01:32 -0700 (PDT)
Date:   Thu, 5 Sep 2019 21:01:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [RFC PATCH v2 00/12] Fix some git clean issues
Message-ID: <20190905190126.GA32087@szeder.dev>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 08:47:23AM -0700, Elijah Newren wrote:
> This patch series fixes a few issues with git-clean:

>   * Failure to preserve both tracked and untracked files within a nested
>     Git repository reported a few weeks ago by SZEDER[3].

Wow, I didn't expect a 12 patch series to fix that issue...
Thanks.

> Elijah Newren (12):
>   t7300: Add some testcases showing failure to clean specified pathspecs
>   dir: fix typo in comment
>   dir: fix off-by-one error in match_pathspec_item
>   dir: Directories should be checked for matching pathspecs too
>   dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule
>     case
>   dir: If our pathspec might match files under a dir, recurse into it

Nit: no capital letters after the '<area>:' prefix.

>   dir: add commentary explaining match_pathspec_item's return value
>   git-clean.txt: do not claim we will delete files with -n/--dry-run
>   clean: disambiguate the definition of -d
>   clean: avoid removing untracked files in a nested git repository
>   clean: rewrap overly long line
>   clean: fix theoretical path corruption
> 
>  Documentation/git-clean.txt | 16 +++++-----
>  builtin/clean.c             | 17 ++++++++--
>  dir.c                       | 63 +++++++++++++++++++++++++++----------
>  dir.h                       |  8 +++--
>  t/t7300-clean.sh            | 44 +++++++++++++++++++++++---
>  5 files changed, 114 insertions(+), 34 deletions(-)
> 
> -- 
> 2.22.1.11.g45a39ee867
> 
