Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CA191F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfA2Xdk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:33:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35605 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2Xdj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:33:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so19818624wmt.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q7vSoAL3CBTOuXOSukkIJtwV2Py4LacnFbJNAZZLWDQ=;
        b=al8uzAm3FD2yfypAp8hdIKGvOEzkw5OwEog65nEtciF6Rv4csUtK5pYLN+FuJcwd5W
         nuwZRKhEeQ2XQc/4naSk3T+emaJxIEeEORrAZH97oWV01Z882dCZUt6KHlVy8/HO0PqP
         CcqUXPYVaPZ1ea825c1HGvrZGqMRFajLNn5GesEtgvvITZ4mM+4NayiqPQ0q6UWijYMc
         F2TYqSBfOUHxoPzC0PhKXpGuNgECI3sd+UBCDWERnp/whHTQtTNeBmT0Q/lslUq7synE
         l9vz4E+qK3f8CHrSu17/tDp6sXvYn4mQi8qxc2ao5CV3apt9QSjYCrYVeW1IsA9kWHdM
         8wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q7vSoAL3CBTOuXOSukkIJtwV2Py4LacnFbJNAZZLWDQ=;
        b=piVCc/LpjuygFRn8makNKFTccA5FKJx/WxM26/N7jHhq6Xge8BZq4PxWz9Y9BrCFB8
         iO3X80Kau9ez6QFHvq6oRQwEAQRLzwQFI9sVV35W8a3kBmPC+X2/4OzF6/hg+C0xuOu6
         FMYb0MPXgwh/sqBO6b8MaJ5sLLZNFz3Eg1L+GxktnaNLLSK/ywSiTCA3eZoQb0EBPb6g
         gTanHs3mEG/o2sNIUSyBbg51+pZMbf7/D0dFnt3YNox/E6HIYqugEtouWgEK3qsRgB8Y
         bpMIvMBLYwjkCeWNB1LcophX/4Vi3Ln9q6HmGMjpKat95bFKELusv2iLxi9UyRXSHYzT
         8EJA==
X-Gm-Message-State: AHQUAubYw0wXinbI0Rbe/ulU3iM955/hdGhGL4IXqQ9vXNAj0Hg37ZVK
        tQRClhHiEuu8G1PFwiS42Cw=
X-Google-Smtp-Source: AHgI3IaP8nz/VI2JCAj5nSBxhGPkWik+lL3/GtKwiqrpJ/SEdxSAYN+0S1nl6QSxLTxgejECsy0ELQ==
X-Received: by 2002:a1c:9806:: with SMTP id a6mr90347wme.114.1548804816719;
        Tue, 29 Jan 2019 15:33:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w6sm222299wme.46.2019.01.29.15.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:33:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v3 1/1] config: allow giving separate author and committer idents
References: <20190129230806.5295-1-williamh@gentoo.org>
        <20190129230806.5295-2-williamh@gentoo.org>
Date:   Tue, 29 Jan 2019 15:33:35 -0800
In-Reply-To: <20190129230806.5295-2-williamh@gentoo.org> (William Hubbs's
        message of "Tue, 29 Jan 2019 17:08:06 -0600")
Message-ID: <xmqqfttb599s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs <williamh@gentoo.org> writes:

> diff --git a/cache.h b/cache.h
> index 009e8b3b15..375be1f68b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1494,10 +1494,19 @@ int date_overflows(timestamp_t date);
>  #define IDENT_STRICT	       1
>  #define IDENT_NO_DATE	       2
>  #define IDENT_NO_NAME	       4
> +
> +enum want_ident {
> +	WANT_BLANK_IDENT,
> +	WANT_AUTHOR_IDENT,
> +	WANT_COMMITTER_IDENT,

I do not recall we crossed the bridge to allow trailing comma here
at the end of enum definition.

> +};


> +extern const char *fmt_ident(const char *name, const char *email,
> +		enum want_ident whose_ident,
> +		const char *date_str, int);
> +extern const char *fmt_name(enum want_ident);

Nice interface.

> diff --git a/config.c b/config.c
> index ff521eb27a..4bd5920dea 100644
> --- a/config.c
> +++ b/config.c
> @@ -1484,6 +1484,12 @@ int git_default_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (starts_with(var, "author."))
> +		return git_ident_config(var, value, cb);
> +
> +	if (starts_with(var, "committer."))
> +		return git_ident_config(var, value, cb);
> +

I'd rather see this done close to where "user." is already handled,
perhaps like

        -	if (starts_with(var, "user."))
        +	if (starts_with(var, "user.") ||
        +	    starts_with(var, "author.") ||
        +	    starts_with(var, "committer."))
                        return git_ident_config(...);

> -int git_ident_config(const char *var, const char *value, void *data)
> +static int set_ident(const char *var, const char *value)
>  {
> -	if (!strcmp(var, "user.useconfigonly")) {
> -		ident_use_config_only = git_config_bool(var, value);
> +	if (!strcmp(var, "author.name")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_author_name);
> +		strbuf_addstr(&git_author_name, value);
> +		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> +		ident_config_given |= IDENT_NAME_GIVEN;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "author.email")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_author_email);
> +		strbuf_addstr(&git_author_email, value);
> +		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> +		ident_config_given |= IDENT_MAIL_GIVEN;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "committer.name")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_committer_name);
> +		strbuf_addstr(&git_committer_name, value);
> +		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
> +		ident_config_given |= IDENT_NAME_GIVEN;
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "committer.email")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		strbuf_reset(&git_committer_email);
> +		strbuf_addstr(&git_committer_email, value);
> +		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> +		ident_config_given |= IDENT_MAIL_GIVEN;
>  		return 0;

So, when we see "committer.phone", git_default_config() would call
git_ident_config() which in turn would call this, and the unknown
variable is silently ignored, which is good.

> diff --git a/log-tree.c b/log-tree.c
> index 3cb14256ec..1e56df62a7 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -687,8 +687,7 @@ void show_log(struct rev_info *opt)
>  	 */
>  	if (ctx.need_8bit_cte >= 0 && opt->add_signoff)
>  		ctx.need_8bit_cte =
> -			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
> -					       getenv("GIT_COMMITTER_EMAIL")));
> +			has_non_ascii(fmt_name(WANT_COMMITTER_IDENT));

Very nice.
