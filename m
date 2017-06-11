Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5281FAED
	for <e@80x24.org>; Sun, 11 Jun 2017 00:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdFKAnf (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 20:43:35 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33310 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdFKAnd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 20:43:33 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so35794332pgc.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 17:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f++SdPZlxkCRGHhy1KzRdVubBgUGZlja9OMDb6K2Rv0=;
        b=AzKMN3ebXGX3W5l8qzDz/ozdG7XzZ5PzXEvsD3H1823H68E8+kmcLl29wvxPYU/+fI
         H+q1N6iBGhLUhgwmPbAINj5fLzjpizZ8lrjojKYvmAkUu5FP4+Wcb9vAE+oOw+djNEX5
         YKAGuCf2WLU6436+DZpcNfaR1NQ/63DSsCta7yScrdztOIwR0qRq6qulLKBu6NWJz5yB
         77f8U4EQFAcNiY5EQIQLwxqJPZVRAmF0kOZJmyGIboyXkCklt8pBZV4FdF+o6zP+brxP
         UODReNf99FXcLQj5fwHclo5fLMkrU8D3pIRprMj9QsABQLfP4mAhAqzp440Ql1lzY9dq
         8giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f++SdPZlxkCRGHhy1KzRdVubBgUGZlja9OMDb6K2Rv0=;
        b=Z5vsR9OCv2pSKfgBYgYZBpyizIKMluMJbv/aCQ9Ks/EJYO/oJVT1qhsb71Xrj6UA45
         xTO+W/wLE56uWNGlL7TUuMfN3UG/me9fPBuHf7xSOBfYjTG+MUkKgX5DigZ/5tOKFAKa
         n0ztRiwrykUqO1FkZOThFsw+dQ9txW+N+tV2573P1RfHjmb/jO14sufsVwpty2ixFxcD
         vfpN1F/FxkE+B+lJlv4mgBoWYbXCa//JT9BA8ptD5ZOf0ufHVU8WqgYzy91MC+x9xEpw
         Fc1AwfW0gGGkSKLhInahI7QQ1sWN6vf1/KMHVCJOw4HHz+5dAXeuzva3OEkgAbEztYi9
         uW0w==
X-Gm-Message-State: AKS2vOyfsOw29NjRcBIegGhxte4iMGXL2xXDbfmGGxs1G99XFgf0FjZO
        hYXEareF1vb1ultq
X-Received: by 10.98.79.149 with SMTP id f21mr1361585pfj.222.1497141812826;
        Sat, 10 Jun 2017 17:43:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b5f4:f53d:2985:c426])
        by smtp.gmail.com with ESMTPSA id s131sm9951864pgc.61.2017.06.10.17.43.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 17:43:31 -0700 (PDT)
Date:   Sat, 10 Jun 2017 17:43:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170611004329.GE81269@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
 <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
 <20170610061326.2dkdnvpjdq5d7223@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170610061326.2dkdnvpjdq5d7223@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10, Jeff King wrote:
> On Sat, Jun 10, 2017 at 02:07:12AM -0400, Jeff King wrote:
> 
> > I think the repository object has to become a kitchen sink of sorts,
> > because we have tons of global variables representing repo-wide config.
> > ls-files doesn't respect a lot of config, but what should, e.g.:
> > 
> >   git config core.quotepath true
> >   git -C submodule config core.quotepath false
> >   git ls-files --recurse-submodules
> >
> > [...]
> >
> > [1] I wanted to see how Brandon's series behaved for this quotepath
> >     case, but unfortunately I couldn't get it to work in even a simple
> >     case.  :(
> > 
> >       $ git ls-files --recurse-submodules
> >       fatal: index file corrupt
> 
> Ah, this was just hitting the bug mentioned later in the thread. With
> that fix, I can see that it does indeed behave differently than the
> current code:
> 
>   git config core.quotepath true
>   git -C submodule config core.quotepath false
>   (cd submodule &&
>    echo hello >buenos_días &&
>    git add .
>   )
>   git ls-files --recurse-submodules
> 
> shows:
> 
>   submodule/buenos_días
> 
> before the patch series, and:
> 
>   "submodule/buenos_d\303\255as"
> 
> after.
> 
> Like I said, I doubt this is a bug that anybody cares much about, but
> it's hard to know what other repo-specific global-variable usage is
> lurking in low-level code.

I disagree with a few points of what jonathan said (mostly about
removing the config from the repo object, as I like the idea of nothing
knowing about a 'config_set' object) and I think this problem could be
solved in a couple ways.

I don't think that the in-memory global variable 'quotepath' (or
whatever its called) should live in the repository object (I mean it's
already contained in the config) but rather 'quotepath' is specific to
how ls-files handles its output.  So really what should happen is you
pass a pair of objects to the ls-files machinery (or any other command's
machinery) (1) the repository object being operated on and (2) an
options struct which can be configured based on the repository.  So when
recursing you can do something like the following:

  repo_init(submodule, path_to_submodule);
  configure_opts(sub_opts, submodule, super_opts)
  ls_files(submodule, sub_opts);

This eliminates bloating 'struct repository' and would allow you to have
things configured differently in submodules (which is crazy if you ask
me, but people do crazy things).

-- 
Brandon Williams
