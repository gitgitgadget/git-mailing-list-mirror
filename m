Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76F020A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 07:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeLNHiI (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 02:38:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36544 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNHiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 02:38:08 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so8006267itj.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 23:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVJlEV31t3u2Lovwv0u1OPtGMTenjDiWvP+HKgdBf0c=;
        b=Tgb+dowTTfcScENImVYhw6VbWhXxw4b73cEgHPCUQkV4nEkRfBgYnhYdFI99wD1DKY
         hSOyEUtTBOVhfsD917jZH6BbWSGnLKD3j0vvtGkEp1sw+EH7Pj62V3tbduT2WEF5x49q
         b6dARmHMk4xNHisf+3xj2SuBDJdJ7s479b3DOyWmG7Vp5PBcmr2Lkt68H1tjVeXuLYX3
         DlPnCqkD1i8maG21XpLlg7++DM8YUJHsngcGELlHoe7k/9L25Ez1sEK3Nd7HFzfMrxmv
         iWz46NvqumRZUACHitC2cKf6YtuLBon4/hwuFTOJmN3LBYaj4K2/d81Wiug+UuYGPsIQ
         eiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVJlEV31t3u2Lovwv0u1OPtGMTenjDiWvP+HKgdBf0c=;
        b=cszZQ2uhxpd0IDyBSVw751xwNr7B6BbuoYGLvNLK5HxAguykvPAYHumRS/63D2vpUZ
         GAFaZ6oxZDLn5yDtFgtmcObmd12oPaKdhsw/njCJ6aLGuWgH3HRc9hXzob1ybvuN96b5
         7lGSY2m7FKEIEVlbAqrbLm2JzLUvEIks7Fs/ekcjt3vurl/sbBM7pn1CwpKs+hnlvjyy
         FmFR27VKtZEjtapmR2xQ3MMN48NZEuXtWCQzqBqqI4oPEXhbiGhtZ8VrOaCPOifpC94M
         Omn3wh42KsLM6YNtJrsTHoNU5A82WMhkijp+mgLOYYp9ngdXqVCYybQlz10lS1h53NzV
         zKfA==
X-Gm-Message-State: AA+aEWYH42F5v4BDqRpkiAC7hvEB4QZWavIth90EPgWyeZ21qbc1VP6q
        EyW3+v7+Jv1/Y/P+yvW1m/IfcCJ5JInTJZ7aGow=
X-Google-Smtp-Source: AFSGD/W9kj6atcg6D2Y8PXAU+vXtB0gh3Cayf2It6LnXDFRRKH46a1fS8dpWghmgMhy1lB7BdUyNF4ZUpxFLO1QDNGU=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr1134798ith.123.1544773087126;
 Thu, 13 Dec 2018 23:38:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com> <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
In-Reply-To: <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 14 Dec 2018 08:37:41 +0100
Message-ID: <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 7:50 AM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 1:16 PM Mike Rappazzo <rappazzo@gmail.com> wrote:
> >
> > On Thu, Dec 13, 2018 at 3:48 PM Stefan Beller <sbeller@google.com> wrote:
> > >
> > > > > The current situation is definitely a problem.  If I am in a worktree,
> > > > > using "head" should be the same as "HEAD".
> > >
> > > By any chance, is your file system case insensitive?
> > > That is usually the source of confusion for these discussions.
> >
> > This behavior is the same for MacOS (High Sierra) and Windows 7.  I
> > assume other derivatives of those act the same.
> >
> > On CentOS "head" is an ambiguous ref.  If Windows and Mac resulted in
> > an ambiguous ref, that would also be OK, but as it is now, they return
> > the result of "HEAD" on the primary worktree.
> >
>
> Because refs are *not* case sensitive, and we know that "HEAD" should
> be per-worktree, it gets checked in the per-worktree refs section. But
> lowercase head is known to not be a per-worktree ref, so we then ask
> the main worktree about head. Since you happen to be on a case
> insensitive file system, it then finds refs/HEAD in the main refs
> worktree, and returns that.
>
> I don't understand why the CentOS shows it as ambiguous, unless you
> actually happen to have a ref named head. (possibly a branch?)

I think it's just our default answer when we can't decide

$ git rev-parse head
head
fatal: ambiguous argument 'head': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
$ git rev-parse head --
fatal: bad revision 'head'

> I suspect we could improve things by attempting to figure out if our
> file system is case insensitive and warn users. However, I recall
> patches which tried this, and no suitable method was found. Partly
> because it's not just "case" that is the only problem. There might be
> things like unicode characters which don't get properly encoded, etc.
>
> The best solution would be to get a non-filesystem backed ref storage
> working that could be used in place of the filesystem.

Even with a new ref storage, I'm pretty sure pseudo refs like HEAD,
FETCH_HEAD... will forever be backed by filesystem. HEAD for example
is part of the repository signature and must exist as a file. We could
also lookup pseudo refs with readdir() instead of lstat(). On
case-preserving-and-insensitive filesystems, we can reject "head" this
way. But that comes with a high cost.
-- 
Duy
