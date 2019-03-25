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
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B8720248
	for <e@80x24.org>; Mon, 25 Mar 2019 08:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfCYIVb (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 04:21:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42864 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfCYIVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 04:21:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so5469835wrx.9
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vCnfnBWjwc4tr+tOntFHMMTQ4wudOLaaZ/Z9O0Bce6Y=;
        b=TharpcmjVVVaVIghX+WTkSFlsvXXD2svgirCvefMnh9bLA9M2ByZLSe/BzZLfiRAhI
         FNjroFa3XaCFtXWxBG4R1uQPZrsMoVhIJuOTOq6v27JmQUloA5UWLqk9xKQRwbmtmgw+
         W2AJiLupD32in1Hj+TZgk42Vcdlg/aE3J15m3bKcHCSO0WByNSSDcKHbSJoavWoxHY/F
         SpjRBlePaFkaC6YFx6z4RYipDshj1xbDify+5iZpFpj4nqX4gDYDgvD9manESi/Tp8nJ
         k7g+WEepy2c7VyZmIwo7DpXDazzo2lQz7nrPuUVMYV3TzWY5wokx+JVzY10s/kDt5MNE
         JuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vCnfnBWjwc4tr+tOntFHMMTQ4wudOLaaZ/Z9O0Bce6Y=;
        b=DneJ5eT98pCufx0bBrbVWP3fCoqacyJJfAPr3Kr3Ss4U+yU4DpK27NfciRyhJ/4fQE
         seXvRH4c/BEjUdNkAg5QZ47F8y/GjM22J1HEZChffaZziahszlucTAc5gRFzjSBOPQxm
         Hy05pHhW9nDnpvrdpPqzPzw3KS+ZIsU15QPp/axUYwD9WRQ3qM3PBsLcyL2nGDNaRD8l
         3Rb8bFFz1tklmtpex1ZyCLKadEy5D9kuAbfeqrYlOdN4DalYZgTJt/Q4WivELbAoR8e5
         gQuEKTo7DTwGaerYmBBOHZkLAiBxtjc72Rzpedx+QoWv5TPOVHvWEZrb2xcgUEVbeHB8
         oL3Q==
X-Gm-Message-State: APjAAAUGCKdufH7ARI8InfwFiIeIM//aSxFAFwgi4Jiu5JHY2CXJJvGn
        WTyh6yKySysPQpcIYQWMWNo=
X-Google-Smtp-Source: APXvYqyKY7jfiBq2cMvAqTi8h/nxsMx1d0JeeoSkesFI3MddMoxm6nOE+lNNOPVAByjl+ZOjHJSUcw==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr10856073wrs.267.1553502088409;
        Mon, 25 Mar 2019 01:21:28 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g8sm35072249wro.77.2019.03.25.01.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:21:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com> <cover.1553202340.git.steadmon@google.com> <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com> <87bm21coco.fsf@evledraar.gmail.com> <xmqqlg14pi2x.fsf@gitster-ct.c.googlers.com> <87a7hkcome.fsf@evledraar.gmail.com> <xmqqlg13ofqw.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqlg13ofqw.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 25 Mar 2019 09:21:26 +0100
Message-ID: <874l7rcqk9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Mar 24 2019, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> The reason I'm raising this is that it seems like sweeping an existing
>>>> issue under the rug. We document that the "sid" is "unique", and it's =
just:
>>>>
>>>>     <nanotime / 1000 (i.e. *nix time in microseconds)>-<pid>
>>>
>>> If it is just that, then it cannot be unique, can it?
>>>
>>> Let's just fix the wrong doc and move on.
>>
>> I don't see why we wouldn't just fix the SID generation & move on if
>> we're already carrying code purely as a work-around for it not being
>> unique enough.
>
> The thing is, the yardstick to determine "unique enough" depends on
> the caller.  In this codepath, we want the uniqueness within the
> directory that was given to us, and one reasonable way, among the
> most sensible ones, is to ask open(O_CREAT|O_EXCL) and it makes 100%
> sense to fall back with suffix when "enough" thought by the callee
> turns out to be insufficient when judged by the caller.
>
> So I do not see the .%d suffix a work-around at all.  I view it as
> an integral part of the whole package.
>
> By the way, is the "nanotime" implementation that may be in compat/
> fine grained enough?
>
>> Of course nothing is *guaranteed* to be unique, not even a 128-bit
>> UUID. The point is to pick something that's "unique enough" given the
>> problem space, which is already one where we'll ignore I/O errors on
>> writing the file unless you opt-in to a warning.
>
> Yes, the point is to pick something that is unique enough and then
> give a reasonable fallback when it turns out insufficient.  I think
> ".%d" suffix is one reasonable fallback, but I realize that it is
> not the only reasonable fallback.  Another reasonable fallback could
> be "upon seeing a failure of open(O_CREAT|O_EXCL), we give up and do
> not leave a logfile, because this should be a rare enough event as
> our assumption is sid is unique enough for everyday operation".
>
> I could buy that, especially if the ".%d" suffix fallback is too
> expensive to carry and maintain into the future.  And in such a
> case, it indeed would be a more reasonable workaround for a rare
> non-unique sid problem to ignore and discard the log.
>
> I just did not think the ".%d" suffix fallback is too expensive to
> carry.

Oh yeah, the SID.%d fallback is easy enough, and I'd 100% agree that if
that was *all* it was this would all make sense. Let's just retry, just
like a tempfile implementation will retry.

But I'm not interested in using the SID-per-file format Josh is adding
here, but *am* interested in having a logging system where over a bunch
of machines I can expect the SID to be unique with a high degree of
probability.

So this open(O_CREAT|O_EXCL) code is revealing a problem that we're also
going to have in a different form in the
GIT_TR2_EVENT=3D/var/log/one-big-file-of.json format.

It seems to me that the only reason both of these are an issue is
something we can fix with the SID generation.
