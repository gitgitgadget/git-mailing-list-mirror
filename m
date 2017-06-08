Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DA61FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdFHOvD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 10:51:03 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36227 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFHOvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 10:51:02 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so16825707pge.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngWkfjiLCUztVb+CRStw9iIGMhZ5V4914zXQ35LwPFI=;
        b=UkkPeYj7A0OnQtZcoD/R4x3ZvEyAmNAYiV8XDTcSGBfX64dyJgjkTei8wtYituFLtp
         S0DCfveml8UlKd1PA07mSWOBqdJnJTRW+ki8WNrL7lSdlvVDa6hZe3fvTb4ppsP9D1cg
         4k8enqPCWdtKyHTllseUL8SWNNOCpGJnnSXWCL6ttzEovtEuFi1D+ye8mhxHmYdjjxFG
         V2GTPqSLvWuyYQGHQf9mq5uzhW2Cv3JZXzTSGdYkpngzM2QR4gjQglCm1iFZoyZ2pzmm
         WVjoO/Q9mMcjqVQ46Ms2YcWzR9DGtB//TQ1pkg1KcKeSNP4Ge0UKz7dz31FX1RNMSIMz
         my8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngWkfjiLCUztVb+CRStw9iIGMhZ5V4914zXQ35LwPFI=;
        b=FvuFM9XyJUEu+683hEdirTlXvHWxsnHIwWNmxlSMtk7VY4V43ooOF3iteXI5gkNt2t
         uA1TApR1CFK1xzQkGeXp1M/uUjbct4aC1dRRJ8L4h3aiSPjLehYuoSLizjUHiYIJCXWK
         5HgTQZ6OBqDU43LbU/Bvf6WRVUcJbd1K+yqE5vYLJPL2ZBJru3mJVnv3HY1xp4cOEQO1
         sL4nESU4nXwo+7nheXfNwjwu+PbszJ8Z3nltX3HcQVl7t8KVTy0ASPMTEwHZ86m1cDNr
         sXMkfu+25m5FkVaAA7jWr8jG7FIAgm7c2LY0x0DXCiPjLBg4iyRSBRRgzxAhJCgx6ciw
         Qitg==
X-Gm-Message-State: AODbwcCbQMYKG7UHL7NJhyU54keYQHF+eE56NBVr58xXZtRlXKzLFFyQ
        CeqdiLJixzIplQ0A
X-Received: by 10.84.128.68 with SMTP id 62mr35888327pla.184.1496933462064;
        Thu, 08 Jun 2017 07:51:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id z64sm10619083pfd.20.2017.06.08.07.51.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 07:51:01 -0700 (PDT)
Date:   Thu, 8 Jun 2017 07:51:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use the early config machinery to expand aliases
Message-ID: <20170608145100.GJ110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de>
 <20170607182614.GF110638@google.com>
 <alpine.DEB.2.21.1.1706081223130.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706081223130.171564@virtualbox>
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
> > I like seeing chunks of old code being deleted :D
> 
> Me, too. In particular as hacky code as this one. It caused quite a couple
> of gray hairs here.
> 
> > On 06/07, Johannes Schindelin wrote:
> > 
> > > @@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> > >  
> > >  static int handle_alias(int *argcp, const char ***argv)
> > >  {
> > > +	struct strbuf worktree_dir = STRBUF_INIT;
> > >  	int envchanged = 0, ret = 0, saved_errno = errno;
> > >  	int count, option_count;
> > >  	const char **new_argv;
> > >  	const char *alias_command;
> > >  	char *alias_string;
> > > -	int unused_nongit;
> > > -
> > > -	save_env_before_alias();
> > > -	setup_git_directory_gently(&unused_nongit);
> > >  
> > >  	alias_command = (*argv)[0];
> > > -	alias_string = alias_lookup(alias_command, NULL);
> > > +	alias_string = alias_lookup(alias_command, &worktree_dir);
> > >  	if (alias_string) {
> > >  		if (alias_string[0] == '!') {
> > >  			struct child_process child = CHILD_PROCESS_INIT;
> > >  
> > > +			if (worktree_dir.len)
> > > +				setup_git_directory();
> > 
> > So if there is a worktree then we run the setup code explicitly.  I
> > assume that is to ensure that all envvars are setup properly before
> > running the alias.  Just interesting to note that the actual value of
> > worktree_dir is never used, its just used essentially as a boolean
> > indicator of there being a worktree/gitdir/repository.  I'm not
> > suggesting to change from what you have here, its just food for thought.
> 
> Indeed.
> 
> That is what I tried to indicate by this paragraph in the commit message:
> 
> 	Rather than just chdir()ing into the indicated directory in case of an
> 	alias expanding to a shell command, we simply set up the .git/ directory
> 	so that e.g. GIT_PREFIX is set as expected.

I was more commenting on "oh that's what he meant by that" for my own
understanding.  But thanks again for pointing out that you did include a
comment in the commit message reflecting that.

-- 
Brandon Williams
