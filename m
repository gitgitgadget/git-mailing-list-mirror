Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF6F211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLDSbV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 13:31:21 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:35706 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 13:31:20 -0500
Received: by mail-vs1-f46.google.com with SMTP id e7so10452569vsc.2
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 10:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXgOpxwk3/fEwspW0ju2lOyMZ+UueHsaZLPo/zni1ZI=;
        b=EQoRZwaHXn1d/cf4tL+4HAJ+uhkzpYdwgwOerZdmudBNL8UlrFOJ9f5cTplv0blSHy
         Bv/54nWUo86t0uQhgvVEZO8Nj6AySYcqDgrRJPxfDfqY7aASmL5MFm0oGGS1jkKDE7Zk
         pojzgKvQ9RMUDEIMaQ7R910QisV3UzLJCUTEtAD0Q1VY4vhzAwrVfTPWuO2kIboGyVcI
         zGe0n8yzUQ0kyHQNmXIeY3csLm5+Roo5Lw/kGZzuAwra1UEebshEDdmjixeg23A2vWfa
         YKIH0YKy68kQ2ksxbsk+znjux7hTjO4PUcZcmxgkPUtkRpQmdRO0SF2aVwJyBa5W/EQH
         IMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXgOpxwk3/fEwspW0ju2lOyMZ+UueHsaZLPo/zni1ZI=;
        b=AQPV1l9GBOo+32Sh5XG9C6RzblrHxRIrFN3XLhXweob9i3nPI2aVSwpYSIgV6aFv03
         RdB17lxnj5AKAYj7g8SQuNlObKHPc2quHNo2dANsTxgRVftjGdQLuas/OKLPl5l5N9Pw
         gJMVDziQquJvv4mBVycjghOEm3MqodRirA63ng5zTFm/AOvSHz3NjGl+PDBfjmyAO51E
         GmMJQdV7ENoR8MXvxFPpft2/uSUcM2lXAJGyPkHpOWHRjqOuDYwOv4fymWk/CpkGLDeU
         a+CjcY8RUDsqEc02Z9ioQFj1afPyGD5LIVPePO0IU830vSFjtFtRKzwaohXLjQyL2TZf
         glrg==
X-Gm-Message-State: AA+aEWaN533irHVt/ucbHTzYJPgyKw8TBgJS/oIBhQ5Ha/Egj2LxgAxm
        qv1SKUEr7eM9oFAU4+OiwdU8XAbeIn7iGMG58Ok=
X-Google-Smtp-Source: AFSGD/U+e9r4qI8gkXYg7UXv/OsL7g9c0FOrGY8eDtD9EDJWuy9jwi+edMQCpqxLWvGIroQ3ZVbkqwpEUnpK6mTT62o=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr9257666vsi.136.1543948279201;
 Tue, 04 Dec 2018 10:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com>
 <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
 <CABPp-BH=rsLqq4ZRMSUv6n0n5p=aMZs-+VkVT=7P8n4=iUk=-Q@mail.gmail.com> <CACsJy8BSm945_hqwT3MSW2H_1so1KwrW_p1zz3V-fObwyGNUjw@mail.gmail.com>
In-Reply-To: <CACsJy8BSm945_hqwT3MSW2H_1so1KwrW_p1zz3V-fObwyGNUjw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Dec 2018 10:31:06 -0800
Message-ID: <CABPp-BFk8XXv=6bu0XPFfiDrNWE4HP9qF=5E+QFx3Q-brj=BBw@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
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

On Tue, Dec 4, 2018 at 10:22 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 6:45 PM Elijah Newren <newren@gmail.com> wrote:
> > > > > - Two more fancy features (the "git checkout --index" being the
> > > > >   default mode and the backup log for accidental overwrites) are of
> > > > >   course still missing. But they are coming.
> > > > >
> > > > > I did not go replace "detached HEAD" with "unnamed branch" (or "no
> > > > > branch") everywhere because I think a unique term is still good to
> > > > > refer to this concept. Or maybe "no branch" is good enough. I dunno.
> > > >
> > > > I personally like "unnamed branch", but "no branch" would still be
> > > > better than "detached HEAD".
> > >
> > > Haven't really worked on killing the term "detached HEAD" yet. But I
> > > noticed the other day that git-branch reports
> > >
> > > * (HEAD detached from 703266f6e4)
> > >
> > > and I didn't know how to rephrase that. I guess "unnamed branch from
> > > 703266f6e4" is probably good enough but my old-timer brain screams no.
> >
> > Perhaps "* (On an unnamed branch, at 703266f6e4)"?
>
> This 703266f6e4 is the fork point. Once you start adding more commits
> on top of this unnamed branch, I find it hard to define it "at"
> 703266f6e4 anymore. "forked from 703266f6e4" (or even starting/growing
> from...) is probably clearest but also a bit longer.

It reports the fork point rather than the commit HEAD points to?  Ah,
I guess I never payed that close of attention before.  I actually
think "on an unnamed branch" is good enough, but if others gain value
from the extra info, then I understand the conundrum.  I'm not sure
what the use or rationale is for the fork point, though, so I feel
slightly at a loss to try to describe this extra piece of info.
