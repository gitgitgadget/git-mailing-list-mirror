Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D62C64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B322221FB
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgLBWct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:32:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50843 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLBWct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:32:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33029117349;
        Wed,  2 Dec 2020 17:32:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W6aSS21xTrNB
        2RQw7kJ1i1cb2bQ=; b=qm00hG5Gp+pvfLjwDNQuy8fNGpv/1AUY/SzKpYsEswOb
        3GdvGkz14mAw2rl9QtpEubKchp5gCRtD4Tgvrk6J/wBkKzYEXL/jcOq8MIJjFOdh
        6VAAuvrq5S0TL23jZEIfMg3ayd3fVs8NPzH1aPjYBEZmSbzGPiXtONit7+YS4b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UgNQy8
        7J7+RyLIXhxwmxW0Xulbc9YT9yte3LVWntFQhueq4Ug4TV/ehXp86v7gLhe1Ll3a
        aRr34VVp7Un8HWgXE4nJxEWR9C34SAHhVzpmUeiIgqulWbbIS3iqGlDhTCrMuMut
        IbH0//ikYMBkt6dq7mz6tyJEUPDJuyXdwFrRE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B4F5117348;
        Wed,  2 Dec 2020 17:32:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C3A6117347;
        Wed,  2 Dec 2020 17:32:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitignore: remove entry for git serve
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
        <20201201004649.57548-3-felipe.contreras@gmail.com>
        <xmqqczztqszv.fsf@gitster.c.googlers.com>
        <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
        <4e30fa82-fe24-1783-6f9a-13e1dd6f4ca9@web.de>
        <X8eNGzay6yWSEoJH@coredump.intra.peff.net>
Date:   Wed, 02 Dec 2020 14:32:02 -0800
In-Reply-To: <X8eNGzay6yWSEoJH@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 2 Dec 2020 07:48:27 -0500")
Message-ID: <xmqqsg8nltzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34060EE8-34EE-11EB-A323-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 02, 2020 at 12:46:01PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> b7ce24d095 (Turn `git serve` into a test helper, 2019-04-18) demoted g=
it
>> serve from a builtin command to a test helper.  As a result the
>> git-serve binary is no longer built and thus doesn't have to be ignore=
d
>> anymore.
>
> Good catch. This shows a weakness in my detection script: I had a stale
> git-serve sitting around from building old versions of Git. :)
>
> I repeated the script in a "clean" directory that was a fresh clone +
> make, and diffed the results. git-serve was the only interesting
> difference I saw. So this is probably the last of the low-hanging fruit=
.

Thanks, all. =20

Just for simplicity, these two are also queued on the same "random
cleanup" topic branch started with Felipe's four trivial clean-up
patches.
