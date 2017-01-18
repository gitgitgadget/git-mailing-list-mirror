Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F091F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdARWjU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:39:20 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34214 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdARWjR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:39:17 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so7953703pgg.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCdUk4N9fFGE6dQ8v0UkyGnPTxsA/Ix1c+r+wNmtXRM=;
        b=WWdwOKxvPbsERzLTpPP94UZOsXbKU7hPkgRcPtPYfU87ljqArQdVjSTM1Mc9tClIPd
         Koh+zKXnPhXdFP1ptorVl7LbEmrtKl1XyKSOWM3o0LXXK4tPx2gk7MPgJLQm6rRN+zC7
         +WQ+qyaKh37ArHYE9PmWYqrfPIhscdjh240JyM8/srbxUrrLbSsEOmqN0J1/8btM13M5
         XeLMlocv2LbMJdT3rgNyoBsdCXS8mKP9TMrYgACu7g49rfq6zJwJ1nBH2QM1Z4jJwnrO
         vYCzfxHSV1IcGWYCwXR4dvuR8dyJIzKRqaGUqwk1ykGDUz171V5AKx8cDf0+hZs0s2JC
         WkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCdUk4N9fFGE6dQ8v0UkyGnPTxsA/Ix1c+r+wNmtXRM=;
        b=hwDJZDvSMA0iMtrEy96OZz3tyU4j6CQs3ovPqCLkt0noWddYDJpKJlHTg+Muiaqsts
         VHpEovRJBAQkT2poHpObiO8IWvnRp67lHwSdlXgeh0EiSiM4MP+gdA79Rib9TAK5k/nC
         5Gnj3ABNGb6tR/GfuKHBsPDQY0A7GwHM30tpba/42TBXNHaueqwT+7AE9uvQ2wby2w9n
         Vyb+IiGLLn1O3TuA9eFExaMNdjJhZIxc93nsPqrmFZZ6TbCF0FhcX0sZEUcyRjgCi0Y0
         /jANwi2pJ2FMDJD3H3DFiebGX/jEZ3S1xIgjNXaKmRSUnZSiIUgZu4T9gdvhCnyYolCu
         6N+g==
X-Gm-Message-State: AIkVDXINfdnlJZPL/wvFf1iD0TRw7N2EJrn/DqPvZRJFrXoTtTMtZJKkv020TwnzpkInRNB8
X-Received: by 10.84.206.37 with SMTP id f34mr8490434ple.127.1484779099732;
        Wed, 18 Jan 2017 14:38:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id y6sm3132967pge.16.2017.01.18.14.38.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 14:38:18 -0800 (PST)
Date:   Wed, 18 Jan 2017 14:38:17 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20170118223817.GD10641@google.com>
References: <alpine.DEB.2.20.1611301325210.117539@virtualbox>
 <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612051126320.117539@virtualbox>
 <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612061411000.117539@virtualbox>
 <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net>
 <alpine.DEB.2.20.1612061512190.117539@virtualbox>
 <20161206150955.mvq4ocamaei52bap@sigill.intra.peff.net>
 <CAGZ79kZoy2zSgSEc7kfAZ9tg9_uJxa+_FNFVO8UEDLVK6YDxVg@mail.gmail.com>
 <20161206183527.t6rjkkff7fxv5i5c@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206183527.t6rjkkff7fxv5i5c@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Jeff King wrote:
> On Tue, Dec 06, 2016 at 10:22:21AM -0800, Stefan Beller wrote:
> 
> > >> Maybe even go a step further and say that the config code needs a context
> > >> "object".
> > >
> > > If I were writing git from scratch, I'd consider making a "struct
> > > repository" object. I'm not sure how painful it would be to retro-fit it
> > > at this point.
> > 
> > Would it be possible to introduce "the repo" struct similar to "the index"
> > in cache.h?
> > 
> > From a submodule perspective I would very much welcome this
> > object oriented approach to repositories.
> 
> I think it may be more complicated, because there's some implicit global
> state in "the repo", like where files are relative to our cwd. All of
> those low-level functions would have to start caring about which repo
> we're talking about so they can prefix the appropriate working tree
> path, etc.
> 
> For some operations that would be fine, but there are things that would
> subtly fail for submodules. I'm thinking we'd end up with some code
> state like:
> 
>   /* finding a repo does not modify global state; good */
>   struct repository *repo = repo_discover(".");
> 
>   /* obvious repo-level operations like looking up refs can be done with
>    * a repository object; good */
>   repo_for_each_ref(repo, callback, NULL);
> 
>   /*
>    * "enter" the repo so that we are at the top-level of the working
>    * tree, etc. After this you can actually look at the index without
>    * things breaking.
>    */
>   repo_enter(repo);
> 
> That would be enough to implement a lot of submodule-level stuff, but it
> would break pretty subtly as soon as you asked the submodule about its
> working tree. The solution is to make everything that accesses the
> working tree aware of the idea of a working tree root besides the cwd.
> But that's a pretty invasive change.
> 
> -Peff

Some other challenges would be how to address people setting environment
variables like GIT_DIR that indicate the location of a repositories git
directory, which wouldn't work if you have multiple repos open.

I do agree that having a repo object of some sort would aid in
simplifying submodule operations but may require too many invasive
changes to basic low-level functions.

-- 
Brandon Williams
