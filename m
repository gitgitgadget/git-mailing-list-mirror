Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E4C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4300061216
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhIQU1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 16:27:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62963 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbhIQU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 16:27:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00C8DF79AC;
        Fri, 17 Sep 2021 16:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dfooEuzcoyYc
        u6iaEBgD3gaq/W8VLbDd1JZvwPCvjwM=; b=F60yUvAtFF5i72zcor39h9O8LYiJ
        pEC6xC6ktzkRh3CIQDJLgAZU35nnugBLXK7jCVj+q04CoIBi3kItvItFxVu1G3Yf
        5JDZMfuH/E9BwKJ2vTnJd+PevZSj88GhowZBJcKBdSUAl8bTTDLSbzmNCXc79imn
        WntJyWsmoheCwxA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC1AAF79AB;
        Fri, 17 Sep 2021 16:25:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C92BF79AA;
        Fri, 17 Sep 2021 16:25:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dev+git@drbeat.li
Subject: Re: [PATCH] unicode: update the width tables to Unicode 14
References: <20210917191920.55944-1-carenas@gmail.com>
Date:   Fri, 17 Sep 2021 13:25:38 -0700
In-Reply-To: <20210917191920.55944-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 17 Sep 2021 12:19:20 -0700")
Message-ID: <xmqqee9ngda5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6C50A408-17F5-11EC-A3D5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Released[0] after a long beta period and including several additional
> zero/double width characters.
>
> [0] https://home.unicode.org/announcing-the-unicode-standard-version-14=
-0/
> ---

Thanks---missing sign-off is deliberate and waiting for something
else to happen?

