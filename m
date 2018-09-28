Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625461F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeI2BwD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:52:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44323 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI2BwD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:52:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id t11-v6so9100066edq.11
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UymRZn6VEWe0MxgGQYQwDVclB4ioPaqSHW1vXK3Eycg=;
        b=Vtjw6Ym3mDd3vaHqOfrjXtBiIwgGRCFsU4dNnuMWwUSGuwYKezTQCvajNnXr3W7Qi2
         Gd6/WnWPnSM/aWScCwrMmV7fgADrQEOZT0uBLTVNRqDeSHWMlD645wzyNob8+bZJLF/b
         /AbssMZBrgoLp4766R9wGVOy5i+DX8ifeIvN3m0k+HlHCF6qYj/JCX5H+9AaXBgiZUCL
         U4O6SyNct618qB+EoZfeXIBNPm/xIQpG6d1qCYuyK1DSKoVIoNR0FJT/xkEoH3ChgxaN
         +3dg/ApCBn+u46jhW+UpyhvWpKc4OmRxcUkNk8SbM9t6yXeI4viAlkYQXCNpgOrGJC8c
         ZTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UymRZn6VEWe0MxgGQYQwDVclB4ioPaqSHW1vXK3Eycg=;
        b=o1RCc2UjG5K+O8WCLxNP6/ldSaKMIuCUPwB1iRV4FHP8ZPWwv2rrdV0Ef6iFRtc1w7
         feMxWEHP1cw6ypfKjaN7dcRjGIlQyC9KgxRWQp2rzjk/lr8uBLTYnXXqnUBSlskRMiy+
         aganU3QsrH/i/rvvMJ4DkBrepbw0ERytdnvDGizOgpUqFoWp46XqmIPGbt7oixJj4H1l
         SDdTOiaGPV27d+Pk1T+yFmebjSgUT2i/tt7Vo2J99ZuoMlecVQgeyq9tXn7NLVr9LvZG
         Xr51XBe33azuDR8s/734tsNMpUfjGNbPEdWeZ+SKw0CjvP/BUMGhHMlyDvCMw1kUWlf5
         jJBw==
X-Gm-Message-State: ABuFfogaClnVlzSS4uhs/xDLzkr/wMp08KEB5wHw/3zrwiIRvBUkif1f
        Qv+9mCkprgmGyZNuWSDHDhhbYO7o
X-Google-Smtp-Source: ACcGV63AlwFORreVc3a2O0aN1Y53u9mDrChyW6S0RqbP1rdKDPBrRv53TzDeYb3DyDXVF/gb9LxBbg==
X-Received: by 2002:a17:906:c348:: with SMTP id ci8-v6mr3894970ejb.147.1538162808781;
        Fri, 28 Sep 2018 12:26:48 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id r44-v6sm4010369edd.87.2018.09.28.12.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 12:26:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] FYI / RFC: submodules: introduce repo-like workflow
References: <20180927221603.148025-1-sbeller@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927221603.148025-1-sbeller@google.com>
Date:   Fri, 28 Sep 2018 21:26:47 +0200
Message-ID: <87h8i9ift4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Stefan Beller wrote:

> Internally we have rolled out this as an experiment for
> "submodules replacing the repo tool[1]". The repo tool is described as:
>
>     Repo unifies Git repositories when necessary, performs uploads to the
>     Gerrit revision control system, and automates parts of the Android
>     development workflow. Repo is not meant to replace Git, only to make
>     it easier to work with Git in the context of Android. The repo command
>     is an executable Python script that you can put anywhere in your path.
>
>     In working with the Android source files, you use Repo for
>     across-network operations. For example, with a single Repo command you
>     can download files from multiple repositories into your local working
>     directory.
>
>     In most situations, you can use Git instead of Repo, or mix Repo and
>     Git commands to form complex commands.
>
> [1] https://source.android.com/setup/develop/

Some questions just out of curiosity, not for this patch in particular:

Those docs seem to describe the situation without this patch, with this
patch is the repo tool fully replaced?

How are you planning to migrate from repo to this on a repository-data
basis, does gerrit also populate .gitmodules files appropriately, which
your clone --recurse-submodules will pick up, but repo will just ignore,
so you can use the two in parallel?

Now "repo init -u" takes a URL to a manifest of repositories to stitch
together, I've understood from past conversations (but am not sure) that
this is used e.g. by downstream Android vendors so they can use what
Google's using + whatever they have in-house, i.e. make the manifest the
set of open source repos plus some (e.g. drivers specific to their
device). How is that sort of workflow going to work where you
(presumably) have do that via .gitmodules + commit entries in trees?
They run their own Gerrit install with some magic to sync back & forth?

I assume that now the recursive "checkout" relies on all the origin/HEAD
symbolic refs pointing to "master", but how is this going to deal with
incorporating a repo whose main branch has a different name?
E.g. "trunk" or "blead"? Perhaps some interaction with
checkout.defaultRemote + submodule.<name>.branch=<NAME> could make "git
checkout :mainbranch" DWYM.

> * Fetching changes ("repo sync") needs to fetch all repositories, as there
>   is no central place that tracks what has changed. In a superproject
>   git fetch can determine which submodules need fetching.  In Androids
>   case the daily change is only in a few repositories (think 10s), so
>   migrating to a superproject would save an order of magnitude in fetch
>   traffic for daily updates of developers.

Interesting that in all this time with the reliance on a central server
repo wasn't already asking some custom API "what repos changed since xyz
time" to narrow that down, but hey, .gitmodules + commit entries in
trees will do it for you.

> * Sometimes when the dependencies are not on a clear repository boundary
>   one would like to have git-bisect available across the different
>   repositories, which repo cannot provide due to its design.

I assume that you're not upgrading independently to e.g. every single
linux commit, just stable releases, so does bisecting deal with knowing
that e.g. a breakage occurred when linux.git was updated from v4.10 to
v4.12, and then to go within the repo itself and bisect from there, or
is that done manually?
