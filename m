Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D3BC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2293622AAF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbhAKAWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:22:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50166 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbhAKAWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 19:22:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16865AB05F;
        Sun, 10 Jan 2021 19:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8cZ5LezvUghx
        MavKkVuJc5OWzHQ=; b=JbkdXKa/LEhPY93Idhe1NylxVXGBps5aBSHfDwS1H3Ne
        8HA3FsaaQULtjbFjAjadXT7J/zRRjVRSHhctw+tT9+mZaHAnTHhe5f+6w+kyXFI3
        JPWU+pWi46jN0lx3Md9vyatNydfsIzSN2Bb7+T7Q7P/blocKf1JlMwLZinWAMTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qyifiS
        oLBjfhA3ek8zSVWPnRBHANCJcwU+s3VC6WJ/5oDLfgWyk/Yn8xu9AUNjLwbXkjG+
        yE+dJTwPCbaQW0H9BxS85EKaBcOJn6Vnvdww9fjfLz2LsmmuryGmnDI4ic1aBBLs
        B3bbuJQrU8BFl2vnxWTsvdoN+Wb2Bl7NhtPAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DFA6AB05D;
        Sun, 10 Jan 2021 19:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 963A3AB05B;
        Sun, 10 Jan 2021 19:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
        <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
        <87v9c462ht.fsf@evledraar.gmail.com>
Date:   Sun, 10 Jan 2021 16:21:49 -0800
In-Reply-To: <87v9c462ht.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 10 Jan 2021 20:00:46 +0100")
Message-ID: <xmqqv9c48grm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FFCBDC1A-53A2-11EB-A319-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Jan 09 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> I forgot that, oops. Is just declaring here that all of that's:
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>>>
>>> Since you have some acks etc. squashed into it at this point...
>>
>> Puzzlled.  The patches on the trailers topic were all signed-off by
>> you, unless I was careless when I checked before merging them to
>> 'next'.
>>
>> Do the above three lines refer to a different topic, on CoC 2.0?
>
> Yes, I accidentally snipped out the part I should have been quoting. I
> meant "please assume my signed-off-by" to be in reply the CoC 2.0
> series.

Thanks.  Will squash your sign-off in.
