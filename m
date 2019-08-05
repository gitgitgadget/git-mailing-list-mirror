Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F91B1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHET0Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 15:26:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:38169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfHET0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 15:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565033176;
        bh=u3euO6o+cwNb4mnOHS95/jM2JAvoh6Ei9Us6iD9THWE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WsqHLLd0W7NBiw5ib1bJtibRg+D7dsenE4nYNj7F0ZxX+yn6ybik9AGT0g4rv8IAM
         0eh2CHGEHHFq6+8jl7aJVheG5fCEy+fGsIiEqNhN1k/uisZ4WRpFBS4N5hwTzyydM0
         JtECeROTj/DAFAdzrp/BRhJhmDvley0Z/HR3DtBM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1hpd0H0fvB-00YRXF; Mon, 05
 Aug 2019 21:26:16 +0200
Date:   Mon, 5 Aug 2019 21:26:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] pcre2: allow overriding the system allocator
In-Reply-To: <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908052120302.46@tvgsbejvaqbjf.bet>
References: <pull.306.git.gitgitgadget@gmail.com> <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com> <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/4XWa4oAuYOBVh7CIwE5kAiMpBVLJVHjJuL1afWC8iV1lc6anN2
 AgNeOXS85Xw0nsvwpJFdiHASrrF9JxrHOPTE/CDSXAWL8w4ZxiEP8QOTE0KCFl+UUqJgD/z
 KmFpp0Hom2O9QRp4BEk3iQRQNYrKeBmrGq2XIfKGxTxCYL5yl1SLgLmJWdmp0WwtdRBo/gO
 SoXe0ycwvF4TmER5TPmpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kXC4vjAHvwM=:G3nPfRqcIIjCLUAAMsYOv5
 eRLe3/xC093xUOV2zQg3CkMUoQODxnlTXF910RK+QxQvY9zuf3Hv4kgnk1jdDB8dS/O6JRGU4
 6matAz6Cwr+GVlG/gWf7PRe9834h2mQ+72YsT2ZDA95wnOpXfAI9sAdZeMSCFRDLgJXTJJwVE
 p9ImbLR3B20LZjWX0VreRDT+LZFt+LIMxeV5y7TotTk4ZsS+2iiwO0l0lqK63cVlxz/I6oNQQ
 aPGq9XNy2ROUW5/iVzloPOukoe4AwWEwPbBTGJ4VdvFQq5FxD3sC6S/oEHGNyx+BWqb7wTczr
 yKbWp5bMqGDEKAoCzxZJRDTLlopfDkO8nBtBC0ZfbIIpC229SqfFt6ruwCcLjc9jB6FoxWKi/
 Y+n8c6rs8rCatkEPC4r5rAD8dgZrMxeWZ2HTT4G0gyOCHOby1BeCUM4+Nv1FK6Ux7d31QwgAn
 hE1tNoX0Nz7tQIYA/TnSe+v+ZyKX6S4OLKTy4nDYoTFTmWiVtHSK6ToXykvbOZHnmuTSCX3Zb
 Ej/ti7Mf6Jzy+T2DWYo8w+MNi4vOh6rzVG9HJbzaP3ZKhXgOrktReFiZ8KyY5DmWR/0vxO7mu
 GDoHJlaYPoklsSMrG80mXunjKZlYHWN7M2qlkqU9s26x334HtWdwFAwHQIdjM+xTGD9qm/YQM
 lAHP5ZA2Dm+d00JS6aL6N6qBLH6sbg+MbFXIMyz3m1+jGHxXFC2V0+s5B2SpuhpCZHlXFwdMp
 3XQarSgJcZkMTA6IrtSqmXm4FB/91vL6ShJtRRIN60gqrFPNN+Rqflii5s5MHBv0mvNGn/rGc
 8BM2ONWxsOnYw+7ZVriqe+YEzWOO51KtO0GtEyyDOdMHUmrpkTN/8nxNCKZwlcu6EmMgyBmNf
 EDwWlT+AcZlVTBWdaKrTmXNQWpHkfg4xV3l7T9dJl8tlwK/HlY4PCfET8W9veD9Hz5nqecvvu
 2NjL4u5wjaheCJl/52BFDgInlwgjpT7J/A8caY2lxNXYwPsHB+ERNSiizmHWBmhk+MeFIj3Xf
 fQg+tr7EiSt2pDKc19YQmkU+tk2TpIpjmDXIe22FRcYm7+CWDI8j+LCMwBvHM+yjgytvYIUBg
 CfkdDHjLELnoU7e74u9EZAbjJduk51kQ/K29zYcSjxGDsdhP0uy7yvZf6Kknt7gc/Qxriqo44
 Ue7xA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Mon, 5 Aug 2019, Carlo Arenas wrote:

> On Mon, Aug 5, 2019 at 4:51 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > Since 7d3bf769994 (grep: avoid leak of chartables in PCRE2, 2019-08-01=
),
> > we try to release the UTF-8 tables obtained via `pcre2_maketables()`. =
To
> > do that, we use the function `free()`. That is all fine and dandy as
> > long as that refers to the system allocator.
>
> Sorry; I should have thought of this, but assumed was safe since it
> would be broken
> the same way with PCRE1.
>
> Presume git in windows only builds against PCRE2?

That's right, we only build against PCRE2.

> LGTM except from the suggestion below that might make the code more "sta=
ndard"
> and probably be a good base for a similar PCRE1 fix
> >
> > +static pcre2_general_context *get_pcre2_context(void)
> > +{
> > +       static pcre2_general_context *context;
> > +
> > +       if (!context)
> > +               context =3D pcre2_general_context_create(pcre2_malloc,
> > +                                                      pcre2_free, NUL=
L);
> > +
> > +       return context;
> > +}
>
> instead of using a static variable inside this helper function it
> might be better to use one extra field inside the (struct grep_pat
> *p), where all other variables are kept

My thinking about that was that this would add more code, and thus more
opportunities to introduce bugs. Also, it's not like the general context
really has any _state_ per se. It just registers the current allocator,
which we want to assume is constant over the life-time of the process.

So does it really make sense to create one general context per grep
pattern? (Or even per grep pattern and thread?)

> Additionally to being more consistent will avoid creating the global
> context for the most common case (when the locale is either C/POSIX or
> UTF-8) and therefore have a smaller impact on performance.

Given that my patch does _less_ than what you suggest (it really only
creates at most _one_ general context per process, not one per
internal-grep invocation, possibly per-thread, and it also never calls
`pcre2_general_context_free()`), I highly doubt that your proposed
version would have a _smaller_ impact on performance.

Ciao,
Dscho