>  unicode-width.h | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/unicode-width.h b/unicode-width.h
> index b50e686bae..97c851b27d 100644
> --- a/unicode-width.h
> +++ b/unicode-width.h
> @@ -26,7 +26,9 @@ static const struct interval zero_width[] =3D {
>  { 0x0825, 0x0827 },
>  { 0x0829, 0x082D },
>  { 0x0859, 0x085B },
> -{ 0x08D3, 0x0902 },
> +{ 0x0890, 0x0891 },
> +{ 0x0898, 0x089F },
> +{ 0x08CA, 0x0902 },
>  { 0x093A, 0x093A },
>  { 0x093C, 0x093C },
>  { 0x0941, 0x0948 },
> @@ -66,6 +68,7 @@ static const struct interval zero_width[] =3D {
>  { 0x0BCD, 0x0BCD },
>  { 0x0C00, 0x0C00 },
>  { 0x0C04, 0x0C04 },
> +{ 0x0C3C, 0x0C3C },
>  { 0x0C3E, 0x0C40 },
>  { 0x0C46, 0x0C48 },
>  { 0x0C4A, 0x0C4D },
> @@ -116,7 +119,7 @@ static const struct interval zero_width[] =3D {
>  { 0x1160, 0x11FF },
>  { 0x135D, 0x135F },
>  { 0x1712, 0x1714 },
> -{ 0x1732, 0x1734 },
> +{ 0x1732, 0x1733 },
>  { 0x1752, 0x1753 },
>  { 0x1772, 0x1773 },
>  { 0x17B4, 0x17B5 },
> @@ -124,7 +127,7 @@ static const struct interval zero_width[] =3D {
>  { 0x17C6, 0x17C6 },
>  { 0x17C9, 0x17D3 },
>  { 0x17DD, 0x17DD },
> -{ 0x180B, 0x180E },
> +{ 0x180B, 0x180F },
>  { 0x1885, 0x1886 },
>  { 0x18A9, 0x18A9 },
>  { 0x1920, 0x1922 },
> @@ -140,7 +143,7 @@ static const struct interval zero_width[] =3D {
>  { 0x1A65, 0x1A6C },
>  { 0x1A73, 0x1A7C },
>  { 0x1A7F, 0x1A7F },
> -{ 0x1AB0, 0x1AC0 },
> +{ 0x1AB0, 0x1ACE },
>  { 0x1B00, 0x1B03 },
>  { 0x1B34, 0x1B34 },
>  { 0x1B36, 0x1B3A },
> @@ -163,8 +166,7 @@ static const struct interval zero_width[] =3D {
>  { 0x1CED, 0x1CED },
>  { 0x1CF4, 0x1CF4 },
>  { 0x1CF8, 0x1CF9 },
> -{ 0x1DC0, 0x1DF9 },
> -{ 0x1DFB, 0x1DFF },
> +{ 0x1DC0, 0x1DFF },
>  { 0x200B, 0x200F },
>  { 0x202A, 0x202E },
>  { 0x2060, 0x2064 },
> @@ -227,12 +229,16 @@ static const struct interval zero_width[] =3D {
>  { 0x10D24, 0x10D27 },
>  { 0x10EAB, 0x10EAC },
>  { 0x10F46, 0x10F50 },
> +{ 0x10F82, 0x10F85 },
>  { 0x11001, 0x11001 },
>  { 0x11038, 0x11046 },
> +{ 0x11070, 0x11070 },
> +{ 0x11073, 0x11074 },
>  { 0x1107F, 0x11081 },
>  { 0x110B3, 0x110B6 },
>  { 0x110B9, 0x110BA },
>  { 0x110BD, 0x110BD },
> +{ 0x110C2, 0x110C2 },
>  { 0x110CD, 0x110CD },
>  { 0x11100, 0x11102 },
>  { 0x11127, 0x1112B },
> @@ -315,6 +321,8 @@ static const struct interval zero_width[] =3D {
>  { 0x16FE4, 0x16FE4 },
>  { 0x1BC9D, 0x1BC9E },
>  { 0x1BCA0, 0x1BCA3 },
> +{ 0x1CF00, 0x1CF2D },
> +{ 0x1CF30, 0x1CF46 },
>  { 0x1D167, 0x1D169 },
>  { 0x1D173, 0x1D182 },
>  { 0x1D185, 0x1D18B },
> @@ -332,6 +340,7 @@ static const struct interval zero_width[] =3D {
>  { 0x1E023, 0x1E024 },
>  { 0x1E026, 0x1E02A },
>  { 0x1E130, 0x1E136 },
> +{ 0x1E2AE, 0x1E2AE },
>  { 0x1E2EC, 0x1E2EF },
>  { 0x1E8D0, 0x1E8D6 },
>  { 0x1E944, 0x1E94A },
> @@ -404,7 +413,10 @@ static const struct interval double_width[] =3D {
>  { 0x17000, 0x187F7 },
>  { 0x18800, 0x18CD5 },
>  { 0x18D00, 0x18D08 },
> -{ 0x1B000, 0x1B11E },
> +{ 0x1AFF0, 0x1AFF3 },
> +{ 0x1AFF5, 0x1AFFB },
> +{ 0x1AFFD, 0x1AFFE },
> +{ 0x1B000, 0x1B122 },
>  { 0x1B150, 0x1B152 },
>  { 0x1B164, 0x1B167 },
>  { 0x1B170, 0x1B2FB },
> @@ -439,21 +451,23 @@ static const struct interval double_width[] =3D {
>  { 0x1F6CC, 0x1F6CC },
>  { 0x1F6D0, 0x1F6D2 },
>  { 0x1F6D5, 0x1F6D7 },
> +{ 0x1F6DD, 0x1F6DF },
>  { 0x1F6EB, 0x1F6EC },
>  { 0x1F6F4, 0x1F6FC },
>  { 0x1F7E0, 0x1F7EB },
> +{ 0x1F7F0, 0x1F7F0 },
>  { 0x1F90C, 0x1F93A },
>  { 0x1F93C, 0x1F945 },
> -{ 0x1F947, 0x1F978 },
> -{ 0x1F97A, 0x1F9CB },
> -{ 0x1F9CD, 0x1F9FF },
> +{ 0x1F947, 0x1F9FF },
>  { 0x1FA70, 0x1FA74 },
> -{ 0x1FA78, 0x1FA7A },
> +{ 0x1FA78, 0x1FA7C },
>  { 0x1FA80, 0x1FA86 },
> -{ 0x1FA90, 0x1FAA8 },
> -{ 0x1FAB0, 0x1FAB6 },
> -{ 0x1FAC0, 0x1FAC2 },
> -{ 0x1FAD0, 0x1FAD6 },
> +{ 0x1FA90, 0x1FAAC },
> +{ 0x1FAB0, 0x1FABA },
> +{ 0x1FAC0, 0x1FAC5 },
> +{ 0x1FAD0, 0x1FAD9 },
> +{ 0x1FAE0, 0x1FAE7 },
> +{ 0x1FAF0, 0x1FAF6 },
>  { 0x20000, 0x2FFFD },
>  { 0x30000, 0x3FFFD }
>  };
