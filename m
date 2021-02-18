Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC80C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6183B64EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBRWdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:33:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59467 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBRWdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:33:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 132FA10A30E;
        Thu, 18 Feb 2021 17:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cmjCOElLOhQO
        xNuG1ExnvdfU/iU=; b=BPAn4OGfcseKA5XTgXVOpRYTCRXczUgPhildrN0X/bat
        AnLCa0JqYTi0ngIB8VSlhWUfZJIyOZ4t3iN0F+sdbx8K8IUf+3tjGKbHyLstQC/k
        /8idxcLorVzBhQPov4vk+4TUHTIYy9+f40d4YwOYqO3yCr/ertdw37rtGJxt3cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uurCWi
        FIwwOAj7r/SAL3+/FNowwkeZ8QcToNN3yjQBjID0rn37AtT242GW/f7QP31GV8V8
        ym3P9yJsYQooUmiiJctoM/5lm/nM3rD7iNOqgJ/XUv4Q1i3k9xzXVLNalDypGxjy
        UBrxyHPOYQaidjeTkru3PYKKdykle9ojiEipo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B40E10A30B;
        Thu, 18 Feb 2021 17:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4FDD310A309;
        Thu, 18 Feb 2021 17:32:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 10/10] fsck.h: update FSCK_OPTIONS_* for object_name
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-11-avarab@gmail.com>
Date:   Thu, 18 Feb 2021 14:32:32 -0800
In-Reply-To: <20210218105840.11989-11-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 11:58:40 +0100")
Message-ID: <xmqqlfblc8hr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 320E5932-7239-11EB-A3F6-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add the object_name member to the initialization macro. This was
> omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
> go, 2016-07-17) when the field was added.

This is more of a Meh to me.  If this were to change us to
designated initializers and omit NULL and 0 initialization, it would
be more interesting.

Thanks.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.h b/fsck.h
> index c77e8ddf10b..5d44ff1c8e3 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -47,8 +47,8 @@ struct fsck_options {
>  	kh_oid_map_t *object_names;
>  };
> =20
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OID=
SET_INIT }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDS=
ET_INIT }
> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OID=
SET_INIT, NULL }
> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDS=
ET_INIT, NULL }
> =20
>  /* descend in all linked child objects
>   * the return value is:
