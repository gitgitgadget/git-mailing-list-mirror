Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534AC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E610A23142
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbhAFXtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:49:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57479 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAFXtw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:49:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72880116B6A;
        Wed,  6 Jan 2021 18:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MGHUGYJtPjSE
        sSTjzWgdfNwOq8A=; b=cXe9wuNXpbZBHBuU/6pgfHlFjbl9db98Jbwbf86p/c8w
        Ab4YQp5VMVy2PhWUsQEgXUBJXPOQlZir0uUaGT3ttnS3c/HFBH3eBdsSAiY+tV0p
        Dw21r6NYnXFYtBN9wb4ap0hFGd4P7CFMwuSquf2Na/us6U5I4ZJIhmHGQARrq+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RrtVtl
        yEV1E5pwYuUjnnnohe8BGk+MjgpyUWcYL5EZyQftFBD8+fbIHUiGGcBVyfWhupeL
        W0QF0q8mOg9IwJbIHOo5Z3wsbYzo7+PFAAFso18zAWnvPlcmhnabPPI5LM53R5/W
        fXd3CEWvAoutxv9AxktvLUqIsUp35c4+SJ6Xc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A6FB116B68;
        Wed,  6 Jan 2021 18:49:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6494116B67;
        Wed,  6 Jan 2021 18:49:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, Johannes.Schindelin@gmx.de,
        karthik.188@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH 5/5] branch: show "HEAD detached" first under reverse sort
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
        <20210106100139.14651-6-avarab@gmail.com>
Date:   Wed, 06 Jan 2021 15:49:04 -0800
In-Reply-To: <20210106100139.14651-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 6 Jan 2021 11:01:39 +0100")
Message-ID: <xmqqturtoccv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C2FE47FE-5079-11EB-AC43-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	struct atom_value *va, *vb;
>  	int cmp;
> +	int cmp_detached_head =3D 0;
>  	cmp_type cmp_type =3D used_atom[s->atom].type;
>  	int (*cmp_fn)(const char *, const char *);
>  	struct strbuf err =3D STRBUF_INIT;
> @@ -2370,6 +2371,7 @@ static int cmp_ref_sorting(struct ref_sorting *s,=
 struct ref_array_item *a, stru
>  	     ^
>  	     (b->kind & FILTER_REFS_DETACHED_HEAD))) {
>  		cmp =3D compare_detached_head(a, b);
> +		cmp_detached_head =3D 1;
>  	} else if (s->version)
>  		cmp =3D versioncmp(va->s, vb->s);
>  	else if (cmp_type =3D=3D FIELD_STR)
> @@ -2383,7 +2385,7 @@ static int cmp_ref_sorting(struct ref_sorting *s,=
 struct ref_array_item *a, stru
>  			cmp =3D 1;
>  	}
> =20
> -	return (s->reverse) ? -cmp : cmp;
> +	return (s->reverse && !cmp_detached_head) ? -cmp : cmp;
>  }

OK.  Other criteria would honor the "reverse" bit, but when we work
on the set that includes "HEAD" ref (which only happens when "branch -l"
deals with a detached head), it always tries to sort it before all other
refs, regardless of the reverse bit.  Makes sense.

>  static int compare_refs(const void *a_, const void *b_, void *ref_sort=
ing)
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 8f53b081365..5e0577d5c7f 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -221,10 +221,10 @@ test_expect_success 'git branch `--sort=3D[-]obje=
ctsize` option' '
>  	test_i18ncmp expect actual &&
> =20
>  	cat >expect <<-\EOF &&
> +	* (HEAD detached from fromtag)
>  	  branch-one
>  	  main
>  	  branch-two
> -	* (HEAD detached from fromtag)
>  	EOF
>  	git branch --sort=3D-objectsize >actual &&
>  	test_i18ncmp expect actual
> @@ -241,10 +241,10 @@ test_expect_success 'git branch `--sort=3D[-]type=
` option' '
>  	test_i18ncmp expect actual &&
> =20
>  	cat >expect <<-\EOF &&
> +	* (HEAD detached from fromtag)
>  	  branch-one
>  	  branch-two
>  	  main
> -	* (HEAD detached from fromtag)
>  	EOF
>  	git branch --sort=3D-type >actual &&
>  	test_i18ncmp expect actual
> @@ -261,10 +261,10 @@ test_expect_success 'git branch `--sort=3D[-]vers=
ion:refname` option' '
>  	test_i18ncmp expect actual &&
> =20
>  	cat >expect <<-\EOF &&
> +	* (HEAD detached from fromtag)
>  	  main
>  	  branch-two
>  	  branch-one
> -	* (HEAD detached from fromtag)
>  	EOF
>  	git branch --sort=3D-version:refname >actual &&
>  	test_i18ncmp expect actual
