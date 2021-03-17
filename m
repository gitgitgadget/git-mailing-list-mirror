Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79873C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3143464EE1
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhCQSiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:38:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50717 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCQSiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:38:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74E88A8A3E;
        Wed, 17 Mar 2021 14:38:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Rn+niiy/svSM
        etjiSWfKe6yd1f8=; b=FPC4UdIHQMm+Evec0NpU7U0aDzrFu4ZWJfXiRoXSWEo/
        4Xg7PCGETLfIyqnQxK0IlOL4MqXgETi61iOxrB74JBu6EyRQ/H0lTtneEdNREzEd
        JBV6qLrAbfQTaE+hDXE0xh+g7wsZ0PkgPri2RDhcoRQouSFvEXDJBGj95RHGDbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y9wBbZ
        Mnt+rvZv7BMgmfu+A8XgfCVmnicvS9dkUMiQQc+ANpXtaNgBWRhMRBKPu/T3R/MH
        y6kfcvKul6iuou1QF/BAkrTWUzTooXSoeMIGON+nYsxQZ9AfRYpWmCTQjS7IJwwj
        rEQYOM30zXC4AKwwl/U8KNRB9aZwyTN7toVxE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D554A8A3D;
        Wed, 17 Mar 2021 14:38:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E653FA8A3B;
        Wed, 17 Mar 2021 14:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 02/22] fsck.h: use designed initializers for
 FSCK_OPTIONS_{DEFAULT,STRICT}
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-3-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 11:38:22 -0700
In-Reply-To: <20210316161738.30254-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:18 +0100")
Message-ID: <xmqq35wtwrq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F3EF1AE8-874F-11EB-BD07-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.h b/fsck.h
> index 2274843ba0..40f3cb3f64 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -43,8 +43,22 @@ struct fsck_options {
>  	kh_oid_map_t *object_names;
>  };
> =20
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OID=
SET_INIT, NULL }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDS=
ET_INIT, NULL }
> +#define FSCK_OPTIONS_DEFAULT { \
> +	.walk =3D NULL, \
> +	.error_func =3D fsck_error_function, \
> +	.strict =3D 0, \
> +	.msg_type =3D NULL, \
> +	.skiplist =3D OIDSET_INIT, \
> +	.object_names =3D NULL, \
> +}
> +#define FSCK_OPTIONS_STRICT { \
> +	.walk =3D NULL, \
> +	.error_func =3D fsck_error_function, \
> +	.strict =3D 1, \
> +	.msg_type =3D NULL, \
> +	.skiplist =3D OIDSET_INIT, \
> +	.object_names =3D NULL, \
> +}

Being explicit is good, but spelling out zero initialization sounds
more like cluttering than clarifying.  I do not mind .strict =3D 0 in
the DEFAULT one only because it contrasts well with .strict =3D 1 on
the STRICT side, but it would be easier to read to omit these zero
initilization of the .walk, .msg_type and .object_names members.

>  /* descend in all linked child objects
>   * the return value is:
