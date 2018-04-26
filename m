Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0CE1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 05:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDZFc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 01:32:57 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45951 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeDZFc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 01:32:56 -0400
Received: by mail-wr0-f182.google.com with SMTP id p5-v6so27611740wre.12
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VmzOjFfbNrDD0t4suCHG5QWd6LNwrpfaUOUIPc2j6jI=;
        b=bUhOae/dcQqey6R0txNBIZaPehScWzh/ncZAoprvF6JGCzfnC4ibeLTp5+XXXNgpiE
         /ohOViJe09KdNrxCrEAvMvx1NMrpLf9dsTssQVkO0GkQFhfk1BG/T4N4GeXCULACBnPS
         DVqpqioAa3K28acPdcOfWMXHWtEtSYNu6BnL6UoLC764uIdK6CPM87w1AN4tgCpryK5W
         ramypRbWBpxdtUzkLVFDnXeZBJeyjkjKYCX88/ZiJVcXRv6fqy4srkgHua6jGmObkw0V
         pf/voyU3Ezncmk+zgzvbrFaBxXC0U2PcXJBE42aTeDGU/HVQD2edMZjGNojus5d/a8zC
         hyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VmzOjFfbNrDD0t4suCHG5QWd6LNwrpfaUOUIPc2j6jI=;
        b=mK5pOF+Os/d0a9ynbLP4ZfWPa8FeQmzWx8+0hJWeH73J263J6aZqYBeurBfEJwmN7A
         Ps3stz0+2gGjueCmQlIkqtCk1xLNXa7rtCEvQ/nUHtp00EcbaxhbXUTFBIY7XeNiAfVr
         PbEvwUE+y43RxGVdX2YNzenad5dxV5wCf0AliO6dj7Bzr68SHtwQkbuarZuvQv+BY3ZB
         /fkdOwIMPl4jPxhT8c5IQfdtpJeGBYaaF1RJVCccMQDPYIOw5i9Yj7WFP3kDcrBGqx7o
         IMJ3kBOPCkXca8Hn2I98vp788vpDkUpfG7itujyZ48MB/lY9VLPGSe76e22iRGH9DXnv
         ugjw==
X-Gm-Message-State: ALQs6tCpXh1gEjgJYhWSOCw0DsGraNx8HOjs3SBjqvG7b4uJiKcq3bIe
        Xe9tm1hOpAdrHhOSYg2+5tQ=
X-Google-Smtp-Source: AIpwx49pW/xfkkcHJtHENVYzKhh66o7H4zK3u+nIWXIf/LpbEf2mnvex4n76k2DUX/TOS0vDH54TqQ==
X-Received: by 2002:adf:db0b:: with SMTP id s11-v6mr18857964wri.241.1524720775265;
        Wed, 25 Apr 2018 22:32:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m83sm15444539wma.17.2018.04.25.22.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 22:32:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] builtin/config: introduce `color` type specifier
References: <cover.1524716420.git.me@ttaylorr.com>
        <17188b9f3250e4d3547f81b4aaf70a209941b1b5.1524716420.git.me@ttaylorr.com>
Date:   Thu, 26 Apr 2018 14:32:54 +0900
In-Reply-To: <17188b9f3250e4d3547f81b4aaf70a209941b1b5.1524716420.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 25 Apr 2018 21:25:29 -0700")
Message-ID: <xmqq36zi352x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/builtin/config.c b/builtin/config.c
> index d7acf912cd..ec5c11293b 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -61,6 +61,7 @@ static int show_origin;
>  #define TYPE_BOOL_OR_INT	3
>  #define TYPE_PATH		4
>  #define TYPE_EXPIRY_DATE	5
> +#define TYPE_COLOR		6
>  
>  #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
>  	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
> @@ -231,6 +232,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
>  			if (git_config_expiry_date(&t, key_, value_) < 0)
>  				return -1;
>  			strbuf_addf(buf, "%"PRItime, t);
> +		} else if (type == TYPE_COLOR) {
> +			char v[COLOR_MAXLEN];
> +			if (git_config_color(v, key_, value_) < 0)
> +				return -1;
> +			strbuf_addstr(buf, v);
>  		} else if (value_) {
>  			strbuf_addstr(buf, value_);
>  		} else {
> @@ -376,6 +382,20 @@ static char *normalize_value(const char *key, const char *value)
>  		else
>  			return xstrdup(v ? "true" : "false");
>  	}
> +	if (type == TYPE_COLOR) {
> +		char v[COLOR_MAXLEN];
> +		if (git_config_color(v, key, value))
> +			die("cannot parse color '%s'", value);
> +
> +		/*
> +		 * The contents of `v` now contain an ANSI escape
> +		 * sequence, not suitable for including within a
> +		 * configuration file. Treat the above as a
> +		 * "sanity-check", and return the given value, which we
> +		 * know is representable as valid color code.
> +		 */
> +		return xstrdup(value);
> +	}
>  
>  	die("BUG: cannot normalize type %d", type);
>  }

Hmmm, option_parse_type() introduced in [PATCH 2/5] used to learn
to parse "color" in this step, but it no longer does.  

Here is the difference between what has been queued and the result
of applying these latest patches I found.

diff --git a/builtin/config.c b/builtin/config.c
index 69e7270356..ec5c11293b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -72,7 +72,8 @@ static struct option builtin_config_options[];
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
-	int new_type, *to_type;
+	int new_type;
+	int *to_type;
 
 	if (unset) {
 		*((int *) opt->value) = 0;
@@ -95,13 +96,11 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			new_type = TYPE_PATH;
 		else if (!strcmp(arg, "expiry-date"))
 			new_type = TYPE_EXPIRY_DATE;
-		else if (!strcmp(arg, "color"))
-			new_type = TYPE_COLOR;
 		else
 			die(_("unrecognized --type argument, %s"), arg);
 	}
 
-	to_type = opt->value;
+	*to_type = opt->value;
 	if (*to_type && *to_type != new_type) {
 		/*
 		 * Complain when there is a new type not equal to the old type.
