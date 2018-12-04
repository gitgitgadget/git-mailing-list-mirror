Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8810E211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLDSWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 13:22:53 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:41722 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 13:22:53 -0500
Received: by mail-io1-f45.google.com with SMTP id s22so14433358ioc.8
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYtBMS3hy/anqeJK+u6iu5CUeDzJ+snN8npTfZnZz0s=;
        b=IeaBXwxK85JPQq0HbTIjEbbDP0Mbzls8I3tEiqgO77SKMBltJ/+4p0Gc5g4KiLPXO3
         ui54N7X3R04rXici0xKD3J8a6joUijdxe6XlqcQoaBLuZndTxRuOPsu4ZlpaHD5xVvf4
         p6cEmxHLYg3XejDUIs77zbbKDgT2Xj3bXeoEjuWd0RlhMKSWGoyrBa4bX4Y6TKXQoi5O
         HDKcmU2dwVHKPTHGJMpvx+8pRm6i7w4gXUS9f42q6Z3KczmvfmXkdcWQicMFQws9F5W+
         vnkrHq434J5L8bts69j0uEyWZmu8Y/1KnSDgVrgYmhfda3gGW+rH/uufGzQcVOvBQ3b2
         QlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYtBMS3hy/anqeJK+u6iu5CUeDzJ+snN8npTfZnZz0s=;
        b=i8eHS7kRaof1qFl8c8qP7sixPuxQxlw5bWuAMEUAMZ9WByd3SKoqm9f2YsjEEe0txW
         ZvQMd970VIUTFG58WwJp/ee3PczWz+LM6xLKKA135evd1LUm03HUORqqj6dL3Y00a9M7
         1yvLgCdvnmH26Mk7+aperCW+3PUi6iguKW4QI1Enpod0/hfwQorEwOlzYzeBq9WcVa0g
         /tC3SzXCTMDrKZ2zQQnGsBerC3Ekqs0wlZ/vrXx0NhvFUIszbvjgbES2HJI3jAakCd4p
         Upejv2hK+BOGqYUGfO61KbinQgcirfgHKJ4LbXO3P45UBDlkj1VsSEmEaDMmfLqCUlnq
         cCQQ==
X-Gm-Message-State: AA+aEWYSZymUVPd2JzD88myEwrt0qoc/S6Z5+9RiHE5mqgYiunViu/pL
        DWeTlNW/qu09NM2jwzgYmHOMkOP+L1BeQRGKQBc=
X-Google-Smtp-Source: AFSGD/XkFZhxXjD8qGaU6i9AjUZ8EfacYbHbi+FtIDviHSdD0wgvuotXYUi5pXSoQTxIm+PL2zS+68frjJC0IyRvDPE=
X-Received: by 2002:a6b:6f15:: with SMTP id k21mr7233067ioc.236.1543947772202;
 Tue, 04 Dec 2018 10:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com>
 <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com> <CABPp-BH=rsLqq4ZRMSUv6n0n5p=aMZs-+VkVT=7P8n4=iUk=-Q@mail.gmail.com>
In-Reply-To: <CABPp-BH=rsLqq4ZRMSUv6n0n5p=aMZs-+VkVT=7P8n4=iUk=-Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Dec 2018 19:22:25 +0100
Message-ID: <CACsJy8BSm945_hqwT3MSW2H_1so1KwrW_p1zz3V-fObwyGNUjw@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 6:45 PM Elijah Newren <newren@gmail.com> wrote:
> > > > - Two more fancy features (the "git checkout --index" being the
> > > >   default mode and the backup log for accidental overwrites) are of
> > > >   course still missing. But they are coming.
> > > >
> > > > I did not go replace "detached HEAD" with "unnamed branch" (or "no
> > > > branch") everywhere because I think a unique term is still good to
> > > > refer to this concept. Or maybe "no branch" is good enough. I dunno.
> > >
> > > I personally like "unnamed branch", but "no branch" would still be
> > > better than "detached HEAD".
> >
> > Haven't really worked on killing the term "detached HEAD" yet. But I
> > noticed the other day that git-branch reports
> >
> > * (HEAD detached from 703266f6e4)
> >
> > and I didn't know how to rephrase that. I guess "unnamed branch from
> > 703266f6e4" is probably good enough but my old-timer brain screams no.
>
> Perhaps "* (On an unnamed branch, at 703266f6e4)"?

This 703266f6e4 is the fork point. Once you start adding more commits
on top of this unnamed branch, I find it hard to define it "at"
703266f6e4 anymore. "forked from 703266f6e4" (or even starting/growing
from...) is probably clearest but also a bit longer.
-- 
Duy
