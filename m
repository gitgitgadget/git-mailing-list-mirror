Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD13D20248
	for <e@80x24.org>; Tue, 12 Mar 2019 12:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCLMJs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 08:09:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34921 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLMJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 08:09:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id g19so2085218edp.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=va+s2hE5RqzgFCqqnIcBGz2dCiWTfcutz3NQXmaUY7k=;
        b=TFRXsaYzkFr+Qd0rOr/mQH9C3g+Irnm3QMb+kFo+wz5/zIFozZkiv0OBGcNt+3sfZv
         RoEhzv9/rmHQL4zHU9qrMoFNQhgbGtCF4+lKU/zgOQhCJy5T5fC1cdPCnZawem483LCw
         wC2ZKir+zAv41opRF4wy3KeKkj71oQiWDx3vWwcGIt3o1FS/6smWZALK9SOCdJUzRK5L
         XsArODkJiIWENmMwbAfMTkcLaCmOcnEUs10GG09dyxSGoEHYqBY+F57u+4HNTAia/cuA
         xOa0crlenhGZJAyzvbNFoJThJcwfIryJ/+2Lwoe884HowpN3E6NrREOXHe/xu0LVyKQR
         MIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=va+s2hE5RqzgFCqqnIcBGz2dCiWTfcutz3NQXmaUY7k=;
        b=fMJDO2CfsvSAYDRxRScEBYf251cjKKfTvCdty7oIi+tpg8C7BGf6uo1Je4HKW9Cevs
         xX5OxdgIDVLPTrhEpTKcz7EEmqytq0F3zJe7NJYtuoe86I+Zd2FVxhT9d1Ms+y/OVDP5
         cuKme9ibjKTnI2awMoq0e0DrizLm/rYCRmNDUiFIDm42CYa8IMtzpIbhQ9oNidqZfM5q
         JrIvesXpT933FdHN0GoTS/6WtK9NgHVUCitkMSPJN57J70s/GrSWzSPvLhqMiMg0JwCg
         Y6NfnBoZ5uyaO7WWfxYIGzlLhiFIAm2A4M7rlwqA/uUxtU/h8MJj2ZGfT8pOjxPtSOGJ
         Ih6A==
X-Gm-Message-State: APjAAAVcxzdv8I7mGd/nGj6tGbHJi4hdFF7WTGO1ZeOkSys3lmXjhBbL
        tzOWqp8i807eoyTzSyvFjxQ=
X-Google-Smtp-Source: APXvYqxrMJHEztwhGBpapQ1WpyQwIG39ab++ukJt5x5WySdxtYMtADdvqoURogQi9FK4s7iXpIsNng==
X-Received: by 2002:a50:a7e5:: with SMTP id i92mr3231802edc.181.1552392585725;
        Tue, 12 Mar 2019 05:09:45 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o23sm3634176ejg.28.2019.03.12.05.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:09:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test on Fedora 29
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
        <20190308174343.GX31362@zaya.teonanacatl.net>
        <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
        <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
        <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
        <20190311033755.GB7087@sigill.intra.peff.net>
        <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
        <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
        <20190311182328.GB16865@sigill.intra.peff.net>
        <8736nscw2y.fsf@evledraar.gmail.com>
        <20190312110549.GC2023@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190312110549.GC2023@sigill.intra.peff.net>
Date:   Tue, 12 Mar 2019 13:09:42 +0100
Message-ID: <87y35kb8ft.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 12 2019, Jeff King wrote:

> On Tue, Mar 12, 2019 at 09:53:41AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> There's a at least a couple of aspects to this.
>>
>> One is whether we should have the submodule in
>> sha1collisiondetection/. I agree that's probably a bad idea now
>> per-se. Honestly I wasn't expecting the answer when I submitted the
>> final patch to switch to it fully to be to the effect of submodules
>> being too immature for the git project itself to use. So now we're
>> effectively mid-series, and should maybe just back out.
>
> I think it's especially funky because we have three different ways of
> getting sha1dc (in-tree, submodule, or against an external library). And
> I almost blindly submitted a patch making the in-tree version work
> (since that's what's used by default, and what I use) which could have
> totally broken things for the other use cases without anybody realizing
> until the change trickled down to somebody who uses those flags.
>
> (Technically in this case it wouldn't actually have _broken_ them, but
> just not helped them, so they'd be no worse off. But hopefully you get
> the point).
>
> Speaking of external libraries, in some ways the issue I raised is no
> different than it is for any external library, where we're at the mercy
> of whatever version is on the system. The big dependency for us is
> usually libcurl, and we do have to sometimes work around old versions
> there.
>
> But I do think there's one thing that make the sha1dc submodule approach
> more painful is that we don't control the content of the code, but we
> _do_ build it ourselves with our usual compiler flags. So we're weirdly
> intimate with it (and in fact, an external library would not have the
> problem being discussed here, since it would have been built separately
> without UBSan).
>
>> I fully agree with what you've said in theory, but if we look at what's
>> happened in practice we as a project are demonstrably not disciplined
>> enough to manage upstream code like this without overtly perma-forking
>> it.
>
> I'm not sure I agree completely. Most of the things we've imported are
> small enough that we're reasonably happy to accept them as a snapshot in
> time and take ownership. I.e., I do not recall a lot of instances of
> fixing bugs in compat/regex or compat/poll that we could have gotten
> more easily by merging from upstream. But I admit I don't actually pay
> much attention to those areas, so I might be completely off-base.
>
> The one place I really _would_ have liked to remain compatible with
> upstream is xdiff. And we were traditionally pretty hesitant to clean
> things up there for fear of diverging. But in practice, upstream there
> has been stagnant, and we've done most of the bug fixes and improvements
> to it (in-tree).
>
>> As far as I can tell none of the people changing that code went through
>> the process of submitting a parallel upstream fix or seeing if the issue
>> was fixed upstream and we could just update the code we were carrying,
>> and of course that gets progressively harder for any one contributor as
>> our divergence grows.
>
> To be clear, I do sympathize with the notion that not pulling things
> in-tree keeps our relationship with upstream more disciplined, and that
> has value. I'm just not altogether clear how much it's really hurt us
> overall to be undisciplined.

I agree that say the compat/regex divergence hasn't hurt us much if at
all. Just that we have a few conflicting desires:

 A. Make sure you can "make" git by default without pulling down a bunch
    of libraries, especially if they're not ubiquitous. Thus shipping
    the likes of sha1dc.

 B. Being able to hotfix those libraries.

 C. Upstreaming those hotfixes when they happen.

 D. Updating the library we pulled in due to "A" from upstream.

In practice because we've wanted "A" we've felt the need to do "B", but
then also not "C" without ever having the discussion that skipping that
part was a good idea, and as a result "D" is hard.

Do we urgently need "D"? No. I'm just pointing out that in addition to
optimzing for "B" being easy we should also weigh being good free
software citizens and coordinate fixes with upstream, which also makes a
future "D" easier.

Also, while I don't know of any bugs in compat/regex. I think it's a bit
concerning that we're carrying 2010-era code for something like the
regex engine that we expose e.g. over gitweb.
