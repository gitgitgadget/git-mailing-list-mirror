Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F4C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 20:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKVUzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:55:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64850 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhKVUzP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 15:55:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FB3BF5128;
        Mon, 22 Nov 2021 15:52:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bJuQDDjxJkZBm7WDHf6FDoHqs0GCGr58iQ7SOQ
        r4tsQ=; b=F6zumRJRRrPoCVKjLMB31Cn9BeCzJa3wSRiXbBgWp91czlPcrR7dsR
        5Fe7XEuRwkxrYiB2hYbHT7J7KsJ5AjfphoYXU6CnFAG6Y4d7JxQTM9ONpihMs+eD
        vaQDNRqaCJjex2pykN5pCVlDxas8zP02Sy8YFUlgBqfkIdqbOKn3o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E504F5127;
        Mon, 22 Nov 2021 15:52:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A28C7F5126;
        Mon, 22 Nov 2021 15:52:06 -0500 (EST)
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
        <xmqq8rxgf254.fsf@gitster.g>
Date:   Mon, 22 Nov 2021 12:52:05 -0800
In-Reply-To: <xmqq8rxgf254.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Nov 2021 10:58:47 -0800")
Message-ID: <xmqqv90jewwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DB75422-4BD6-11EC-9EAB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Arenas <carenas@gmail.com> writes:
>
>> On Mon, Nov 22, 2021 at 9:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> I had an impression that it was claimed that without this, the other
>>> weatherbaloon for "for (type var=..." would not fly in some of the
>>> jobs we have at CI?
>>
>> It wouldn't if we have a CI job that tests with gcc < 5 but the last
>> version of that job died with travis-ci.org
>
> I was wondering how Dscho's test was not failing, and that is an
> easy answer to that question ;-)
>
> If we wanted to resurrect that CI job, we can always add it in the
> CI definition anyway, so I am OK with that, too.  

But if we were to do so, perhaps we'd want something like what I
gave at https://lore.kernel.org/git/xmqqy25lwa86.fsf@gitster.g/ in
its place to avoid confusing people.

Let me update that topic before dropping the one under discussion.

