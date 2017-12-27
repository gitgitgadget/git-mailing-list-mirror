Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D469C1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdL0Tol (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:44:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751203AbdL0Tok (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:44:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42B51B7865;
        Wed, 27 Dec 2017 14:44:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u8e7air7XFukN2Ro7RW4CytlygU=; b=f/E7TE
        iBniFnW2E7aYA26DEZp+uqdfzWdua2rWTZ4UqXgVmoRA+d3tQSLajHOet3bS/cl3
        rgfErFEnJXgKOGonEhmqf3Dc5cQvw1Ufi6GF7JxhWXJ1G+daQtz2ErOP32GRxsH8
        +jMDKH6f3k+heK1QNBPAIO6JSAPh/2RigIg4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PgHOFnRdMx8NsS7wPbX7aXDRifVJPOGE
        2xy92f1jfFFnT2Ikwly3eyIlX3vNLjhqSVutklAlkyXwSMqjXRvXQs/0la0MIHMK
        78a6p0yUxCGehW5kGeK0JwsMtOQb6jEcBq0Dcf0wkHYyPq0ffFajLwedROfHRZtw
        Pba6wiC3PGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C23B7864;
        Wed, 27 Dec 2017 14:44:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A68E8B7863;
        Wed, 27 Dec 2017 14:44:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ivan Pozdeev <vano@mail.mipt.ru>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] Fix confusing wording
References: <8da9d436-88b9-7959-dd9c-65bdd376bf54@mail.mipt.ru>
Date:   Wed, 27 Dec 2017 11:44:38 -0800
In-Reply-To: <8da9d436-88b9-7959-dd9c-65bdd376bf54@mail.mipt.ru> (Ivan
        Pozdeev's message of "Mon, 25 Dec 2017 13:26:37 +0300")
Message-ID: <xmqqincslzvd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6077171C-EB3E-11E7-9A28-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Pozdeev <vano@mail.mipt.ru> writes:

> Not sure if I should add a CVE-2009-0037 reference as well.

Not in an end-user facing message like this one, I would say.

>
> ---

Sign off?

> http.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 215bebe..26b3386 100644
> --- a/http.c
> +++ b/http.c
> @@ -802,7 +802,7 @@ static CURL *get_curl_handle(void)
> get_curl_allowed_protocols(-1));
> #else
> warning("protocol restrictions not applied to curl redirects because\n"
> - "your curl version is too old (>= 7.19.4)");
> + "your libcurl version is too old (< 7.19.4)");
> #endif

Between 'curl' and 'libcurl', the latter certainly is more
technically correct.  I have a feeling that it would be better to
spell out ">=" as "requires at least" than replacing it with equally
cryptic "<" (it is OK to spell it out as "your libcurl version is
older than minimum required 7.19.4", too).

Thanks.
