Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FE020401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdFUV1U (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:27:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33582 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbdFUV1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:27:17 -0400
Received: by mail-pf0-f174.google.com with SMTP id e7so10897074pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RsD1CY7Sm/wjETpIqpwYJyERaydQwaXCpaJiG77OnJA=;
        b=kR/2W+Te8oSzdC6nqLXaAVbNGuSmOfUxwL2mUd3oOJiXdeM4dxbjm40M2zl1W/0ra8
         7i3smjHyhcGlebsfybZfErj08G/vtsQASzEXSSLzP/cnKVqPpt8nvSHt2VwTLuTW7zQY
         3qQOVBM1eJx5CORyP0Au+tsdF5Ya0OmlldK63Lwmup7u493/Asa7sYq/tnefN5haSFtu
         /DDk+TmRgznPffX05H9bkkVeygxcXsvRLanMqMQnI95syvitTvSygjX28JKUZDUu5Ox7
         wz9vLdVf2ia8qHcQDv3GHCnFonmyw1Szjqyy7rPO7VYuPYPEzoFm5ALYRhjccs8dGzY3
         RF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RsD1CY7Sm/wjETpIqpwYJyERaydQwaXCpaJiG77OnJA=;
        b=PmRv5mI+BBVMrc0SBoM9nVI4Jy93TRaoAJr6oR0p1NbiOQ+PJOVecIJx5RI3VAbyGX
         f2z0wdT0ha1ZhIoeZnTYcUUVtYCvbbGsSIvwjS8jV4sso5yuGFVSReK+ETLD32QJoGz0
         Hyd4p6KM0aoKS+N4qUWZKfnqHM8M1dNkuCVcZ5w38oEVxnsOCTdlQrPpKQxImlrYfrKd
         id3wJFrDU0b+RKaJd1nBDcTecK/ZZqesCzw1wkoKEOW+QmlhsQ/mcCzNFFyfD7t2fqun
         efhcx++GsouJsJF3QRWvnyVzPO5HqCPF0ytufmT/3PDYBgL1GmNuGuaaCDrh8UnbdFVb
         toSg==
X-Gm-Message-State: AKS2vOw0W+oZs5nAbO/cjN2TNQ8s8QXmfxGTEUF1vCBA0L5ARe24vtNo
        DK7RWThx4pDl/kQeGc5wuA==
X-Received: by 10.98.205.194 with SMTP id o185mr38160060pfg.105.1498080431615;
        Wed, 21 Jun 2017 14:27:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id q19sm12060876pfq.86.2017.06.21.14.27.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:27:10 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:27:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 04/20] repository: introduce the repository object
Message-ID: <20170621212709.GC53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-5-bmwill@google.com>
 <CAGZ79kaUiODQm8KsGOAtAoATNW7mci3DRM=RimXXv-6--9NOKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaUiODQm8KsGOAtAoATNW7mci3DRM=RimXXv-6--9NOKw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Stefan Beller wrote:
> On Tue, Jun 20, 2017 at 12:19 PM, Brandon Williams <bmwill@google.com> wrote:
> > Introduce the repository object 'struct repository' which can be used to
> > hold all state pertaining to a git repository.
> >
> > Some of the benefits of object-ifying a repository are:
> >
> >   1. Make the code base more readable and easier to reason about.
> >
> >   2. Allow for working on multiple repositories, specifically
> >      submodules, within the same process.  Currently the process for
> >      working on a submodule involves setting up an argv_array of options
> >      for a particular command and then launching a child process to
> >      execute the command in the context of the submodule.  This is
> >      clunky and can require lots of little hacks in order to ensure
> >      correctness.  Ideally it would be nice to simply pass a repository
> >      and an options struct to a command.
> >
> >   3. Eliminating reliance on global state will make it easier to
> >      enable the use of threading to improve performance.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> > +/*
> > + * Initialize 'repo' based on the provided 'gitdir'.
> > + * Return 0 upon success and a non-zero value upon failure.
> 
> Non zero or negative? The point of the question is if we want to
> ask users of this function to be cautious early on. So in the future,
> do we want to rather see
> 
>     if (repo_init(...))
>         die("you're doomed");
> 
> or rather
> 
>     int x = repo_init(...);
>     if (x < 0)
>         die("you're doomed");
>     else if (x == 1)
>         warning("you're not doomed, but close."\
>              "Not distimming the gostaks.")
>     else
>         ; /* we're fine, carry on with life */
> 
> I guess we can still refactor later, it's just one
> thing to thing about when introducing an API
> that will likely be used a lot down the road.

I'm not sure what we want right now, hence why I left it a little more
vague.  At this point in time all the relevant callers I can think of
(or rather potential callers) don't care about the failure and just want
to know if it succeeded.  I think it would be ok to do a small refactor
at a later time if we really needed to provide the reason for the
failure.  Unless of course someone feels strongly enough that it needs
to be addressed right now.  If we did address it now then we would need
a group of #define's or maybe an enum to describe the failure modes.

> 
> > +struct repository {
> > +       /* Environment */
> > +       /* Path to the git directory */
> > +       char *gitdir;
> > +
> > +       /* Path to the common git directory */
> > +       char *commondir;
> > +
> > +       /* Path to the repository's object store */
> > +       char *objectdir;
> > +
> > +       /* Path to the repository's graft file */
> > +       char *graft_file;
> > +
> > +       /* Path to the current worktree's index file */
> > +       char *index_file;
> > +
> > +       /* Path to the working directory */
> > +       char *worktree;
> > +
> > +       /* Configurations */
> > +       /*
> > +        * Bit used during initialization to indicate if repository state (like
> > +        * the location of the 'objectdir') should be read from the
> > +        * environment.  By default this bit will be set at the begining of
> > +        * 'repo_init()' so that all repositories will ignore the environment.
> > +        * The exception to this is 'the_repository', which doesn't go through
> > +        * the normal 'repo_init()' process.
> > +        */
> > +       unsigned ignore_env:1;
> > +
> > +       /* Indicate if a repository has a different 'commondir' from 'gitdir' */
> > +       unsigned different_commondir:1;
> > +};
> 
> I applaud the effort towards documenting what each variable is
> supposed to contain. But some of them read like
> 
>     /* increments i by one */
>     i++;
> 
> which is considered bad comment style (it doesn't add
> more information, it just wastes a line), so specifically for
> all the "Path to X" comments:
> * Are they absolute path, or relative path?
>   If relative, then relative to what?
> * Can they be NULL? When?
> 
> (* Why do we need so many path?
>     Could one of them be constructed using
>     another and then hardcoding a string relative to it?
>     This question may rather be answered in the commit
>     message)

Thanks for pointing this out.  I'll work a little bit more on the
comments to be more descriptive.  I do think that all field names should
probably be commented though.

-- 
Brandon Williams
