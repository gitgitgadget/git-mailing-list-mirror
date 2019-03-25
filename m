Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A4320248
	for <e@80x24.org>; Mon, 25 Mar 2019 05:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfCYFlt (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 01:41:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45116 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfCYFlt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 01:41:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so4702697pfi.12
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=chryq5PwtidMNKCo+ug7vuqB/BHloF2XBhAbWlGsJJg=;
        b=XZ7q84muR8ri1nMVa2/AsQGGwSpTAl20Yd7M3i2Bwq6G+hE2wi47K040/RMMFbjMUE
         uWdYyvwTiJUEbsWljLYjfE5o7MXbtvGT7kDPkGBifuv3zlQWcxz8vfIOQuPPMsQikN/i
         9Ce5Zq0Qu8GptvgHQcrvFFc75wZm4uov74Zz2AIbdKFmA5lTSEJPTGawlyHnZR/9OrbK
         oOgFWfgUBrCPeEMni1bRAnTEBXlWjT3ywUuh799o4SbmBFKxiawi5/T7qx4VHeDyMGi9
         +zO9EhOqQJdNFjlZvV6uobJky6cmffh4VStSwGQiVvszCuwzfF3vTkQ5utDq18sQMkyC
         +thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=chryq5PwtidMNKCo+ug7vuqB/BHloF2XBhAbWlGsJJg=;
        b=f2PbX+QvYyhbIw+LoIAZ7yCJonEH5s4MgoALxuV5/rRPqRl21Pk7GQaOgeMORsS/aP
         lmTwVvLS5nyFiMrCdwlbbdPJiyHvzgVpipH4EdeHezgm4UGf5gzdiPyRm8tTOh7IMi4f
         nXm88qG11uEZMcPw9AmabEd7VgKa5Ji+TeHvTCHB1x6sx+WHT26C/+mvPmLW70fkg8XQ
         ZHZhvxrO1+pTmOgk4fp13/gZzKbK4tf8BfnypN1TRwWOgT3HnvsdnfKIoyKygRolIo0w
         dbziuf1jksPmHSmafyRm6a767ytwSU1ET4ks98lFdoR/O9HodBx6SRzhjS3gflpiVsb7
         H4ew==
X-Gm-Message-State: APjAAAUZ7IKYw3y2INlqsVpGBYtbEnoYAm7ccFUZMzET+X4sawX/quvw
        hVufJ0QoBzfNnlJzbN0P7qck71uB
X-Google-Smtp-Source: APXvYqyd4dcSF8p3RWDSH284Udob+cVy0Ohvh05bsgF/wiDSe02JHDwUTY25mn90OG9q2uIjuz3B0A==
X-Received: by 2002:a63:3f8b:: with SMTP id m133mr21301832pga.91.1553492508495;
        Sun, 24 Mar 2019 22:41:48 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id d12sm22994561pfh.168.2019.03.24.22.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 22:41:47 -0700 (PDT)
Date:   Sun, 24 Mar 2019 22:41:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
Message-ID: <20190325054145.GA1652@archbookpro.localdomain>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
 <xmqqtvfso1cz.fsf@gitster-ct.c.googlers.com>
 <20190325000618.GB9384@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325000618.GB9384@archbookpro.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 05:06:18PM -0700, Denton Liu wrote:
> Hi Junio,
> 
> On Sun, Mar 24, 2019 at 10:20:28PM +0900, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > 
> > > A common scenario is if a user is working on a topic branch and they
> > > wish to make some changes to intermediate commits or autosquashing, they
> > > would run something such as
> > >
> > > 	git rebase -i --onto master... master
> > >
> > > in order to preserve the merge base. This prevents unnecessary commit
> > > churning.
> > >
> > > Alternatively, a user wishing to test individual commits in a topic
> > > branch without changing anything may run
> > >
> > > 	git rebase -x ./test.sh master... master
> > >
> > > Since rebasing onto the merge base of the branch and the upstream is
> > > such a common case, introduce the --keep-base option as a shortcut.
> > >
> > > This allows us to rewrite the above as
> > >
> > > 	git rebase -i --keep-base master
> > >
> > > and
> > >
> > > 	git rebase -x ./test.sh --keep-base master
> > >
> > > respectively.
> > 
> > I never use the "feature" myself, but I recall that when "git
> > rebase" is run on a branch appropriately prepared, you do not even
> > have to say <upstream> (iow, you type "git rebase<RET>" and rebase
> > on top of @{upstream}).  
> > 
> > Can this new "--keep-base" feature mesh well with it?  When the
> > current branch has forked from origin/master, for example, it would
> > be good if
> > 
> > 	$ git rebase -i --same-base
> > 
> > becomes a usable short-hand for
> > 
> > 	$ git rebase -i --same-base origin/master
> 
> By "--same-base", I am assuming you mistyped and meant to write
> "--keep-base"? If that's the case, I can make it a shorthand.

Sorry, I misunderstood your question. "--keep-base" already has the
shorthand case handled by default.

One caveat is that "--fork-point" is automatically implied if no
upstream is supplied but this behaviour is the same for "--onto" or when
no other options are supplied as well.

I don't use the feature either so I'm not really sure if this behaviour
would be the most sane thing to do.

> Thanks,
> 
> Denton
> 
> > 
> > aka
> > 
> > 	$ git rebase -i --onto $(git merge-base HEAD origin/master) origin/master
> > 
