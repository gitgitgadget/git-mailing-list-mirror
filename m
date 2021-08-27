Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F0C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54AA61002
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhH0REu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:04:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65393 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhH0REu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 13:04:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C864315D7A6;
        Fri, 27 Aug 2021 13:04:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t60xL5nQwyWF
        99BRVPXHZdeLVj5Aia5mxiZBIS89xcA=; b=cj7p1riQr2liKKpaYHbP4rR6UJph
        1mQ6ThMduk4Jd/Oa1Kv6AI2B4tVAkK0T+fxRXfaXJYXYFd9j30xAkkvpU5/FqL5Q
        2AaZq7ezTKFSVcRFt1o3nKRVk4Wix4F9ayqCl61RFW3pyVbJf93oNJ8OrWoG7P4X
        2EeoRm3FL5me3Yg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB58815D7A5;
        Fri, 27 Aug 2021 13:04:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E92915D7A2;
        Fri, 27 Aug 2021 13:03:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>
Cc:     Christopher Yeleighton via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher Yeleighton <ne01026@shark.2a.pl>
Subject: Re: [PATCH v2] pretty-options.txt: describe supported encoding
References: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com>
        <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
        <2247912.lYO0ccLKhl@localhost.localdomain>
Date:   Fri, 27 Aug 2021 10:03:56 -0700
In-Reply-To: <2247912.lYO0ccLKhl@localhost.localdomain> ("Krzysztof
        =?utf-8?Q?=C5=BBelechowski=22's?= message of "Fri, 27 Aug 2021 13:51:34
 +0200")
Message-ID: <xmqq5yvqbz0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C4BAB8C0-0758-11EC-AF76-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Krzysztof =C5=BBelechowski <giecrilj@stegny.2a.pl> writes:

> git log recognises only system encodings supported by iconv(1), but not=
=20
> POSIX character maps used by iconv(1p). Document it.
>
> Signed-off-by:  <ne01026@shark.2a.pl>

The "Human Readable Name <email@add.re.ss>" on this line must match
the one on the "From: " line that records the author of the patch.

If you are forwarding somebody else's patch (with or without
improvement), we also need your sign off.

> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-
> options.txt
> index 27ddaf84a19..4f8376d681b 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -36,9 +36,13 @@ people using 80-column terminals.
>         The commit objects record the encoding used for the log message
>         in their encoding header; this option can be used to tell the
>         command to re-code the commit log message in the encoding
> -       preferred by the user.  For non plumbing commands this
> -       defaults to UTF-8. Note that if an object claims to be encoded
> -       in `X` and we are outputting in `X`, we will output the object
> +       preferred by the user.


> +       The encoding must be a system encoding supported by iconv(1),
> +       otherwise this option will be ignored.
> +       POSIX character maps used by iconv(1p) are not supported.

This paragraph is a bit hard to grok.

I think it is saying that the "-f frommap -t tomap" form in [*1*]
that can use arbitrary character set description file is not
supported, but "-f fromcode -t tocode" form, which also is what
iconv_open() takes [*2*], is supported.  Am I reading it correctly?

Is there an easier-to-read way to explain the distinction to our
average reader?

What I am getting at is this.  Imagine average users who need to see
their commits recoded to iso-8859-2.  They see "git log" has
"--encoding=3D<encoding>" option, read the above paragraph and wonder
if they are on the supported side or unsupported side of the above
paragraph.  I want to make it easy for them to stop wondering.

For that purpose, "iconv(1) vs iconv(1p)" would not help them very
much, especially considering that not all Git users are UNIX users
(they probably do not even know what (1) and (1p) means).

> +       For non-plumbing commands this defaults to UTF-8.

I think I can guess why the patch wants to change "non plumbing" to
"non-plumbing" (I do not strongly care either way, so I'd take the
patch without complaint about that particular change).  It would
have been nicer to mention this change in the proposed commit log
message, though, but that is minor.

> +       Note that if an object claims to be encoded in `X`
> +       and we are outputting in `X`, we shall output the object
>         verbatim; this means that invalid sequences in the original
>         commit may be copied to the output.

I probably wouldn't have noticed this if a new manual page used
"shall" consistently, but since the original deliberately used
"will" and the patch changes it to "shall", I have to ask: why?

I think our end-user facing manual pages tend to avoid the latter.
We do use "shall" in the RFC2119/BCP14 sense on the technical side
of our documentation where we give requirements to the third-party
implementations so that they can interoperate with us, but this is
not such a description.

Thanks.


[References]

*1* https://pubs.opengroup.org/onlinepubs/9699919799/utilities/iconv.html=
=20
*2* https://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv_open=
.html
