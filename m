Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF3C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 06:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151DE20B1F
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 06:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ykkZvhgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgJGGM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 02:12:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58845 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGGMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 02:12:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14133E8D0C;
        Wed,  7 Oct 2020 02:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BCYLBA2XSb0XHMQ+DSFznfCdgYw=; b=ykkZvh
        gwqvHRWuQe/0ugKuWMSUiAxV/sIBjquw2ztEZLbgSm8tLWpCW2aCYw6RdaD/8Vec
        E1z5G4dTY6cfkaiNQlkWO42rsEtHaSujfhbJwbM5HzFGFuf+cEc9gK85Tz8H9qEh
        ilSh87K4esmv/y5jhA9JXQp1KpX9CrAkyQyzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K3K5Bs/vQiiWoIb8VuidNWIJ2EcuDOw8
        Pu10yAlbWMVqhL26dbxZ2A5OPjBLIr/cEVW8DZ3bSl/i0fF1BEZrLoqYQPGq07GO
        r2WRONBW/iXVMZ34zrCs57F2Bzr/0pVPgInnwddAEUCVvRcjXUCpXL6g6nV8R+XQ
        uYiMdXhgaag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F286DE8D0B;
        Wed,  7 Oct 2020 02:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBD85E8D09;
        Wed,  7 Oct 2020 02:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Javier Spagnoletti <phansys@gmail.com>
Subject: Re: [PATCH v2] Improve diff pattern for PHP files
References: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
        <pull.864.v2.git.git.1602041898670.gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 23:12:18 -0700
In-Reply-To: <pull.864.v2.git.git.1602041898670.gitgitgadget@gmail.com>
        (Javier Spagnoletti via GitGitGadget's message of "Wed, 07 Oct 2020
        03:38:18 +0000")
Message-ID: <xmqqeema4la5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E928D0A-0864-11EB-B46D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Subject: Re: [PATCH v2] Improve diff pattern for PHP files

You seem to have read J6t's excellent suggestion well but forgot to
retitle.

> From: Javier Spagnoletti <phansys@gmail.com>
>
> PHP allows some function modifiers that are not recognized in our current hunk header pattern
>
>        final public function foo() { }
>        abstract protected function bar() { }
>
> Add "final" and "abstract" to the list of function modifiers.
>
> Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
> ...
>  t/t4018/php-abstract-method | 7 +++++++
>  t/t4018/php-final-method    | 7 +++++++
>  userdiff.c                  | 2 +-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/php-abstract-method
>  create mode 100644 t/t4018/php-final-method
>
> diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
> new file mode 100644
> index 0000000000..ce215df75a
> --- /dev/null
> +++ b/t/t4018/php-abstract-method
> @@ -0,0 +1,7 @@
> +abstract class Klass
> +{
> +    abstract public function RIGHT(): ?string
> +    {
> +        return 'ChangeMe';
> +    }
> +}
> diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
> new file mode 100644
> index 0000000000..537fb8ad9a
> --- /dev/null
> +++ b/t/t4018/php-final-method
> @@ -0,0 +1,7 @@
> +class Klass
> +{
> +    final public function RIGHT(): string
> +    {
> +        return 'ChangeMe';
> +    }
> +}
> diff --git a/userdiff.c b/userdiff.c
> index 1df884ef0b..a99d84a7e3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -143,7 +143,7 @@ PATTERNS("perl",
>  	 "|=~|!~"
>  	 "|<<|<>|<=>|>>"),
>  PATTERNS("php",
> -	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
> +	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
>  	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
