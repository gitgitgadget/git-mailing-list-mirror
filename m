Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C91C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbhL3Wgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:36:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60309 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhL3Wgo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:36:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CBFB10CFE3;
        Thu, 30 Dec 2021 17:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=nv9i1gZagwZOZOa0JSycvhq5V
        111XfFYdLasdZi7mXs=; b=O1pqwE3f0w9YLei+GJaXG4OAz5b6ixczMeridqcby
        vku4Ac2v0b+Rf1siqNNYJALGzHdpVFCAEJwwW2dRilFMQ8UulAZm+5WvTqLWmMR7
        /ywmPMsmei8s69Ex+5u8gWVNDrV8aGLL6wDLGnGElnkVpLpJR4DoKI5OFGJBAlwc
        8Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 228E110CFE2;
        Thu, 30 Dec 2021 17:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D62510CFDE;
        Thu, 30 Dec 2021 17:36:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 03/11] i18n: turn "options are incompatible" into
 "cannot be used together"
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <486cc6c89e2612761bc8835700c9c85c0b50ab55.1640804108.git.gitgitgadget@gmail.com>
        <233ae6c6-294f-f68c-51ca-ec83d25f05dd@kdbg.org>
        <48262743.WQR3eRXon5@cayenne>
Date:   Thu, 30 Dec 2021 14:36:42 -0800
Message-ID: <xmqqa6ghpvnp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6B56814-69C0-11EC-971B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> >  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>> > -		die("cannot use --grep-reflog without --walk-reflogs");
>> > +		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
>>=20
>> This last transformation does not fit the topic of this patch. It shou=
ld
>> go into patch 6/11, I think.
>>=20
>
> True! Will reroll after checking again.

Also, it lacks single-quote-pair around %s's; intended?
