Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 982B420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeLNSre (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:47:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47063 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeLNSre (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 13:47:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so5724659edt.13
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQBn6fL0U5xwfeV9623Wil/Q6DGgY8PoZaeZdykga3s=;
        b=VcPzeCyOrfsZyys5wIApfVmq1j8ZMGuHTZvizZCNcIDrJM3VwG2MZHXl/DsiDvYb4b
         /7V76qQ+3tJEPB8YncsJXlz+KpPWWznso+IzAiV8VeeqXzzPzSCYy1/yJwFh7QS8ZnDM
         6fd8VLniSrlzK2nMa6md0t0IE1R2petKwgrUaP5PyXH0SsRr/OR0gs1JAvk9Ac/jEDk2
         1kPxHndvtihkLSm8kpNAfh9TOGX4McrQloxDhL91SVl7GEo5hYatYYBOx8bxFpEVdtRh
         hdIHf1FblY7IkP6RrWkmI6oejD2v8trW7/RCDzpMcYrm8nDLKC1wQ6aeDn2jsANSMJ1o
         DVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQBn6fL0U5xwfeV9623Wil/Q6DGgY8PoZaeZdykga3s=;
        b=s6Qs2mZn0Wd0lq/yG4dL2kS4jDCC2uU6xOJ6ukCWGbQ242RJZX/NVU5QzjNtae1wQf
         o76g0Alsp+xeCdDuh8f0nhfp/XozwjvmDBBWZkqe2uG5JLkHS0yHfOMW49UmR3SAHdii
         zhZT/4kgwSB2UGQHvDz72Mw/uNwVfecw0D5+gHc3FFpMfG/UosnJ/u31eTDzxTtM8sHi
         4Fdu6FDfgksFqYDejmEOxe2lwOZFs3YFsyl305lzza7suDHs+Z6as+QG2IgnGLFiEzzi
         zKtYN0pFXqk0zGjydjv/WseJ103X8fsQe5j28WXdiPgY+30xOeggQyV/MvfXTWXP4WfF
         IBPg==
X-Gm-Message-State: AA+aEWY82UenOmE68bGjnJGGThuaNbsMEMsnvxBdQ+Mnp2uTj8h0i4qd
        vyb5HDILBcDejg6Ab+ZkRi2z9u02Q2wa6153S3o=
X-Google-Smtp-Source: AFSGD/WNmQk3BPQ6ZhvajKoKUK/HVIRELdGU6jp1xKJFfEhgTX7BlZKrZgpSBWChJSu7BBlo81freI9XTuyBrdyGqi0=
X-Received: by 2002:aa7:c594:: with SMTP id g20mr3759047edq.79.1544813252035;
 Fri, 14 Dec 2018 10:47:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
 <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
 <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com>
 <CA+P7+xoxE0o=5fMQrDoyCgWMQ-By2t1LdApecRDWmoXXCfnFuw@mail.gmail.com> <CACsJy8CT8K9SHnTsJT4HrxAK95yTz-x2DnNRBYKkvMyGbBZCgg@mail.gmail.com>
In-Reply-To: <CACsJy8CT8K9SHnTsJT4HrxAK95yTz-x2DnNRBYKkvMyGbBZCgg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Dec 2018 10:47:20 -0800
Message-ID: <CA+P7+xoe0M6ytATCQy7cftSPDc36dPQ2icSzQz9S4-TxWHAD1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 9:38 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 6:22 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > On Thu, Dec 13, 2018 at 11:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > > Even with a new ref storage, I'm pretty sure pseudo refs like HEAD,
> > > FETCH_HEAD... will forever be backed by filesystem. HEAD for example
> > > is part of the repository signature and must exist as a file. We could
> > > also lookup pseudo refs with readdir() instead of lstat(). On
> > > case-preserving-and-insensitive filesystems, we can reject "head" this
> > > way. But that comes with a high cost.
> > > --
> > > Duy
> >
> > Once other refs are backed by something that doesn't depend on
> > filesystem case sensitivity, you could enforce that we only accept
> > call-caps HEAD as a psuedo ref, and always look up other spellings in
> > the other refs backend, though, right?
>
> Hmm.. yes. I don't know off hand if we have any pseudo refs in
> lowercase. Unlikely so yes this should work.
>

I think even if we had lowercase pseudo refs, as long as we know which
identifiers represent pseudo refs, and we don't have two variants
which match if compared case insensitively, we shouldn't have
ambiguity, since we'd distinguish whether to check a pseudo ref spot
before we actually check the file system.

> > So, yea the actual file may not
> > be case sensitive, but we would never create refs/head anymore for any
> > reason, so there would be no ambiguity if reading the refs/head vs
> > refs/HEAD on a case insensitive file system, since refs/head would no
> > longer be a legitimate ref stored as a file if you used a different
> > refs backend.
> >
> > Basically, we'd be looking up HEAD by checking the file, but we'd stop
> > looking up head, hEAd, etc in the files, and instead use whatever
> > other refs backend for non-pseudo refs. Thus, it wouldn't matter,
> > since we'd never actually lookup the other spellings of HEAD as a
> > file. Wouldn't that solve the ambiguity, at least once a repository
> > has fully switched to some alternative refs backend for non-pseudo
> > refs? (Unless I mis-understand and refs/head could be an added pseudo
> > ref?)
>
> No I think "pseudo refs" are those outside "refs" directory only. So
> "refs/head" would be a "normal" ref.
>

Right, I was a bit confused pre-coffee and forgot why a ref was a pseudo ref.

> > Jake
>
>
>
> --
> Duy
