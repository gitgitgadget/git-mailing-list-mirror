Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C9C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F96564EAD
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhBPX6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:58:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60828 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhBPX6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 18:58:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DACDA8A2E;
        Tue, 16 Feb 2021 18:57:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UgChtyIlYWOq
        /Ysn8NKVZuleIbc=; b=dF/n3cuFUPBsgQQmPqnbEKqoR1K+IBdQ6llHSfb4yDJo
        mixnb/XdxIJ2glJzYuhUohaqH+gMr2PF0/OAdCIOgW8k3Jz11ikM7wp/7dV6N2Gm
        MV7A1wA/fmylRvcTYs1SK0AaP1euIUM5RavpQcAaEcZr8NROH5+mo3rfPPX7+4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DsqeAJ
        yEZ48P7WxxHDpXXQQSfYmb3mnsSU0rC7aCbQpKMfUfYpMQt5uVxuowyYHU6OR++X
        74EnjXvcYGnnR229hYKNzDNgD34ZaH/QfYIJpLI1hAFlS+xH+zdE7wHeDp8RMw2G
        R8I4bnRPj//deEQvIpeW2X18C1FgTFAq0zV9U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 043DAA8A2D;
        Tue, 16 Feb 2021 18:57:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66267A8A2C;
        Tue, 16 Feb 2021 18:57:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 18/27] gitattributes doc: reword discussion of
 built-in userdiff patterns
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-19-avarab@gmail.com>
Date:   Tue, 16 Feb 2021 15:57:51 -0800
In-Reply-To: <20210215154427.32693-19-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Feb 2021 16:44:18 +0100")
Message-ID: <xmqqa6s3o9a8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7DAF372-70B2-11EB-929E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Reword the discussion of the built-in userdiff patterns to make it
> more natural to precede it with a discussion about the semantics of
> pattern matching, instead of assuming that it follows right after the
> "diff.tex.xfuncname" example which now immediately precedes it. This
> will make a follow-up commit smaller.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/gitattributes.txt | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Good changes.  The current text, which dates back to ae7aa499
(Document custom hunk header selection, 2007-07-08), may have been
adequate back when there were only "java" and "tex" built-in
patterns but not anymore.

I may (or may not) give the series a second pass to collect
independently salvageable bits, and if I did so, this would
be one of those that would be gleaned.

Thanks.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
> index e84e104f93..62c1147ba9 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -794,11 +794,17 @@ backslashes; the pattern above picks a line that =
begins with a
>  backslash, and zero or more occurrences of `sub` followed by
>  `section` followed by open brace, to the end of line.
> =20
> -There are a few built-in patterns to make this easier, and `tex`
> -is one of them, so you do not have to write the above in your
> -configuration file (you still need to enable this with the
> -attribute mechanism, via `.gitattributes`).  The following built in
> -patterns are available:
> +There are built-in patterns shipped as part of git itself. A more
> +advanced version of the `tex` pattern discussed above is one of them.
> +
> +For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
> +configuration file as discussed above, but if present, it will
> +override a built-in pattern.
> +
> +Nevertheless, you need to enable built-in patterns via .gitattributes`
> +for the pattern to take effect.
> +
> +The following built-in patterns are available:
> =20
>  - `ada` suitable for source code in the Ada language.
