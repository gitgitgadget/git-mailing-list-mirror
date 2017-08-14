Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94C320899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbdHNXrs (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:47:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57221 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752651AbdHNXrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:47:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FB0B9E732;
        Mon, 14 Aug 2017 19:47:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T0ECt3x3pCRBWk7Rp2lDkwGMz78=; b=EisNv9
        oJ2HkMeDX4ymcRCs48NRPw2RZtn1JBS1unl642bJBho2/r4fXdl18dpE+UwNa2IX
        WSLN30rK9U+Ah5pggTy3xmwQP85OYNw/JoxPdvvmv4t8I+2ln7gq84zucfabHjf+
        KbMN0X9EjdkyRSbtxjmBDzt/Zy9cTzK6twVB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jG1yq2+KtKgl4xLMyXGavjkmGV953AVO
        wAxjRCjV4HoAOMkHX3VhMZZaMD8VJfb1swp0tjHTuhaEv35aSY/fdFr6AMp6LVhW
        vgGKc0OoH349cOgzaF0QxAVgAJhOZDf2l9rG3QCh6kOix7FC0LNdND+3m+oCankL
        fb5WM58DwB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47F0D9E731;
        Mon, 14 Aug 2017 19:47:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98F3E9E72F;
        Mon, 14 Aug 2017 19:47:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
References: <20170808012554.186051-1-bmwill@google.com>
        <20170814213046.107576-1-bmwill@google.com>
        <20170814213046.107576-3-bmwill@google.com>
        <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
        <20170814225716.p5airw6j5o6dszbn@sigill.intra.peff.net>
        <xmqqzib1sp6z.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 14 Aug 2017 16:47:45 -0700
In-Reply-To: <xmqqzib1sp6z.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 14 Aug 2017 16:29:56 -0700")
Message-ID: <xmqqvalpsoda.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F93B03E0-814A-11E7-B44F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I do not know which vintage of /usr/bin/git-clang-format
> I happen to have on my box, but I needed a crude workaround patch
> (attached at the end) ...

I guess you hit the same thing while our messages crossing ;-)


> As to what it does, the first example I tried may not have been a
> great one.  I got this:
>
>         git clang-format --style file --diff --extensions c,h
>         diff --git a/cache.h b/cache.h
>         index 73e0085186..6462fe25bc 100644
>         --- a/cache.h
>         +++ b/cache.h
>         @@ -1498,11 +1498,8 @@ struct checkout {
>                 const char *base_dir;
>                 int base_dir_len;
>                 struct delayed_checkout *delayed_checkout;
>         -	unsigned force:1,
>         -		 quiet:1,
>         -		 not_new:1,
>         -		a_new_field:1,
>         -		 refresh_cache:1;
>         +	unsigned force : 1, quiet : 1, not_new : 1, a_new_field : 1,
>         +		refresh_cache : 1;
>          };
>          #define CHECKOUT_INIT { NULL, "" }
>  
> which is not wrong per-se, but I have a mixed feelings.  I do not
> want it to complain if the original tried to fit many items on a
> single line, but if the original wanted to have one item per line,
> I'd rather see it kept as-is.

To clarify, the above is after I added a_new_field that is one-bit
wide without doing anything else.  I do not mind the checker
complaining the existing force, quiet, etc. whose widths are all
spelled without SP around ':', because they appear near-by, as a
collateral damage.  My only gripe is that the result got squished
into a single line.

> Anyway, we cannot have perfect checker from the day one, and
> considering this is an initial attempt, I'd say it is a good start.
