Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE71C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0347D2067C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFeM1FH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLAUSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:18:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53507 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgLAUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:18:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 561A18EBCA;
        Tue,  1 Dec 2020 15:17:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T/78xMdgAF54
        8jNaZxsBDi+snmU=; b=CFeM1FH/2J/FEAcxYDKjn6MX3vBzVvnJwbbNZPokR5Z8
        ImU3nqOYEX9u2fK+jPAzG1badZylHdlbZ758E1Y5KuHf0I31alw7KbRSa5x9VVaC
        +kpOPxEmys3mQL+tutUXxd9pL3djEyHm//iUVl1fOcVI+5g+8xfe7gK9VUfAoB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vruqph
        /S8XSH7wrIrSmNiqeK2v7dZ+V05EQPQluTRb/gZq4HT6G4PvVuMpz5icxOGusHBm
        e2ObV6GTLLCabO5EcRZ7C16TsmOjfLEuVSLT5h1eRRghsmz8vU65KcBVEIbpONwH
        wkmHdORzxMEDmHanYGtcfHxgdNkJeZ+LLhzVk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E4748EBC9;
        Tue,  1 Dec 2020 15:17:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3B898EBC8;
        Tue,  1 Dec 2020 15:17:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] mktag doc: say <hash> not <sha1>
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-2-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 12:17:56 -0800
In-Reply-To: <20201126222257.5629-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Nov 2020 23:22:48 +0100")
Message-ID: <xmqqa6uxp9fv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CD7B6E2-3412-11EB-A794-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "mktag" documentation to refer to the input hash as just
> "hash", not "sha1". This command has supported SHA-256 for a while
> now.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

I think saying <hash> instead of <sha> is a very good idea---it won't
tie us to the SHA family of hashes, including SHA-256, forever.

>  Documentation/git-mktag.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index fa6a756123..a158428eb9 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -23,7 +23,7 @@ Tag Format
>  A tag signature file, to be fed to this command's standard input,
>  has a very simple fixed format: four lines of
> =20
> -  object <sha1>
> +  object <hash>
>    type <typename>
>    tag <tagname>
>    tagger <tagger>
