Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A75C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F9361985
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhC2Wxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:53:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58146 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhC2WxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:53:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEA1B111B4A;
        Mon, 29 Mar 2021 18:53:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ztelIM2ulSbH
        ofYmN8TIQRgEcUs=; b=Timj3e/OF4x7niaJ6r+O5ETe56kEWu57KurhDlbXws1q
        5jKbxA+4xJGuz4NBob7/IulgeU3AW4gX/AGglGsGOCtBXq9FrpkcssT+ILns8P7d
        VkwmFAml9jU34MuKwNGi55MGz+BppioaZIvb3+RJGA3YfRqtJnGZiymuPO8eUJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Amk84f
        S7WSFk+LpzZ0C2Z2OXUaI1U9hZNh+nuh7kxmPp2mP+EaLSDU6NHVBF6RqbgvX+sf
        Gcv8dQdwVDzZ9GxhlPT0M7BBXQvG6G7E+IZEcHcvELUeGlv63LrKEEr4mcNO/ncG
        b9+ajus5epLUjU8ori+AuliFs8h+9b1/V4QIE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2E0E111B48;
        Mon, 29 Mar 2021 18:53:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E10F0111B47;
        Mon, 29 Mar 2021 18:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Makefile: add a INSTALL_FALLBACK_LN_CP mode
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-6.7-9ada8979890-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 15:53:18 -0700
In-Reply-To: <patch-6.7-9ada8979890-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:44 +0200")
Message-ID: <xmqqeefxh8rl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E98AF42-90E1-11EB-86E6-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the default behavior on "make install" where we fallback
> through a chain of "ln || ln -s || cp" to instead error out when we
> can't symlink or hardlink, and not then fallback on a "cp" (or from a
> symlink to hardlink etc.).
>
> The fallback behavior was introduced in 3e073dc5611 (Makefile: always
> provide a fallback when hardlinks fail, 2008-08-25), since then we've
> gained the ability to specify e.g. that we'd like symlinks via the
> INSTALL_SYMLINKS setting.

Hmph, I am not so sure.  "Use hardlink if we can, as that would not
consume inode, but where hardlinks cannot be used, it is OK to use
symlink, and I do not want to waste disk blocks with cp" is probably
one of the sensible wishes, but at least without "ln || ln -s" fallback,
you cannot do that, no?

So I would understand if there are two orthogonal knobs

 - the order of preference (e.g. hardlink > symlink > copy)
 - which ones are allowed (e.g. "no symlinks please")

but I cannot quite imagine how a system without any fallback would
be useful.

> +main_no_fallbacks () {
> +	if test -n "$no_install_hardlinks" -a -z "$install_symlinks"

As the values of these variables are (presumably) tightly under our
control, the use of -a/-o with test may be safe in these examples,
but to avoid letting clueless shell script newbies to cargo cult
this code, let's use the safer "test -n A && test -z B" form.
