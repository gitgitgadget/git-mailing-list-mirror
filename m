Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB1C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A8864E26
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhBJV5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 16:57:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51592 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhBJV5b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 16:57:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4AAEA340E;
        Wed, 10 Feb 2021 16:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZCg+dlQGdo4Q
        q9FWpqL8mFEpldE=; b=ZpL5YqvgaI/UX7OAj6vTRQTIj+G+VTigmJONdwAw5Ooh
        2rSPvLKG8O4l45nqWD//yo1Q3NE5R1uwkTXqfYkLnbWglVgJ3/vDGdFP4hWnICYc
        DUbIPM8WKMnCeTELkTZ42E0HSKm4NQqZza/koYqkHQFJGsrmaRh9iVry7LjN90A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=X6DSfU
        /KeZJz0Bxa9iTd4f/KqZ4jNrtkk4FgrDSdzwiR3gueTitx1iWirflNDV1eQYOUF+
        6JSKLFHwG+dB5Xk44XgFWgusZQL70Yl9ACSJDNxcFOIsjcvfk4dPrCjQqHWLX1jz
        8EAcwuMk4K1x0j1dxWaRjbjIkfvpT0C8pCgEU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9025A340D;
        Wed, 10 Feb 2021 16:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49C75A340C;
        Wed, 10 Feb 2021 16:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 09/12] test libs: rename "diff-lib" to "lib-diff"
References: <20210209214159.22815-1-avarab@gmail.com>
        <20210209214159.22815-10-avarab@gmail.com>
Date:   Wed, 10 Feb 2021 13:56:47 -0800
In-Reply-To: <20210209214159.22815-10-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 9 Feb 2021 22:41:56 +0100")
Message-ID: <xmqqeehn1t9c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF9F093E-6BEA-11EB-8A9B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Rename the "diff-lib" to "lib-diff". With this rename and preceding
> commits there is no remaining t/*lib* which doesn't follow the
> convention of being called t/lib-*.
> ---

Seeing nothing (other than the OID length abstraction that prepares
us for SHA-256 world) has happened since 2009, I have no issue with
this change and no in-flight topics would, either.

Needs a sign-off, though.
