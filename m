Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935141F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeIEVTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:19:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39903 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:19:34 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so6511921iok.6
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcuUfVav7khbmiE2KaPBCGLT/HHqopK/f20P3JTXjMs=;
        b=JmIeW2mTgT0iseatiZbTLKAtYtSFoPyWWyh1ah6NVpJlDbScB35FDG+Ko7djJh+iMu
         TaJKN/pK0fgMmluLrbe/59O5/odH8Vz2ZAXRPKNSZkqEGyagKMSkSITyF3rljtDVm5UC
         1sCqEX8LeQoxOFOjlOtesnBB3F8LC5W/tManvY23v2Otfcek9iRz5lnMWwJOam6RCpEe
         Ld1M2zazSNbm8b5wO6hk3hiVCjua9RwCzrDxeI56WN9H987E8SPtM+M41MU8XmCmGUvm
         ASeUzWpyMXY4ynKKTDFDD48vkB3zo2rAEeombvjQ5OW0WrpU/AsuuhoLxud9UvrdkTAI
         FJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcuUfVav7khbmiE2KaPBCGLT/HHqopK/f20P3JTXjMs=;
        b=YgPAlK6Ks/LLSlbgVU4Z8czTe5r+Szbb+dDhY6EwOb4eMOVPMoWiIpfWq6TMztVuBg
         zXrjOA+9AYzEADvZ/DUrA3upzXs/OAJ+btvQWqnfzo2kBGP9TkQmkbQI5536mnxH9YYp
         3/Eb02E1sZGfHI76ICswBlUdRR8PFO6RHvCht7A3aHrjzlnxYYJywYkMBnvRJB+O1pKx
         wMOinzH/bt8Djx8L+nHF3BVtscpbpKcs8aYwGfkDJQsmhiX9fuaAbRru623mWExjclM2
         QlkAexdbxwsPySPoL1C39aFrPMOdvnWg72GulSzBeZlo5MHlJmCViF2cEPBuM9DsikOQ
         2Mpg==
X-Gm-Message-State: APzg51D5O90gzrLbmq6nZzrTz0O5QVLUsN2F3kkF0AHSngeqfo1Ui5tz
        yAimfdtvm7RSg74BGQlzjxIo6F8/Z0oiht3JZjuqAA==
X-Google-Smtp-Source: ANB0VdYFcVUAceLlnFUjX3IS6V3qMdCphz9wUXT/ZxMq+4UP/RPLY7FmDqkg6u16mkcqaxsovf66ozjiDBzhAKTAJgU=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr24775362iok.236.1536166113392;
 Wed, 05 Sep 2018 09:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com> <xmqqbm9b6gxs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm9b6gxs.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Sep 2018 18:48:06 +0200
Message-ID: <CACsJy8CJfsjmt8Z03dT5enN86Ke7aMBHv+BvpRh8zFBgU4Z=Vw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 6:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> >
> > Git 2.19-rc2 is out.  Hopefully the tip of 'master' is more or less
> > identical to the final one without needing much updates.
>
> By the way, linux-gcc job of TravisCI seems to have been unhappy
> lately all the way down to 'master'.  It fails split-index tests,
> which may or may not be new breakage.
>
>     https://travis-ci.org/git/git/jobs/424552273
>
> If this is a recent regression, we may want to revert a few commits,
> but I do not offhand recall us having touched the spilt-index part
> of the code during this cycle.

I can't reproduce it here (with either 64 or 32 bit builds on x86).
Not denying the problem, just a quick update. I'll need more time,
maybe over weekend to have a closer look.
-- 
Duy
