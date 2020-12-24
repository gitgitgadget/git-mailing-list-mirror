Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F33DC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA1022285
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLXGgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 01:36:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63152 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXGgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 01:36:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90D9A11BBCE;
        Thu, 24 Dec 2020 01:36:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Im41GIu45nrhzgYpkHa5GGFx1N8=; b=WbVGRt
        s1EUhvkkTuiGG+WVENXOR1YGTeODU1wP8z7YjDni4YoxVSXidvJ4dlCIF0HEs8Mj
        MAHel0VHJ7k2Lwu5+wvhHgOVLY07HDSBx4hqb4Uo3cxvX4XDZ7fc5UDeUal+evIh
        ZHAbnWWVZQ1rnD6QtzP+ToEzj5tRIWI584RZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=InpmY62qeSaFR6CTKef2l9By0bUMqTCm
        NUMRB10iS/2KzUjZcAlTEm247uoijLFY+UipqwFvTxhg4sFdZMwJYnh8uM5uXYsJ
        9uzumWKeLnbdyWKD8kTojsRueGAn7l/M32M56xFnXIYDC2/tJSAKN3PcwxDlXU6p
        NWfJU747B8Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FF5411BBCD;
        Thu, 24 Dec 2020 01:36:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C100011BBCC;
        Thu, 24 Dec 2020 01:36:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.30.0-rc2
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
        <CAP8UFD3aHEpHZWxzwz=RQr7DNAmJhLeoiOzubRqk1=7gRyG4_g@mail.gmail.com>
        <xmqqblej4t1a.fsf@gitster.c.googlers.com>
Date:   Wed, 23 Dec 2020 22:36:07 -0800
In-Reply-To: <xmqqblej4t1a.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 23 Dec 2020 22:28:17 -0800")
Message-ID: <xmqq7dp74so8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E7A07F0-45B2-11EB-B5BB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> Most of the suggestions below are found by GMail.
>>
>> On Thu, Dec 24, 2020 at 12:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> A release candidate Git v2.30.0-rc2 is now available for testing
>>> at the usual places.  It is comprised of 19 non-merge commits since
>>
>> Maybe: s/is comprised of/comprises/
>
> Funny.  
>
> I do recall somebody else (perhaps Peff but I may be misremembering)
> helped me grammofixing the use of verb "comprise" in the sentence
> when I started listing the names of commit authors back in v2.3.3 or
> v2.4.0 era.  Perhaps I failed to follow the advice given?  I dunno.

Ah, just to avoid duplicated archive digging effort, it indeed was
in https://lore.kernel.org/git/20150312223131.GA24492@peff.net/
where Peff said

    > ... usual places.  It comprises of 41 non-merge commits since
    > v2.3.1, contributed by 19 people, 5 of which are new faces.

    It's not generally considered correct to use "of" with the active
    tense of "comprise". So either:

      It comprises 41 non-merge commits...

    or:

      It is comprised of 41 non-merge commits...

    is fine.  The latter is much more common, at least in American
    English, though I imagine it gives some prescriptivists headaches.

and the Meta/Announce script has stuck to the latter form since
then.

Thanks anyway.
