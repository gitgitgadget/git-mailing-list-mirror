Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D431F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdFLRxn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:53:43 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36700 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdFLRxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:53:42 -0400
Received: by mail-io0-f176.google.com with SMTP id y77so59137313ioe.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e6p4ai6WkJVNWaiNpVd8vhFQMp2hY4ZI/vPuuZ1CbEc=;
        b=IVCbcl+r1aE42sSbMZuZ9lTVQMBDsvlhK8Q19rX1swdhfhSjEoqlF8yqvMdrMQXjKs
         pupq6SfsySkIx6B9d6R+wQe8Mj6+Yi/CwvAtKO4aTh6e9SbqG67GHZThvrLEyII2I3xg
         a092/njt9HpRd1LVBOUJ3wUS9blXkfU7E5KH/MOMOISAtl1oOhOWKjL1YyYQZVct4yn8
         22Slvl87+GnP7Jg6b8nvJ/iIZKdDTlvaOzpWsHG2ob4fYrk15jDa3W/odNlANT+7bXwC
         M8gGLDAt7Y+nDXiW9NloTl6bji6cKL+mfESLn9AUWBkZpkJfg5ASD2G9FaF9ZvhjXA2W
         Mwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e6p4ai6WkJVNWaiNpVd8vhFQMp2hY4ZI/vPuuZ1CbEc=;
        b=esPX3QeaIP29TjJF+dgOrkALxbMWgpwR/xpndO36eBhVe5OCFq23iBdMIy1mSNp6y/
         9eRWixmo8VSNReFfy1V8LwAcDs7Tc3dL7ENQ4gHBSOxHsi+bfoN3241zlnLc6zuUlAzB
         92QIBjmO2jeWXrLU5/QlWbxiLV72hfPtnl4DGcrPnJhBQhJU2UqNWVmz7BW0jJOJ7tDJ
         REjsYaNreSzLUhpXnHmBWOmSHKldmomuGlKAX6uG9gIJu2shrOZJ7tA6Glm6fVVSzztG
         RX9UWcl/GrRxZ2qKtitebuCY79XqO+sinLNkSkJf+ksICCpWHRFmfiJd7SiXYtrFx23+
         oMyA==
X-Gm-Message-State: AODbwcAiZWs7LSc7T3oqiWkfhfiOhsTV1PfIQ+Wc+Vd7adSwUR2WL36x
        SQIYWaTlMZFSjRnyKZn0IDF3XHLaxg==
X-Received: by 10.107.178.130 with SMTP id b124mr40395303iof.50.1497290022145;
 Mon, 12 Jun 2017 10:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 12 Jun 2017 10:53:21 -0700 (PDT)
In-Reply-To: <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de> <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net> <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net> <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net> <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net> <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net> <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com> <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 12 Jun 2017 19:53:21 +0200
Message-ID: <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Ulrich Mueller <ulm@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 6:56 PM, Ulrich Mueller <ulm@gentoo.org> wrote:
>>>>>> On Mon, 12 Jun 2017, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> On Mon, Jun 12, 2017 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>> Yes, or you could look up a time zone name somewhere else -- except we
>>>> don't have a way to do that, at least for now.
>>>
>>> Is that only "for now"?  I have a feeling that it is fundamentally
>>> impossible with the data we record.  When GMTOFF 9:00 is the only
>>> thing we have for a timestamp, can we tell if we should label it as
>>> JST (aka Asia/Tokyo) or KST (aka Asia/Seoul)?
>
>> It's obviously not perfect for all the reasons mentioned in this
>> thread, but we already have a timezone->offset mapping in the
>> timezone_names variable in date.c, a good enough solution might be to
>> simply reverse that lookup when formatting %Z
>
> That cannot work, because there is no unique mapping from offset to
> timezone name. For a given offset there may be several timezone names,
> or no name at all. (For example, if I decide to commit with my local
> mean time which has an offset of +0033 then there won't be any
> timezone name at all.)

Yes, I understand that it's a 1:many not a 1:1 mapping. What I'm
saying is that %Z in the context of git-log means a human readable
timezone name, and we can just make a best-effort at guessing that by
picking 1/many out of the 1:many mapping.

This obviously doesn't give us the user's timezone, but when you're
browsing through git log you can get an approximate human-readable
idea of what timezone someone was located in, and that's the whole
point of %Z in the context of how it would be used via git-log, isn't
it?

>> Of course we can never know if you were in Tokyo or Seul from the info
>> in the commit object, but we don't need to, it's enough that we just
>> emit JST for +0900 and anyone reading the output has at least some
>> idea what +0900 maps to.
>
> Please don't. Outputting invented information for something that
> really isn't in the data is worse than outputting no information at
> all.

It's not invented information. %z being +0900 is the same thing as %Z
being JST since +0900 =3D=3D JST, just because some other things are also
=3D=3D +0900 that doesn't mean that JST is invalid or less useful than
+0900 or "" for the purposes of human-readable output.
