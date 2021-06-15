Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D4EC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459636140D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhFOD5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:57:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62406 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFOD5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:57:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06529C7712;
        Mon, 14 Jun 2021 23:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cKfTZ8ywr/b0/QviJlk1EjDk3ZQFg5k44KYeL9
        FI+0c=; b=fa+0gT/pz8r7NoNqGqzKtKJ8DHjpkKoSbNRjlYELVMGwqdqBq9x4xB
        3gLH/BjJUnxHObyDJuSBKJtXp672osozjGp++H9sSAeb98flh8xyR0PsoJMq0D1z
        uKDm99sSp/yT+4/nXOAixPWuwKkHZT4IwwecCVRYZZwQHRwjLiOFY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2B3FC7711;
        Mon, 14 Jun 2021 23:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86A32C7710;
        Mon, 14 Jun 2021 23:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH resend] graph: improve grammar of "invalid color" error
 message
References: <20210612184144.6894-1-alexhenrie24@gmail.com>
Date:   Tue, 15 Jun 2021 12:55:38 +0900
In-Reply-To: <20210612184144.6894-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 12 Jun 2021 12:41:44 -0600")
Message-ID: <xmqqv96fwzlx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C777E08-CD8D-11EB-92CA-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Without the "d", it sounds like a command, not an error, and is liable
> to be translated incorrectly.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> Resending to make sure that this patch isn't forgotten.

Thanks, will queue.

> ---
>  graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/graph.c b/graph.c
> index c128ad0cce..e3828eb8f2 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
>  		if (!color_parse_mem(start, comma - start, color))
>  			strvec_push(colors, color);
>  		else
> -			warning(_("ignore invalid color '%.*s' in log.graphColors"),
> +			warning(_("ignored invalid color '%.*s' in log.graphColors"),
>  				(int)(comma - start), start);
>  		start = comma + 1;
>  	}
