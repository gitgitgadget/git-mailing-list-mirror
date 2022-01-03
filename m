Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67814C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiACWkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 17:40:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53470 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiACWkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 17:40:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B92E6170BE2;
        Mon,  3 Jan 2022 17:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mUCR8bU/xAqnxFOXR7mxSIy9Y
        1iKaJySNsq0MxAAQBc=; b=pob0esZs/Wva8BTkcUGnpmdNrIg5MbUlpVArnHzkM
        ABx1wo0MjhA76vU92s5A6+u16l4EnVN0qzazejJaLV/XjmwdcCtQagqTUEh676HE
        Yjzet7cT9xP1+K3rRy5RwSpWlCUlq1VCkW74YovtjQdKPSnT4xo9gEsGkGuWqnsr
        18=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1B3C170BE1;
        Mon,  3 Jan 2022 17:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE177170BE0;
        Mon,  3 Jan 2022 17:40:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/1] grep: align default colors with GNU grep ones
References: <20211216115622.85506-1-lenaic@lhuard.fr>
        <xmqqh7b88b3o.fsf@gitster.g>
Date:   Mon, 03 Jan 2022 14:40:46 -0800
Message-ID: <xmqq4k6kjvdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32072C68-6CE6-11EC-8252-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:
>
>> git-grep shares a lot of options with the standard grep tool.
>> Like GNU grep, it has coloring options to highlight the matching text.
>> And like it, it has options to customize the various colored parts.
>>
>> This patch updates the default git-grep colors to make them match the
>> GNU grep default ones [1].
>>
>> It was possible to get the same result by setting the various `color.g=
rep.<slot>`
>> options, but this patch makes `git grep --color` share the same color =
scheme as
>> `grep --color` by default without any user configuration.
>
> I am not a huge fan of adjusting our defaults to other people's
> default, since it will lead do an inevitable "Why don't they adjust
> to match ours?" question, plus "We've been happily using the default
> coloring, and you suddenly changed it to something ugly. We want our
> color back and we do not care that now you match what GNU does".
>
> The UI color choice is so personal, which does not help us either.
>
> Having said that, I'll keep an eye on what others say on this
> thread.

It's been a bit more than a week and it seems nobody else is
interested in supporting this change [*1*].

Whether we want this change or not, I just noticed that the real
patch [1/1] has no commit log message, and most of what is in the
above "cover letter" would would make a good material for the log
message.  Perhaps we'd want to redo the log message if it turns out
that we want to take this change.

Thanks.


[Footnote]

*1* "Nobody is against" is not even an argument, by the way.  If we
    took changes only because they see no objection, we will force
    reviewers to shoot down all nonsense changes and wear them down.
    The default for any new change is "not to apply" until it turns
    out that it is beneficial.
