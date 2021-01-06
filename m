Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAECC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD2B22D6F
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbhAFXWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:22:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60443 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbhAFXV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:21:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62981B4829;
        Wed,  6 Jan 2021 18:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=03UXfETZNlsq
        zwV/3CAl2N2+X3I=; b=eIBoWBx/ZrQ8+loIlBBzjAM/kgYH63Oc0u5x76WRCWst
        N7lTL0/YpVVAxXervrdj7wDyULjYwyvGjjqFZHIKRRJpgPi0FS0twKUCZABENXib
        UrElrPt6IWwiZoi7efb0USXneJNol/Nc5MaOB56oECOQb95HEi5TZx/JDFhPJj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LlpGsc
        NeUlbosWNZx28qsFB0Uz5Do1qv9Qj2qzP3AXNxKSvuaOPegRAzMivb+YHgwJlBOG
        zebWiAaUkICl0/lZM18KzG6yaZnHJhhKb7RKmfem1mj/jwFE0YkQVMxDddC7dwAE
        4A313p1ubIDwlB9HxvOsXTT0Mkbv4ugEkku2Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59411B4828;
        Wed,  6 Jan 2021 18:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9345B4827;
        Wed,  6 Jan 2021 18:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, Johannes.Schindelin@gmx.de,
        karthik.188@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH 2/5] branch tests: add to --sort tests
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
        <20210106100139.14651-3-avarab@gmail.com>
Date:   Wed, 06 Jan 2021 15:21:16 -0800
In-Reply-To: <20210106100139.14651-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 6 Jan 2021 11:01:36 +0100")
Message-ID: <xmqq5z49ps7n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E03DA188-5075-11EB-8B91-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Further stress the --sort callback in ref-filter.c. The implementation
> uses certain short-circuiting logic, let's make sure it behaves the
> same way on e.g. name & version sort. Improves a test added in
> aedcb7dc75e (branch.c: use 'ref-filter' APIs, 2015-09-23).
>
> I don't think all of this output makes sense, but let's test for the
> behavior as-is, we can fix bugs in it in a later commit.

OK.

I wondered if 'type' and '-type' tests and 'version:refname' and
'-version:refname' tests, should be separate, so that the latter
half of the latter pair can expect to have HEAD at the beginning
with test_expect_failure until it gets fixed.  But "document the
status quo, and then change the behaviour and demonstrate how the
new behaviour is superiour with the change in the expectation in the
patch" is a reasonable approach, too.

Will queue; thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3203-branch-output.sh | 51 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index b945faf4702..f92fb3aab9d 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -210,7 +210,7 @@ EOF
>  	test_i18ncmp expect actual
>  '
> =20
> -test_expect_success 'git branch `--sort` option' '
> +test_expect_success 'git branch `--sort=3D[-]objectsize` option' '
>  	cat >expect <<-\EOF &&
>  	* (HEAD detached from fromtag)
>  	  branch-two
> @@ -218,6 +218,55 @@ test_expect_success 'git branch `--sort` option' '
>  	  main
>  	EOF
>  	git branch --sort=3Dobjectsize >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	cat >expect <<-\EOF &&
> +	  branch-one
> +	  main
> +	* (HEAD detached from fromtag)
> +	  branch-two
> +	EOF
> +	git branch --sort=3D-objectsize >actual &&
> +	test_i18ncmp expect actual
> +'
> +
> +test_expect_success 'git branch `--sort=3D[-]type` option' '
> +	cat >expect <<-\EOF &&
> +	* (HEAD detached from fromtag)
> +	  branch-one
> +	  branch-two
> +	  main
> +	EOF
> +	git branch --sort=3Dtype >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	cat >expect <<-\EOF &&
> +	* (HEAD detached from fromtag)
> +	  branch-one
> +	  branch-two
> +	  main
> +	EOF
> +	git branch --sort=3D-type >actual &&
> +	test_i18ncmp expect actual
> +'
> +
> +test_expect_success 'git branch `--sort=3D[-]version:refname` option' =
'
> +	cat >expect <<-\EOF &&
> +	* (HEAD detached from fromtag)
> +	  branch-one
> +	  branch-two
> +	  main
> +	EOF
> +	git branch --sort=3Dversion:refname >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	cat >expect <<-\EOF &&
> +	  main
> +	  branch-two
> +	  branch-one
> +	* (HEAD detached from fromtag)
> +	EOF
> +	git branch --sort=3D-version:refname >actual &&
>  	test_i18ncmp expect actual
>  '
