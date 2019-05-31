Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36FBC1F462
	for <e@80x24.org>; Fri, 31 May 2019 13:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEaNQa (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 09:16:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33911 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfEaNQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 09:16:29 -0400
Received: by mail-it1-f195.google.com with SMTP id g23so10896037iti.1
        for <git@vger.kernel.org>; Fri, 31 May 2019 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0u3Qs/DizbIfG1CeVQ7Fw3cyf/ofrJTR1cqXdXLzLwM=;
        b=QdgEjdfvP4j5XNzGcxRnunIB5phSQohh/DY7xmbYeQKijja2y0XUCejPW3n75ADKV5
         FaPInF3MQXK3JeCtyJq6TinXlSF3VGkbYA7O6ohnsK8T6QS3neHgI1+coBzr7pNGugLQ
         rnNsKgu1fRBsywS+llwIS12RaQaqdBxse3rsiLjiwZBj5ROcwzM7L2uynREeN3jUQAAC
         ur50nt+4SRnknUAWFH9xXHAO+anl0sNlXHi+reqNX2yVQkNqzU1eD57Oxrxtjy20G8r0
         pJHxnL8b+8wwsp3lhegFTKPQzG5sNV9C+KiLJT/T3S2XpQFSHfjsdFV4aiUtZdzjRirJ
         HZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0u3Qs/DizbIfG1CeVQ7Fw3cyf/ofrJTR1cqXdXLzLwM=;
        b=RbFOS++MMpyM1TwALgmLwcBPKvNs6cLjiTJX6EGG8zuznrywGb00eM9r2zsLYFQmmA
         QoSsMXPxvLBJ/BTd5Rcftkl3kVCfCwgvB8QSC6g8fPtrRqEbiw69llnwwm/AIgavelRj
         Zr1ZqHh9m2cWTD56ExSjl1J7wwxahKdieD0t6VXMoJSwcJnvcyKvZrTILppJpknEDdtD
         Bf48s03jy7JGOKQvry1g2Fncxboo3Z5FuMPRdhzY6rfenoK+M/0A2GPbbWp4ctK+/UBO
         xmqpczYh+m7pIWbTUoGdwSi2o29BFqBfoG6+zhEDFT7u4Tdo8DGUgUSKseYn9+3x6Q7W
         g7Mw==
X-Gm-Message-State: APjAAAXsdThM0Jbx5um5s5mE7du1FaChVfqNO5Q8OG8cmwHw91Ttdriw
        KAW/+FZ8UEXne/twmdlb8Fg=
X-Google-Smtp-Source: APXvYqykLGI1z2aIrKWJVzNhSMO5k3D44ao3TE8wOhZyMX+GWMJYykKfL+ubv4IxvVCQsZsZ2Ijfjg==
X-Received: by 2002:a24:ed7:: with SMTP id 206mr4567915ite.97.1559308588892;
        Fri, 31 May 2019 06:16:28 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id q1sm2004261ios.86.2019.05.31.06.16.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 06:16:27 -0700 (PDT)
Date:   Fri, 31 May 2019 09:16:26 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] config: learn the "onbranch:" includeIf condition
Message-ID: <20190531131626.GA30114@archbookpro.localdomain>
References: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com>
 <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1905311453420.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905311453420.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, May 31, 2019 at 02:58:30PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 30 May 2019, Denton Liu wrote:
> 
> > Currently, if a user wishes to have individual settings per branch, they
> > are required to manually keep track of the settings in their head and
> > manually set the options on the command-line or change the config at
> > each branch.
> >
> > Teach config the "onbranch:" includeIf condition so that it can
> > conditionally include configuration files if the branch is checked out
> > in the current worktree.
> 
> What a coincidence. I actually wished for something like this, to have
> branch-specific aliases.
> 
> However, I would need this to handle patterns (via `wildmatch()`?) rather
> than branch names.

Do you mean that we should be able to match a branch by pattern? So, for
example, if we had

	[includeIf "onbranch:mas*"]

we'd match if we were on "master"?

> 
> > I decided to go ahead and implement the includeIf onbranch semantics for
> > fun. For completeness, I'm sending it to the list but I'm not really
> > sure if this should get merged, since I don't really have a use-case for
> > this, especially if we go the branch-specific format-patch config route.
> >
> > Another thing to note is that this change doesn't completely cover all
> > the use-cases that the branch-specific format-patch does. In particular,
> > if I run
> >
> > 	$ git checkout foo
> > 	$ git format-patch master..bar
> >
> > with the `format.bar.*`, we'd get bar-specific configs, whereas with
> > `includeIf "onbranch:bar"`, we'd fail to include bar-specific configs
> > and, more dangerously, we'd be including foo's configs.
> 
> I actually think that this is fine. "on branch" means that you are on the
> specified branch, not that you merely mention the branch name on the
> command-line (in which case there would be the ambiguity "did the user
> mean `master` or `bar`?").

The reason why I brought this up as a use case was because currently,
when format-patch generates a cover letter, with the above, it'll use
bar's branch description to populate it even if "foo" is checked out. As
a result, when implementing the branch-specific format-patch stuff, I
wanted to make this consistent so that we wouldn't end up in a situation
where the cover letter has the branch's description but is missing its
Cc's.

> 
> Ciao,
> Dscho
