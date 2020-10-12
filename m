Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BD5C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4107E20790
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YqExVkg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgJLKe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:34:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:33561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbgJLKe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 06:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602498874;
        bh=8ienZduKFF0e5nLlBc9LRm8eZMgUQc+6Ptw2o/mtL/E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YqExVkg9KkoO+1XBWtB9XajIOK9M2MBxVUkUojX2mzNxuqy+MN/lpM29WTlVuIb4a
         1gUp2y6afKRx1vRIPBACof549j0UKBXK8JgI5qU+jMYk0HmgkRsBWwBYiuugWNZLRx
         /9E1xhx4e2zfzB85T9+sHQqb6mnXovagKo2C5Ycs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1kJ1Zt1zWx-011nDZ; Mon, 12
 Oct 2020 12:34:34 +0200
Date:   Mon, 12 Oct 2020 12:34:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
In-Reply-To: <20201011225850.GA490427@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2010121233590.50@tvgsbejvaqbjf.bet>
References: <20201011224804.722607-1-samuel@cavoj.net> <20201011225850.GA490427@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1069393321-1602498874=:50"
X-Provags-ID: V03:K1:+O25QQWoGFN3IGFc6XVx2tNXJAw+kkOwFS3+OoU3heGa/Cu+5p9
 3Ro03zICuvfUQnjrwkse6ETehZY8tUfzv577Rg2BBJy9RwbpmeRsEilbX/McfHUeezkiNES
 remhEjNKiPOfeIUX5LRyjiQxPtIrebkVU1eTgr9c3L5gOk5JXFfBNFiCdWU0InmyYOJkjgf
 7Rnpwvj1//DO3A2nh69UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJ5mevb1Tu8=:TNekGuVKfrYt+LSiEp15JU
 kCto8Wsn2ReGMiU0ZiKjR0NDdQZhor/gpFSZgC4JrthUPdqd63AjDF72Ss47FRDBtp4e6/BcA
 yCu/q7LChNGSxo9zYGQ6ywP0osLC/MkRBbZIlmfBpVyINV1Gp7+vgJGAu0gBgYu0Aua8QEpBe
 rgdgZKdW1tC/15lrTz5w7dgqiM/VX9++LgyBuXRO4YvtPrVkQFjNhIptEuXxrF5EfkNxOwKsN
 vT9wI3MgAAn2lKCdkTIO7JxQ+QDvXbzCB/81cPSDnTvfCjF0F0mK4cEMbzoWm7XVTEVtzXIyE
 LeiL0uZbUGywgf6pcb1f3g4BdOrd2W9tlqcojJEotNlGTlHuPtM8y3mvgazNcyp+ZBxi4Yd5D
 7vcnfqQ/nakuPwjO9xb/r4KWQjS/80FSmYIJVC7vFteDStsw6xXQ7TPZmGAYpnqOiAVqAx/C6
 CaQV1ZffecRM/oVN3N4D3DxJUp1qdPSHBhqW+0g15SHvU68HKpVqD/GIyNvM9+4mBxA2lpqb1
 83uVBbTBaUwyY/j1V9Jy1pqsH/mwBFplYOyIclChJfmc70DwatAbbGoHhmxAsIInPo8WWVxur
 9aO+SPLUcXupq3eWMBGNJStOLAoXwPJU3AfBdVVjcqlAG921QpmhkDfInYAzsdAcX5lUeC3tM
 rFYR5hKfr2qB39pR8SfF4kbpjZ3qG7A1tIhJkimHBLxzTNMwGDxnGttdANYK8ATwwmzHNAfyy
 bx1efxJQUoETi29AmWVKQ2E0qwxT13cYlXYPG1P8lN9ACbrX17EAImeH+yBKArzZK1iR6ClhT
 q79ISzcMc2IV36LCxjwPwI5dXqok9aJbS2XBAzb7wy7gtWOrLDbaUb1MuNeXdDfuGGHR5iedB
 q9KGKqTmisQNqdvhKc8azmrNuLr6EKRHrjFdw1WAAfVqXFzB2Axq7vjQpsGpRBbjFXOPXOH4F
 b7hbGueZl/q4nVRgkmTb5OVNmvRWwnlfx+s/6Mk6ymwpqlbt4Rfapa41cb8olsYqfYrbHg3jh
 kiV19oN89LofpxIiot+tS8tJa6IVn/U4UhJFVCMd4BdMqdFumnE6QJPVqXKw3JzSUkhxcg1xJ
 HWtBdOlHpqYUBdBgJVFPKuwnLvG1JL5qpsIGMjDivHgPQWMRdksjN518nabORVcgBJobU86xB
 SuIh9uzItd4PnSLRk0fc+9OGYOm/2F7S7y/n2B4JtsLdg2VN5/0y720fa8bEQpNZXiae35KC6
 OWqgpWRJphwZ79sozrcO8UR6st91haq4vPnK6Pw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1069393321-1602498874=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 11 Oct 2020, brian m. carlson wrote:

> On 2020-10-11 at 22:48:04, Samuel =C4=8Cavoj wrote:
> > When performing octopus merges with interactive rebase with gpgsign
> > enabled (either using rebase -S or config commit.gpgsign), the operati=
on
> > would fail on the merge. Instead of "-S%s" with the key id substituted=
,
> > only the bare key id would get passed to the underlying merge command,
> > which tried to interpret it as a ref.
> >
> > Signed-off-by: Samuel =C4=8Cavoj <samuel@cavoj.net>
> > ---
> > It is unclear to me whether I should have based this off of maint or
> > master, master made more sense to me. I apologize if maint was the
> > correct one, please tell and I will resubmit.
> > ---
> >  sequencer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 00acb12496..88ccff4838 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
> >  		strvec_push(&cmd.args, "-F");
> >  		strvec_push(&cmd.args, git_path_merge_msg(r));
> >  		if (opts->gpg_sign)
> > -			strvec_push(&cmd.args, opts->gpg_sign);
> > +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>
> Yeah, this seems obviously correct, and it's very similar to what we do
> elsewhere in the file.  This will also handle the case where the option
> is empty (because we want to do autodetection of the key to sign)
> correctly as well.

ACK

It is unclear to me whether we want to bother introducing a test case for
this; Octopus merges are somewhat rare...

Ciao,
Dscho

--8323328-1069393321-1602498874=:50--
