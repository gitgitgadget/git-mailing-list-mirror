Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B01A1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfFNKgR (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:36:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36340 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfFNKgR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:36:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so2846764edq.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXHVr3a739q0zq/iCndd+AYS5+lUHewdoQ5WlvDoMdg=;
        b=d0oFLW6VdATE9Y1DIHN0nfAhWuPQI3MBsDS+3JpY90LJRiqA5oAvos1b4MZtWGAR8R
         4Mtc3eh3abZqSsu+x2EeHL4Er3IZl8XYNMiDLyD0mQz/m6575/OZ528DhsRUdWFX7+1O
         Y+LLOq83I+PYRMGO3B2RREzwU5+eQYdJVFRxZVhKJ/XBcY2kNxyt+1JnXAV0Vdv9e96/
         Jf1rmDvWUisSEBxeXFYtQ1EsxAQ+6QGxKWpq+nuMq/0SOpbNWjZEx4ZnST4VGbdXZ4jP
         VB0gxJeybmjcCul8HvuwPls58q2n7M0mR4FkB55OJPi3wabTuKOnYFnbYWVMwlgssJkD
         uLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXHVr3a739q0zq/iCndd+AYS5+lUHewdoQ5WlvDoMdg=;
        b=JlB659KU3mNSWqb02vnJlyfmN4qr6sAjToKCeRfJrgtCHyn9toGTaRYTykxj8HrKWn
         DZIDiCW2le9LGbRWUtpmmQ2oHzdvzG0Cr9E6bbiL0Uk6jp9wG+Mxae8Z/7xARPsrQ9Au
         SCho9ywl8dIv3BLg2ocj9YhOmEAY/25TtoZoNsWJHznPhP1pnlvwiTkSY+JrWXC66M/l
         ZT9vpMREIR1gAu6Dip+RxPpvl/iy/2IGCnPSiIL+s4+m+XHKKIa5wFrRRFNo/CVvidf9
         20AoRBtY7c8iRorWRHT37y22qGg0x0OcAKn0JDs7o86+JZdlmgZC/Y8GEULuJd6//5K8
         uwYw==
X-Gm-Message-State: APjAAAXRezVApZUOCOnQmIIxHKPgt3ALQkQpsJ00vmMvKHb4bh55nC2i
        VeQaW+n6hhYNgLJsYrk77Lq7/kIe63QU8LtE/b9/pRlDnzU=
X-Google-Smtp-Source: APXvYqxwfLw+/kuGeRHWJsNb9xRCSQwFTR4sdMKKVAY2gC7bg3jVgMDhVoxR4ONu2SIBhLUsbQ453B5fgZ3XcYxSsVo=
X-Received: by 2002:a50:bdc2:: with SMTP id z2mr100072299edh.245.1560508574803;
 Fri, 14 Jun 2019 03:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org> <20190609092259.GB24208@szeder.dev>
 <20190613171913.GA14055@sigill.intra.peff.net> <20190613175236.GF31952@szeder.dev>
 <20190613190229.GB27217@sigill.intra.peff.net> <xmqqh88tunvt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh88tunvt.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 14 Jun 2019 12:36:02 +0200
Message-ID: <CAP8UFD3Q2rQwq82LNSXuLSEUMHABVJVgy8UJ7Fvgxug1rZGMFQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 12:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> > I know there are testing philosophies that go to this level of
> >> > white-box testing, but I don't think we usually do in Git. A unit
> >> > test of oidmap's externally visible behavior seems like the right
> >> > level to me.
> >>
> >> That's a good point...  but then why does 't0011-hashmap.sh' do it in
> >> the first place?  As far as I understood this t0016 mainly follows
> >> suit of t0011.
> >
> > I'd make the same argument against t0011. :)
>
> Yeah, I tend to agree.  It is not a good excuse that somebody else
> alerady has made a mistake.

Ok, I will remove the "hash" test in t0016 and the corresponding code
in test-oidmap.c.

> > I think there it at least made a little more sense because we truly are
> > hashing ourselves, rather than just copying out some sha1 bytes. But I
> > think I'd still argue that if I updated strhash() to use a different
> > hash, I should not have to be updating t0011 to change out the hashes.
>
> True, too.

I will also send an additional patch to remove similar code in t00161
and test-hashmap.c.
