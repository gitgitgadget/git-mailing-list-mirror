Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFAD20248
	for <e@80x24.org>; Thu, 14 Mar 2019 03:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCNDti (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 23:49:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51283 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCNDti (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 23:49:38 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so2472504itl.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GaQUxDQe9B2V3WN7Eg1lP2vp0EYB7IBA2vk/8UTO3eo=;
        b=FOftg789f0EuTZpRsv/wI/J3pjEaRoA3H7evBz+teIa/jwsF9g2v40bMX/d78pAM2x
         q7rk6SFxHqkcMwFSdw/HDeAt03Jb40E4hJ0kvoEMtyd8h9v1o5p8VIupgihz8SH8R/Es
         RaAK6U2iW5WQ1MZ24S0nIRE68Pp0lxP9weV4REs8AIJTUPMbFsSelfrE1glJXbO4cjQw
         zkOBNigPmZc8JbctXopi4FOHKpKdlj5q8+eAyfEolz6sZuHtlJsbCwxzv2OpJ6gapgQ/
         m0C8eN3XlN2z1quiQgiYWO1M8aNpnEYp2og+gen6IjB+q8UXVd8bdRfA+Rmr29uNsy+l
         5Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GaQUxDQe9B2V3WN7Eg1lP2vp0EYB7IBA2vk/8UTO3eo=;
        b=IF5hh8CIqiGRsoHpLxH4jcqUR2OS+LB7SvhiINTFE2Nd7Zx6k+1vCgQTjg6Mcbizc5
         nT3+uCiZryfTpYRISWLvv0sV1DGJkdeTATp2q2G1cHULi10PMU3Rlwr4N6NAQpbPmdLi
         UaL44BHRnSBShuAtW8Z1u9cimAahlIdG/u+xOnggPfwgAXshvXk4lxN1SdXxRPz4gEeP
         eIBbw88hj6EdVw1nbTzSoanf2ZgRFSB9l542nQwL/SUbm/Al98zOnOIjnEXvGV8Esqif
         /WnkAhpw+utpNoJEEGBu+GMIY1R5ybA1tsSxWqKMjXfJgXe7+uMBgRuSG7hKrGybpeqR
         hGIA==
X-Gm-Message-State: APjAAAX2Di/hiZj3R3Q9Cu/g5BCYDL4irGb8TUPlYNvOfRygw78mdPVU
        7qNsyIcvJmlXiatKwJMCLhPOmaoiR/LAGn/l1Mo=
X-Google-Smtp-Source: APXvYqzrDSM5fCL3twdqpf6dinI06eg7YvTuID7bhD2Cbq3y8S7DNFUeBnborvZGnbI4i42YVICIFL/GgOtnPJ7Qd0U=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr7816997jac.92.1552535377520;
 Wed, 13 Mar 2019 20:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
 <xmqqr2bacrgf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2bacrgf.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 10:49:11 +0700
Message-ID: <CACsJy8D+bbDR4Oavf_aTk=rN2JDOQ5nhP5ZgCmML66xkMf8fYw@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] And new command "restore"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 5:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Fri, Mar 8, 2019 at 5:17 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
> >> - --index has a different meaning in git-apply. I don't have a good
> >>   suggestion except "yeah we have two different worlds now, the old
> >>   and the new one"
> >
> > I will rename --index to --staged to avoid this. It is already used as
> > synonym for --cached in git-diff. I will also add --staged as synonym
> > to "git rm" so that "git status" can consistently advise "git <verb>
> > --staged" where verb is either restore or rm.
>
> Does "restore --index" (now "--staged") work the same way as
> "--cached" aka "--staged" in git-diff?  "--cached" is about
> affecting only what is in the index (as opposed to "--index"
> affecting both the index and the working tree).

Yes. To affect both you would need --staged --worktree (or -WS for
short because I don't think anybody is going to type that many
characters)

> If it does, then calling it "--cached" aka "--staged" does make more
> sense than calling it "--index", I would think.  Otherwise, such a
> rename does not buy us much.
--=20
Duy
