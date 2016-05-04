From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/4] githooks.txt improvements + core.hooksDirectory
Date: Wed, 04 May 2016 15:13:24 -0700
Message-ID: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
References: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
	<1462393128-26762-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 00:13:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay52y-0004Yp-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbcEDWN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:13:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754371AbcEDWN2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2016 18:13:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E1FC198AE;
	Wed,  4 May 2016 18:13:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o1m4yWG/xv9I
	WljIwHCHZ2zSLfw=; b=d32Sarfv24bm0759SazcMr1mxTv1xtpUBKnPE3SpiDQD
	ZsR1THBdrZYNGZM6XuooJBW4WYtdthABYS1a3H1wDdUO//Bog5tJ+HpBHMt7eizI
	FQt+7HYrBeU7LZdbKIC0ftjdi9dgvzxpyE4pq7x5K/WfoXkwHyi4SN8l7BYd63A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cXDEm6
	eMghEGrOT2UTZo/zoTus8LBWjy6mRkXarOT9Ah9urntInbSaahrZpYanhhWTR/eJ
	oXxR40qxSS0TUxbJe0RWLLTFNZx/0vVjGZ053BH+VBclAmZbNdvy/Oxl8ikWRqMP
	sWdqsrY+JG16LBe2HwEV4FTZ9S6BbC9FiiAWA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 656E6198AD;
	Wed,  4 May 2016 18:13:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD523198AC;
	Wed,  4 May 2016 18:13:25 -0400 (EDT)
In-Reply-To: <1462393128-26762-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 4 May
 2016 20:18:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C30C28E-1245-11E6-BF06-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293609>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> For convenience & ease of review a diff between the bits of v4 and v5
> that I changed follows below.

Thanks.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> ...
> +This configuration variable is useful in cases where you'd like to
> +centrally configure your Git hooks instead of configuring them on a
> +per-repository basis, or as a more flexible and centralized
> +alterantive to having an `init.templateDir` where you've changed

"alternative" (can be locally amended).

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> ...
> +Hooks don't need to worry about the user's current working
> +directory. Before Git invokes a hook it changes its working
> +directory. The working directory will be the root of the working tre=
e
> +in a non-bare repository, or in the $GIT_DIR directory in a bare
> +repository.

I suspect that the first sentence does more harm than good.  When
you say "don't need to worry about", somebody is bound to ask "that
is good that I do not need to, but what if I _want_ to know?", and
you do not have a good answer to that question.

	Before Git invokes a hook, it changes its working directory
	to either the root of the working tree in a non-bare
	repository, or to the $GIT_DIR in a bare repository.

perhaps?

> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path=
=2Esh
> index f2f0aa9..6e4586a 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -7,10 +7,10 @@ test_description=3D'Test the core.hooksPath configu=
ration variable'
>  test_expect_success 'set up a pre-commit hook in core.hooksPath' '
>  	mkdir -p .git/custom-hooks .git/hooks &&
>  	write_script .git/custom-hooks/pre-commit <<-\EOF &&
> -printf "%s" "CUST" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +	echo CUSTOM >>actual
>  EOF
>  	write_script .git/hooks/pre-commit <<-\EOF
> -printf "%s" "NORM" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +	echo NORMAL >>actual
>  EOF
>  '

These closing EOF can and should be indented like the body of the
here-text, i.e.

	cmd <<-\EOF &&
        ...
        EOF

> @@ -24,8 +24,14 @@ test_expect_success 'Check that various forms of s=
pecifying core.hooksPath work'
>  	test_commit have_custom_hook_abs_path &&
>  	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
>  	test_commit have_custom_hook_abs_path_trailing_slash &&
> -	printf "%s" "NORMCUSTCUSTCUSTCUST" >.git/PRE-COMMIT-HOOK-WAS-CALLED=
=2Eexpect &&
> -	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOO=
K-WAS-CALLED
> +	cat >expect <<-\EOF &&
> +	NORMAL
> +	CUSTOM
> +	CUSTOM
> +	CUSTOM
> +	CUSTOM
> +EOF

Likewise.
