Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0310D1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 21:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeJBEMO (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 00:12:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44840 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 00:12:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id 36-v6so14665825oth.11
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X9Q0VW5T/J/7Ntr6psdKoTu8rihHg1eL0HW6rmg5l6E=;
        b=T+geMScRIHVoew5NgPdylja9L53mIOv08yrZA+qM3tp2H5HfkRmO+ATRHRnh/vBW9c
         7YGUeblFnrdYtZ9dNlbygL/0ELgn3S9vKsmpSmGRqiVxkmwy1EUV9WRaKl8Slk4WFSX+
         qt6fppYSL2lCAadQnKwgUS7NGHdsfX/3EQq6C9KjF6V06Z+M598NWhol+zEi1Gg4dC0v
         EXGa6FEHUK8KHkZCbzcGMcoTONIMDXLbdom6b1Yrg4uKOVEHJ5eE+cEjVNkiGCAok2Wf
         e2xPx9qOIbtnPAFlwOehy0sw7MGayzrv4YXEjmWtxvS9AIHp8g4jeOJqD+yh/KjCQbJy
         /d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X9Q0VW5T/J/7Ntr6psdKoTu8rihHg1eL0HW6rmg5l6E=;
        b=jP5t14/m5cqTI+dYi+2hs+Be3E8hiOA4qKlE1B1W+86vhPpvDvp/VxMh0YcdFRutQ8
         qV7G4sXpIhlSMsGdEic0SOcRc1nL+ppxixWdHz14CBygQ0FBhNoZ6qrUuqJk0SJkjsyS
         oNadHysTshQ/SjjqXBXE+x9suGCEufAGZrwi2oO0gO2MQsmcFlzTfISBn5O7aZL5alss
         x5CZCXMpINswv2toZw+pkLxmkbcKrgO79EAT4PHbccXXeIVMajW27KPb1x4hWqQb2J9+
         AQd547Q9m8/78cYMHdfPEL95kWsY5dv/4iZnCh1TabK8IbnySawEzaK66RgxAceD422w
         J8pA==
X-Gm-Message-State: ABuFfoj4zvzqOfqTInU11d5wiXtlAREciSqlv3S1SKDOjqYOVfIBZ0CJ
        A8bou4YiVijnO4DE58IKUpNxpEMC8T9Mynbrrrc=
X-Google-Smtp-Source: ACcGV615R92UU+BaicBSdS6YmKwNw+x3wXUHoXi+XboKKmV6koEJQRNDAovNfafk9beAbSQGNY1+7kG8NylE4gR1O3s=
X-Received: by 2002:a9d:da8:: with SMTP id 37-v6mr7210962ots.212.1538429545858;
 Mon, 01 Oct 2018 14:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGDaZ_oBpLxD0cutrsNsFBEtH+-Fn2eT40gDsnGZhhU0qm2Ofw@mail.gmail.com>
 <87bm8giapu.fsf@evledraar.gmail.com> <CACsJy8BYr6cVtAcDO9w-tfgEiWnbvQCgSR7p3OFKbqVkPA1Gaw@mail.gmail.com>
 <CAGDaZ_oS4bjzd67T5atJrJ6_x2Cfr8JgnoGWePzA53mb2ObdNg@mail.gmail.com> <CAGZ79kYX3ZgmE3S-2cq0F_27Ctq_wwuSo53znRrBquik3ODXew@mail.gmail.com>
In-Reply-To: <CAGZ79kYX3ZgmE3S-2cq0F_27Ctq_wwuSo53znRrBquik3ODXew@mail.gmail.com>
From:   Raymond Jennings <shentino@gmail.com>
Date:   Mon, 1 Oct 2018 14:31:49 -0700
Message-ID: <CAGDaZ_q30GPWsd-NF1OSOx8m7LwXm4vk_5XcqRD5MxcjDx=GzQ@mail.gmail.com>
Subject: Re: [BUG] Segfault in "git submodule"
To:     sbeller@google.com
Cc:     pclouds@gmail.com, avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, git 2.16.4 to be exact.

I upgraded to 2.19 after ~arch keywording the package on gentoo and
that fixed it.
On Mon, Oct 1, 2018 at 12:19 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Sat, Sep 29, 2018 at 9:43 AM Raymond Jennings <shentino@gmail.com> wro=
te:
> >
> > I have a repo, but it appears to be specific to staging area state.
> > It only segfaults when I have a certain file deleted.
> >
> > Where do you want me to upload it?
> > On Sat, Sep 29, 2018 at 8:34 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Sat, Sep 29, 2018 at 5:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > > > > #1  refs_resolve_ref_unsafe (refs=3D0x0,
> > > > > refname=3Drefname@entry=3D0x55e863062253 "HEAD",
> > > > > resolve_flags=3Dresolve_flags@entry=3D1, oid=3Doid@entry=3D0x7ffd=
c834b1c0,
> > > > > flags=3Dflags@entry=3D0x7ffdc834b1bc) at refs.c:1493
> > >
> > > refs is NULL. It looks like somebody fails to get the right submodule
> > > ref store (or tries to get it but fails to check if it may return
> > > NULL)
>
> This is spot on.
>
> Raymond, are you on Git v2.16.0 by any chance?
> (and if now which version are you on).
>
> I suspect 2.16, as that is a version of Git, in which there happens to be
> a call into the refs subsystem in submodule--helper.c in line 624.
>
> Is it possible to upgrade Git (to v2.18.0 or later) or cherry-pick
> 74b6bda32f (submodule: check for NULL return of get_submodule_ref_store()=
,
> 2018-03-28) into your copy of Git?
>
> Thanks,
> Stefan
