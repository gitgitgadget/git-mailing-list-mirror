Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E601F424
	for <e@80x24.org>; Mon, 18 Dec 2017 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759542AbdLRWe3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 17:34:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64128 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758309AbdLRWe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 17:34:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FF2AC9020;
        Mon, 18 Dec 2017 17:34:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Hgd5ZwewdsspvRw0wUT8zh1zcw=; b=jKsus2
        oEQmyDftUd3fDwa2ssy2Qa7rYQKHZMqNmyFDEzlT71Xidwk4yPtKjA9t3KlO1O2B
        TvvKriCDi2ofXSLL1cQo55CGhNci82ONZGpXTEJRaZT5J2r/MAM6Pv3lCoQJr+7R
        OhmGCdTLOBb0vsYXwOikDf6jYdE4kNHM7cgqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WQgZJKwZBx2/lPOux91LQkMfC/aVYAhU
        cpdmSFaJZP1YdDwH13aHGvbOJenV2jOrsYc0npaY4tFoqVQ9yr6ED4PIqPzBuuL3
        KCMYTChIKvXgZgHC/E28ocrbNPGlpfMqGxLja0MePYiWR/85eWrgW+oTnsMCS6q8
        sdTgTQ5DB88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97BD2C901E;
        Mon, 18 Dec 2017 17:34:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12932C901D;
        Mon, 18 Dec 2017 17:34:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] travis-ci: don't install 'language-pack-is' package
References: <20171216125418.10743-2-szeder.dev@gmail.com>
        <20171216125758.11120-1-szeder.dev@gmail.com>
        <8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.com>
        <CAM0VKj=xVfCd5qR4jXwFGDxSABgyAeZY5qJxUP3GHvUE7gjw6A@mail.gmail.com>
        <AB053B56-5318-47D4-8ADE-0A72B9860BED@gmail.com>
Date:   Mon, 18 Dec 2017 14:34:27 -0800
In-Reply-To: <AB053B56-5318-47D4-8ADE-0A72B9860BED@gmail.com> (Lars
        Schneider's message of "Mon, 18 Dec 2017 23:17:39 +0100")
Message-ID: <xmqq3747y8b0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B80A758-E443-11E7-BBED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> It seems we would loose coverage with this patch, so it should be
>> dropped.
>
> Yeah. I think we should add a comment to the travis.yml to avoid
> future confusion. I'll do it unless you beat me to it with a re-roll.

Rather, it should be commented close to where is locale is used in
tests, and possibly in t/README, I would think.  Those who want to
use t/*, not necessarily using Travis, would benefit from the hint,
"installing icelandic locale may give you better test coverage", or
something like that.


