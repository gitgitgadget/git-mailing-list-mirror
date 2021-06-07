Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C7C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 23:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AD961182
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 23:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGXhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:37:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59218 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFGXhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 19:37:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BA18C22A0;
        Mon,  7 Jun 2021 19:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GYGmx+Nsdf01
        bHXm5sTwMWJqXONe11nQpYKVcafBKmQ=; b=NSuGRInUgVxLV/NRXZCOo1MP/lRh
        PM77HlUN+csOJYMTD+TCzrGaOGn049+mj3gx/kQgeZOu1Q+AdgqZavFVbYf1o2mF
        ijfsT8c+zISN/pwgpyjxaCqtRQISQG+CVNDJJhwTgHZxjCuePIA5Vb+fan6HMO1o
        TKawD+MOhNZozYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0490BC229C;
        Mon,  7 Jun 2021 19:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70C53C229B;
        Mon,  7 Jun 2021 19:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bundle doc: rewrite the "DESCRIPTION" section
References: <patch-1.1-4e736877d1-20210607T143643Z-avarab@gmail.com>
        <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
Date:   Tue, 08 Jun 2021 08:35:57 +0900
In-Reply-To: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 7 Jun
 2021 18:56:39 +0200")
Message-ID: <xmqqh7i9tfhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C862B7A-C7E9-11EB-8A63-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Rewrite the "DESCRIPTION" section for "git bundle" to start by talking
> about what bundles are in general terms, rather than diving directly
> into one example of what they might be used for. This changes
> documentation that's been substantially the same ever since the
> command was added in 2e0afafebd8 (Add git-bundle: move objects and
> references by archive, 2007-02-22).

OK.

>  NAME
>  ----
> -git-bundle - Move objects and refs by archive
> +git-bundle - Create, unpack and manipulate bundles

While I find the updated description an improvement, I do not think
the updated one-line explanation is.  Not that "archive" is much
better than "bundles", but to those who needs "git-bundle" explained,
it is better not to use the same word "bundle" to do so, and worse,
when one does not know what "bundles" are, "do X, Y or Z" on that
unknown thing would not help understanding all that much.  At least,
the original _hints_ that it is related to some way to transport Git
data (by mentioning "objects and refs"), and those with good instinct
may even guess that it is an offline transport (with the hint the
word "archive" leaves).

> -Some workflows require that one or more branches of development on one
> -machine be replicated on another machine, but the two machines cannot
> -be directly connected, and therefore the interactive Git protocols (gi=
t,
> -ssh, http) cannot be used.
> +Create, unpack and manipulate "bundles" (.bundle) files. Bundles are
> +.pack files (see linkgit:git-pack-objects[1]) with a header indicating
> +what references are contained within the bundle. The header is in the
> +format emitted by linkgit:git-show-ref[1].

Before going into the composition of a bundle, can we touch the
reason why we create such a thing?  It is to help "offline" Git
transfer without common history discovery.

That is,

	Create, unpack, and manipulate "bundle" files, that helps
	"offline" transfer of Git objects without an active "server"
	sitting on the other side of the network connection.

or something.
