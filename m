Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7703C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F712468B
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BM9JLIIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgARSe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:34:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63845 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgARSe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 13:34:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F5F2AF2E3;
        Sat, 18 Jan 2020 13:34:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r4XAVILfKdb1df8HCJIbK0bNZNo=; b=BM9JLI
        IjCQe+jIzAj9tshSmY0HZGjbgSbH119aBIephfM3Jwm3+BObpwaa6YfOH9dgJfIV
        XFaFeYjKZMinKSfCGqb6X6L9aPPHMyqYSr6kG7Yvlz/1L6cmtunzFxjIRaRqa7tT
        gkOgk1m2k9IRYQfXA3FW3QCEgZlVtOoqPIRac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uF2I9mT2HbE73KnP8AHDH/TJ04qzlr+i
        KV60zRxGVptWftlexdc1e0UI+BhrOiaukrY0hf8U+AhyFtZs0uX9tKO3dUB1nh0u
        BMjgfStKHSyH5gGN4YwvlPhfdNpjJ3RnvrVn4Wpr8QhmycTQVahrZNRlgSnfltOR
        iBw8De8YZMA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47D23AF2E2;
        Sat, 18 Jan 2020 13:34:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70714AF2E1;
        Sat, 18 Jan 2020 13:34:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 3/3] color.c: Alias RGB colors 8-15 to aixterm colors
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
        <20200118145318.5177-1-shawarmakarma@gmail.com>
        <20200118145318.5177-3-shawarmakarma@gmail.com>
Date:   Sat, 18 Jan 2020 10:34:51 -0800
In-Reply-To: <20200118145318.5177-3-shawarmakarma@gmail.com> (Eyal Soha's
        message of "Sat, 18 Jan 2020 09:53:18 -0500")
Message-ID: <xmqqzhekbol0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37EBB602-3A21-11EA-95B0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> This results in shorter output, and is _probably_ more portable. There
> is at least one environment (GitHub Actions) which supports 16-color
> mode but not 256-color mode. It's possible there are environments
> which go the other way, but it seems unlikely.

Nicely explained.

>
> Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
> ---
>  color.c          | 7 ++++++-
>  t/t4026-color.sh | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/color.c b/color.c
> index 66d32e1191..ba067ed97a 100644
> --- a/color.c
> +++ b/color.c
> @@ -136,11 +136,16 @@ static int parse_color(struct color *out, const char *name, int len)
>  		else if (val < 0) {
>  			out->type = COLOR_NORMAL;
>  			return 0;
> -		/* Rewrite low numbers as more-portable standard colors. */
> +		/* Rewrite 0-7 as more-portable standard colors. */
>  		} else if (val < 8) {
>  			out->type = COLOR_ANSI;
>  			out->value = val + COLOR_FOREGROUND_ANSI;
>  			return 0;
> +		/* Rewrite 8-15 as more-portable aixterm colors. */
> +		} else if (val < 16) {
> +			out->type = COLOR_ANSI;
> +			out->value = val - 8 + COLOR_FOREGROUND_BRIGHT_ANSI;
> +			return 0;
>  		} else if (val < 256) {
>  			out->type = COLOR_256;
>  			out->value = val;
> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index 78c69de90a..c0b642c1ab 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -82,6 +82,10 @@ test_expect_success '0-7 are aliases for basic ANSI color names' '
>  	color "0 7" "[30;47m"
>  '
>  
> +test_expect_success '8-15 are aliases for aixterm color names' '
> +	color "12 13" "[94;105m"
> +'
> +
>  test_expect_success '256 colors' '
>  	color "254 bold 255" "[1;38;5;254;48;5;255m"
>  '
