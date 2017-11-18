Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525CC201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967428AbdKRSMV (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:12:21 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38500 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967398AbdKRSMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:12:19 -0500
Received: by mail-wm0-f42.google.com with SMTP id 128so3313464wmo.3
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c0H6oJctSomnMiKiDMd26zGZDDb9DG7WDIy/LB5t7RA=;
        b=iL1kMy2uYbC0SvDVw6DrP3kuLHFhUw/kEhMOdBSv0Qe/Bh8jt9tebMmMQVJLNbu55c
         a/1LLM5z/IW3MpSIr0+9zjq9nJ1WigIs1Dygik66HdUYSQQRI9TAXh92lMQFbtTt5xdK
         zMtbEfYy9W88sN+6CHr5Xx3MXJIPGWjLG7lSaPLNIKttxELlCfl9TFd1XangfIyAvJpC
         ddp2dX8/UMrHFAjT4Atj4wE85QMqzwgAIyrLyWb3xbuh4SS2aoIdU0fd2/xwx1QBgp56
         S5uDJ4cSg7JQoJ+rZpOpr5zJK/Rwwyxc6olg9njuKBFeBNaI6KYQJjQLmNRZ1nHOjq8A
         DvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0H6oJctSomnMiKiDMd26zGZDDb9DG7WDIy/LB5t7RA=;
        b=sreB80l81VtxxCeQhmr3DPxwnTB2JSL70YVHGEn4gghTMDDaKMnLl2gCHx1QZ+rgTV
         DxjUu344x1j6h5DOFc9xQz2mHTTvUA+bala2GBQw4hf5WQldEt4LTT7WcOGIgULQcX3+
         gxRFVf5gsgjdfD1X1QD9dvH6JvsiGJYdtdwSv7wJPmLgW3K+QsurKpHHwQp0rqrwGpqB
         aYEHlAQkoWTd/T/+n5pjnGg2jrL5Q06NhaVA13vg1eLHT2Kv8Ye9kf0/qIpniqHdRWgO
         dm3t8G10YuLbSw+F+2Cfv9x7V69+4yqf7uSUDImwa8F5ZxWTE4cair+McKVcf60Z4cNl
         GnyQ==
X-Gm-Message-State: AJaThX7KgF01Dqb8mnrB6GPH6bbuod8x9aGmn8X8gHerqqdujgcLuty7
        h9X/a+1bUw+mOixRPaRbPRw=
X-Google-Smtp-Source: AGs4zMYV8gEyQA1gWVD//OPruUbnw4DL0mZMXEi24s7PsBfl9i1RmB4TCRmGC0Bf6Cb0ieDPBQZXlw==
X-Received: by 10.28.126.14 with SMTP id z14mr6062318wmc.121.1511028738250;
        Sat, 18 Nov 2017 10:12:18 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r63sm9534271wmg.13.2017.11.18.10.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 10:12:17 -0800 (PST)
Date:   Sat, 18 Nov 2017 18:13:45 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
Message-ID: <20171118181345.GC32324@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com>
 <20171114084517.GA12097@hank>
 <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
 <CAPig+cTDMvOWW2xLYfvQsOsfBuCOGDJwH_zRDQyxx1vpfkX4tA@mail.gmail.com>
 <20171115085229.GB32324@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115085229.GB32324@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Thomas Gummerer wrote:
> On 11/14, Eric Sunshine wrote:
> > On Tue, Nov 14, 2017 at 3:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > For my own edification...
> > > [...]
> > > git worktree add ../topic
> > >
> > > * Correctly errors out, refusing to create a new branch named "topic",
> > > if "topic" is already a branch.
> > 
> > By the way, there's an additional DWIM that could be done here instead
> > of erroring out. Specifically, for "git worktree add ../topic":
> > 
> > * If branch "topic" exists, check it out (rather than refusing to
> > create a new branch named "topic").
> 
> I think this would be a good improvement either way as I suspect this
> is what users would hope for, and as it currently just dies there are
> less backwards compatibility worries.

While I still think this would be an improvement, after thinking about
it a bit more I think this is somewhat orthogonal to what I'm trying
to achieve with this patch series.  Therefore I didn't implement this
yet, but I'm still thinking of implementing this in a separate topic.

> > * If origin/topic exists, DWIM local "topic" branch into existence.
> > 
> > * Otherwise, create new local branch "topic".
> > 
> > > * Creates a new branch named "topic" if no such local branch exists.
> > >
> > > The desired new DWIMing would change the second bullet point to:
> > >
> > > * If no local branch named "topic" exists, DWIM it from "origin/topic"
> > > if possible, else create a new local branch named "topic".
