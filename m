Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC35B1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946654AbeCBQBQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:01:16 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38188 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946608AbeCBQBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:01:12 -0500
Received: by mail-wm0-f52.google.com with SMTP id z9so3920209wmb.3
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1V7r4pUrbrbx+Ak693MW6f1HyKpKpgCKOWijZrOl1R8=;
        b=c7lg1q0w4hOTgVGSAC1hR10X6uX2PhvNcPREk0eLZdDm+pcjkhUkVXf4o6A8VdOQ8b
         Yf/3iRaIZqu0GYoY7kWaD4Wn31JaJTMAJyptUvENWpeOo7oDGz2RrKYCGJTTgtLk77Hn
         ANvyFMUgeYsFItPyYCs1MTcZKW9vnl4/nPtC4pMytPmaa5n9jopbOoOQE1QhH8MwCVYM
         PC1VgutqxO/aAaOroZ6YF9l7pFEpz2V6oT2419TyyFWTcN1Is2eGmfRFfywSIG3KRerm
         GjudVQ8DN1tUeXQpgOJpQTxaaY1KgjuxPC+hoj1NKQ1h8ghfPC7jAmcEeainylFtTO0F
         5tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1V7r4pUrbrbx+Ak693MW6f1HyKpKpgCKOWijZrOl1R8=;
        b=WuL6mTFJobn96FsDW5ZExOKRjZ0xkMEx3VIsb3hwDjiqm/ghiEutMuYjw/YiGBA/vW
         Cugvz2K+4UkmRUuzOR8xGRY0h1tafGijDGafcMzuiUwK5WkTyH7CifZrkmv2DYi/AWqe
         /aRtHUP2QX6McJsZ8FemDaLJIGXmEPhD1CMFuqo0vZ2iNZxyPqk4ymZz9GpL4EoI7MOR
         Ge6+S3QvhDLJEcOz1JgYVmYLmwk+tMDlon3NHvoQ6Yh25vkdNhABdxQBt8hmXiEatXli
         ntyfbe6EOEZKuFoHuGPMDtuySD1AFxs+YKo2ldVTOGd3NEVdsY4//QfbeHscrCRWjoHm
         am1A==
X-Gm-Message-State: APf1xPAJGaOV86h7CCrJHy6etpuIybSEa1AGb1l+zGMoIyN1iWmpmIrl
        q4WzwNXlD5Mg2dywhv0ynftVDN51Ifs04sKgzRA=
X-Google-Smtp-Source: AG47ELt8DQpV7dQVA4TD2JzJyICmRNMj/Wi8hirwdgInQlIgLeX3AdWzJKaH80PtyHCSREe2Mvjt/yVnyezNEX3/tc8=
X-Received: by 10.80.153.221 with SMTP id n29mr8026170edb.303.1520006471584;
 Fri, 02 Mar 2018 08:01:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Fri, 2 Mar 2018 08:00:50 -0800 (PST)
In-Reply-To: <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 2 Mar 2018 08:00:50 -0800
Message-ID: <CA+P7+xrkAKB621Na3V-tE9cMtbnADX94FvTrJf26SkQYbXqMGw@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 3:17 AM, Phillip Wood <phil@philandanna.no-ip.org> wrote:
>
> It is interesting to think what it means to faithfully rebase a '-s
> ours' merge. In your example the rebase does not introduce any new
> changes into branch B that it doesn't introduce to branch A. Had it
> added a fixup to branch B1 for example or if the topology was more
> complex so that B ended up with some other changes that the rebase did
> not introduce into A, then M' would contain those extra changes whereas
> '--recreate-merges' with '-s ours' (once it supports it) would not.
>

Unless the method of merging was stored, I don't think we *can*
correctly automate resolving of "-s ours" because all we store is the
resulting content, and we don't know how or why the user generated it
as such. I believe the "correct" solution in any case would be to take
the content we DO know and then ask the user to stop for amendments.

Thanks,
Jake
