Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCB1211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 18:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDSkA (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 13:40:00 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:35688 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 13:39:59 -0500
Received: by mail-it1-f169.google.com with SMTP id p197so16066344itp.0
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZYLB+tSM+sDxrsQ5BrYZ6kMp8joeVBTCEDne2EWM7w=;
        b=sOidfscZAuMBLAhvHDugJwrBd9x2PtCB1dZPt9/RBsSFkpbKTEmOdUxXwzl6yHHfUb
         WUAxJvu3UZAko57jgdYEn7oLaqIAQwh0U7o30nhnd51aw3g/9t7kYIvw/gOZR48Wb/Q6
         XhgJx8xeSR8olYo7xlUYBTzv9t9mZTWh8I8nStRw7tIcqkA7L+cWoskJ8R3rjJtUE7yk
         LUaljArUHlhAd5WMAWdGOF/xYCuuwHCXP9x86MF8g4S/R10XmKPyPzmoEkIXvZC+Reyn
         66WqVvcHjLujBFRACO4ghVISXMku6ddW8jfXr9/gmUivkKZZs6LJeiKbP8B8jgW6rzU+
         X3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZYLB+tSM+sDxrsQ5BrYZ6kMp8joeVBTCEDne2EWM7w=;
        b=bES2JqhThglug18wPUnU/T0tPLMRSOhJ7w/THhzeaiuhG4RzFy91GDiqzqjIejHA5h
         tBgbP/03vxmgCrQdT0EEOTDkt0KmuOfGEW2g2K/w/RcSOnce18z8uZyNai9y6BgDIs11
         I4m+VpRTGWsS9Wmy1b+2hF4Il+RsCLEQVB7nG58UmYeKySM1JlR6ZVtIfg8Db23u6cmz
         j1pPMDcBZT4Pn604FzrFSxGPjKsFzFf9+nvWjWU4Gc5ZEIxtnlpslsb0t4oh/I3D8Vza
         XV359ff/IkoDatqIe87K73QSEKpuiTnnuiJkNNz2/DC8yQBJRN5yHpfcKQ+3DvlPIyen
         JacQ==
X-Gm-Message-State: AA+aEWYYM+/HQ941QcKJWFHEp4PCo883daiAiLJ4rCBKjhHOa6bGvsXx
        pduSEuv8LcRHTVm/QTxlBoQoPRzqrxeB7kiVoVY=
X-Google-Smtp-Source: AFSGD/XgMxaaEBQbLilT/alep8ECvJtE7Mus+oOrhX58dysHVc5+3N6D9CrOGZU49ulhB1yRq9RjxQB+cHEtEq+8h1M=
X-Received: by 2002:a02:8943:: with SMTP id u3mr18917409jaj.92.1543948798605;
 Tue, 04 Dec 2018 10:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com>
 <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
 <CABPp-BH=rsLqq4ZRMSUv6n0n5p=aMZs-+VkVT=7P8n4=iUk=-Q@mail.gmail.com>
 <CACsJy8BSm945_hqwT3MSW2H_1so1KwrW_p1zz3V-fObwyGNUjw@mail.gmail.com> <CABPp-BFk8XXv=6bu0XPFfiDrNWE4HP9qF=5E+QFx3Q-brj=BBw@mail.gmail.com>
In-Reply-To: <CABPp-BFk8XXv=6bu0XPFfiDrNWE4HP9qF=5E+QFx3Q-brj=BBw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Dec 2018 19:39:31 +0100
Message-ID: <CACsJy8BfOwXvO1dvuFB+3vY2JAaErD8x0NDcVcpvPtBEw9QDew@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 7:31 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 10:22 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Tue, Dec 4, 2018 at 6:45 PM Elijah Newren <newren@gmail.com> wrote:
> > > > > > - Two more fancy features (the "git checkout --index" being the
> > > > > >   default mode and the backup log for accidental overwrites) are of
> > > > > >   course still missing. But they are coming.
> > > > > >
> > > > > > I did not go replace "detached HEAD" with "unnamed branch" (or "no
> > > > > > branch") everywhere because I think a unique term is still good to
> > > > > > refer to this concept. Or maybe "no branch" is good enough. I dunno.
> > > > >
> > > > > I personally like "unnamed branch", but "no branch" would still be
> > > > > better than "detached HEAD".
> > > >
> > > > Haven't really worked on killing the term "detached HEAD" yet. But I
> > > > noticed the other day that git-branch reports
> > > >
> > > > * (HEAD detached from 703266f6e4)
> > > >
> > > > and I didn't know how to rephrase that. I guess "unnamed branch from
> > > > 703266f6e4" is probably good enough but my old-timer brain screams no.
> > >
> > > Perhaps "* (On an unnamed branch, at 703266f6e4)"?
> >
> > This 703266f6e4 is the fork point. Once you start adding more commits
> > on top of this unnamed branch, I find it hard to define it "at"
> > 703266f6e4 anymore. "forked from 703266f6e4" (or even starting/growing
> > from...) is probably clearest but also a bit longer.
>
> It reports the fork point rather than the commit HEAD points to?  Ah,
> I guess I never payed that close of attention before.  I actually
> think "on an unnamed branch" is good enough, but if others gain value
> from the extra info, then I understand the conundrum.  I'm not sure
> what the use or rationale is for the fork point, though, so I feel
> slightly at a loss to try to describe this extra piece of info.

It's probably a corner case. This is a better example

* (HEAD detached at pclouds/backup-log)

It does help see i'm working on top of some branch (or tag)
-- 
Duy
