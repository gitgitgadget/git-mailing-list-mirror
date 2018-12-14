Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1626A20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbeLNSsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:48:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42769 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeLNSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 13:48:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so5740429edp.9
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0jxfK4CCLbg3erdgHBnm9sDVAHJ/VB/+q5GnaJa7cg=;
        b=FFcTSFQIQ3dBwlOjzDFnxidMx74Ie8cneTtpE1QRKCbZwXwlnCH2T6GqKGbeCBPCgh
         XxMO6X8D/Pk+lUmgepBLpHi2w/pTuGhjRksGZ5iF1rGpvfUPZZhQxEYR0yDdkkI9/BKG
         CE+atA16ujMM/eT8jjs8egrOyE3ujc8DX3xlBwLuJW5G83VcDM3U+1g2ce+E1BKyR6lX
         +WQ9TikOaxa3LjZgP2pXkPg9um+ouBh+NSjBqqnW+KXAztQBENc+fk3/QUkdLyBfWU5o
         Exh5PhGbCSvKnMk9z2M7jGrzWq7+S7xXNgYuwXVhtpy2KR3vWlPvDE+c/dGXLpijSIk5
         sCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0jxfK4CCLbg3erdgHBnm9sDVAHJ/VB/+q5GnaJa7cg=;
        b=QeAM05/GgsaByIZW8tVtu61s1JaarpwxHMGEQtyNFGqmr80H0LxgYpfdojAo0e9mWT
         PN+XoHsBB0cy7Sq+51VOBZX7V9nrXh2XGYckh0YA/x5FSNCmZN7NzDWx9ZOnKX9c6IgR
         DA5mQveaoBF1pd94WQ+R+R409QhhYOfS98RUbHUnlsUMF9LtH2zDoYA1/QB0mGB66RU1
         cz/3PdFjFNAaqwL5WU0iJDpFoRyv7QP+qk6jft5pXvkNB0QFSaJMHmwNFTqVMW6AN73e
         U6/F3uTMKv9XEUuWyOxk/5sIkux7XQgDO7iLM0t/TOqPNle9LmzqjxGcig5D/wclJn0j
         PyTw==
X-Gm-Message-State: AA+aEWYkoqoSKET4UO/TyleGCm/BReWO/8xH338xraVvAEn68h0JIp1a
        cjXUpW8o26QVusLw64VqzJpMfffklIljE2ye5wU=
X-Google-Smtp-Source: AFSGD/UKTnc3GfxgsOa6E2e2t4gbuhEfhDrlbfJxuhf79fnmrNaFYSGom6XGKRQ68VQC5ysnmREV7QexAsKwe6c4uwk=
X-Received: by 2002:a50:a8c3:: with SMTP id k61mr4025516edc.296.1544813332010;
 Fri, 14 Dec 2018 10:48:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
 <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
 <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com>
 <CA+P7+xoxE0o=5fMQrDoyCgWMQ-By2t1LdApecRDWmoXXCfnFuw@mail.gmail.com>
 <CACsJy8CT8K9SHnTsJT4HrxAK95yTz-x2DnNRBYKkvMyGbBZCgg@mail.gmail.com> <CACsJy8COqOMEk3Wzr==1-hsuGqdgKnbNfG_c90+xpU_oS-bW6A@mail.gmail.com>
In-Reply-To: <CACsJy8COqOMEk3Wzr==1-hsuGqdgKnbNfG_c90+xpU_oS-bW6A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Dec 2018 10:48:40 -0800
Message-ID: <CA+P7+xoRMhAhAseVfgeKg+LMFpPbuAWXqXymL9DQTGS3bTcBpg@mail.gmail.com>
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

On Fri, Dec 14, 2018 at 9:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 6:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Fri, Dec 14, 2018 at 6:22 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> > >
> > > On Thu, Dec 13, 2018 at 11:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > > > Even with a new ref storage, I'm pretty sure pseudo refs like HEAD,
> > > > FETCH_HEAD... will forever be backed by filesystem. HEAD for example
> > > > is part of the repository signature and must exist as a file. We could
> > > > also lookup pseudo refs with readdir() instead of lstat(). On
> > > > case-preserving-and-insensitive filesystems, we can reject "head" this
> > > > way. But that comes with a high cost.
> > > > --
> > > > Duy
> > >
> > > Once other refs are backed by something that doesn't depend on
> > > filesystem case sensitivity, you could enforce that we only accept
> > > call-caps HEAD as a psuedo ref, and always look up other spellings in
> > > the other refs backend, though, right?
> >
> > Hmm.. yes. I don't know off hand if we have any pseudo refs in
> > lowercase. Unlikely so yes this should work.
>
> One thing we could do _today_ without waiting for a new refs backend
> is, avoid looking up pseudo refs if the given ref name is not
> all-caps. So "head" (or hEAd) can match refs/head, refs/tags/head,
> refs/heads/head but never $GIT_DIR/HEAD. And yes I checked the code,
> pseudo refs must be all-caps.
> --
> Duy

Right, I think that's a good start, at least for these pseudo refs. It
doesn't solve the more general case of refs mismatching, but it
prevents the obvious one where case actually matters, by preventing
head from looking up as HEAD.

Thanks,
Jake
