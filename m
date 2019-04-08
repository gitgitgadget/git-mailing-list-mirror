Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063B720248
	for <e@80x24.org>; Mon,  8 Apr 2019 11:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDHLJh (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 07:09:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45789 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHLJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 07:09:37 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so10606301iom.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loMHk2W0CeT298OGsRa4UXzRvanG9fpFkbGZdgtjrVw=;
        b=LYU3c9w2FnPUdzlRsQiRxe3sc/sr2bbGr0ezJ308JIfc74SpXeK+IjsC8eQX0Qa1L7
         tIZ/wd4kYVqcMosXCXhFXb2r9ZR74BHkOT/EP9rgSOaCagXqyLohIVTyKuXtreJjWUJo
         5CMd89eIBQxO2dIuTb/rK9ESa6Hl0wq0hW5eL0n5sv8OTjBmNUQUbhQue7r9OIT1ZL3W
         KlYwBW273u/j5tCPTkSDJx5y07rAKHrBvJ1UcZ1NrAiiNr40LLkG1KureIXPpKPRWfdv
         pYKNwKm/KbNZFNFsy2TL5pwLZl+R9VlYpj6yz5wqGoirXBxlWwpN3SG4CK+6zE4d2+Ga
         4aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loMHk2W0CeT298OGsRa4UXzRvanG9fpFkbGZdgtjrVw=;
        b=Yg0P16EFLQGr87DsUmxyOFiGYTFFpxC/Usvzv7tw3KAMlnHOBzW7v475xf8z57uM+7
         9un+cxFTcQoQrR2dE6EeHwwfFPptyvZBXLZLdwaegPOVKAdwP54dJd36x7xozZnlm0De
         SELBkDb2fyfqTVLPp+WLeClm1d5NMiSiH0aFbuF3gxU+iOU992i1ct+3c3G7kv12vKk+
         IhewCNyjtOHDnzlcuzhmcIrW1kf0Evg6Dlax4D2GKS85MiTaca/9qwSvtCFaUNrEgkAp
         MnuMTyyfeillkXtV+HhV71lUL5g2UmBYKPZTjAEMHfNzSwmJuz7Jju/34ArqZCr0pJtz
         L6Eg==
X-Gm-Message-State: APjAAAW3R9feVtPP5wDNKGJPkIshFMYbAKh10DK/Qw24J/krYS4nmkYZ
        eE9wu9ILjOIJCCNL3YDPUK9WvpmK2jXmuiYS3gY=
X-Google-Smtp-Source: APXvYqxZzr5NVDd7xkRsmKgGZxCPNZoC3LId74BzSzZrmiXcRbh36Gc/l17kShlLW4VVFkbXzgYATlXOWULtOorYeKc=
X-Received: by 2002:a5e:8418:: with SMTP id h24mr17955817ioj.170.1554721776713;
 Mon, 08 Apr 2019 04:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
 <20190407183857.GA32487@hank.intra.tgummerer.com> <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
 <CACsJy8Dc3fuXWOOO-hNJqGNomufP7bffoHVf5hHLTubHQvq9vA@mail.gmail.com> <CAMknYENqH==YcAfU-B16Jytc4Pts4viNQn9deTFag++zZVb1+Q@mail.gmail.com>
In-Reply-To: <CAMknYENqH==YcAfU-B16Jytc4Pts4viNQn9deTFag++zZVb1+Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 18:09:10 +0700
Message-ID: <CACsJy8D7mQZgJhZ4H8Z929EnjYe1Wp7idrbXqkUsmL1Ypn83dg@mail.gmail.com>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 6:00 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
> for finding that commit message did you do something like this:
> git log -L :repo_read_index_unmerged:read-cache.c

No. I'm old fashioned. I just do "git log --patch --follow <path>"
then search read_index_unmerged, which should at least appear in the
@@ line. But yeah log -L or "tig blame" may be better to dig in
history.
-- 
Duy
