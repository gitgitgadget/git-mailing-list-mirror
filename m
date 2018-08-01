Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501BD1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbeHBAWs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:22:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40496 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeHBAWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:22:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so100847pgp.7
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l3SPl2yL+fhRp7D6vma6rkCJO4V7PLe+z0+P1ugXNFM=;
        b=R6eTbirQsXAXypuMBPAIKaEYre5lVUJzRqOxuyYAIXH7VydVaPPsvm4LBq0dpKoGqa
         dIXAJW3BbIDVBWqIxjqL9DsH+v4sVbNIuSLQvLkwcDnWtDee0tdiqNk3spgH+YHP6NL4
         bkRwmxLLh5bBN6Tw5C+X8EzB7AAIfp+q47FzbWv844yXOeFuwiPPisGt5hsZBRn77IQI
         hF5QpeJvG8u6NrB0xvYxmdjq8y0NracuL/W1boaF6Zhr/sg6rhVErlNwmyCZRD7Dbq+z
         fFbqhlo7ebdKM2QGI6wepDkR0SyDfLf73qbSG+qnAXJMR1kpdr+wdwegpzAhj6LtuT1K
         JyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3SPl2yL+fhRp7D6vma6rkCJO4V7PLe+z0+P1ugXNFM=;
        b=L7o97M9bvT0qBOlk0pXt7suGr6v8vaya/ITptEm4H6iZxT8dxL6Br9gufemqMP1bjZ
         upeTJmAhHUUUWzUrv3dlCSPJBLmHQooNLlkD4NMC8PG0fYtjrKg6YcD9XKF+mbW+RD8i
         aCIYS7klGocEvuadjp3EEbzfbMXzWThdCs7t1HrlAaGQk3Oye0P+g2mh40ry+6qmggR7
         Lvebmxb87iOvZBp/OzSH6P5GRGwCtJOZ8E/oS3U0mqgwDawGCpNLZHgOzXlru+T83aOy
         7Sb4x6/fBU51PT0N47Qo1Vg6aKQLl6PYpeMv3HEiy4iOP1VtOId8tsggLO6sGVlFXk7r
         LR2Q==
X-Gm-Message-State: AOUpUlEYdwJ23vYjh9yDa5sco6TEvq4GHW4FWYk9Y+VjRoNWaB4B+Ipf
        wx1eXXAuHz31krNb+R6Vz/A=
X-Google-Smtp-Source: AAOMgpdncmlJON93QaZk8+SLiXwVZSajEkIAL19I0+9hoQja/1vTK7yEnlzsg2ZpJB2EvMeJUgKyOA==
X-Received: by 2002:a63:144b:: with SMTP id 11-v6mr206089pgu.219.1533162886965;
        Wed, 01 Aug 2018 15:34:46 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e8-v6sm118100pgi.24.2018.08.01.15.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:34:46 -0700 (PDT)
Date:   Wed, 1 Aug 2018 15:34:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: Fetch on submodule update
Message-ID: <20180801223439.GA189024@aiede.svl.corp.google.com>
References: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert Dailey wrote:

> Problem: I want to avoid recursively fetching submodules when I run a
> `fetch` command, and instead defer that operation to the next
> `submodule update`. Essentially I want `fetch.recurseSubmodules` to be
> `false`, and `get submodule update` to do exactly what it does with
> the `--remote` option, but still use the SHA1 of the submodule instead
> of updating to the tip of the specified branch in the git modules
> config.
>
> I hope that makes sense. The reason for this ask is to
> improve/streamline workflow in parent repositories. There are cases
> where I want to quickly fetch only the parent repository, even if a
> submodule changes, to perform some changes that do not require the
> submodule itself (yet). Then at a later time, do `submodule update`
> and have it automatically fetch when the SHA1 it's updating to does
> not exist (because the former fetch operation for the submodule was
> skipped). For my case, it's very slow to wait on submodules to
> recursively fetch when I only wanted to fetch the parent repo for the
> specific task I plan to do.
>
> Is this possible right now through some variation of configuration?

Can you say more about the overall workflow?  This seems quite different
from what we've been designing --recurse-submodules around:

- avoiding the end user ever having to use the "git submodule" command,
  except to add, remove, or reconfigure submodules

- treating the whole codebase as something like one project, so that
  "git checkout --recurse-submodules <commit>" always checks out the
  same state

More details about the application would help with better
understanding whether it can fit into this framework, or whether it's
a case where you'd want to set "submodule.recurse" to false to have
more manual control.

Thanks and hope that helps,
Jonathan
