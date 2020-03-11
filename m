Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D5C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8360920736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pv4wT0gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgCKSjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:39:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50931 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKSjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 14:39:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEE61BCBF6;
        Wed, 11 Mar 2020 14:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5DapUKQ0mCkYVegd/6k/0SirUA0=; b=pv4wT0
        gKZXUyksaU8LEeHG98+bL9BgdyfNc1JmOQLrS3c+dToV3wgOemlf+YO1gUco2PVh
        zOcCATVbzhL3EWnPJS4eRM8UbsXb6+5OGvMTDMoExNNpZsF6XwaK1pq0gj6roNNf
        UXD/7yDPxE12T7q/XbHwmPgsiVlbpQqQt66MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qyZvn7aMJmk+LYIy7vZYYmqThf+zbgfJ
        MYvfecWN6agTChz7YXc+lYvHufuDYM9a+jy47vr1PSYyawONWCdvC9HIGhtRLRtH
        ud8P3BNGwThpHsN/KoeWbnZSaEBVNoiTB+riIYAHibAVf0DSi4bMXHfmqAjZnDcs
        jkpWdMNQjho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A685EBCBF5;
        Wed, 11 Mar 2020 14:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01491BCBF3;
        Wed, 11 Mar 2020 14:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: unmark a message in rebase.c
References: <20200311065527.7669-1-worldhello.net@gmail.com>
Date:   Wed, 11 Mar 2020 11:39:08 -0700
In-Reply-To: <20200311065527.7669-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 11 Mar 2020 14:55:27 +0800")
Message-ID: <xmqqsgiehh2r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98BA0E78-63C7-11EA-9494-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Commit v2.25.0-4-ge98c4269c8 (rebase (interactive-backend): fix handling
> of commits that become empty, 2020-02-15) marked "{drop,keep,ask}" for
> translation, but this message should not be changed.

Thanks.

>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index cb7aeae597..bff53d5d16 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1543,7 +1543,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				 "ignoring them"),
>  			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> -		OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
> +		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
>  			       N_("how to handle commits that become empty"),
>  			       PARSE_OPT_NONEG, parse_opt_empty),
>  		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
