Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B971F453
	for <e@80x24.org>; Tue, 23 Oct 2018 09:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeJWRgD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 13:36:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39724 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJWRgC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 13:36:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5-v6so884496eds.6
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KgZ1j9+kQFnlMDvOgNgD5oILiq1sXePQuRec7sPMHRw=;
        b=cDDaDNes8C/1O+V3QEI6Dy15FaY0YwPAHyDtkVpDq12UvhI1bAzVv5OWZWqAbanaR6
         4R6i2jRMBa+kmViLcaneglMxzejgs9mStirhH6MJNEFg+Mp6od9J2sQS2OxWHflC13tF
         RcoIG46DQ1biJfKmcR5LiTfWNPHnw3fqeEaAiJny2/YmaGPrGrnXnNYLGDCKYrnHUori
         3NRS3W1v5HP3p98cZPbqpymjPAKTGVXVckmcxiEwmwSC3MmDiasT4NWhLm3JkMADtLCC
         kXjpMkj9Cqn6rDUsR9DmOwYP7qugufpqmGSVFP8vI9FY/6VTVHxOHrm1Ic3x/bfol6iN
         3kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KgZ1j9+kQFnlMDvOgNgD5oILiq1sXePQuRec7sPMHRw=;
        b=B3Cvgl4pVdnsYcHTvTelwyce7Yp4/E2YYA7vIneyjK2uV6tYee5ZzvoDMir7x4fntv
         80ipnIXBAaRpAvthbz1j2MSQCqcd0Scgn5WRhaEUagN3SRntd18uxIus6ZlbMCwWkgqK
         /tQFRUmpl398GcoQRPU8mpIeC0WtcxozmjzeJaIcBvwdhlk0nLK41lngU9j+uEGVMKn2
         oSMiraAGwD8fgc1IxMrDkmk4ku6Ln4GhkOm/Ok55OuqqcpSox/57DxXRLG8a8zb+mbbC
         FYvPJ//KhcBD3JPwjyY9eWcxwQ42zOdrUqGKdwcQnaq42GRDUnpQHGcaLL7aPLlAt0qu
         N6qw==
X-Gm-Message-State: ABuFfoi+Kk5rdBhxPwXfSiky8dMVwqy0Vx5glLcYZCZZswpGarD6owvf
        EVEjKmEi1F/ZheT7BSem+5Y=
X-Google-Smtp-Source: ACcGV628JN9O5E5E6qlK/aOxioqx6gZ7GtFu+hEhedhN3M6C9VXIXBjQsxQxV2Upje+a+FZShxmNog==
X-Received: by 2002:a50:b4eb:: with SMTP id x40-v6mr16407889edd.12.1540286010633;
        Tue, 23 Oct 2018 02:13:30 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id z15-v6sm223849ejq.60.2018.10.23.02.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:13:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181017164021.15204-3-peartben@gmail.com>
        <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
        <20181017182337.GD28326@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181017182337.GD28326@sigill.intra.peff.net>
Date:   Tue, 23 Oct 2018 11:13:27 +0200
Message-ID: <874lddc9fs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 17 2018, Jeff King wrote:

> On Wed, Oct 17, 2018 at 02:19:59PM -0400, Eric Sunshine wrote:
>
>> On Wed, Oct 17, 2018 at 12:40 PM Ben Peart <peartben@gmail.com> wrote:
>> > Add a reset.quietDefault config setting that sets the default value of the
>> > --quiet flag when running the reset command.  This enables users to change
>> > the default behavior to take advantage of the performance advantages of
>> > avoiding the scan for unstaged changes after reset.  Defaults to false.
>>
>> As with the previous patch, my knee-jerk reaction is that this really
>> feels wrong being tied to --quiet. It's particularly unintuitive.
>>
>> What I _could_ see, and what would feel more natural is if you add a
>> new option (say, --optimize) which is more general, incorporating
>> whatever optimizations become available in the future, not just this
>> one special-case. A side-effect of --optimize is that it implies
>> --quiet, and that is something which can and should be documented.
>
> Heh, I just wrote something very similar elsewhere in the thread. I'm
> still not sure if it's a dumb idea, but at least we can be dumb
> together.

Same here. I'm in general if favor of having the ability to configure
porcelain command-line options, but in this case it seems like it would
be more logical to head for something like:

    core.uiMessaging=[default,exhaustive,lossyButFaster,quiet]

Where default would be our current "exhaustive", and this --quiet case
would be covered by lossyButFaster, but also things like the
"--no-ahead-behind" flag for git-status.

Just on this implementation: The usual idiom for flags as config is
command.flag=xyz, not command.flagDefault=xyz, so this should be
reset.quiet.
