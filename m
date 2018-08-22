Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81C61F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeHVTkW (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:40:22 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:52782 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:40:22 -0400
Received: by mail-it0-f52.google.com with SMTP id d9-v6so3569599itf.2
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wRNSRi/EiAMtiWI/8yLIK7D7uzt+m+ph6EYLL1fTPQ=;
        b=oKN5s26KGzj4SUe1SuhUrqpl5EnVDsLCPP2arvpf2tUWceXZDKd22jKPyjqf1jV56Z
         CaxEEJU5V7kEHRCJZ4fR/HQvpplq9RYRB5KkKJK2dKkVHcWtNkQ2jk9OrBTXMivj4R2v
         LjP4xT55Hi0NXBTg4gwWy5PaBM39tj3qP/R3rJZeWr2rr6fnx/fOA4el0bb11cutaAa+
         Y2yRw41FLaO2hNc/vRKYvFGWLJzCEuQ5K+nxf19fdPeU1DizYGr2R31phfkrtjvc2plR
         32vxDQ5DZD9u1XeHd6fVH1XqAUAMjiCR6yMeD7SfWnd84aRKWYAletzDABOVVVlzFheO
         MhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wRNSRi/EiAMtiWI/8yLIK7D7uzt+m+ph6EYLL1fTPQ=;
        b=ADAtPxUMcoq7mKRslefS/BLvd7xpuJn/mOIYxnJ9t54HWDukrrADtpq61KJoNjxgmb
         anx8qI+WxBN76L33W05I4Z2aohXACXe6vBPyOaQXD46RNLfDM/FpjAVp2yVNTbQbmgcr
         9AzjEoHeGvLSC+WocSYh6gHLJKqMFXcLsmEY5PPBbYqpmGCDy8VT0WUA4zYFHcMjMkR9
         d8310AXTr1gnfSABjxnAVdorpUvilukDYUsZ/hsu1atBhKjlZKA0pxzDX8tKzIJRUwOU
         MXCfBJyy1CdtN3NLRL1FM5IGCAIzJ6cP/tPP2eTQh5+fRFKRyplV/23VI7TX9CpR0uqe
         dfaA==
X-Gm-Message-State: APzg51ARYzT87qnLm9WzgV8FCeh5NfAsCYMOVo5/cXllNE+HUgzaj41O
        QRe6osJJOafOWVurdcGIk28WAbzS7oC8GCdkPRA=
X-Google-Smtp-Source: ANB0VdYylvY6qaqSe1p0BBLatDueKGXW8lj+IoB1kzhNi9hmzPPzr8Vy68xfTEmis9E7FxdM5chhQ7kbjhzAisREvpM=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr3598410itk.62.1534954490287;
 Wed, 22 Aug 2018 09:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com> <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net> <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net> <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net> <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com> <20180822151703.GB32630@sigill.intra.peff.net>
 <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
In-Reply-To: <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 22 Aug 2018 18:14:24 +0200
Message-ID: <CACsJy8DifmYtDE4D58yVM7rYhfJFe8p-t9bXgMmMsw=txxmzHA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 6:08 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Aug 22, 2018 at 6:03 PM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Aug 22, 2018 at 07:14:42AM -0400, Derrick Stolee wrote:
> >
> > > The other thing I was going to recommend (and I'll try to test this out
> > > myself later) is to see if 'the_hash_algo->rawsz' is being treated as a
> > > volatile variable, since it is being referenced through a pointer. Perhaps
> > > storing the value locally and then casing on it would help?
> >
> > I tried various sprinkling of "const" around the declarations to make it
> > clear that the values wouldn't change once we saw them. But I couldn't
> > detect any difference. At most I think that would let us hoist the "if"
> > out of the loop, but gcc still seems unwilling to expand the memcmp when
> > there are other branches.
> >
> > I think if that's the thing we want to have happen, we really do need to
> > just write it out on that branch rather than saying "memcmp".
>
> This reminds me of an old discussion about memcpy() vs doing explicit
> compare loop with lots of performance measurements..

Ah found it. Not sure if it is still relevant in light of multiple hash support

https://public-inbox.org/git/20110427225114.GA16765@elte.hu/
-- 
Duy
