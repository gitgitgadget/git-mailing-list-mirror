Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72361F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 23:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941207AbcIYXPB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:15:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58736 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941106AbcIYXO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:14:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E746C420C3;
        Sun, 25 Sep 2016 19:14:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TzHW/76bOJWOAO15zW1B8MpCExE=; b=VpNytX
        cIkIn83KLNMrx00bFuoQ+zSzZV3KKxGVLF5Vki5kxcrHKiZNmmTkuzC7muUt0yw8
        zYBEqRCXUBa8QulIfbndrsnMowPA3KZLfni9iszNBfwxGcAd4D1CwJtX9K2FiW5L
        4YNTBdUR1YjJfQjwMbwunFWfutMuBMYychTdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aXQsqs2RT8quYxi6lYSvMtP2QoUTt5kC
        Uh5R4wCzTkSjrBMm8xQiuK5WtxO4GXGvwwNdtBOSQfLuf5TbAsIcslwi1jPX/G9y
        WDC+c93jTS3xpuh7vHzoTSaeQ/CAOJ3oKFkv1lTnXfCJViFFborPD9v3FLLkYSwl
        vzMrIu2y4ss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E04CC420C2;
        Sun, 25 Sep 2016 19:14:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68E70420C1;
        Sun, 25 Sep 2016 19:14:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 08/11] i18n: send-email: mark strings for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-9-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 16:14:54 -0700
In-Reply-To: <1472646690-9699-9-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:27 +0000")
Message-ID: <xmqq37kny3kh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF6F9EA4-8375-11E6-894B-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> -		$_ = ask("What to do with this address? ([q]uit|[d]rop|[e]dit): ",
> +		# TRANSLATORS: Make sure to include [q] [d] [e] in your
> +		# translation. The program will only accept English input
> +		# at this point.
> +		$_ = ask(__("What to do with this address? ([q]uit|[d]rop|[e]dit): "),
>  			valid_re => qr/^(?:quit|q|drop|d|edit|e)/i,
>  			default => 'q');
> ...
> -		$_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
> +		# TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
> +		# translation. The program will only accept English input
> +		# at this point.
> +		$_ = ask(__("Send this email? ([y]es|[n]o|[q]uit|[a]ll): "),
>  		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
>  		         default => $ask_default);

The same comment as the one for the prompt in "add -i" applies
here.  If something should not be translated, perhaps we are better
off pushing it outside __(), no?
