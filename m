Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AEA20281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdJBRSF (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:18:05 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:56172 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdJBRSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:18:04 -0400
Received: by mail-io0-f176.google.com with SMTP id z187so5330512ioz.12
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fsdL1dqUcCj6l8KL52/0W3LEz1BkVLfBCo46on5PjZ4=;
        b=CPfcuOMov5eoGnKPm6+fkLSTCq3uPEIxuiq5c+RpN9EvEYu9njRCw01OlNDR7XZzVY
         f2WwxnRZLFI/RnCVOtvHxAk5UKc0BqVHf9hDiav/0gUH1N2Jwab9/IZ587XbJHZtBaVg
         aDzzhg/riVgqoMn6VFSqWGSfpL8vUlM2Hw7b3fPuJ8io6hiX1SwMDJXxkoVPp9BgkRaX
         9xAnRXZQGPAiDkMtaXN4C913Sx5BwNqt06vErRUcICAeURQFywo7gOnHQdSooEmNONJb
         TgS58t4T+rFT4MfFAZ1HJt2OIIeTdGv7KhSdyomX7OI0uoSCNzJFSiwuMZMtxxQA47/J
         s2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fsdL1dqUcCj6l8KL52/0W3LEz1BkVLfBCo46on5PjZ4=;
        b=XrkhsfXgPgtib/B7XfKrC2V5rfPEVjnUxNUXCbgWZ2ZHlZBSWT6IWZl5iQGkKTvzwa
         w7AY3zrOP8/8TSkjmhr6nodObGhXQ7vh2rIUKfSKv/yIEVlKMBkfQNP9XwhI5/RY71Qt
         x87Unkzqnui8L3OEb6jecoN/0Jg/+qKDMb3BwSOSAlAi9QHKrJxFU+8qlflcs83uE8qn
         TolvcQGeWeJGmr/IccvTTw2jmKahRCg6CeOhc9dy9BlPE8OQZFHe29TFlIesfDL0/N1L
         6p46zYSc3zSaoVvO6ZoFV6v37KxIUInq+lwgK+cJyr3x6fIIxTGLOaxvFnjnFRxrPePM
         MwhA==
X-Gm-Message-State: AMCzsaVJxt5x49sNe7mSvKCeRLMe2dNWB1RPrMsO376waHuXTRb33L5r
        qJmZhpX1gyfLNhCkXpXro7f23oqcEl8Mh65uO34=
X-Google-Smtp-Source: AOwi7QCZHwMGRCuMHLUKHSASJrdET13J3CezcZ5cdiHSbTDE01VUG8IpIZ0nAQ+JSsqrzWhqy++LgggTcyTGgmrJcyk=
X-Received: by 10.107.200.86 with SMTP id y83mr25333475iof.24.1506964684121;
 Mon, 02 Oct 2017 10:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.103 with HTTP; Mon, 2 Oct 2017 10:18:02 -0700 (PDT)
In-Reply-To: <20171002140011.GE31762@io.lakedaemon.net>
References: <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox> <20170926170502.GY31762@io.lakedaemon.net>
 <alpine.DEB.2.21.1.1709262356360.40514@virtualbox> <20171002140011.GE31762@io.lakedaemon.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Oct 2017 10:18:02 -0700
X-Google-Sender-Auth: 5Jea3JaUfr65PrGjigZ-qCdjMzQ
Message-ID: <CA+55aFyb=h1V-3tkESY8jkc356k5rcQRmjr6o_8p6ZgKMp=Jag@mail.gmail.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 2, 2017 at 7:00 AM, Jason Cooper <jason@lakedaemon.net> wrote:
>
> Ahhh, so if I understand you correctly, you'd prefer SHA-256 over
> SHA3-256 because it's more performant for your usecase?  Well, that's a
> completely different animal that cryptographic suitability.

In almost all loads I've seen, zlib inflate() cost is a bigger deal
than the crypto load. The crypto people talk about cycles per byte,
but the deflate code is what usually takes the page faults and cache
misses etc, and has bad branch prediction. That ends up easily being
tens or thousands of cycles, even for small data.

But it does obviously depend on exactly what you do. The Windows
people saw SHA1 as costly mainly due to the index file (which is just
a "fancy crc", and not even cryptographically important, and where the
cache misses actually happen when doing crypto, not decompressing the
data).

And fsck and big initial checkins can have a very different profile
than most "regular use" profiles. Again, there the crypto happens
first, and takes the cache misses. And the crypto is almost certainly
_much_ cheaper than just the act of loading the index file contents in
the first place. It may show up on profiles fairly clearly, but that's
mostly because crypto is *intensive*, not because crypto takes up most
of the cycles.

End result: honestly, the real cost on almost any load is not crypto
or necessarily even (de)compression, even if those are the things that
show up. It's the cache misses and the "get data into user space"
(whether using "read()" or page faulting). Worrying about cycles per
byte of compression speed is almost certainly missing the real issue.

The people who benchmark cryptography tend to intentionally avoid the
actual real work, because they just want to know the crypto costs. So
when you see numbers like "9 cycles per byte" vs "12 cycles per byte"
and think that it's a big deal - 30% performance difference! -  it's
almost certainly complete garbage. It may be 30%, but it is likely 30%
out of 10% total, meaning that it's almost in the noise for any but
some very special case.

                 Linus
