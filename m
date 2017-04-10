Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABEF320970
	for <e@80x24.org>; Mon, 10 Apr 2017 11:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbdDJLfU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 07:35:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35941 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbdDJLfT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 07:35:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id i5so6060031pfc.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7q0fBg7x/K3PyZWUuya9oZ7PPl4BHfJSgJEjqt1UrPk=;
        b=q8pUVRV5Az1gyk33h0c4Pftu7xIKDcgD+rf8MKMP8fWV6r0WdbmNVgDNEdVHgiaqg4
         nXrWdryVmM84igTvZwvLHLkmF80PrOMNeSnMmrts1pBdJzeGk7joRgbND9/g7/uxt8wI
         Ay8INZ6BJAds5u90CgIRuf7dloow7pSF8JP03GH4g8xJboyrIAa+2M5tnwmOPuloFu+N
         WoAZ93FleH26er3/PL41GsF1jEzM1ZHo1318H5gkQ2AJ8B0LLC6hHfOPWDzHiVfo85l0
         PiExJ5q+MLZmhUOg69L68m1NGj3vve+zAwUgN2LqsSgrWm2tFICCdSDkhovqMHBau33k
         LAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7q0fBg7x/K3PyZWUuya9oZ7PPl4BHfJSgJEjqt1UrPk=;
        b=Yo/BngPqbnRNEKHMyU8h45n1ngfHmWBqLlqeZxpw0cvdKvGtF0PBDTUnsI2oWiaPTa
         MahQ0PSFx6IxOiYJO2M9IkBCjSAS2+dSFkyCUMbS0iLDzQ1nPnj/PjF4NTvr6mYG6IZG
         3MH9soJNq/4F4VJdJEYKDItdit/3Ul0sIL1uJkbf5iHPFDWVyDHz6A/4v9oRxwmSMInv
         gvKMaz7o8lzUYGoaDpZo3Rbn0vuM1qGbjHb79aboZMwgsWF7tyHwHlYt1/VowG3A1Jsu
         RAMEyqMLhjGzzP02ozy8M7o5JhAdphs8Twthi+yNUj0ns80qu/oEFCtaXg9q3ptdQNBg
         7jww==
X-Gm-Message-State: AFeK/H2gTMKQ57MPY8LwFIKyBAADYQWyiLbourFT5LQAUF9HtzI5Sf2XkVIcJy/2xR/hUQ==
X-Received: by 10.98.42.14 with SMTP id q14mr22746704pfq.229.1491824118074;
        Mon, 10 Apr 2017 04:35:18 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z21sm2548218pfk.95.2017.04.10.04.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 04:35:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 10 Apr 2017 18:35:13 +0700
Date:   Mon, 10 Apr 2017 18:35:13 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] WIP - Allow custom printf function for column
 printing
Message-ID: <20170410113513.GB23601@ash>
References: <20170330014238.30032-1-sbeller@google.com>
 <20170330014238.30032-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330014238.30032-4-sbeller@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 06:42:38PM -0700, Stefan Beller wrote:
> Ever wondered why column.ui applies the untracked files in git-status,
> but not for the help text comment in git-commit? Nobody wrote the code!

How do you decide text width for this help text? If the output is
terminal, we know how wide it is.

But editors are different animal. We might use terminal width for
text-based editors, but we won't even know if it's text or gui
based. Or should we just go with 72 columns? I don't think we even
enforce that anywhere now.

> diff --git a/wt-status.c b/wt-status.c
> index 308cf3779e..cfba352683 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -43,12 +43,13 @@ static const char *color(int slot, struct wt_status *s)
>  	return c;
>  }
>  
> -static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
> +static int status_vprintf(struct wt_status *s, int at_bol, const char *color,
>  		const char *fmt, va_list ap, const char *trail)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf linebuf = STRBUF_INIT;
>  	const char *line, *eol;
> +	int ret = 0;
>  
>  	strbuf_vaddf(&sb, fmt, ap);
>  	if (!sb.len) {
> @@ -59,9 +60,9 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
>  		}
>  		color_print_strbuf(s->fp, color, &sb);
>  		if (trail)
> -			fprintf(s->fp, "%s", trail);
> +			ret += fprintf(s->fp, "%s", trail);
>  		strbuf_release(&sb);
> -		return;
> +		return ret;
>  	}
>  	for (line = sb.buf; *line; line = eol + 1) {
>  		eol = strchr(line, '\n');
> @@ -78,15 +79,16 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
>  			strbuf_addstr(&linebuf, line);
>  		color_print_strbuf(s->fp, color, &linebuf);
>  		if (eol)
> -			fprintf(s->fp, "\n");
> +			ret += fprintf(s->fp, "\n");
>  		else
>  			break;
>  		at_bol = 1;
>  	}
>  	if (trail)
> -		fprintf(s->fp, "%s", trail);
> +		ret += fprintf(s->fp, "%s", trail);
>  	strbuf_release(&linebuf);
>  	strbuf_release(&sb);
> +	return ret;
>  }
>  
>  void status_printf_ln(struct wt_status *s, const char *color,
> @@ -834,6 +836,20 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
>  	strbuf_release(&summary);
>  }
>  
> +static struct wt_status *global_wt_status_hack;
> +static int column_status_printf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	struct wt_status *s = global_wt_status_hack;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = status_vprintf(s, 0, "", fmt, ap, NULL);
> +	va_end(ap);
> +
> +	return ret;
> +}
> +
>  static void wt_longstatus_print_other(struct wt_status *s,
>  				      struct string_list *l,
>  				      const char *what,
> @@ -856,6 +872,7 @@ static void wt_longstatus_print_other(struct wt_status *s,
>  		path = quote_path(it->string, s->prefix, &buf);
>  		if (column_active(s->colopts)) {
>  			string_list_append(&output, path);
> +			global_wt_status_hack = s;
>  			continue;
>  		}
>  		status_printf(s, color(WT_STATUS_HEADER, s), "\t");
> @@ -876,6 +893,8 @@ static void wt_longstatus_print_other(struct wt_status *s,
>  	copts.indent = buf.buf;
>  	if (want_color(s->use_color))
>  		copts.nl = GIT_COLOR_RESET "\n";
> +
> +	copts._printf = column_status_printf;

This is kinda ugly. I think status_vprintf() can handle multi-line
strings well. In that case maybe you just need to make
strbuf_print_columns() return a strbuf instead, then pass the entire
string to one status_vprintf() call.

There isn't need to abstract the printf() calls in column.c. Just
change it unconditionally to strbuf_addf() and print the whole thing
out to stdout in the end in print_coluns(), or pass the strbuf back
with strbuf_print_columns().

The small delay before printing the first line (because we know buffer
everything in strbuf first) won't be an issue because we already have
to queue all items for layout before we can print anything anyway.

>  	print_columns(&output, s->colopts, &copts);
>  	string_list_clear(&output, 0);
>  	strbuf_release(&buf);
> -- 
> 2.12.2.511.g2abb8caf66
> 
