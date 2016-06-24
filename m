Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B76C1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcFXWDy (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 18:03:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751337AbcFXWDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 18:03:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E7F826830;
	Fri, 24 Jun 2016 18:03:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=miupePR0lPwP0q0adXzTO1xOyEQ=; b=oq/WqD
	ydzDWpULRD1OSwQJ47NmK8yy/GTP5O08mk9IfQsPN9T+HLTIQ4dx8otTW9jquYhV
	+I4VoPlxnaVYrLm6kICX/RGIz0kGofZ/JChAD7nPrwb//dnE5XaVAgfZTotirK3U
	hJgzcT1ux6V1sSEwIBO6fzaI+LM/UVkJLYegk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BaO2kgZSxg5ts4Kn0wZfzXXRi+6OM1dD
	/iecF/GvgI8ZJARsNkCA8PGpPXRrqERtjZ64KP+gFFVhE6JxHwfu47hcvzE8FqK7
	hGPJZ+kseEtOUqOkqWfnG6WfjBoXhaOBkIOQbdwvDbUB0b27hmnA/EmM0LHp+lut
	3Sxf/IyFRAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27B9B2682F;
	Fri, 24 Jun 2016 18:03:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A90B52682E;
	Fri, 24 Jun 2016 18:03:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/10] format-patch: use stdout directly
References: <cover.1466505222.git.johannes.schindelin@gmx.de>
	<cover.1466607667.git.johannes.schindelin@gmx.de>
	<35a00cad311766d2bc64dada92e14c163e5a5806.1466607667.git.johannes.schindelin@gmx.de>
Date:	Fri, 24 Jun 2016 15:03:49 -0700
In-Reply-To: <35a00cad311766d2bc64dada92e14c163e5a5806.1466607667.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 22 Jun 2016 17:02:04 +0200
	(CEST)")
Message-ID: <xmqqwpledz22.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8909D94C-3A57-11E6-9969-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Earlier, we freopen()ed stdout in order to write patches to files.
> That forced us to duplicate stdout (naming it "realstdout") because we
> *still* wanted to be able to report the file names.
>
> As we do not abuse stdout that way anymore, we no longer need to
> duplicate stdout, either.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/log.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

The logical consequence of 07/10; very nice.
