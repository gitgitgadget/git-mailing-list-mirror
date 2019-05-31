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
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B1F1F462
	for <e@80x24.org>; Fri, 31 May 2019 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEaSow (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:44:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46061 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfEaSow (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 14:44:52 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so9028906ioc.12
        for <git@vger.kernel.org>; Fri, 31 May 2019 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KgRoqgX4/F/sYMx0GuZvzS1ByXxl3dmG+7mqXpPfL8Y=;
        b=Zx1OStIbP5fqpJyHHyhx6SHSFrMBijpCcTJTkvF+2zLVpcQQw40a+y/+oBaB950u/M
         TGoRefd45RiodT+V4/Ol050XmePQEnkm3Uwj7+YSJwy8N4UdIQSqqO+MDWB/Az0/1UH1
         AW0i+tFz7XStHwCtq1sL1V52TySn+LVr9kTAlTA5TRSNLV7F12Q255GsylIZnk5TnxQO
         XinMzERD+vXuJ1BlH0Ncf716N47KjGHrn7qSCic3FN4WXennBtsDQLd55TuD5dn6Ai9y
         mrbtdX1ahRW9eY9eWS3DVJ2PGX4jcIMw5cqLI7P55iKCPpWdQia++T9IK3D3n7MhsMZS
         vLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KgRoqgX4/F/sYMx0GuZvzS1ByXxl3dmG+7mqXpPfL8Y=;
        b=lN4oNd6XQ68fjm79TOcPljXJQz1FElIPEyI53k/sova+uT4xIAHYuqioHeZYV1o8tL
         eDRdzaRtvvUYiZuLYhoWyQBDqJp9Lt82K9Hh26AHN7IFOYkXDVKHzKHJgUHN4zghqd5f
         tSiLjBPzakd78e+NFGCkBjY6nXfawwYE0Jf2cV3ouEjj26PKX1NieXpNdTsv5SiowwUC
         J576VitE/9d9LLm3e8cSs1GhMFn/JPT07342WGI5WTDsP2YVfNZOAr/Sd+sf6oQ8d/BY
         lJcLwlUlsY2Ad4tk3CiumlwQCLVP/POBhbBX6wQtUpvA9Hl+r+RhYDs/R4ItFFdOwQVu
         SZBw==
X-Gm-Message-State: APjAAAWopHM4Z9Nb3P4suLXDzA4cPPWLxPMggTJdOdcxeDfgAHYNLVE3
        gDlhAI3n2zAtr/MymN5m9xg=
X-Google-Smtp-Source: APXvYqz2OtakAyh7Fe3TH7EyhEvY0lx37NbBVbU4NiCAM9KZthFBUldIrm69YgFYtcWtyRuHflfT3Q==
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr2430134iop.168.1559328291612;
        Fri, 31 May 2019 11:44:51 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id k5sm1658749ioj.47.2019.05.31.11.44.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 11:44:50 -0700 (PDT)
Date:   Fri, 31 May 2019 14:44:48 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] config: learn the "onbranch:" includeIf condition
Message-ID: <20190531184448.GA1175@archbookpro.localdomain>
References: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com>
 <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1905311453420.44@tvgsbejvaqbjf.bet>
 <20190531131626.GA30114@archbookpro.localdomain>
 <nycvar.QRO.7.76.6.1905311918510.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1905311918510.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 31, 2019 at 07:23:56PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Fri, 31 May 2019, Denton Liu wrote:
> 
> > On Fri, May 31, 2019 at 02:58:30PM +0200, Johannes Schindelin wrote:
> >
> > > On Thu, 30 May 2019, Denton Liu wrote:
> > >

[...]

> 
> > > > I decided to go ahead and implement the includeIf onbranch semantics
> > > > for fun. For completeness, I'm sending it to the list but I'm not
> > > > really sure if this should get merged, since I don't really have a
> > > > use-case for this, especially if we go the branch-specific
> > > > format-patch config route.
> > > >
> > > > Another thing to note is that this change doesn't completely cover
> > > > all the use-cases that the branch-specific format-patch does. In
> > > > particular, if I run
> > > >
> > > > 	$ git checkout foo
> > > > 	$ git format-patch master..bar
> > > >
> > > > with the `format.bar.*`, we'd get bar-specific configs, whereas with
> > > > `includeIf "onbranch:bar"`, we'd fail to include bar-specific configs
> > > > and, more dangerously, we'd be including foo's configs.
> > >
> > > I actually think that this is fine. "on branch" means that you are on the
> > > specified branch, not that you merely mention the branch name on the
> > > command-line (in which case there would be the ambiguity "did the user
> > > mean `master` or `bar`?").
> >
> > The reason why I brought this up as a use case was because currently,
> > when format-patch generates a cover letter, with the above, it'll use
> > bar's branch description to populate it even if "foo" is checked out. As
> > a result, when implementing the branch-specific format-patch stuff, I
> > wanted to make this consistent so that we wouldn't end up in a situation
> > where the cover letter has the branch's description but is missing its
> > Cc's.
> 
> That strikes me as a different use case than `includeIf`. I could imagine
> that you'd want a setting like `formatpatch.detecttargetbranch = auto` or
> some such that would pick up the `format.bar*` settings if there was *one*
> rev argument, and it was a commit range (or a tip commit), *and* it
> obviously referred to a single target branch.

Correct. For context, upthread I initially implemented the
branch-specific format-patch configs but Ævar suggested that we
implement the onbranch config semantics instead.

So I was just addressing the fact that this patch can't supercede the
branch-specific format-patch stuff since they have different use cases
so the other patchset has to coexist with this one. I'm happy to see
that we're both in agreement about this.

> 
> It's just a scenario that is *very* specific to `git format-patch`.
> 
> For example, I would not, ever, want `git log ..next` to pick up a
> config specific to `next` just because I mentioned a commit range with
> `range` as the tip to start from.

Yeah, I'd never dream of implementing something that gross ;)

> 
> Ciao,
> Dscho
