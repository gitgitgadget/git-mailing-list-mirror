Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7DF1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 19:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeKVFqA (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 00:46:00 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:42363 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeKVFp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:58 -0500
Received: by mail-lf1-f46.google.com with SMTP id l10so4799082lfh.9
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZhScoViksa5lPLNLYBT0INLOhMnzXUxR75FC0dM9rfY=;
        b=RLdKOoN4hGOtQx7b/MLM/qoGxPRBvo7nY9ELlgVSwPLLh/bIgSIKTeO7asok3cjyKP
         wEm4UtWt2Zy9ffSGISNPJe9SAE5MG9NZSfO1+fsFhdPSOP7NvN2GlBJoAGrYFHUyF2XT
         03sT1YeO9rKYn2s+bhhyMSx3qTBYrTtXCgVznsODKHcGvxOuHHyhrtTDyCamxT5Y0qAD
         gsQoqIgNXF0Lx0PcX95Ppnv4GfKB3XnoKZ9NopXd3poi6hZ5jZEiYzYVOCmWJUhmxMto
         ZCLnCeZ5kHSfrHTw3wnA2wBSwEkP8r4U7tF3aoxYuE56C4WohQerLNzvmA86aL3iVd0l
         aLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZhScoViksa5lPLNLYBT0INLOhMnzXUxR75FC0dM9rfY=;
        b=ljtu2IPdJHvuWOf+vPGI+hAB2DqOtgMIY5H+s3hOJKLoEQJuJ4uJxmqo7v7r62COQ2
         vDtYqoERJ+fuvnRHu7TCrLBGyndx7WMqqqU4BqP5BY30CNE3qJPvsbt+IsMYLBRMr7AE
         wuPWPOgFhz94CO/tltXs9aM5+4oswVJ2TS88C3VECBjFoorSm9tCPQobRFdI5teHBJe0
         /PeCqvImNmXdo5Ht3lWO3ivGXWqgnjpRt1rhkn/VgNUVVMVk37gtSnGril/rg0qnqQpm
         1kr+L+r6Q58pmFsEoGoP2TaXh6+O22AM0ga0WuEM9DY34f5+qq7CrjanhdIMXeOYKpAc
         scGw==
X-Gm-Message-State: AGRZ1gJZyzLpQ0JjViyK4CMuUayj/QNBgls276SZ5EOavm1oMg9/xjyA
        F+CsMo07yu+7L3iogh6qigNgZuziW/qHC7IqmdNO+g==
X-Google-Smtp-Source: AJdET5dInuyYIKXTR9XcVuZytEu4nUo8hNb4VhdyS5WeqHbWpFjbFYSKraEPoqwm2MPArDbE/pqMU9WJmucRRfWxWj8=
X-Received: by 2002:a19:48d0:: with SMTP id v199mr4789545lfa.104.1542827423182;
 Wed, 21 Nov 2018 11:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <87r2fm1hey.fsf@evledraar.gmail.com>
 <20181120011841.GB62243@google.com> <87r2fgyth8.fsf@evledraar.gmail.com>
 <CAPL8Zis6Jz3=Jb0JxuSyHczYQrrrqP3JGiov1ZuH2A_0x=dpVQ@mail.gmail.com>
 <20181120220626.GB149929@google.com> <CAPL8ZitZMSOLRZ3pQW_9qatdTPhZ69fG1A=zRk1QVLARAawiuQ@mail.gmail.com>
 <20181121013326.GF149929@google.com>
In-Reply-To: <20181121013326.GF149929@google.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Wed, 21 Nov 2018 11:10:10 -0800
Message-ID: <CAPL8ZitRThJmqyvvf7-Cw=aSmPMcpqr8wvFVeJ3tfGY5feFH9g@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   I don't have a strong opinion about whether this would go in the
> design doc.  I suppose the doc could have an "implementation plan"
> section describing temporary stopping points on the way to the final
> result, but it's not necessary to include that.

As long as this is something I'm just doing for fun and nobody needs
to coordinate anything with me, I was planning to just document the
endpoint and then work on whatever seems interesting at any given
moment. Of course, if I found a job/team that would let me do this as
my day job, I'd be more willing to commit to deliverables.

  - Stefan
On Tue, Nov 20, 2018 at 5:33 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Stefan Xenos wrote:
> > Jonathan Nieder wrote:
>
> >> putting it in the commit message is a way to
> >> experiment with the workflow without changing the object format
> >
> > As long as we're talking about a temporary state of affairs for users
> > that have opted in, and we're explicit about the fact that future
> > versions of git won't understand the change graphs that are produced
> > during that temporary state of affairs, I'm fine with using the commit
> > message. We can move it to the header prior to enabling the feature by
> > default.
>
> Yay!  I think that addresses both my and =C3=86var's concerns.  Also, if
> you run into an issue that requires changing the object format
> earlier, that's fine and we can handle the situation when it comes.
>
> I don't have a strong opinion about whether this would go in the
> design doc.  I suppose the doc could have an "implementation plan"
> section describing temporary stopping points on the way to the final
> result, but it's not necessary to include that.
>
> Thanks for the quick and thoughtful replies.
>
> Jonathan
