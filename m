Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE47C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E537D6113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 19:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhGTTRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:17:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55988 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhGTTRC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:17:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABCDF13A651;
        Tue, 20 Jul 2021 15:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TdFeIiA9fg+0
        kaV8AEwLapfBflLov+8NRAP4Ndu80oI=; b=KmPmjUVtkSOyk4RkKmdh8P2K8sjU
        JENIqfWD0Nj+UnDbkm6gG2qKLhvnw5uD8s2rrj7t99RjSOTjb5j6oU4PBcEefhI1
        Xx7QWjqXhnB01PN6n+QuOJNYXuxZdjOED537xZcMro/JoDZxdd35/CEizaIafNzs
        bcpnFdeIa+/kzVg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A41F113A650;
        Tue, 20 Jul 2021 15:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8876B13A64F;
        Tue, 20 Jul 2021 15:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] bundle tests: use ">file" not ": >file"
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
        <patch-1.2-746d727113b-20210720T115052Z-avarab@gmail.com>
Date:   Tue, 20 Jul 2021 12:57:34 -0700
In-Reply-To: <patch-1.2-746d727113b-20210720T115052Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Jul
 2021 13:52:08 +0200")
Message-ID: <xmqqwnpkhi6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BAF1AC5E-E994-11EB-BA90-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change redundant uses of ":" on the LHS of a ">" to the more commonly

While the changes are correct, I am not sure if the adjective
"redundant" would apply.  The word refers to uses of two or more
when one would suffice, but in this case, you use one explicit no-op
command ":" when you need zero.

> use ">file" pattern.

"use" -> "used".

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t5607-clone-bundle.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index f4c383cd5ce..c9323a08fe8 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -54,14 +54,14 @@ test_expect_success 'bundle --stdin <rev-list optio=
ns>' '
>  '
> =20
>  test_expect_success 'empty bundle file is rejected' '
> -	: >empty-bundle &&
> +	>empty-bundle &&
>  	test_must_fail git fetch empty-bundle
>  '
> =20
>  # This triggers a bug in older versions where the resulting line (with
>  # --pretty=3Doneline) was longer than a 1024-char buffer.
>  test_expect_success 'ridiculously long subject in boundary' '
> -	: >file4 &&
> +	>file4 &&
>  	test_tick &&
>  	git add file4 &&
>  	printf "%01200d\n" 0 | git commit -F - &&
> @@ -75,7 +75,7 @@ test_expect_success 'ridiculously long subject in bou=
ndary' '
>  '
> =20
>  test_expect_success 'prerequisites with an empty commit message' '
> -	: >file1 &&
> +	>file1 &&
>  	git add file1 &&
>  	test_tick &&
>  	git commit --allow-empty-message -m "" &&
