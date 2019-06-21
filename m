Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C064B1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 19:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFUTSS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 15:18:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61663 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfFUTSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 15:18:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0235C14AF49;
        Fri, 21 Jun 2019 15:18:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lStsA2giJNhwPiFbDry63M1G8No=; b=uJrXfR
        bsLJRMbA9wiOhCLAWBbXiVSeSB4zA1kZ2phj94th21QEiBibPv506dfwNM+DVkP+
        2ITkr22V/9N+Razv/KlRdo1RUE5IDYUIchuKmeUhkSd26ZbSjbya+OEWTl+DeDG1
        3+/u6wiM1USA3Mi6LRCMncvKYxaSbEDLhDQQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FfK8GfU7SehwDKdsXh2ClnRkHQ7cPLHF
        aKLV9XOZaukdqCSos2E0SeGTDlwhfw2buTYrUNBbMNTJeQGmoJ2IAOqJMd0vsX8t
        cG0vQ6oQaFDea2++vHu9uYJYO9fR4jrtSHEnIej4SD+A8Rhf04Qud97J27+0FwkZ
        V2J3zQ7xlc8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED8ED14AF48;
        Fri, 21 Jun 2019 15:18:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63F1414AF46;
        Fri, 21 Jun 2019 15:18:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] l10n: localizable upload progress messages
References: <20190621185051.77354-1-dimitriy.ryazantcev@gmail.com>
Date:   Fri, 21 Jun 2019 12:18:11 -0700
In-Reply-To: <20190621185051.77354-1-dimitriy.ryazantcev@gmail.com> (Dimitriy
        Ryazantcev's message of "Fri, 21 Jun 2019 21:50:51 +0300")
Message-ID: <xmqq8stukarw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FDB6866-9459-11E9-912F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:

> Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> ---
>  progress.c | 3 ++-
>  strbuf.c   | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index a2e8cf64a8..3d47c06495 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -151,7 +151,8 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
>  	strbuf_humanise_bytes(buf, total);
>  	strbuf_addstr(buf, " | ");
>  	strbuf_humanise_bytes(buf, rate * 1024);
> -	strbuf_addstr(buf, "/s");
> +	/* TRANSLATORS: per second */
> +	strbuf_addstr(buf, _("/s"));
>  }

Hpmh, if it is OK to assume that in all human languages it is OK to
express the reate as <number> followed by translated "per second",
without allowing the order from getting changed, then ...

>  	if (bytes > 1 << 30) {
> -		strbuf_addf(buf, "%u.%2.2u GiB",
> +		strbuf_addf(buf, _("%u.%2.2u GiB"),
>  			    (unsigned)(bytes >> 30),
>  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);

wouldn't it make more sense to split GiB, MiB, KiB and "bytes" units
out of these messages, and ask only these unit names, without the
%u.%2.2u number formats, to get translated by the localization team?

>  	} else if (bytes > 1 << 20) {
>  		unsigned x = bytes + 5243;  /* for rounding */
> -		strbuf_addf(buf, "%u.%2.2u MiB",
> +		strbuf_addf(buf, _("%u.%2.2u MiB"),
>  			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
>  	} else if (bytes > 1 << 10) {
>  		unsigned x = bytes + 5;  /* for rounding */
> -		strbuf_addf(buf, "%u.%2.2u KiB",
> +		strbuf_addf(buf, _("%u.%2.2u KiB"),
>  			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
>  	} else {
> -		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
> +		strbuf_addf(buf, _("%u bytes"), (unsigned)bytes);

This needs the Q_() to deal with plural (i.e. in en, between "byte"
and "bytes").

>  	}
>  }
