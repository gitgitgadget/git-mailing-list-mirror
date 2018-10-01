Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A381F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeJBB7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 21:59:10 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40105 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBB7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 21:59:10 -0400
Received: by mail-yb1-f193.google.com with SMTP id w7-v6so6094679ybm.7
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ihTkUqZhhqmkUOzZiik/UlNMwfDIn+N9i+/O/Uvjecs=;
        b=DGs7YUw6XPMHevDpAACAht18VBFv731arSp1Y89CTWu13tpTvd/ARR7cYb04oR0vOG
         aTdJ3b9iT5dM/2ug1pL1nc0H1l1R2nZoPuS0EEZOSGAzVjQhlWlRGOdhlfOEL38s+Amz
         N5Xdg+Clgnqh2bDstDlbZSmrDS1XamkwFwD4PwDm/9Y5bojfBWD0dkSpf0qK4JoitznN
         TaoRGtWqccRmLGYqSXqvHBCGCQTjcsTSk2BUW3PHm5u8usjP3AtDhJB5Y1ftzCIcsYi/
         9Mu1FqmwTGLDMG2IHEr03P6+AKWb9qVH3EnNyhx9syUCOrYhPyTmzh9DXc11Lpi7XhY8
         E/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ihTkUqZhhqmkUOzZiik/UlNMwfDIn+N9i+/O/Uvjecs=;
        b=IP7Hb4lmDkek5eYyupkmTWSRgxoVpBa4dnUPb4Oh9mJspCK/8uUhiqUB/yI7moIOF/
         j/KKhaWaI8e1URPQZ5nSqjaYTE/J83Mx2sPhjCCl/WTPntLG4Cv3bgXBoPX2IsP/0mWJ
         Xd2+VexvGxHVvcra7BdmHr78RkjJW2aXNP4RAJOBh6bcmdtw3Ige/8DCDTZir09zP0Ab
         VQzaAQAGJDWml2s2tkGgrxeyHBQzXyI/rxTLT/hOauTKgdoJoPy1mm8xVHNlRBCQYnnD
         AoH8jLHyVNpSXXvffOSzKUs1GQrWdW7SPdmyxWX0iGNhAdVectlIxOL6g45UDz+N3k2b
         elzg==
X-Gm-Message-State: ABuFfoiSM9CDpzvCiTB31sJdXkp2pIIAaZRn8jmlLeqehQlS2cV1rTlW
        qG7tdOPb+/0x3f3+zT9mkEWoI65RP8Uqg7DbvzbPxg==
X-Google-Smtp-Source: ACcGV620hHat7zhZi70D6z0MdNPpovaDI0hTww2Ne929kbduS3OiSPgHK2NTm85ursjY9bpV0WL2I3rR+zg6kpiuP0g=
X-Received: by 2002:a25:7505:: with SMTP id q5-v6mr6936269ybc.191.1538421593928;
 Mon, 01 Oct 2018 12:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGDaZ_oBpLxD0cutrsNsFBEtH+-Fn2eT40gDsnGZhhU0qm2Ofw@mail.gmail.com>
 <87bm8giapu.fsf@evledraar.gmail.com> <CACsJy8BYr6cVtAcDO9w-tfgEiWnbvQCgSR7p3OFKbqVkPA1Gaw@mail.gmail.com>
 <CAGDaZ_oS4bjzd67T5atJrJ6_x2Cfr8JgnoGWePzA53mb2ObdNg@mail.gmail.com>
In-Reply-To: <CAGDaZ_oS4bjzd67T5atJrJ6_x2Cfr8JgnoGWePzA53mb2ObdNg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 Oct 2018 12:19:42 -0700
Message-ID: <CAGZ79kYX3ZgmE3S-2cq0F_27Ctq_wwuSo53znRrBquik3ODXew@mail.gmail.com>
Subject: Re: [BUG] Segfault in "git submodule"
To:     shentino@gmail.com
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 9:43 AM Raymond Jennings <shentino@gmail.com> wrote=
:
>
> I have a repo, but it appears to be specific to staging area state.
> It only segfaults when I have a certain file deleted.
>
> Where do you want me to upload it?
> On Sat, Sep 29, 2018 at 8:34 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sat, Sep 29, 2018 at 5:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > > > #1  refs_resolve_ref_unsafe (refs=3D0x0,
> > > > refname=3Drefname@entry=3D0x55e863062253 "HEAD",
> > > > resolve_flags=3Dresolve_flags@entry=3D1, oid=3Doid@entry=3D0x7ffdc8=
34b1c0,
> > > > flags=3Dflags@entry=3D0x7ffdc834b1bc) at refs.c:1493
> >
> > refs is NULL. It looks like somebody fails to get the right submodule
> > ref store (or tries to get it but fails to check if it may return
> > NULL)

This is spot on.

Raymond, are you on Git v2.16.0 by any chance?
(and if now which version are you on).

I suspect 2.16, as that is a version of Git, in which there happens to be
a call into the refs subsystem in submodule--helper.c in line 624.

Is it possible to upgrade Git (to v2.18.0 or later) or cherry-pick
74b6bda32f (submodule: check for NULL return of get_submodule_ref_store(),
2018-03-28) into your copy of Git?

Thanks,
Stefan
