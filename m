Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6704F1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeAZVF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 16:05:57 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41421 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeAZVF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 16:05:56 -0500
Received: by mail-pg0-f65.google.com with SMTP id 136so1000722pgd.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P+UZOO6jm1+AlG1fW3fTbVnei2ogkxoLz5o9PjRxgbE=;
        b=RGk1/C1V8T/J1gsOmfozEf55Dnz8MMHAD0bUL6FfoSAA7JmWqksXnvQX6Ro3Fhnjof
         Vd8yPnV4Pl1bSo9oCVjgHmzlTAg68cAQoJ61FyzyhXePiBlO2LEar7Tnc0Etvb5FMYbr
         kYbMflreM8ehAQ71SU5YVN8IVplFEHVQIFRj9A8k/+0/14V+4XgCXRpGosVow1T96ad3
         jNrHHqUk1ggtp6TlglQpDEPRmMRLKv3GfxtyzITZ7iwnQg+Yj2h2eG4YdJJPhqWG5A4E
         aIIB/osCCOO81VWcLRkAOaJ2ZpRZXyHNLYaHQNs6rAwBeP8KE7mV0tMQ4n0zGONpAoZv
         +L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P+UZOO6jm1+AlG1fW3fTbVnei2ogkxoLz5o9PjRxgbE=;
        b=LGWB7r/EAuvKnTh92gp7lEmfbNk+ODwoF7YBZRe9oh0uG5Tc+D61GakHOA629/I4nD
         ulMCYx/vaIPyiAQ2SEMH0GNiMzCt1SozDwbMFS0/8NmmLZ46oFh0r/I6rK8YzFLKwJuI
         dWZ1L3iQMih8i7tsGpZl9QjsC1aKn4cReMHvv8L9BO4/kwqvufVIXiK1EEHYmmVHxM8S
         wFnezf3NdKju5Qde+kp34NLLkeWRjaD3YtugthFRITUgXIzpdldFXkiwzQMc3v+E6lVx
         J47rudmT0c0wYCQANJlOZvCSELR0bSNTbeEA+sshHMePZ8hEoJjrD6wRRX7n/lak2Wy+
         7LSA==
X-Gm-Message-State: AKwxytfBsfvUN5lXOWYYb5PzLjiqsWxqEdrbPdN0h6t/vPvPJwM+Uixk
        4l1hWuGPhvSGYWAplvZHoZI=
X-Google-Smtp-Source: AH8x225/YLS6sXd3T4KlD4NKWM+1AML4DEdKgdTp6m7pSAXprFDt5jeXe91fQQvQXhhwX8KgquiQqA==
X-Received: by 10.101.101.71 with SMTP id a7mr16513177pgw.192.1517000755527;
        Fri, 26 Jan 2018 13:05:55 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id 62sm8401705pgh.80.2018.01.26.13.05.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 13:05:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 02/24] ref-filter: add return value to some functions
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
        <0102016133ff3ad8-abf99952-4df0-42a4-9ae9-06f602e84f3b-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Jan 2018 13:05:53 -0800
In-Reply-To: <0102016133ff3ad8-abf99952-4df0-42a4-9ae9-06f602e84f3b-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 26 Jan 2018 19:43:40 +0000")
Message-ID: <xmqq1sic72ku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Add return flag to format_ref_array_item, show_ref_array_item,
> get_ref_array_info and populate_value for further using.
> Need it to handle situations when item is broken but we can not invoke
> die() because we are in batch mode and all items need to be processed.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 21 +++++++++++++--------
>  ref-filter.h |  4 ++--
>  2 files changed, 15 insertions(+), 10 deletions(-)

Makes sense as a preparatory step to pass the return status
throughout the call chain.  The functions that actually will detect
issues should probably gain

	/*
	 * a comment before the function
	 * that documents what it does and what values it returns
	 * to signal the failure.
	 */

before them; those that only pass the errorcode through to the
caller do not necessarily have to, though.

> -void show_ref_array_item(struct ref_array_item *info,
> +int show_ref_array_item(struct ref_array_item *info,
>  			 const struct ref_format *format)
>  {
>  	struct strbuf final_buf = STRBUF_INIT;
> +	int retval = format_ref_array_item(info, format, &final_buf);
>  
> -	format_ref_array_item(info, format, &final_buf);
>  	fwrite(final_buf.buf, 1, final_buf.len, stdout);
>  	strbuf_release(&final_buf);
> -	putchar('\n');
> +	if (!retval)
> +		putchar('\n');
> +	return retval;

This is questionable.  Why does it write final_buf out regardless of
the return value, even though it refrains from writing terminating LF
upon non-zero return from the same function that prepared final_buf?

"Because final_buf is left unmodified when formatter returns an
error, and calling fwrite on an empty buffer ends up being a no-op"
is a wrong answer---it relies on having too intimate knowledge on
how the callee happens to work currently.
