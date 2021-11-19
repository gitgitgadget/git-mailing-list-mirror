Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56572C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhKSV4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:56:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63282 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhKSV4o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:56:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA3F816FF6E;
        Fri, 19 Nov 2021 16:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DHFd+zNTWnAu
        JbKuoQtZMfDX5/aEHNvxnvKpICeRF/o=; b=kZL47O/uvxlUuF8aghj0qMnOj2bb
        TEkjRRohgro9S3Zo8Cu3amkJZ/kqzO9i68yk8l5u113FD0xwH73p4eb0X2rnLTdY
        FxgWqrw5OXkSME7oGeuTDPcbFTrp+yBZrntBJlaluFKGKJ+ijv1tz/TuqNlNTcyh
        Ei8lGsu89XBBZ9I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A332F16FF6D;
        Fri, 19 Nov 2021 16:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07E3F16FF6C;
        Fri, 19 Nov 2021 16:53:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] json-writer.[ch]: remove unused formatting functions
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
        <patch-6.6-e14ee1f8c47-20211119T124420Z-avarab@gmail.com>
        <YZe3nRLPV4FrzbDq@coredump.intra.peff.net>
Date:   Fri, 19 Nov 2021 13:53:38 -0800
In-Reply-To: <YZe3nRLPV4FrzbDq@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 19 Nov 2021 09:41:33 -0500")
Message-ID: <xmqq7dd3q0bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27E4DA90-4983-11EC-A74B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 19, 2021 at 01:46:26PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> These were added in 75459410edd (json_writer: new routines to create
>> JSON data, 2018-07-13) for future use with trace2, but have not been
>> used by anything. These are easy enough to bring back should we need
>> them, but until then there's no point in carrying them.
>
> This is another one where I could _imagine_ somebody using these in a
> custom patch or topic in flight (though I don't have any such case
> myself). And they complete the json-writer API, so keeping them is not
> that ugly.

This falls into the same category as 5/6 in my mind.

> But I'm also OK with dropping them under the notion of cleanliness, and
> that they're easy-ish to resurrect.

Again, all the same "resurrecting is the easy part, knowing we used
to have one is hardre", "keeping is not without cost", "apparently
incomplete API is an invitation for future reinvention" apply here.

