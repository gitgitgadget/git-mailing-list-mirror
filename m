Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B69C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 18:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiI1SEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiI1SES (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 14:04:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412510253D
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 11:04:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C50B145D97;
        Wed, 28 Sep 2022 14:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TyFpnwdjIqQi
        8+8/7t2ioRMRHLufNsfBvQJqqC9c+bc=; b=iKU2fSCEWS6GnAr8wOz07pzfwOy9
        zcqTLUAHagG0UYKpqr9k4V9BCAiYkkF0idb27MnLbDaFQk2vmv94qUIgiP1OjaAL
        nkZmHerBY25Haglg5TGOr2kbGj6utf2GhCpCBmbLI52IAkChKALK+oHktGs7m6EB
        y5OJ/4ZYa+0MllY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 921B7145D96;
        Wed, 28 Sep 2022 14:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA545145D8E;
        Wed, 28 Sep 2022 14:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 00/35] doc/UX: make txt & -h output more consistent
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
        <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
Date:   Wed, 28 Sep 2022 11:04:09 -0700
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 28 Sep
 2022 10:38:55
        +0200")
Message-ID: <xmqqk05ntlye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F42F97A0-3F57-11ED-A0F2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Victoria: I decided not to go for your suggestion of trimming this
> series down in [1]. Reasons:
>
>  * It would take me time I don't have to spend on this, as some of it
>    isn't easy to cleanly re-arrange. E.g. the later "make consistent"
>    commits rely on earlier whitespace/basic syntax fixes.

A devil's advocate question.  If even the original author feels it
does not deserve his or her time to clean up the series, how does it
possibly deserve reviewers' time to review such a series?

>  * A major advantage of reviewing this in one go is that the 34-35/35
>    tests at the end are asserting everything that came before
>    it.

Yes, but it does not assert anything about the other patches not
doing unrelated things while at it.  So tests cannot be blindly
trusted (in other words you have to be also trustworthy, if the
reviewers are expected to swallow this huge series uninspected).

I'll give it a read-over when I find time.  Thanks for working on
it.
