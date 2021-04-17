Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18271C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 01:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21556101D
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 01:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDQBzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 21:55:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51321 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQBzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 21:55:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EC7F1189BE;
        Fri, 16 Apr 2021 21:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cNoA6tuP76u1s1LOGSs5ScheoOk=; b=RHAO6xq1w3zhrMskn2k9
        XQ76z3roZQS6rzFkFFcT4dNgJHpWlfbR9sI/O3g8iIMGslMd8R5bG5Tzhi9+fNUh
        yaHJCUKGQK3RFSm7FlRVVZbhteLUKRYlOTS/24J5ziW1jmqtDWe3WE5ZNU6huPqL
        Q4lP+A6MgkRjVL5coPAXLRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=QuDksdTxB6iv7ZtZ2M+cYR219YNAqgx+gERC5gNRkZYX8P
        h+BNwRAbV6EDLc3VdvB1RXART+Gx0tqBEfUMZDUWPRrY2uu5j1w3OjfCbbTLm8O2
        2Z9yL2i038dJWLc9WvMdgJYnyOHmIPAYNx2NZlvzLGFsEXDCi9lMDjiIXSr0I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5794E1189BD;
        Fri, 16 Apr 2021 21:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A05481189BC;
        Fri, 16 Apr 2021 21:54:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v9 1/2] [GSOC] docs: correct descript of
 trailer.<token>.command
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <8129ef6c476b4f35be59eae71367de5b83888068.1618245568.git.gitgitgadget@gmail.com>
        <xmqqwnt7b5fg.fsf@gitster.g>
        <CAP8UFD2gUbWP2LWXDt1nmph1qMyhEBfLErw3=5OTBx-KeBQBVQ@mail.gmail.com>
Date:   Fri, 16 Apr 2021 18:54:37 -0700
Message-ID: <xmqqtuo5iski.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEDC3B8A-9F1F-11EB-9075-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> $ git config trailer.sign.command 'echo "$(git config user.name)
> <$(git config user.email)>"'
>
> My opinion is that we should have added a `trailer.<token>.runMode`
> config option along with `trailer.<token>.command`. This was not
> discussed unfortunately when ".command" was implemented, but it seems
> to be a good idea now.

Yes, without a knob to diable/enable, the "feature" is pretty much
useless.  

> It can be avoided when the --trim-empty CLI option can be used. A hook
> to remove empty trailers (which might call `git interpret-trailers
> --trim-empty` itself) could also be used when --trim-empty cannot be
> used directly.

And as you know, --trim-empty that applies to all trailer keys would
destroy other trailers and trailer.<token>.trimEmpty, even if it
were available, would not work at all to remove it for the case you
cited above, to add "user.name <user.email>", which is not an empty
string.

> I agree that the current mechanism cannot easily emulate "commit -s".
> ...
> I agree that --trim-empty is not usable sometimes. Another idea would
> be to add 'trailer.<token>.trimEmpty' to be able to do things like:

"easily"?  "sometimes"?

"--trim-empty" is unusable, trailer.<token>.trimEmpty would not work
even if it were added because the reason why this is broken is not
because it gives an empty value, but because it runs even when it is
not asked and there is no way to turn it off.

This shows that even the only plausibly-useful use case we've seen
so far is not very well supported, and necessary options/knobs to
make it usable have not been invented and implemented.

It is time for us to admit that this is a misfeature that is not
well thought out.  Recognising that .command is broken is the first
step to remedy it with a better alternative in .cmd; otherwise we
would inherit the same breakage in the replacement.

The only reasonable way out I would think of is to hide the
unconditional execution behind trailer.<token>.runMode, and make the
default for runMode to "do not run when --trailer=<token>[:<value>]
is not asked from the command line" for .cmd; it is OK for .command
not to honor the knob, as we will get rid of it once we see .cmd
works well.

Thanks.
