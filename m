Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E6B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeI2XMq (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 19:12:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35740 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeI2XMq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 19:12:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id m11-v6so7991710oic.2
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9LsyGAejmpk/SFymd9s+sl6ttILmOMKEt/Sh+upsato=;
        b=fa3/LgD+gKDLsnovOQo9k+CBCMlMqx3mFQKswjRVWgk0MWrRhOp6/ncUuP7tvecyWR
         Kfhda1v/PakqyoxeHrocrlI7Ut5fE8C6TBCyIH+mZSAAVPb/vKHbmObOuNPPxAvbtS8t
         /aB63cn3AOZv6SBs5WX/hw6F9fuAkYlhoIMPxXYhuh2NxaN2V7U+60s1L8kSP5lAlqhI
         3xLkngxrWE3jnJgrqghV0M4vSpOHM7+qt24XjIBO3tBHFby7uCsjLnny68rBtyXTukuv
         Gg0hr5/ZKSPXCd5dU2SA9rozTLr61/0bVqBpZCvCdAeYbQMptGKbE2X5l6STYZaaqa8S
         ICyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9LsyGAejmpk/SFymd9s+sl6ttILmOMKEt/Sh+upsato=;
        b=RYUznPqFGAXUL32OJcOMvhjN3TqTpKopzsKujGQcqV1wdE2fs/gb7uMAH0ZLIHHgpQ
         jLha88TrDVc8RIReFtBnx+P1cXpsl138o3dDAshUYcSo3brc8lTt61ZVXl2Wae924hrt
         jYRCeLJm00b5uDxpjZpQ1rk8531dGpvcQ5K/cZCKe6B3M/GIdFIithhUGu4NcncbNvfQ
         7fHXm8EdNCzg94kTM2vDLZtXu97cW/U9IyUHZU87lTX1/BaTeVE1tR8OCruaBTad0MWu
         h9Ru6Vq924tsmPOxwzQxNH56BUC9tt2BsUo2lJRXDW6x0WsXXAY5NfFOeAsm6vKQlmKm
         kNqQ==
X-Gm-Message-State: ABuFfohnhHWbTSczPxjUybRHGUmuzcxem3j9YHnV5EDI4gun6V4xvJfN
        o4UIy7iK83P6fQCvOHOV7f5Tjtzt5utEMWul/BXT+g==
X-Google-Smtp-Source: ACcGV63JrEPaJm9nHyShWXxv1QPuH4rpfXtHY7KTsLz8IRa8bhkKgQB2o+aRzSRc9FJVhYwE8JE0wrzuFp4xkkbBBvQ=
X-Received: by 2002:aca:3003:: with SMTP id w3-v6mr1854960oiw.231.1538239420296;
 Sat, 29 Sep 2018 09:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGDaZ_oBpLxD0cutrsNsFBEtH+-Fn2eT40gDsnGZhhU0qm2Ofw@mail.gmail.com>
 <87bm8giapu.fsf@evledraar.gmail.com> <CACsJy8BYr6cVtAcDO9w-tfgEiWnbvQCgSR7p3OFKbqVkPA1Gaw@mail.gmail.com>
In-Reply-To: <CACsJy8BYr6cVtAcDO9w-tfgEiWnbvQCgSR7p3OFKbqVkPA1Gaw@mail.gmail.com>
From:   Raymond Jennings <shentino@gmail.com>
Date:   Sat, 29 Sep 2018 09:43:03 -0700
Message-ID: <CAGDaZ_oS4bjzd67T5atJrJ6_x2Cfr8JgnoGWePzA53mb2ObdNg@mail.gmail.com>
Subject: Re: [BUG] Segfault in "git submodule"
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a repo, but it appears to be specific to staging area state.
It only segfaults when I have a certain file deleted.

Where do you want me to upload it?
On Sat, Sep 29, 2018 at 8:34 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Sep 29, 2018 at 5:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > > #1  refs_resolve_ref_unsafe (refs=3D0x0,
> > > refname=3Drefname@entry=3D0x55e863062253 "HEAD",
> > > resolve_flags=3Dresolve_flags@entry=3D1, oid=3Doid@entry=3D0x7ffdc834=
b1c0,
> > > flags=3Dflags@entry=3D0x7ffdc834b1bc) at refs.c:1493
>
> refs is NULL. It looks like somebody fails to get the right submodule
> ref store (or tries to get it but fails to check if it may return
> NULL)
> --
> Duy
