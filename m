Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0CC41F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394111AbeKVU4B (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 15:56:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39344 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388046AbeKVU4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 15:56:01 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so13100046itl.4
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VI5fJusUfBOTLlc00aeTey5BAHkzORS4t4IST6qRNbQ=;
        b=WeDqhpT8c/rJgsHUIsDt1yNY6qfx9vbx67j0E9hN/cd9J8qRFHWWCh94HyP93Gog29
         FQxPvqVO/av9EU2RATCSekzK/Ggxy2PORseBeAN9dtmQkkGbTq4LtwT9LYOR43Y5pGc/
         cv6w4OuhBixoEK74k2LZUxNecT8NH/C+KFE1TtzyZ2eKwV3aEht3O5ZnNT25v4Ji8bg0
         VOzSdqw+G/g5Ecb8WDGx51UhYs+07Lh7IVXNMjh30HMlHY51Eh7qIZzsLthGXUBlGRRk
         JwXb0GNp8jrSSpA5RZxJbRK2sVBoha+iwFbsszJsoH7s7lvnTmVO7hnJ9cRJOEFUOH46
         pHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VI5fJusUfBOTLlc00aeTey5BAHkzORS4t4IST6qRNbQ=;
        b=XRZ8ECKgOPwynkZNLR1XnOzoOnxNyY4EqjraHN/rf8yPhA5nXk3weKjikb1jxWTeaV
         IX6oKTkJTksj5NcnH5xbF58maC1BURbzGs+adPAYCoyzHwRi4tmFbVhL/34cAUeHOIBZ
         0GQdOFteIFQoPPbJCSRQO0Zp0JBJ6+D0G7hBt4TlKBAR78ZvSQ5M9JId/PaMv+QidtwL
         X2+N2XHyy0vnGTV9EAhc7l5Qo0EjV8gfCJiOR/BLjRSmhJ32KK0mY6uYqV70B5OGhqRn
         PFkhazz2HIf8uEssyTYFjOsCoiPaPY2xlYX364XYbxrwik/S+MFXZqzIx9dAF9zBfTR8
         2fnQ==
X-Gm-Message-State: AA+aEWZJ/ORDQb8STZ2/km72Ss/IXMi+etG7e+9cXYwWpbc112BoK7KF
        ABMykVlI0FghnHrWnfzeZJ4o6g02QNsQKFgwoQZ0yw==
X-Google-Smtp-Source: AFSGD/VnV7cyTRjx/4tLjEEFtcxPrvE3TBDPcGIazbUc21Jfy3ybMdJGpmxlw+oCKXVWSa9e+ucLXKGwfduCO3P1Q14=
X-Received: by 2002:a24:19d5:: with SMTP id b204mr7505804itb.6.1542881833363;
 Thu, 22 Nov 2018 02:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net> <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local> <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
 <20181122063714.GE5348@jessie.local>
In-Reply-To: <20181122063714.GE5348@jessie.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 22 Nov 2018 02:17:01 -0800
Message-ID: <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
To:     max@max630.net
Cc:     peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 10:37 PM Max Kirillov <max@max630.net> wrote:
>
> On Wed, Nov 21, 2018 at 05:04:25PM -0800, Carlo Arenas wrote:
> > the last child of its children long gone with an error as shown by :
> >
> >   9255      1 git-http-backend CALL  close(1)
> ...
> >   9255      1 git-http-backend CALL  write(2,0xbfb2a604,0x36)
> >   9255      1 git-http-backend GIO   fd 2 wrote 54 bytes
> >        "fatal: request ended in the middle of the gzip stream\n"
>
> This should be some other test than push_plain, some of the
> gzip related ones. Are there other tests failing?

it should, but I should note that for test 9 to fail, then either (or both)
tests 7 and 8 should first succeed; not that I'd seen any other test fail (after
I locally patched the perl path, of course) even when reordering them and
while making sure tests 1 and 2 run first to create the dependencies
for the rest

Peff, could you elaborate on your "load testing" setup? which could
give us any hints
on what to look for?, FWIW I hadn't been able to reproduce the problem anywhere
else (and not for a lack of trying)

> >   9255      1 git-http-backend RET   write 54/0x36
> >   9255      1 git-http-backend CALL  write(1,0xb781f0e0,0x94)
> >   9255      1 git-http-backend RET   write -1 errno 9 Bad file descriptor
>
> This is interesting. http-backend for some reason closes its
> stdout. Here it then tries to write there something. I have
> not seen it in my push_plain run. Maybe it worth redirecting instead
> to stderr, to avoid losing some diagnostics?

that should help with the garbled output from stderr, AFAIK the
process API allows creating
a pipe specifically for that with would be better than redirecting
stderr into stdout.

the fact we got EBADF means that there is a problem somewhere though
in the way the
previous failure that closed stdout got handled (which should had been
most likely in
the call to die)

Carlo

PS. upstreaming the PERL_PATH fix is likely to be good to do soonish
as I presume at least all BSD might be affected, let me know if you
would rather me do that instead as I suspect we might be deadlocked
otherwise ;)
