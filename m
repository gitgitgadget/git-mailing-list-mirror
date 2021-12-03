Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE28C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhLCSuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:50:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhLCSuG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 13:50:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E298164279;
        Fri,  3 Dec 2021 13:46:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MLon+0jK+XQZKYfX0GJ8J4s9lOvAsgPOm9AkQx
        4MyqI=; b=NT53fbbmKW0Xfcs6l8/iu9GgcL/11nfuv/zX0fdVNl6YmYbAiaIlJ6
        wpTZljr016hAAUTib3Pw0OTvbrK5N8Cac+2jptZu3jvXeFgX/xQMy3Q9Cvuf5mKa
        zHeIgUO06TlEY8kyDzzzjikxX8Zl5UKEidK5oe8WfU57dFwaPWrw0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07729164278;
        Fri,  3 Dec 2021 13:46:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 158BA164277;
        Fri,  3 Dec 2021 13:46:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
References: <20211117093529.13953-1-fs@gigacodes.de>
        <20211130141112.78193-1-fs@gigacodes.de>
        <20211130141112.78193-8-fs@gigacodes.de> <xmqqczmfyi44.fsf@gitster.g>
        <20211202093126.nuuvxjnhbkdu5pwn@fs> <xmqqwnknue3n.fsf@gitster.g>
Date:   Fri, 03 Dec 2021 10:46:36 -0800
In-Reply-To: <xmqqwnknue3n.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        02 Dec 2021 09:10:52 -0800")
Message-ID: <xmqqo85xsf03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E04CE2-5469-11EC-9BCA-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Fabian Stelzer <fs@gigacodes.de> writes:
>
>> Yes, that looks good. In this case the conflict is rather trivial, but
>> how could i prevent this / make it easier for you to merge these?
>> Especially since in this case the conflict only arose after a reroll
>> when both topics were already in seen. For a new topic i can of course
>> make them as "on top of XXX". Should I in the future rebase the
>> "support non ssh-* keytypes" topic on top of this series and mark it
>> as such? Or whats a good way to deal with things like this? (besides
>> avoiding merge conflicts altogether :D)
>
> For this particular one, my rerere database already knows how the
> conflict and its resolution should look like, so there is nothing
> that is urgently needed.
>
> If the other topic were to be rerolled, since either has hit 'next',

Sorry, "since neither has hit 'next' yet," was what I meant to type.
Not being in 'next' allows us to replace the series without having
to do "oops, that earlier one was wrong, and here is a band-aid".

Thanks.

> basing it on top of the other, essentially making the result into a
> single series, may be the easiest (and that is basically avoiding
> conflicts altogether ;-).
>
> Thanks.
