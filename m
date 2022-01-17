Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F755C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiAQSmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:42:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52325 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAQSmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:42:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FC8010FACA;
        Mon, 17 Jan 2022 13:42:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UHW2gIxMJplEetQlxwfEc/wQ2+ZmUhd/9IFTeB
        Tl0Ww=; b=Y8wHYRFJdyAcQ4MkT/3H8f18MHePQo/+dUllrEj3GUPW7x4neOPyUq
        mq1dCUpbivGNq5TK3H4dIIHoppCBvuolj5+OZB2xWfqwdxGJWRmhre8KrEv0Q27e
        OFWvmOZLp1fZRW5t9MOOwX3aJ40k/EPYVXWNP9u3okhWU++d2k8Xw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2680E10FAC9;
        Mon, 17 Jan 2022 13:42:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF72E10FAC8;
        Mon, 17 Jan 2022 13:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.35.0-rc1
References: <xmqq35lp68rw.fsf@gitster.g>
        <026201d80bbc$10a251a0$31e6f4e0$@nexbridge.com>
Date:   Mon, 17 Jan 2022 10:42:02 -0800
In-Reply-To: <026201d80bbc$10a251a0$31e6f4e0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Mon, 17 Jan 2022 11:05:31
        -0500")
Message-ID: <xmqqy23eurut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A1F856A-77C5-11EC-BCEA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On January 14, 2022 9:19 PM, Junio wrote:
>> A release candidate Git v2.35.0-rc1 is now available for testing at the usual places.
>> It is comprised of 467 non-merge commits since v2.34.0, contributed by 80
>> people, 32 of which are new faces [*].
>
> FYI: rc1 built/test (mostly) passes on both NonStop x86 and ia64 platforms.
>
> We seem to have a recurrence of a transient failure in t5562 from a few releases ago. Retesting makes the problem disappear.
>
> Subtest 8
> #	
> #		test_env HTTP_CONTENT_ENCODING="gzip" test_http_env upload empty_body &&
> #		! verify_http_result "200 OK"
> #	
> Subtest 14
> #	
> #		test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive empty_body &&
> #		! verify_http_result "200 OK"
> #	
>
> Am I mistaken that using the ! verify_http_result construct is not recommended or am I misremembering the discussion?
>
> Regards,
> --Randall

I do not recall anything about that shell function.

I found a half-thread with similar-looking report on an obscure
system, since the 2.25 era:

https://lore.kernel.org/git/nycvar.QRO.7.76.6.2003252000200.46@tvgsbejvaqbjf.bet/

And then from you that is even older, in the 2.21 era:

https://lore.kernel.org/git/002201d4c560$5a319c40$0e94d4c0$@nexbridge.com/

But neither seems to lead to a discussion on the use of verify_http_result
helper.

