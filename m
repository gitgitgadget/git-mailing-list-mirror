Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B37C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 20:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhLUUzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:55:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60582 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhLUUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 15:55:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3891BF9121;
        Tue, 21 Dec 2021 15:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=URoCG6y9h4enpb5kUYCHyrg4ZdlRsAx/f8Cb5+
        rgVvU=; b=THWG5MxivTX8GIHYjb1yo5uj2DiUNCfSy/hDP6QT7Xolnppd4RnKIF
        g3LgXHQkRjTf5Iur5kjJ4KgBtzkRc3o/bPLNyFjLd7DErTWJRn+nV8adnEyvs8vH
        nTzDh9ZKR3yj7fKzyzPMk6mJCNZxj6legGcGGSj1JS5Hukldnith8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BB51F911F;
        Tue, 21 Dec 2021 15:55:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4B77F911E;
        Tue, 21 Dec 2021 15:54:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Subject: Re: [PATCH v2] l10n: README: call more attention to plural strings
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
        <a9453065c2e89d79fc117363fe41fa10986e06d1.1640113138.git.steadmon@google.com>
Date:   Tue, 21 Dec 2021 12:54:58 -0800
In-Reply-To: <a9453065c2e89d79fc117363fe41fa10986e06d1.1640113138.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 21 Dec 2021 11:00:42 -0800")
Message-ID: <xmqq1r25ptjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42EEABC8-62A0-11EC-A74A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In po/README.md, we point core developers to gettext's "Preparing
> Strings" documentation for advice on marking strings for translation.
> However, this doc doesn't really discuss the issues around plural form
> translation, which can make it seem that nothing special needs to be
> done in this case.
>
> Add a specific callout here about marking plural-form strings so that
> the advice later on in the README is not overlooked.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  po/README.md | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/po/README.md b/po/README.md
> index dcd8436c25..19fabb4acf 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -221,6 +221,10 @@ General advice:
>  - Adjust the strings so that they're easy to translate. Most of the
>    advice in `info '(gettext)Preparing Strings'` applies here.
>  
> +- Strings referencing numbers of items may need to be split into singular and
> +  plural forms; see the Q\_() wrapper in the C sub-section below for an
> +  example.
> +
>  - If something is unclear or ambiguous you can use a "TRANSLATORS"
>    comment to tell the translators what to make of it. These will be
>    extracted by xgettext(1) and put in the "po/\*.po" files, e.g. from
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc

Looks sensible to me.

I do not mind taking this myself, instead of getting it via our i18n
manager, if Jiang is OK with it.

Thanks.
