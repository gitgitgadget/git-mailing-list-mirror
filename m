Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9EBC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbhLMV4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:56:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60530 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbhLMV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:56:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91EAC16106D;
        Mon, 13 Dec 2021 16:56:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MqFWVg9JRJNAFzSNy5bR5ZqxE1Zh+dgRoSEy9x
        c0hNM=; b=DTKF7aZdV2YDRu17L9BQrIcnfxMS6gsoepCtBoTHtvLRqTt5Pn3cvX
        vVVHunhOmbMV8r2H5xC+esQ/qheS9tzOz5w72eXUarYl5W+NMFjJcWeuVRd0drVj
        jR5TDJIT9sOpxrRrWVlWB3zXarzFUk1aIkapnRfti+ebSSoyHdLOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B02816106C;
        Mon, 13 Dec 2021 16:56:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E088416106A;
        Mon, 13 Dec 2021 16:56:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: README: call more attention to plural strings
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
Date:   Mon, 13 Dec 2021 13:56:07 -0800
In-Reply-To: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 13 Dec 2021 11:56:09 -0800")
Message-ID: <xmqqa6h4b24o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A8D07B0-5C5F-11EC-B68A-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
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
>  po/README.md | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/po/README.md b/po/README.md
> index dcd8436c25..fd1e024dd3 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -219,7 +219,10 @@ General advice:
>    they're part of Git's API.
>  
>  - Adjust the strings so that they're easy to translate. Most of the
> -  advice in `info '(gettext)Preparing Strings'` applies here.
> +  advice in `info '(gettext)Preparing Strings'` applies here. Strings
> +  referencing numbers of items may need to be split into singular and
> +  plural forms; see the Q\_() wrapper in the C sub-section below for an
> +  example.
>  
>  - If something is unclear or ambiguous you can use a "TRANSLATORS"
>    comment to tell the translators what to make of it. These will be

Sounds good to me, but I'd want an ack by those from the l10n
department.

Thanks.
