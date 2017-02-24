Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6967C201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 11:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdBXLEl (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 06:04:41 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35076 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdBXLEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 06:04:22 -0500
Received: by mail-it0-f68.google.com with SMTP id 203so2794332ith.2;
        Fri, 24 Feb 2017 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3YJSFulTKGdhf0XipaBy6Q3YZmStazV3OVqc0dW/Xl8=;
        b=IrN/QADsTMUJfhch3zGpQlPEBK2C7H8Rgk8f5vaC2yxwwl0lIAmw5Ubf8fX7DRSHHP
         3bf/d6Z0zMCGIMCKk0ObrqpJuk/1UUmSTog1CQchCNipQW/igiddJe1XqylJ16Vj7bPS
         8bB52Wrskmeo6ejwP+3gLQLABAW/I4gYwKw92OFjRDSiEOwpa/McI+mee4bh7913XdD3
         UfKt3qm2KRa+M6dcwvtbI4PxVyemLxv5wjtgPfcagQKGpl3Pv4ZDuCrMBTK7kO/ZysvN
         eA9rMUuqqxtxao8gj8W9XWYbD5IGbaPO0OJ1mXs2zoHUusX0xw3+GMa6WDE93lMDneLi
         38Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3YJSFulTKGdhf0XipaBy6Q3YZmStazV3OVqc0dW/Xl8=;
        b=S5IK71NFGpKsCjcn3Iq73NIyj7TfPcS8z18mMveLVL0iFNOnksq7x/YflYFDi/14TS
         x8YrnNYvjg0Jy1iZVQrp6ic6ugFJwtWFHLlmlYj7m6mYy4FPPw5YAZPpZtJtKYskG0Zd
         0KXwgvrHt1FGcQmaos+EP7h5NOJVU5kuImv8PxwDENLMGfn1rViVog0kPNmza4XtxBhj
         arflNfYKQ5X1CYqjzTLQuQYYqx8mhsFE94XpPqXG+JcQBh4ehVr6Mu+xpGqGjaYgA1L1
         fPoz949BrqGNHBBl2GSQNbWmBCy2E45QeqkN4hNhsSwvacQdDFreIWZ94DijYBo/HZpN
         EDIA==
X-Gm-Message-State: AMke39nBy7NanGkhy6XsOmb6LjmFvfokjHDjcWBeJTBwrC/P0VZkaVaRMhFPzp5NsXFeehVUyv7VSOa2V13EhQ==
X-Received: by 10.36.21.71 with SMTP id 68mr1761001itq.35.1487934226190; Fri,
 24 Feb 2017 03:03:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.145 with HTTP; Fri, 24 Feb 2017 03:03:45 -0800 (PST)
In-Reply-To: <20170223061702.bzzgrntotppvwdw6@sigill.intra.peff.net>
References: <20170222145613.GA17333@kroah.com> <CA+55aFy1JpXmo_PpC7f0zZa0YAP6rz+bztJ+fpDUoWgCz0_FMw@mail.gmail.com>
 <20170223060444.GA26196@kroah.com> <20170223061702.bzzgrntotppvwdw6@sigill.intra.peff.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Feb 2017 12:03:45 +0100
X-Google-Sender-Auth: VMucKV6UkdaV8lLsM7YXYVv4rEs
Message-ID: <CAMuHMdX+xGUD+K16VCE=ywRgN1Zd4MzSr=NJ=2xz+8e_ixyGKQ@mail.gmail.com>
Subject: Re: git email From: parsing (was Re: [GIT PULL] Staging/IIO driver
 patches for 4.11-rc1)
To:     Jeff King <peff@peff.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Simon_Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 7:17 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 23, 2017 at 07:04:44AM +0100, Greg KH wrote:
>> > Poor Simon Sandstr=C3=B6m.
>> >
>> > Funnily enough, this only exists for one commit. You've got several
>> > other commits from Simon that get his name right.
>> >
>> > What happened?
>>
>> I don't know what happened, I used git for this, I don't use quilt for
>> "normal" patches accepted into my trees anymore, only for stable kernel
>> work.
>>
>> So either the mail is malformed, or git couldn't figure it out, I've
>> attached the original message below, and cc:ed the git mailing list.
>>
>> Also, Simon emailed me after this was committed saying something went
>> wrong, but I couldn't go back and rebase my tree.  Simon, did you ever
>> figure out if something was odd on your end?
>>
>> Git developers, any ideas?
>
> The problem isn't on the applying end, but rather on the generating end.
> The From header in the attached mbox is:
>
>   From: =3D?us-ascii?B?PT9VVEYtOD9xP1NpbW9uPTIwU2FuZHN0cj1DMz1CNm0/PQ=3D=
=3D?=3D <simon@nikanor.nu>

Slightly related, once in a while I get funny emails through
git-commits-head@vger.kernel.org, where the subject is completely screwed u=
p:

    Subject: \x64\x72\x6D\x2F\x74\x69\x6E\x79\x64\x72\x6D\x3A
\x6D\x69\x70\x69\x2D\x64\x62\x69\x3A \x53\x69\x6C\x65\x6E\x63\x65\x3A
=E2=80=98\x63\x6D\x64=E2=80=99 \x6D\x61\x79 \x62\x65

and some of the mail headers end up in the body as well:

    =3D?UTF-8?Q?\x75\x73\x65\x64_\x75\x6E\x69\x6E\x69\x74\x69\x61\x6C\x69\x=
7A\x65\x64?=3D
    Return-Path: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
    MIME-Version: 1.0
    Content-Type: text/plain; charset=3DUTF-8
    Content-Transfer-Encoding: 8bit
    X-Git-Commit: b401f34314db7c60e6d23ee7771cd090b4ef56c1
    X-Git-Parent: 1e8ad3d8da4763b238d09244d4d1177aa640c0d3
    X-Git-Refname: refs/heads/master

    Web:
https://git.kernel.org/torvalds/c/b401f34314db7c60e6d23ee7771cd090b4ef56c1
    Commit:     b401f34314db7c60e6d23ee7771cd090b4ef56c1
    Parent:     1e8ad3d8da4763b238d09244d4d1177aa640c0d3
    Refname:    refs/heads/master
    Author:     Noralf Tr=C3=B8nnes <noralf@tronnes.org>
    AuthorDate: Thu Feb 23 14:29:55 2017 +0100
    Committer:  Dave Airlie <airlied@redhat.com>
    CommitDate: Fri Feb 24 12:08:58 2017 +1000

        drm/tinydrm: mipi-dbi: Silence: =E2=80=98cmd=E2=80=99 may be used u=
ninitialized

My first guess was Noralf's UTF8 last name, but after looking at a few more=
,
they all seem to have UTF8 quotes from gcc output in the oneline summary.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
