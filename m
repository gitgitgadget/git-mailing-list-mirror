Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2392320A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 17:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeLLRHs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 12:07:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37115 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeLLRHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 12:07:48 -0500
Received: by mail-io1-f68.google.com with SMTP id f14so15408267iol.4
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 09:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c3ovfN91KG5M+wFi6xy35u2ChOvQIyyi7v8TO8limA=;
        b=PRvepzyas2ltP1CMGdngYSjdmBhrepteuvwEjlpfwbTOWRphdmwHeDyWNuaUIxKVTh
         oruw9JdKy6gDVdtrtGsf83xd5BTGBWb8nNqFhMwg8MHrs84Nt1rDHaTe4vBmz21m3xi0
         iTTAb535JhGhRBlhmB1GlDhd4SHcHMFebHoCQJQHyHB4S35IwGxdbSmLmzCI/L+j1ybR
         SAJ3i2YU8OrAkUXxdv50YWKVCA5aLvHocMTb3WSqTUtAJ65qfZZxX8md03luIHL8YXT7
         ru8zFYyK67LlujLW6z0McAE0SGWDnTPvS0fwNzDVXtf8lSJ9LWUHyKgiH4Uyyy4U7XAn
         BFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c3ovfN91KG5M+wFi6xy35u2ChOvQIyyi7v8TO8limA=;
        b=YrRM12a7i6XSAmmU7kim6sSVCChyAonbI9QZX+szpImC9juJOWNsTWmSHEiKT4jtW8
         6IGesmcJy3JjH/z/iAleZZb8MA2nVlul09o8EcmcDpjhyj9DbGiJugmb9FgURJYek3FB
         DtbUXwhuJgRK8IaEH2W/Ksxu6hOhpELNFIetyEXQV/OJjUDgbTs3PFPJr1U/alaiTYi+
         Veiwv3Fyt3tISkl+ciVxojic9XGETA2mtoDdblogpsaTMpBBKKd1imQYAwY701GDzZXU
         ovXKCmbBYiEfPxV5hjujJAsPsTm6UQIbY5qPYmaQFfVaV0mMjqzq17yxKyyBHqgf8ezT
         ZlTg==
X-Gm-Message-State: AA+aEWbgkRXk1qnpjENrPTWg9A6UT23O7gQHiTc68BejWM3/WR1TJjCs
        fGfrOCzT8ZSL+6h6TXtEPmR6WeObXhZS4CWlqlA=
X-Google-Smtp-Source: AFSGD/UuxaxyeU9IW9JQYX6rsR/wJyf2nC3toCRiL4bsiR2DfYDX9qgKBs9sy7cb9Y7wvDW9/+q2XTouRivgtnmUG7k=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr14800843ior.282.1544634466904;
 Wed, 12 Dec 2018 09:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-2-t.gummerer@gmail.com>
 <CACsJy8AgbU9YyMHXdp=bkMncBO_Mu0FOQ4kSRkgacHzTJ0DrdA@mail.gmail.com>
 <20181211215019.GO4883@hank.intra.tgummerer.com> <CAPig+cQ0pPiB01KOWsC7a3mHdJz6LtAJjtf8=MWF+34NFdVb1g@mail.gmail.com>
In-Reply-To: <CAPig+cQ0pPiB01KOWsC7a3mHdJz6LtAJjtf8=MWF+34NFdVb1g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Dec 2018 18:07:20 +0100
Message-ID: <CACsJy8Cr9V=UZAdRwUKXdCGO=Y=wPo4XViknij7uRAmAW1p2Hw@mail.gmail.com>
Subject: Re: [PATCH 1/8] move worktree tests to t24*
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 2:27 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Dec 11, 2018 at 4:50 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 12/10, Duy Nguyen wrote:
> > > On Sun, Dec 9, 2018 at 9:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > > Move the worktree tests to t24* to adhere to that guideline. We're
> > > > going to make use of the free'd up numbers in a subsequent commit.
> > >
> > > Heh.. I did the same thing (in my unsent switch-branch/restore-files
> > > series) and even used the same 24xx range :D You probably want to move
> > > t2028 and t2029 too (not sure if they have landed on 'master')
> >
> > [...] good to know someone
> > thought the same way.  I started this work before t2028 and t2029
> > landed on master, so I failed to notice them.
>
> The thought of renumbering the test script came up as early as
> 2015-06-30. See the last bullet point of [1], for instance.
>
> [1]: https://public-inbox.org/git/1435640202-95945-1-git-send-email-sunshine@sunshineco.com/

Ah good. I thought I was just being lazy and picked a random range to add tests.
-- 
Duy
