Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D26C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiGRRRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRRRG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:17:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091DA2C131
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:17:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DA3D1BE278;
        Mon, 18 Jul 2022 13:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=llu0f66LFcIn
        RYFNgODa6rIPudDb8+Z3dUSVLNXVU3k=; b=AdALWHsDSXiFzOBNDrqEpmxdFbtf
        u8yQot3Gq6JFW5y0aK7x3Z4RaHkD8SFgSBv8ysdVOtQWpYMsGRdrj5m1MzowinaL
        TnIT3/zfxdKnI2PXghqSBZAmXkICbZwMl5KjxHu4GXsffFAJkX64qr7dHhDbDmdC
        2W0KjRIYEsT67Kk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85B1C1BE277;
        Mon, 18 Jul 2022 13:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27A981BE275;
        Mon, 18 Jul 2022 13:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 2/8] git docs: split "User-facing file formats" off
 from "Guides"
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
        <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
        <patch-v4-2.8-883c483d4e7-20220718T132911Z-avarab@gmail.com>
Date:   Mon, 18 Jul 2022 10:17:00 -0700
In-Reply-To: <patch-v4-2.8-883c483d4e7-20220718T132911Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 18 Jul
 2022 15:29:28
        +0200")
Message-ID: <xmqqlesqqr1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70588B44-06BD-11ED-9140-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We take a wide view of what's considered a "user format", it's not
> just a file format, but e.g. githooks(5) also belongs, since the
> layout of the ".git/hooks/" and the placement of hooks in it is
> something the user might be expected to interact with.

I am afraid it is a bit big a stretch.  Other documents that fall
into the user-format category all have "format" the users must
follow while writing the "contents" in the file.  ".gitignore" has
certain format and syntax and the document describes what effect the
file has, based on the contents of the file that follows the syntax.

A hook can be written in any language, even though our UNIX lineage
makes our samples all in written in the shell, so there is no
"format" for the users to follow that we should force upon them.

If we can come up with a word that is more appropriate than
"format", it would be great.  If we do not place too much emphasis
on "format", I agree that both "gitignore" and "githook" fall into
the same category, because they define how the contents written in
these files affect the operation of Git commands.

> -With no options and no '<command>' or '<guide>' given, the synopsis of=
 the 'git'
> +With no options and no '<command>', '<guide>' or '<doc>' given, the sy=
nopsis of the 'git'

At some point, we will have enough <doc> that it would probably
become meaningless to treat <guide> as a separate class, no?
Guides, user-supplied customization files, and implementation
details of on-disk files that may help reimplementations of Git, all
will become <doc>.

> @@ -26,8 +27,8 @@ printed on the standard output.
>  If the option `--guides` or `-g` is given, a list of the
>  Git concept guides is also printed on the standard output.
> =20
> -If a command, or a guide, is given, a manual page for that command or
> -guide is brought up. The 'man' program is used by default for this
> +If a command or other documentation is given, the relevant manual page
> +will be brought up. The 'man' program is used by default for this

Good.
