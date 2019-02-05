Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9791F453
	for <e@80x24.org>; Tue,  5 Feb 2019 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfBEUWa (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 15:22:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43936 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfBEUW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 15:22:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so5101802wrv.10
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=j36lAedxNvvW0sb5aj+Q3FtXXxFl4vn21As3u9R0KMQ=;
        b=BvKT7NgxdKCyq7gBpB99eOzkuiL7+yVUE+N9saqqrC+xEahz1EpuNPg01XL/ZgNH56
         t9+5k7oV1RWgwixpFCTLxksjKj5PP7D+iPoumKDgFQgKx1lmRsym/IXLYKyeyggCrps4
         K6/KxqOLTuWGOrDEQGwRFUck4TM5/W0FEwTyQcY31LYAWq/fqrY5slGFHAjeTHreU8Gd
         RWg7nuf2dEKznXvxwq7HwbHv18l5kM2LRGqpcXM3VeaCktNnjqpEmLapTtdiPxu2fT9s
         PkOHxls2s+05KQlR2q3WMco1DZscBWaWqDfIqOJE0NnJJfgsJY8lmio+qYguYiSPfT+T
         p3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=j36lAedxNvvW0sb5aj+Q3FtXXxFl4vn21As3u9R0KMQ=;
        b=pxoshNVv/jTY16V3dQM5GBWR/59T+0NPxzuN6Ct6nk6hQj3Vslrvf2cZNK5JVwsqKw
         hxMGGIn/Mrzf5rZ9JIkZDqhy5QAIKowFOhzZqp8GyDFUOd8NXSwHB/laKcSslZTDGvby
         3HjMT/3FjyPbY5REDD3bPp8OwN4AlsopWzlzazRga+lkn6zxeyHwRnsdo4E2cM5moDc/
         V4bZ7ANo7fRW8I2h7rmiKxClGf4PI3p2zF5gDfg5XQp/sV4k0vr60f8G/m0FMe3PcDVS
         LcOFYSARSUuZPwn59S8/8zpkYol6AwSL5LACAMidoDZrK6y9pIU6sNKLukbuNFuCCyrQ
         ETqA==
X-Gm-Message-State: AHQUAubr8oKGur84h9+ajAQi7828OoXXICGg4B7+XsKbe4mdb1W3yOmT
        wFBcET4hTANP6yxKd90wQ2g=
X-Google-Smtp-Source: AHgI3IZp32L6WHwQet9DIZhb5Utx2YlYXqEJuhtW/dxDshrEz6sJisZsC8qCTwk+UZ0ujYMjuWK0gQ==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr5169080wrv.153.1549398147426;
        Tue, 05 Feb 2019 12:22:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z17sm15183733wrv.2.2019.02.05.12.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 12:22:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, William Hubbs <williamh@gentoo.org>,
        chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org>
        <20190205195212.25550-3-avarab@gmail.com>
Date:   Tue, 05 Feb 2019 12:22:24 -0800
In-Reply-To: <20190205195212.25550-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 5 Feb 2019 20:52:12 +0100")
Message-ID: <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +static int set_ident_internal(const char *var, const char *value,
> +			    struct strbuf *sb, const int flag)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	strbuf_reset(sb);
> +	strbuf_addstr(sb, value);
> +	author_ident_explicitly_given |= flag;
> +	ident_config_given |= flag;
> +	return 0;
> +}
> +
> +static int set_ident(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "author.name"))
> +		return set_ident_internal(var, value, &git_author_name,
> +					  IDENT_NAME_GIVEN);
> +	else if (!strcmp(var, "author.email"))
> +		return set_ident_internal(var, value, &git_author_email,
> +					  IDENT_MAIL_GIVEN);
> +	else if (!strcmp(var, "committer.name"))
> +		return set_ident_internal(var, value, &git_committer_name,
> +					  IDENT_NAME_GIVEN);
> +	else if (!strcmp(var, "committer.email"))
> +		return set_ident_internal(var, value, &git_committer_email,
> +					  IDENT_MAIL_GIVEN);
> +	else if (!strcmp(var, "user.name"))
> +		return set_ident_internal(var, value, &git_default_name,
> +					  IDENT_NAME_GIVEN);
> +	else if (!strcmp(var, "user.email"))
> +		return set_ident_internal(var, value, &git_default_email,
> +					  IDENT_MAIL_GIVEN);
> +	return 0;
> +}

In the v5 patch from William, author_ident_explicitly_given and
committer_ident_explicitly_given were set separately depending on
what variable was given (e.g. user.name marked both, author.name
marked only author but not committer_ident_explicitly_given).  In
the original before the addition of this feature with v6, giving
user.name would have set both, as we can see below.

Is this change intended?  

Or did you find that committer_ident_explicitly_given is no longer
useful and the variable is not used anymore?

>  int git_ident_config(const char *var, const char *value, void *data)
>  {
>  	if (!strcmp(var, "user.useconfigonly")) {
> @@ -480,29 +551,7 @@ int git_ident_config(const char *var, const char *value, void *data)
>  		return 0;
>  	}
>  
> -	if (!strcmp(var, "user.name")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		strbuf_reset(&git_default_name);
> -		strbuf_addstr(&git_default_name, value);
> -		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
> -		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> -		ident_config_given |= IDENT_NAME_GIVEN;
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "user.email")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		strbuf_reset(&git_default_email);
> -		strbuf_addstr(&git_default_email, value);
> -		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> -		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> -		ident_config_given |= IDENT_MAIL_GIVEN;
> -		return 0;
> -	}
> -
> -	return 0;
> +	return set_ident(var, value);
>  }
