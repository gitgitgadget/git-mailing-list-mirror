Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54EFC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B477464E33
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhCJVkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:40:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61482 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCJVkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 16:40:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DC6CB4B04;
        Wed, 10 Mar 2021 16:40:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+UoSGFIapChXNF6aMrDo+LoZ1A=; b=M2ymPa
        N/HID68Rfe4OT24S8tX5Ys1isKPX5Qa8S+O/DPSs51IuoGlO7pcjji27An5cf6I+
        wX3nWxCjXy1i7ucglTkUD3OsLtLAcnHkWt9GfLmrqEVk0M5jUCRT+gm+vuXVhW1X
        lBVyL01Of5zBeVQeVLdRiU+lAvJtx2znfiAYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iv3MGIuBe9QrEWa+Cn5nQ5b523hHMcGv
        Plh7JP0yzarfYoC4bsiH0Ks7GHRB5Vm1ykT/IbIs8pJlXDvWra2JsslEZWCUfhaE
        mSWexTRnssUjggnKrVnyhymBMNIE9ryHrSQO0VWL8cj4d5oig3iTSzDwilbDD35F
        0WE+Fz4dSEM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D564B4B01;
        Wed, 10 Mar 2021 16:40:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CDEEB4AFC;
        Wed, 10 Mar 2021 16:40:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Daniel Gruesso <daniel.gruesso@gmail.com>,
        "Patricia B. C." <pati.camsky@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: RES: Can git change?
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
        <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
        <xmqqpn1w95dj.fsf@gitster.c.googlers.com>
        <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
        <xmqqh7n85qwd.fsf@gitster.c.googlers.com>
        <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2101251650150.57@tvgsbejvaqbjf.bet>
        <CAFdpPnBG==5L6hwH6h2JTFtYVQqLZUcCi4+wzL_cpKKg_X3yoA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2103101038170.50@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Mar 2021 13:39:59 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2103101038170.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 10 Mar 2021 22:03:29 +0100 (CET)")
Message-ID: <xmqqy2euit74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B74EBDA-81E9-11EB-BF50-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I guess that something like 6 months of a "deprecation period" (i.e. the
> time to keep `master` as the default) _might_ be enough, so we could
> potentially move forward with changing the default around end of May (by
> my calculation, v2.32.0 should be due around May 24th, that might be a
> good candidate to target).

You are apparently more ambitious and risk tolerant than I am.  I
was expecting it to be more towards the end of the year myself.

And we already made sure that it would be easy to interact with
projects by using the same primary branch name as the upstream
project uses when cloning; hopefully by the time we change the
built-in hardcoded fallback default, it would not have much impact
to the real life usability than it is a symbolic act.

