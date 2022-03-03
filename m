Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B52C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiCCWbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiCCWbK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:31:10 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E8134DF1
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:30:23 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4651B10757F;
        Thu,  3 Mar 2022 17:30:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JlMydHymrQcbL2uDSuFWR2wESbqVoXEeFeU4R9
        sarmw=; b=neK5ZWXNu/skb8twFgt1SGuaVOPy0sfDzIooPAykquTelYTFJOrI29
        BRsGW1u9Y+TQ7Oex5ztO646vI5RazcRH0KTHdeWknDGCQ4JQ+mZdY2I/DzJOSEIZ
        6eXA46NxZfTLr3K8DGXaqDXP6/ME877DSbBfF6A8gF0m/NXs5Xcjo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD9210757D;
        Thu,  3 Mar 2022 17:30:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A70CE10757C;
        Thu,  3 Mar 2022 17:30:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <nycvar.QRO.7.76.6.2203012024210.11118@tvgsbejvaqbjf.bet>
        <20220303173456.3773-1-chakrabortyabhradeep79@gmail.com>
Date:   Thu, 03 Mar 2022 14:30:20 -0800
In-Reply-To: <20220303173456.3773-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Thu, 3 Mar 2022 23:04:56 +0530")
Message-ID: <xmqqv8wu7jpf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83BCA70C-9B41-11EC-B8D5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> And since Abhradeep is a new contributor, I found it important to steer
>> the direction toward sound advice that they can use over and over again
>> over the course of their career: whenever possible, prefer static checks
>> over runtime ones.
>
> Thanks Johannes for the advice. I will always remember it ^^

Yup, if we can have static and dynamic checks of the same quality,
static checks are always better alternative.  In this case, runtime
check would probably be an expedite solution suitable for a shorter
term to fill the gap, as a static check with the same quality as it
would probably need some time to develop.

> Since Junio and you both have an interest in Coccinelle, if you allow,
> I want to look into it.

I do not have any particular interest.  If it is a tool fit for the
task, it would be good to use it, that's all ;-)
