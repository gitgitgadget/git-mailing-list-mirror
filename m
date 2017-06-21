Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C0C20401
	for <e@80x24.org>; Wed, 21 Jun 2017 23:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdFUXJP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 19:09:15 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35402 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdFUXJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 19:09:14 -0400
Received: by mail-pf0-f170.google.com with SMTP id c73so10824pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a0k9xkfGGehI+CuBuFg2zkFNuQYz8FyesCISCHCvxLs=;
        b=byXxZZdFUSaFZ5CuFT4GmPvbu2hiTsyUEg3xIUSgTOlQFJz+A7C5S6Chn51M9ZanTO
         2ySqoJ2SQYOuLh5NQ1z2eH45QFfGxIYQA9nQtXc1SPms+rFHCOy+l182clWYXfL/1xQr
         KbQ6vnvPQ4KPF5vTKQBFw0QSPoHwzklyQTtpT6jD2IHSllHfioC/gRt393x+bw+03G6O
         jgxqWikCgxHA7g0eFfbABLj3ohDmpyqWw/rWy433P9tu0ievmhabOmxld1QZjtvdniNA
         nkoRWmf0MXkr20vA4P0xUHfN0WbTHnhunt8pyedlmDsFr9S7wJ5Nwd4/26RWOkalgKcN
         RIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a0k9xkfGGehI+CuBuFg2zkFNuQYz8FyesCISCHCvxLs=;
        b=pu7cMsKd+40rwaI1Lu/ryCvWW+IFUYgkLLewEM356ypybI4z/rXFtGI9a/q/uQur8g
         WqQXC3xNjWmIzRPMco2SWfH/+/wL+0JPTYfEpNkyfAn6t0d8X0CCkhYzWUQXMQcdANnC
         Aj3KW10piPFQ41uRs7kXCkUDcKe2R9LaY8XdEz+eWWn27Q4cwgV46SokL8B4fxD37f/1
         XYtZqS0YjLOn62QAbFfaAmfTOI77qlnlooDf/tvP7oCgnxiPG+RP/ymqhp4W6ICC/FAW
         pQbeZFjc1s7jobAPc3TcdD3Hxj0OVhYfWMP7OMBkcqdqFd2cfOTdxtfyxfnyYu3a1wlp
         ERUw==
X-Gm-Message-State: AKS2vOyyjyWMNrxknpGe5WckWX6wup1bZ6IpbYCfE71ATusyLc9lQCbd
        +SPpebq9uib2uUwS
X-Received: by 10.99.160.17 with SMTP id r17mr39263595pge.95.1498086553112;
        Wed, 21 Jun 2017 16:09:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id r5sm35006062pgu.5.2017.06.21.16.09.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 16:09:12 -0700 (PDT)
Date:   Wed, 21 Jun 2017 16:09:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 19/20] repository: enable initialization of submodules
Message-ID: <20170621230910.GI53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-20-bmwill@google.com>
 <20170621160007.4976187d@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621160007.4976187d@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/21, Jonathan Tan wrote:
> On Tue, 20 Jun 2017 12:19:50 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > Introduce 'repo_submodule_init()' which performs initialization of a
> > 'struct repository' as a submodule of another 'struct repository'.
> > 
> > The resulting submodule can be in one of three states:
> > 
> >   1. The submodule is initialized and has a worktree.
> > 
> >   2. The submodule is initialized but does not have a worktree.  This
> >      would occur when the submodule's gitdir is present in the
> >      superproject's 'gitdir/modules/' directory yet the submodule has not
> >      been checked out in superproject's worktree.
> 
> In a recent proposal [1] to update the submodule documentation, an
> "initialized submodule" is one that has a working directory, which seems
> to have a different meaning of "initialized" (to the paragraphs above).
> 
> Or did you mean the "struct repository" is initialized etc.? In which
> case, it does not seem strange to me that a repository is initialized
> but does not have a worktree, since bare repositories are like that too.

Yes "initialization" only refers to the state of the 'struct
repository'.

> 
> [1] https://public-inbox.org/git/20170621173756.4444-1-sbeller@google.com/
> 
> >   3. The submodule remains uninitialized due to an error in the
> >      initialization process or there is no matching submodule at the
> >      provided path in the superproject.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> [snip]
> 
> > +/*
> > + * Initialize 'submodule' as the submodule given by 'path' in parent repository
> > + * 'superproject'.
> > + * Return 0 upon success and a non-zero value upon failure.
> > + */
> > +int repo_submodule_init(struct repository *submodule,
> > +			struct repository *superproject,
> > +			const char *path)
> > +{
> > +	const struct submodule *sub;
> > +	struct strbuf submodule_path = STRBUF_INIT;
> > +	int ret = 0;
> > +
> > +	sub = submodule_from_cache(superproject, null_sha1, path);
> > +	if (!sub) {
> > +		ret = -1;
> > +		goto out;
> > +	}
> > +
> > +	strbuf_repo_worktree_path(&submodule_path, superproject, "%s", path);
> > +
> > +	if (repo_init(submodule, submodule_path.buf, submodule_path.buf)) {
> 
> This works because the 2nd parameter (git_dir) can take in either the
> Git directory itself or its parent, but it does make the call site look
> strange. Would it be a good idea to make it mandatory to specify the Git
> directory? That would make call sites clearer but require more code
> there.

Correct, The idea was to make it easy for callers to initialize
repositories...but you may have convinced me to change that and require
and exact path to the gitdir.  That would actually make the repo_init
code cleaner too.  Originally I was worried that extra boiler plate code
would be needed everytime we wanted to init a submodule, but then I
introduced this funciton so the extra logic would be contained in this
function.

> 
> > +		strbuf_reset(&submodule_path);
> > +		strbuf_repo_git_path(&submodule_path, superproject,
> > +				     "modules/%s", sub->name);
> > +
> > +		if (repo_init(submodule, submodule_path.buf, NULL)) {
> > +			ret = -1;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	submodule->submodule_prefix = xstrfmt("%s%s/",
> > +					      superproject->submodule_prefix ?
> > +					      superproject->submodule_prefix :
> > +					      "", path);
> > +
> > +out:
> > +	strbuf_release(&submodule_path);
> > +	return ret;
> > +}

-- 
Brandon Williams
