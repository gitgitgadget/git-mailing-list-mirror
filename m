Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5415F1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 14:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdFHOqb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 10:46:31 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35790 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdFHOqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 10:46:31 -0400
Received: by mail-pg0-f43.google.com with SMTP id k71so16802903pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LdLgfsbuNwRCpp4PnXb0BjGOBD8Ihy5HpaPlTiOkIY=;
        b=pNvFelOJzfaiRJpu8zKTmRTH+LZ80VK9qESOG6dmNWCoVMYt+iZRJDMP33ET+iLOqZ
         ySetmAkdTWxQ0NiFhKGl4Q+qu+X84PcQq+ExOQyyq5DQxHV8VweOydWfgbCzq7/9MGFJ
         ZQPeecBYRodEGsGssQdIoR0iXoKTWcv5b3AziMmKeHmFGVg8+B/jYWzwPFj6Sy9H7DzM
         I7FOGOPYIHCAqsG8RmYbDy9UQgpzjw7s06Kzdeg68q66fyJzOBnem9vSUKHZyHNbbJ3P
         LQigVuXU36lVBjZaCPPdDHBq8T/zKdo9gCL4ovoMkOjNhLCb1EvMcXcMbXYSxR1KYF1h
         Pvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LdLgfsbuNwRCpp4PnXb0BjGOBD8Ihy5HpaPlTiOkIY=;
        b=bTKi+DFY9hYqLlTz+xyNmd43F6yRZExAo/AQCfCjCp5YbNwU96oOLLEq9JAxqhsyXr
         n4MOta9L0tqn2FEAq0wKW2JqjhW8LfqCVvXIDL4czide9jKa5olId4246ID7Kg50T5Nm
         ndMzyCT8R2wF/2i3JAVJDGWzFNv+kmoBWZxs4JYFVfrH3jlaBBgbGNO5adbY0DPU+O+v
         APHQ8IO5n7UM1YJciRDanHlx2dzJ+DlcqTcjkYUJmu+NxarOb85hlG4XTj7+x6oDCBjC
         DyoN9JxOhy9/UJaB6PhQFHKPhQwrfjb7tA1ZOY/biTELiSfPYhvXofUCOIxJGNZ/9u60
         m+aw==
X-Gm-Message-State: AODbwcASohnkRC+kaTL+wu8wg1hvAPGUYYwrOrCLjy/ImnnO+uMjQJA0
        94WGQ7aCKMzuGYqG
X-Received: by 10.84.229.15 with SMTP id b15mr36087590plk.231.1496933190218;
        Thu, 08 Jun 2017 07:46:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id c27sm10360810pfj.107.2017.06.08.07.46.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 07:46:29 -0700 (PDT)
Date:   Thu, 8 Jun 2017 07:46:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the
 worktree's top-level directory
Message-ID: <20170608144628.GH110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de>
 <20170607181333.GD110638@google.com>
 <alpine.DEB.2.21.1.1706081204330.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706081204330.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 7 Jun 2017, Brandon Williams wrote:
> 
> > On 06/07, Johannes Schindelin wrote:
> > > @@ -1668,7 +1668,7 @@ void read_early_config(config_fn_t cb, void *data)
> > >  	 * notably, the current working directory is still the same after the
> > >  	 * call).
> > >  	 */
> > > -	else if (discover_git_directory(&buf))
> > > +	else if (discover_git_directory(&buf, worktree_dir))
> > >  		opts.git_dir = buf.buf;
> > 
> > It feels kind of weird to get back worktree info after calling
> > read_early_config but I understand why you need to get it.
> 
> Yeah. It is awkward. Required for backwards-compatibility, though (and it
> is hard to explain *when* it is needed, and even harder under what
> circumstances it is *not* needed even if there is a worktre).
> 
> > One thing to consider is the 'if' statement not shown here since you
> > aren't adding any worktree information if that branch is taken.
> 
> Right. For lurkers, that `if` statement reads thusly:
> 
> 	if (have_git_dir())
> 		opts.git_dir = get_git_dir();
> 
> > Maybe we can drop the first if statement all together as
> > 'read_early_config' is used before setup is run and it should really
> > only be triggered when setup has been run.
> 
> The `read_early_config()` function is *sometimes* used *after* setup has
> run. Look at `run_builtin()` in git.c:
> 
> 	if (p->option & RUN_SETUP)
> 		prefix = setup_git_directory();
> 	else if (p->option & RUN_SETUP_GENTLY) {
> 		int nongit_ok;
> 		prefix = setup_git_directory_gently(&nongit_ok);
> 	}
> 
> 	if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
> 		use_pager = check_pager_config(p->cmd);
> 

Ah, ok so my comment was incorrect, thanks for pointing this out.

> For builtins having either the RUN_SETUP or the RUN_SETUP_GENTLY flag, we
> do not need to re-discover the .git/ directory at all when checking the
> pager config.
> 
> Back to the worktree_dir variable.
> 
> I think part of the confusion here is that it may be left alone even when
> there is a worktree. For example, if we are already in the top-level
> directory. Or if the worktree somehow points to a different directory than
> the one containing the .git/ directory.
> 
> Therefore, I renamed this variable to `cdup_dir` to reflect the fact that
> it is only touched if Git determines that it is in a subdirectory of the
> directory containing the .git/ directory.

Ok, maybe I'm just not following but just from reading the variable name I can't
really understand what 'cdup_dir' means.

> 
> Ciao,
> Dscho

-- 
Brandon Williams
