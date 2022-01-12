Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D81C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357427AbiALURb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:17:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51413 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357426AbiALUR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 15:17:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 721F1FE790;
        Wed, 12 Jan 2022 15:17:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ywkq6L6f2Kz9mVHVKvsG8Y0s1vEhyvaNDbvXwF
        kFXtQ=; b=MVOlXASJl0x6Kup+hHMpu1LwmjbrF3fmdLflmPT4WAfGcueVOJA0D5
        2+oIzKXmfMyLdFN1JkAVDuKaKKuxWaZVujAkjFQqXw7o7BOZGCqq4XAH+a5e2+ge
        eEFx5ptm/HZCN5Hx55MM5nR0HzmqOvHgr6bjDMT75vXjoB2vzCK68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69C4EFE78F;
        Wed, 12 Jan 2022 15:17:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2B94FE78E;
        Wed, 12 Jan 2022 15:17:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v1] Modify NonStop configuration to disable uncompress2
References: <002901d807ee$84cd2f40$8e678dc0$@nexbridge.com>
Date:   Wed, 12 Jan 2022 12:17:26 -0800
In-Reply-To: <002901d807ee$84cd2f40$8e678dc0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 12 Jan 2022 14:56:36
        -0500")
Message-ID: <xmqqtue8so89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9ADDD0C-73E4-11EC-85AB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Modify NonStop configuration to disable uncompress2.
>
> The zlib version available on NonStop x86/ia64 does not contain the
> uncompress2()
> Procedure.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

I'll lift your s-o-b from this patch and use it in
<xmqqzgo0u5j7.fsf@gitster.g>, as the patch part didn't apply.

Thanks.

>
> diff --git a/config.mak.uname b/config.mak.uname
> index a3a779327f..9b3e9bff5f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>         NO_SETENV = YesPlease
>         NO_UNSETENV = YesPlease
>         NO_MKDTEMP = YesPlease
> +       NO_UNCOMPRESS2 = YesPlease
>         # Currently libiconv-1.9.1.
>         OLD_ICONV = UnfortunatelyYes
>         NO_REGEX = NeedsStartEnd
> --
> 2.34.1
