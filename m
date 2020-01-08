Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC8DC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7A20705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+1s6zPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgAHVQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:16:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52618 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 16:16:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 425893847C;
        Wed,  8 Jan 2020 16:16:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JULBij/Kayn8
        YDNJZ4ajAgdACqE=; b=D+1s6zPfijeBTwy+wOJ0mtb1ifhEVkohtFspvF1gVeVW
        KJ1RFyaar9S/C3zo3k2iIoLR38XEu5OrD2LcW8Z2xctb/rH1c5xR1Z/qpBWxvJMs
        PGJIuixnGo3WI6bcqp04OC4rfdLb4CkB/+Ngwbq7cFvbUJgd+buUacivk2EYFF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wef6K1
        +vKvCQ522eAndCwxExtvIddL4k4GXbTvpuIId5GHl1TOLcwgahClyv+yWiGJdLuD
        oyQaq9wHCqw1EUFull9/rUJj5ME97GQTg1J84eTKaGBF8xnpxQYWOMk5Evg6gDeY
        2IermbocAysM55fzkZuOnyo5xQI3Y7ND7yVvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AB8C3847A;
        Wed,  8 Jan 2020 16:16:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A68E038479;
        Wed,  8 Jan 2020 16:16:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] config/advice.txt: fix description list separator
References: <20200108200844.30803-1-martin.agren@gmail.com>
Date:   Wed, 08 Jan 2020 13:16:55 -0800
In-Reply-To: <20200108200844.30803-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 8 Jan 2020 21:08:44 +0100")
Message-ID: <xmqqftgp1we0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 334894A2-325C-11EA-877D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> The whole submoduleAlternateErrorStrategyDie item is interpreted as
> being part of the supporting content of the preceding item. This is
> because we don't give a double-colon "::" for the separator, but just a
> single colon, ":". Let's fix that.
>
> There are a few other matches for [^:]:\s*$ in Documentation/config, bu=
t
> I didn't spot any similar bugs among them.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  This was the only thing that stood out at me while going through
>  `./doc-diff v2.24.0 origin/master`. This is obviously a non-critical,
>  purely cosmetic issue.

Thanks.  It still is a new bug introduced by a recent change, so I
am tempted to include it in the final but it is a bit too late for
the -rc2 I planned to tag today.


>
>  Documentation/config/advice.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/adv=
ice.txt
> index d4e698cd3f..4be93f8ad9 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -107,7 +107,7 @@ advice.*::
>  		editor input from the user.
>  	nestedTag::
>  		Advice shown if a user attempts to recursively tag a tag object.
> -	submoduleAlternateErrorStrategyDie:
> +	submoduleAlternateErrorStrategyDie::
>  		Advice shown when a submodule.alternateErrorStrategy option
>  		configured to "die" causes a fatal error.
>  --
