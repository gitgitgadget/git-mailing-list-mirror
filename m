Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE52BC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 02:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhLUCLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 21:11:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58688 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLUCLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 21:11:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D179171A58;
        Mon, 20 Dec 2021 21:11:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=83NGC0ApJeWj
        o0MpdLxJ6t6rpMMvrqr9oGl+Nulqrco=; b=CMCxrfz00WrdQqoOrYB8yAQUPTjp
        LnuYQn1C+e+A3qC4pz/6C2fpz4cjvLLqqkBzD4tuSULYkfZEDKWlfyX07ds1mXZO
        u8HXKynT/+/cbcCawLQBnfX9Z7xhlK+wcMg3s3/sMJSGZK4VnQes5Z01cVKKVPef
        1YaASgGYfULtsTI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27385171A57;
        Mon, 20 Dec 2021 21:11:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F0A6171A54;
        Mon, 20 Dec 2021 21:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH] object-file API: add a format_loose_header() function
References: <20211217112629.12334-3-chiyutianyi@gmail.com>
        <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
        <xmqqilviud6e.fsf@gitster.g>
        <211221.86wnjyspd3.gmgdl@evledraar.gmail.com>
Date:   Mon, 20 Dec 2021 18:11:08 -0800
In-Reply-To: <211221.86wnjyspd3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Dec 2021 02:42:44 +0100")
Message-ID: <xmqqmtkuso5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4359C054-6203-11EC-B41F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I've got some patches locally to convert e.g. write_object_file() to us=
e
> the enum, and it removes the need for some callers to convert enum to
> char *, only to have other things convert it back.
>
> So I think for any new APIs it makes sense to work towards sidelining
> the hash-object.c --literally caller.

Your logic is backwards to argue "because I did something this way,
it makes sense to do it this way"?
