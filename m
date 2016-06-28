Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30242018A
	for <e@80x24.org>; Tue, 28 Jun 2016 15:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbcF1Pmi (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 11:42:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752157AbcF1Pmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 11:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5195223B63;
	Tue, 28 Jun 2016 11:42:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eBfyKOtumkshTt7PD0K7QmRhJ0g=; b=sXhETg
	0uySUV6p7kVWDmny7ROcVVhF55RRlBxJcCuHkshpH+cfaOgqrw0QOmhBSkboY6yU
	tl8gYnbXKeDvWUoPLlIH4ndbz4BbLHWCxZTEwJZ4Gf5WvFerdShVnVNOy7Bwi/SA
	m8C0zESJj6gaaP6fgjBBYF9gJ4YWrdLnOAgjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QyCaYmbaG90KLymCbDJcgjQEBj+B41M/
	ZSGhmayvR8eYO5kPI0t2WWye8F+/sj62qf8dLf5fyI7rXQhvjELLIVoviSdIAfem
	0KZLTBnfyj2h62JzRVzmGuXn9GpegUk6eg6njfGNPomSm8dBkZ3/6txawpIwZ6LP
	Gcf5eNDQXts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 489EB23B61;
	Tue, 28 Jun 2016 11:42:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7DD123B5D;
	Tue, 28 Jun 2016 11:42:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <blees@dcon.de>, Stepan Kasal <kasal@ucw.cz>,
	Jeff King <peff@peff.net>, Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Remove obsolete comment from color.h
References: <16f3d3edb03c2cb9a6c11b745eda9fb2274af182.1467108142.git.johannes.schindelin@gmx.de>
Date:	Tue, 28 Jun 2016 08:42:33 -0700
In-Reply-To: <16f3d3edb03c2cb9a6c11b745eda9fb2274af182.1467108142.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 28 Jun 2016 12:02:49 +0200
	(CEST)")
Message-ID: <xmqqinwt9v6e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFA4B86A-3D46-11E6-B073-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Originally, ANSI color sequences were supported on Windows only by
> overriding the printf() and fprintf() functions, as mentioned in e7821d7
> (Add a notice that only certain functions can print color escape codes,
> 2009-11-27).
>
> As of eac14f8 (Win32: Thread-safe windows console output, 2012-01-14),
> however, this is no longer the case, as the ANSI color sequence support
> code needed to be replaced with a thread-safe version, one side effect
> being that stdout and stderr handled no matter which function is used to
> write to it.

So as long as we write via stdio to stdout/stderr, you can show
colors?  Or is it now stronger, in that as long as we do anything
that ends up writing to file descriptors 1 or 2, you can show
colors?

> So let's just remove the comment that is now obsolete.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/winansi-color-v1
>  color.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/color.h b/color.h
> index e155d13..b9ead16 100644
> --- a/color.h
> +++ b/color.h
> @@ -18,11 +18,6 @@ struct strbuf;
>   */
>  #define COLOR_MAXLEN 70
>  
> -/*
> - * IMPORTANT: Due to the way these color codes are emulated on Windows,
> - * write them only using printf(), fprintf(), and fputs(). In particular,
> - * do not use puts() or write().
> - */
>  #define GIT_COLOR_NORMAL	""
>  #define GIT_COLOR_RESET		"\033[m"
>  #define GIT_COLOR_BOLD		"\033[1m"
