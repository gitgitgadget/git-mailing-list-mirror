Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714BC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhKVTB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:01:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57119 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhKVTB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:01:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AAEBE80D0;
        Mon, 22 Nov 2021 13:58:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J0JK25F82rvDIBjYeNNhR9FvCbh+iYr/z6sRyx
        ijqzs=; b=CDCbd+PNNqOMjjgSsWCgyoG36bZUMP/t8yQKx/rG2UAkY9VD5V+CAb
        fuskfRq1/lnX72UQ+pEQJpaDZ3dDWjoYmtRwveDOV1c8QPVRnrNH8CTfQpk2/Yjz
        MBt4gSyzagh3P2JzO2T7W5n/ff6maZmqOfXgfycH0eCbJkagV3QSY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 405C5E80CF;
        Mon, 22 Nov 2021 13:58:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C28EE80CE;
        Mon, 22 Nov 2021 13:58:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
        <20211114211622.1465981-2-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
        <xmqqk0h7423v.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
        <xmqq1r38hzi9.fsf@gitster.g>
        <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
Date:   Mon, 22 Nov 2021 10:58:47 -0800
In-Reply-To: <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 22 Nov 2021 09:52:16 -0800")
Message-ID: <xmqq8rxgf254.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39C71FBC-4BC6-11EC-9F65-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Nov 22, 2021 at 9:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> I had an impression that it was claimed that without this, the other
>> weatherbaloon for "for (type var=..." would not fly in some of the
>> jobs we have at CI?
>
> It wouldn't if we have a CI job that tests with gcc < 5 but the last
> version of that job died with travis-ci.org

I was wondering how Dscho's test was not failing, and that is an
easy answer to that question ;-)

If we wanted to resurrect that CI job, we can always add it in the
CI definition anyway, so I am OK with that, too.  

Thanks.
