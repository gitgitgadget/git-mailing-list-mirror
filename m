Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9500B211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeK3CmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:42:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34479 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbeK3CmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:42:17 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so7694385itd.1
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVNsoOmH8MWdmq3U01A33XrqsFYjsmXnXwlzNEcuJ1Q=;
        b=OfC0tyFO5BggsF9rnComZm/d+z+AKfeYSHUof+RugSBSgoIZiUUFEmgeF3LaFBDBuk
         uiVYZroziYhIgdQAb2ziq3zmsZLOJEhz9LBKr+abyGcpDWbgJ7G1PRP8UrQqI1pB2EoD
         Xvc0s2nG0odkHQUGOkmvALG9SfZE71bcBNQupEdbOQ72S79tul1HK3fLDNk9bWBm5Ndr
         x00rpbrJEjlR5ATEF/dUypJnqTTbfgZE9K5NCO5dTB025C25IR9ecqxbVdY7aO3TPYUU
         smMgZTw1WAG/fovo2Kpf+DAo0PF95yX18reOTXHokEWqSZox9OlryBNAV9JQAbZDc4I/
         /f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVNsoOmH8MWdmq3U01A33XrqsFYjsmXnXwlzNEcuJ1Q=;
        b=MsnBRA1Qy2nyofplTu79D9W4hldQeUSbiTfqiu4qo1Z8MBBQ8bg7D1/JMtYmwqAQiV
         eun47NbFt0j6J9kRVrDzTllvevBckenSpKpYYnSFWJjGs87SleQJeSeHwPTwC3el/xsm
         ARBKdBSlsLIxx6ZvKfUvBtJdCixl3Rx54UdYvo8gS0j9qHCBVLDsnBSxLAfFSyoiWj36
         M/Wu7jkfApoil8cbnyRT25T+qKSxjsoChziOIKKGyr8a5CRIoqafXqQj8yu+EjGkc3X5
         f7CpQMbFOrATns18kgV0j3qgX4p+D+Hx9sOVXxXwmSwUh8J5rEOv11A8Pi2W02JoR9A3
         i/TA==
X-Gm-Message-State: AA+aEWYxE/t5LfUyPIlvcjlgOtQsSXLE+w9jOR6W8zwj/+yJtLbBeoT4
        u1VJU5BhslZ7wYxH3NUdf39yIDF/SKSWt6yc0a8=
X-Google-Smtp-Source: AFSGD/VAdDY/GfYoQQGzdlYLhOa+yiV3GlYlOxE7LiW10B5sqAQwDAifLFY6y1bdpc/UcfuzMc9G0e4DAHlXcyHCPek=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr1919168itk.70.1543505791078;
 Thu, 29 Nov 2018 07:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
 <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
 <CAPL8ZivJ+=Y=8pxvs3sJrdxVtkn9xfTA63GeHcr=J0Y2JscOMQ@mail.gmail.com> <xmqqd0qopgpn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0qopgpn.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 16:36:04 +0100
Message-ID: <CACsJy8AQk--qoBBbniJF5uJZdX2P1=y+wBt-RzD28WsH4m2rkQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Xenos <sxenos@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 6:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Xenos <sxenos@google.com> writes:
>
> > Although I have no problem with "switch-branch" as a command name,
> > some alternative names we might consider for switch-branch might be:
> >
> > chbranch
> > swbranch
>
> Please never go in that direction.  So far, we made a conscious
> effort to keep the names of most frequently used subcommand to
> proper words that can be understood by coders (IOW, I expect they
> know what 'grep' is, even though that may not be a 'proper word').
>
> > switch
> > branch change (as a subcommand for the "branch" command)
>
> It is more like moving to the branch to work on.  I think 'switch'
> is something SVN veterans may find familiar.  Both are much better
> than ch/swbranch that are overly cryptic.

OK I'll go with switch-branch and restore-files in the next round. And
perhaps consider just 'switch' and 'restore' later.
-- 
Duy
