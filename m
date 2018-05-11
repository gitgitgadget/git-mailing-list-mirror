Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE9A1F406
	for <e@80x24.org>; Fri, 11 May 2018 13:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeEKNMS (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 09:12:18 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:46083 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeEKNMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 09:12:17 -0400
Received: by mail-oi0-f50.google.com with SMTP id y15-v6so4636748oia.13
        for <git@vger.kernel.org>; Fri, 11 May 2018 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3j7WKSgyV3XN84nH04fnxLyZErtMjRlPJ5GiOmAgqYY=;
        b=SqJgwFANkQwja0fdpaCPw3NShcvNUWuJaILGegtOl5FBDYTBuwTIGdd6F0dr0i7C2a
         OvgGbUm4rslEpe4POxBOMqXGH1VguQ3TCinoSpiLBiZPgdgnownpGheaPRUHmOcZikK3
         kaDxMhBl060Dbr1KVn36jQLlFBodW2ATspU/kxPT/0PEI24zq9F208Ik440T29iVXBjg
         EsjM6B4GR9xvreQXfR70VYxeITuPudIJ9nqVW8N2nyZNgV2RTSrZdRimIEnMMKbSVXJU
         c711+3qs+a1GDteOoY5amMfv7sX9T6bBKy9dmrLBtltiM+zFpFVZgTbOOG1XMe7ZpJgq
         TtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3j7WKSgyV3XN84nH04fnxLyZErtMjRlPJ5GiOmAgqYY=;
        b=sotoiWNLvQMEKPKkZF/wfK0AEYPzzwmBHNoCfhVMDgcAEScEjBufqahMTeeOWAgO5K
         rPZyBcx3gJYuMsSUhHV2vnM6JMPqNiIcDCwmG3+RP2lxVx1FVpm0uHQuPIk/MqTeV7z2
         eMFtu3qsmNJhTsKBbUwUz5wzwvahwHUDgm0fk56p2t+RCcfgdZlcho/XbyUw+MJxysNG
         ATagyJ9/5QWg8hwbInHCle6v7CePCmnMoGERjiZlrK3YokOo+1k3XGyXr93onM1xEiJ7
         o1ezGWtRlxEQ3TGrsK7jQMveBLtzJ+LbRoD3iDimr+yVZW7VY87IOwWXSFU3O43ZlNFX
         GBpA==
X-Gm-Message-State: ALKqPwfsqZ0ciPGYGN9hpfjNW8YzyIUbLr5EwhQu2LAW/1200BHHhcpd
        2OXS1JDFGLk5acnJUW/BJhYOxk3Hq1CtnVZaobI=
X-Google-Smtp-Source: AB8JxZoGYqBoQs1Xt17mQmMQxRQtd/1aGXK/G2ee2jWvwujF4F6N8ArDZAc/f3LBbe56YGBmvqwjEWX1FKAKS8w+yDw=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr3371814oir.56.1526044336739;
 Fri, 11 May 2018 06:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 11 May 2018 06:11:46 -0700 (PDT)
In-Reply-To: <20180511085634.GC22086@sigill.intra.peff.net>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de> <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com> <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com> <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com> <20180511085634.GC22086@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 15:11:46 +0200
Message-ID: <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 10:56 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 11, 2018 at 08:19:59AM +0200, Duy Nguyen wrote:
>
>> On Fri, May 11, 2018 at 6:49 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> > Junio C Hamano <gitster@pobox.com> writes:
>> >
>> >> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>> >>
>> >>>> But it somehow feels backwards in spirit to me, as the reason why w=
e
>> >>>> use "void *" there in the decoration field is because we expect tha=
t
>> >>>> we'd have a pointer to some struture most of the time, and we have
>> >>>> to occasionally store a small integer there.
>> >>>
>> >>> Yes, fast-export seems to be the only place that stores an integer a=
s
>> >>> a decoration.
>> >>
>> >> With the decoration subsystem that might be the case, but I think
>> >> we have other codepaths where "void * .util" field in the structure
>> >> is used to store (void *)1, expecting that a normal allocation will
>> >> never yield a pointer that is indistinguishable from that value.
>> >
>> > I was looking at a different topic and noticed that bisect.c uses
>> > commit->util (which is of type "void *") to always store an int (it
>> > never stores a pointer and there is no mixing).  This one is equally
>> > unportable as fast-export after your fix.
>> >
>>
>> In both cases we should be able to use commit-slab instead of
>> commit->util. We could go even further and kill "util" pointer but
>> that's more work.
>
> I would love it if we could kill the util pointer in favor of
> commit-slab. Unfortunately the fast-export case is decorating non-commit
> objects, too.

Right. The "util" thing was a side discussion.

Back to fast-export, can we just allocate a new int on heap and point
it there? Allocating small pieces becomes quite cheap and fast with
mem-pool.h and we can avoid this storing integer in pointer business.
--=20
Duy
