Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34ABF20954
	for <e@80x24.org>; Tue, 21 Nov 2017 08:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdKUIRO (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 03:17:14 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:32792 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdKUIRN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 03:17:13 -0500
Received: by mail-it0-f54.google.com with SMTP id o130so6500761itg.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 00:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UKL4FMEDw6FoQT4TL90Jj0Ne0Drff9TiTr3cfsT8Bnc=;
        b=GVIctuCfOSKfhZLPqhD/t/GFCYlhaDuI5AmCLhhNAJdpr/a0qZAxJ2KbPJKCgdgHGS
         g9IfM179cuOt3a97TX+sqFWVfiCPdIDJzTH8fnRVs22re96F4QlmXEWR0pmL3uExjl94
         IcL/ft8Yr7G9h3U/vovJWyOSfsVRetKDSNNvtQc1HJxwfi902Ltzl9ZTe+Mwoer3WcS3
         7giZ5Wb5+DVPuP6bIzAPRn6fFX3iqOLJaNKvkTwGazKjJGRMZS2wirjjVKhjrvWxQ+Xc
         AaJkYkG1vcPWWPUM8sb1chtN3aIjEJOFW4cdr7FzN2/DM4qmXCxGvs1cKmh/uM5j3bIO
         KlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UKL4FMEDw6FoQT4TL90Jj0Ne0Drff9TiTr3cfsT8Bnc=;
        b=ULBAyzsWSBegoUKf9QXojSU1gLy1pMSgjS1UzrqHUDG9yuCK8Gcc4spd0YClWFpWv2
         ANGDp3x9XfM2kmN12lmZHG5RMaHbDSAR3mOksjZBVDHo1/D9pPo0F7cLJV22YTOXRC8I
         dOP8O5iwfrWZYkkhsdqzmfgi+Z3thlFskz45qC2b5c0RoMx9o6KcS62/ZK29UZJyPVsn
         HINAltWaFEWRTr7ayhJBrS9j/m781eE6hGLJ6vsoNduzvwQAMYKPQd0KQLKeRog0X3lR
         RFsqoQwUrXCJUB0NK6x1y6IIL6cibdwTtICENb4nbNuSCtQ3KiH1paSQzCVG00ITy4CC
         JWDg==
X-Gm-Message-State: AJaThX4mqDmND1qBSx40R/y1iVCxtRNYqSAqWe5j+y5x9Yr5kMpPWVrL
        qHbbIXg3wamzkdMST9HiXxqJeaaQ55UJI0pURdY=
X-Google-Smtp-Source: AGs4zMb1HMqCajUaO8nurLhrSHn/2HV01VW0rubqBNq8F5B7LrspqSp5GYiekId322wqXipHaPMsgPrRR95QIdKsa7w=
X-Received: by 10.36.192.2 with SMTP id u2mr840231itf.119.1511252232367; Tue,
 21 Nov 2017 00:17:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Tue, 21 Nov 2017 00:17:11 -0800 (PST)
In-Reply-To: <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
 <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com> <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Nov 2017 09:17:11 +0100
Message-ID: <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 33
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Yubin Ruan <ablacktshirt@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 2:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> That said, I believe that the gitattributes(5) manpage does an okay
> job of covering this and that that thread came to a clear conclusion:
>
>   https://public-inbox.org/git/20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com/
>
> I commented at [1] that I found the conclusion of the rev news entry
> misleading and confusing but it doesn't appear that there is anything
> I can do about that.

Well, you could have provided a pull request or otherwise suggested
what you think would be a better conclusion for the article and why.

If you just say that the above email is the conclusion, when it seems
to me that another email from someone else is also a conclusion with a
quite different outcome, it does not help much come to an agreement
about what should be reported as the conclusion of the thread.

> It's disappointing because if there is something
> that was not covered in that thread, then it would be good to revive
> it so we can improve the program's behavior or docs, but I wasn't able
> to find out what was missed.

Perhaps nothing was missed, but as the issue is complex, it is just
difficult to explain and summarize it in a good way.
