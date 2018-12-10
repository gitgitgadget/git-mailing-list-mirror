Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E8E20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 08:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLJI4G (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 03:56:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34749 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeLJI4G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 03:56:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so9593910wrw.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 00:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2fmUQv4wZuBR4VkqPJRmStzBGYEmLcsRgiu/wy1VK1E=;
        b=fkG8XIc32475wdrRN6fp0B5h/+WaM8Ux9H7JMGg0VPcLA1o8tW/PrB7+PUox8lsj00
         zoaxDYSCJtvtHRTWQpfqcozq/MTTV3xUvUSCyn0ziegL2Vs/wR7enBtwoiEEWvk1oUNS
         /fnUZxv6mwNY2IYTaLwiR19B9dOKSUNgbGOOM4cqfMMZdupKI9gYQ47K0Ovva0hBAsLn
         sVXkfuGkiswBWyivTV5CnIpj7acUX/5iGpHeAovGGG3uaDvTeiilTqnhUjemb3q670pd
         16j+3rS/JGllso8VFw6iGfuTxzQIZgmt7AqYRh4S5cEQkLO2vKKnan4Ad9yM3n3+kAri
         aMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2fmUQv4wZuBR4VkqPJRmStzBGYEmLcsRgiu/wy1VK1E=;
        b=ddCl6akfbubuYiXbz2gviOam/EHoF2Ud4wPSEenCBUGyoLxmfHWVmRCgEFq5G/cMM0
         O7Xr3h3T4k7FZdB1ji+w/VPpTupOz05+mxaIE7IkPfiYyWeihZBB2zxuHMRwS+hiWgIe
         I3jyOwHYjGpk9vo0cX7bJvRIgJjRcQSMHSeCSv6+RUBu3ekQ0+OAu9zN6PVVKpE8vHlF
         VAMj3FUI02zJN8IUhwuQNKRSXn2ZMxyKPR7JZL5uh+QFEgkePlLq+OKqAyReNB663W8h
         6QOCnepS+Y00/W3HBOxVYnQz1Cv7KoJywRvNPvzoWgwsRNVD+6DaLliw0gY9vEbtNYzC
         VOhw==
X-Gm-Message-State: AA+aEWah5hGQvxie83VsUJnYhQnWGJ3OjWnEwSRe/usrTnXN/i59zKe8
        0pNGwJg/ROCTr0S09t9gQZCXVo9nM+8=
X-Google-Smtp-Source: AFSGD/VOXb7IKnBZedakUS6C3UqOfHB7x3G9ISpYze0UYJ0hb7mBO2VMrWBDtabTc73f6IfKlWyqow==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr8747171wrm.143.1544432162952;
        Mon, 10 Dec 2018 00:56:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j33sm22096512wre.91.2018.12.10.00.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 00:56:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v4 4/7] pretty: allow showing specific trailers
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181208163647.19538-1-anders@0x63.nu>
        <20181208163647.19538-5-anders@0x63.nu>
Date:   Mon, 10 Dec 2018 17:56:01 +0900
In-Reply-To: <20181208163647.19538-5-anders@0x63.nu> (Anders Waldenborg's
        message of "Sat, 8 Dec 2018 17:36:44 +0100")
Message-ID: <xmqqy38xiwv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> -static int match_placeholder_arg(const char *to_parse, const char *candidate,
> -				 const char **end)
> +static int match_placeholder_arg_value(const char *to_parse, const char *candidate,
> +				       const char **end, const char **valuestart, size_t *valuelen)
>  {
>  	const char *p;
>  
>  	if (!(skip_prefix(to_parse, candidate, &p)))
>  		return 0;
> +	if (valuestart) {
> +		if (*p != '=')
> +			return 0;
> +		*valuestart = p + 1;
> +		*valuelen = strcspn(*valuestart, ",)");
> +		p = *valuestart + *valuelen;
> +	}
>  	if (*p == ',') {
>  		*end = p + 1;
>  		return 1;
> @@ -1074,6 +1081,12 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
>  	return 0;
>  }
>  
> +static int match_placeholder_arg(const char *to_parse, const char *candidate,
> +				 const char **end)
> +{
> +	return match_placeholder_arg_value(to_parse, candidate, end, NULL, NULL);
> +}
> +

OK.  The unified parsing of boolean value I mentioned on an earlier
step can naturally be done using martch_placeholder_arg_value(), I
think, in match_placeholder_bool_arg().

> +static int format_trailer_match_cb(const struct strbuf *key, void *ud)
> +{
> +	const struct string_list *list = ud;
> +	const struct string_list_item *item;
> +
> +	for_each_string_list_item (item, list) {
> +		if (key->len == (uintptr_t)item->util &&
> +		    !strncasecmp (item->string, key->buf, key->len))

Remove SP after strncasecmp.

We won't have too many elements in this string list, so O(N*M)
search like this one would be OK.

> +			return 1;
> +	}
>  	return 0;
>  }
>  
> @@ -1337,6 +1362,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  
>  	if (skip_prefix(placeholder, "(trailers", &arg)) {
>  		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +		struct string_list filter_list = STRING_LIST_INIT_NODUP;
>  		size_t ret = 0;
>  
>  		opts.no_divider = 1;
> @@ -1344,8 +1370,20 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  		if (*arg == ':') {
>  			arg++;
>  			for (;;) {
> -				if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
> -				    !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold))
> +				const char *argval;
> +				size_t arglen;
> +
> +				if (match_placeholder_arg_value(arg, "key", &arg, &argval, &arglen)) {
> +					uintptr_t len = arglen;
> +					if (len && argval[len - 1] == ':')
> +						len--;
> +					string_list_append(&filter_list, argval)->util = (char *)len;
> +
> +					opts.filter = format_trailer_match_cb;
> +					opts.filter_data = &filter_list;
> +					opts.only_trailers = 1;
> +				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
> +					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold))
>  					break;
>  			}
>  		}
> @@ -1353,6 +1391,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
>  			ret = arg - placeholder + 1;
>  		}
> +		string_list_clear (&filter_list, 0);

Remove SP after string_list_clear.

>  		return ret;
>  	}
>  
