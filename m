Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6C220401
	for <e@80x24.org>; Tue, 13 Jun 2017 05:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdFMFwr (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 01:52:47 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34717 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFMFwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 01:52:47 -0400
Received: by mail-pf0-f173.google.com with SMTP id 15so34601308pfc.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y2nIwXxsYl4h2XDfPB7j9oEc/a/u1DyjWTiHAEVbVIg=;
        b=bFwheSzncdGTOb43hxUaQNwGI2VziEb9gHJH9elHHS0ZDobbg3LlrBZ2Ra4i+glqmb
         dKLG52qRYIz6MYs3OWmREAKwCBpRcyVtSer1lJp9DArAbyr5PXgaJxLO9tZaokC6PYj2
         kO8yA6Kr8vOp2H9oaeLhFMuQRour74K3iYElMTLYOzo2eHVD+MzGa5yOU/1Z2amoEHWR
         wjOSCHr/KDGSyeg8V59tXAsgqv5JxDGNxyBIr/rlYM1VnMyN7Dpu5d9NdfXvdmwiFFEm
         DSNwCT46rvLDPq3ej43bGeqGY2cJ8lfISfN9zknB/ai086BQTNaBq+tiTnVKE9UuIMWj
         gsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2nIwXxsYl4h2XDfPB7j9oEc/a/u1DyjWTiHAEVbVIg=;
        b=Ujzs/kYbsVrgCoxRnCQ7okm+/KILlz3Os8r+7OnQVLzatspisAO+PLVqTv8YvgmbyS
         VMetBTD5VANmnplGg+35QhPAG1CMba5X+MZ5RCPaHtP6yu3ra68ud9wimSMJXOAfLsVd
         tj7ZM9uHrgqG4G1Kl0AeQMAm/UXuVwNdIaQeJJCXMJ6/s0eJacs02D1Sn4fxX8sgCXBz
         FK86LwHfrwhWKRcHc7gKqCzv84CYT46uCJw5LjsY4aLYhkA8/AtfrTGtG3od0vTgZEVW
         x91EblGIJVbjl+hV4djhPGJKGLHaC6OUp5JXEZL1mvJfPCbkvkgwzrZ0G1C5iu6Ou7pn
         NyMw==
X-Gm-Message-State: AODbwcD7vxLCqAr76sGa/hCPD2h1399helBgy8ArYdQ95NT6kgdmBnoE
        Pro+OMxvfG+lJNDx
X-Received: by 10.84.178.4 with SMTP id y4mr61537947plb.158.1497333166106;
        Mon, 12 Jun 2017 22:52:46 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id g23sm22673229pfj.131.2017.06.12.22.52.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 22:52:45 -0700 (PDT)
Date:   Mon, 12 Jun 2017 22:52:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613055243.GI154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613013817.GE133952@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12, Jonathan Nieder wrote:
> Hi again,
> 
> Brandon Williams wrote:
> > On 06/12, Jonathan Nieder wrote:
> 
> >> Alternatively, could this patch rename git_config_with_options?  That
> >> way any other patch in flight that calls git_config_with_options would
> >> conflict with this patch, giving us an opportunity to make sure it
> >> also sets git_dir.  As another nice side benefit it would make it easy
> >> for someone reading the patch to verify it didn't miss any callers.
> [...]
> > And I don't know if I agree with renaming a function just to rename it.
> 
> I forgot to say: another way to accomplish the same thing can be to
> reorder the function's arguments.  The relevant thing is to make code
> that calls the function without being aware of the new requirements
> fail to compile.
> 
> [...]
> >> Brandon Williams wrote:
> 
> >>>  	opts.respect_includes = 1;
> >>> +	if (have_git_dir())
> >>> +		opts.git_dir = get_git_common_dir();
> >>
> >> curious: Why get_git_common_dir() instead of get_git_dir()?
> >
> > Needs to be commondir since the config is stored in the common git
> > directory and not a per worktree git directory.
> 
> *puzzled* Why wasn't this needed before, then?  The rest of the patch
> should result in no functional change, but this part seems different.

there is no functional change, this is what always happened.
git_path("config") will replace gitdir with commondir under the hood.

> 
> Please add some explanation to the commit message.
> 
> Thanks,
> Jonathan

-- 
Brandon Williams
