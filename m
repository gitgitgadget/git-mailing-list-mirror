Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00386C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB88261107
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347140AbhIXPen (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:34:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55456 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbhIXPem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:34:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 489A8151D4D;
        Fri, 24 Sep 2021 11:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fAbbmv2lJz/IsHUfzWeV3g820+201cS6EB6OVR
        U+edM=; b=hOz3BQ2Uu7MA4x9DjkO+u26eiSNnb2stLc7sf2tNm/135+nIj45f4S
        oqvS316T4XZP4bYYBo1xQqhXEnJLCNj/+QJgDPwjhQHjePKDBALQzTsmGRE18HWW
        uDab+Y4jEouN9d04sEZ1TfMIKpwPNYAHUwe0AmcjEkKHKFvjLlNaA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D6FD151D4C;
        Fri, 24 Sep 2021 11:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83227151D4A;
        Fri, 24 Sep 2021 11:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
References: <87zgs34ccx.fsf@evledraar.gmail.com>
        <20210924024606.20542-4-tbperrotta@gmail.com>
        <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
        <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
Date:   Fri, 24 Sep 2021 08:33:05 -0700
In-Reply-To: <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 23 Sep 2021 21:53:54 -0700")
Message-ID: <xmqqzgs2vvim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6F04B38-1D4C-11EC-AC64-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, Sep 23, 2021 at 9:36 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 24/09/21 09.46, Thiago Perrotta wrote:
>> >   SYNOPSIS
>> >   --------
>> >   [verse]
>> > -'git send-email' [<options>] <file|directory|rev-list options>...
>> > +'git send-email' [<options>] <file|directory>...
>> > +'git send-email' [<options>] <format-patch options>
>> >   'git send-email' --dump-aliases
>>
>> Is <format-patch options> optional? If so, we can say [<format-patch
>> options>].
>
> no; as Junio explained [1] this omission is intentional while the
> rev-list options that
> got cut to make space are not and are more relevant.
>
> IMHO leaving [<options>] to imply ALL options (that also include diff
> options, for example) is better

Could you claify this idea a bit more?  Do you mean that the second form
can just be:

	git send-email <format-patch options>

That will exclude the send-email specific ones (like
"--in-reply-to=<msg>"), so it may not be a great idea.

Or do you mean

	git send-email <options>

and have the <options> placeholder to stand for both send-email
options and options meant for format-patch?

Thanks.
