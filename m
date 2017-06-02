Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07CE20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 02:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFBCXd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 22:23:33 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33930 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBCXc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 22:23:32 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so43119968pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SGBJqbpJiGXaymkeMfXcmE6hX8nGkyj69I45y8ijxuo=;
        b=oGgKm5t2QyWdzaCAMyg0z0El37NwqCa5l4L7cBaGw5OTzLV74vLCmRCwtFDoMpINvQ
         ajSoBUD5FTUxxA2H3ZgyUkULfk2h/b6Sbb+jP/Qr2Z0P0TBcS1jbyyL2FJZBOENzW8Gz
         9z3yOB+zFsfIL8uVJCkKsOPQ0TCWh4DWqLgSuqK3dlrWKVoatil82iaEQrpKhmGmDz9E
         MTGv19RIAgNcuVSrUAsimwHgKkUHl4HD/z9iI2f3jeznfK7KiUv917fZAfV6XhcuARVk
         1dAhPb3zDAadmmDKHTfmeAlFf2o2ItfVymWMYcOPr8ISu52XNDIj7SqYBMnomAFjAaMZ
         iM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SGBJqbpJiGXaymkeMfXcmE6hX8nGkyj69I45y8ijxuo=;
        b=QKLQ65c6A2Q8O+rlRkTXkoltIZWPwDjyVO6lSex+1rpJlcYNHbq/3lrQE9nYeKNznG
         AocYL++kU89KhBStAsj0KA03BmyyrEyGjF+XYEdoL5UkebHd2toYwbg2QefJDi4pYyPf
         pxgM0zcD7WrDzG1xsS2CowgCK74m7qONr51viTJQm6jycInD4Xe5I0TGCRUYQbc4jcpi
         UipKp+4PwtrVKtpiaTAwguHaLNjXn2evmEwiC3cDerK6uvZEo7j5P/NktIgVBSIkmlJ+
         yZSEiGf5d3GDnvMeuZwdz7+51LIqEoVC37TJkbvp3H9qHg51YfPcOMPTibtGLJSzGH4l
         4bVg==
X-Gm-Message-State: AODbwcCUsstNUK2rEVX0PpMLuivcqtTOGTtrYwPH84bTla05mWEYawVs
        bTyy4kffIyRuoA==
X-Received: by 10.84.197.3 with SMTP id m3mr66284582pld.40.1496370211742;
        Thu, 01 Jun 2017 19:23:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id 19sm31855193pfz.39.2017.06.01.19.23.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 19:23:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
        <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
        <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
        <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
Date:   Fri, 02 Jun 2017 11:23:30 +0900
In-Reply-To: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 28 May 2017 13:43:19 +0200")
Message-ID: <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 27.05.2017 um 23:46 schrieb Jeff King:
>> On Sat, May 27, 2017 at 06:57:08PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> 
>>> There's another test which breaks if we just s/gmtime/localtime/g. As
>>> far as I can tell to make the non-local case work we'd need to do a
>>> whole dance where we set the TZ variable to e.g. UTC$offset, then call
>>> strftime(), then call it again. Maybe there's some way to just specify
>>> the tz offset, but I didn't find any in a quick skimming of time.h.
>> 
>> There isn't.
> Right.  We could handle %z internally, though.  %Z would be harder (left
> as an exercise for readers..).
>
> First we'd have to undo 0a0416a3 (strbuf_expand: convert "%%" to "%"),
> though, in order to give full control back to strbuf_expand callbacks.
>
> 2-pack patch:

I think the list concensus is that handling %z ourselves like this
one does is the best we can do portably.

Anybody wants to wrap this up into a patch with log message?

Thanks.


>
> --- >8 ---
>  builtin/cat-file.c         |  5 +++++
>  convert.c                  |  1 +
>  daemon.c                   |  3 +++
>  date.c                     |  2 +-
>  ll-merge.c                 |  5 +++--
>  pretty.c                   |  3 +++
>  strbuf.c                   | 39 ++++++++++++++++++++++++++++++---------
>  strbuf.h                   | 11 +++++------
>  t/t6006-rev-list-format.sh | 12 ++++++++++++
>  9 files changed, 63 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1890d7a639..9cf2e4291d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -252,6 +252,11 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
>  {
>  	const char *end;
>  
> +	if (*start == '%') {
> +		strbuf_addch(sb, '%');
> +		return 1;
> +	}
> +
>  	if (*start != '(')
>  		return 0;
>  	end = strchr(start + 1, ')');
> diff --git a/convert.c b/convert.c
> index 8d652bf27c..8336fff694 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -399,6 +399,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
>  	struct strbuf path = STRBUF_INIT;
>  	struct strbuf_expand_dict_entry dict[] = {
>  		{ "f", NULL, },
> +		{ "%", "%" },
>  		{ NULL, NULL, },
>  	};
>  
> diff --git a/daemon.c b/daemon.c
> index ac7181a483..191fac2716 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -148,6 +148,9 @@ static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
>  	case 'D':
>  		strbuf_addstr(sb, context->directory);
>  		return 1;
> +	case '%':
> +		strbuf_addch(sb, '%');
> +		return 1;
>  	}
>  	return 0;
>  }
> diff --git a/date.c b/date.c
> index 63fa99685e..d16a88eea5 100644
> --- a/date.c
> +++ b/date.c
> @@ -246,7 +246,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>  			month_names[tm->tm_mon], tm->tm_year + 1900,
>  			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
>  	else if (mode->type == DATE_STRFTIME)
> -		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
> +		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz);
>  	else
>  		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
>  				weekday_names[tm->tm_wday],
> diff --git a/ll-merge.c b/ll-merge.c
> index ac0d4a5d78..e6202c7397 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -172,7 +172,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
>  {
>  	char temp[4][50];
>  	struct strbuf cmd = STRBUF_INIT;
> -	struct strbuf_expand_dict_entry dict[6];
> +	struct strbuf_expand_dict_entry dict[7];
>  	struct strbuf path_sq = STRBUF_INIT;
>  	const char *args[] = { NULL, NULL };
>  	int status, fd, i;
> @@ -185,7 +185,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
>  	dict[2].placeholder = "B"; dict[2].value = temp[2];
>  	dict[3].placeholder = "L"; dict[3].value = temp[3];
>  	dict[4].placeholder = "P"; dict[4].value = path_sq.buf;
> -	dict[5].placeholder = NULL; dict[5].value = NULL;
> +	dict[5].placeholder = "%"; dict[5].value = "%";
> +	dict[6].placeholder = NULL; dict[6].value = NULL;
>  
>  	if (fn->cmdline == NULL)
>  		die("custom merge driver %s lacks command line.", fn->name);
> diff --git a/pretty.c b/pretty.c
> index 587d48371b..56872bfa25 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1428,6 +1428,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
>  	} magic = NO_MAGIC;
>  
>  	switch (placeholder[0]) {
> +	case '%':
> +		strbuf_addch(sb, '%');
> +		return 1;
>  	case '-':
>  		magic = DEL_LF_BEFORE_EMPTY;
>  		break;
> diff --git a/strbuf.c b/strbuf.c
> index 00457940cf..206dff6037 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -309,12 +309,6 @@ void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
>  			break;
>  		format = percent + 1;
>  
> -		if (*format == '%') {
> -			strbuf_addch(sb, '%');
> -			format++;
> -			continue;
> -		}
> -
>  		consumed = fn(sb, format, context);
>  		if (consumed)
>  			format += consumed;
> @@ -785,7 +779,28 @@ char *xstrfmt(const char *fmt, ...)
>  	return ret;
>  }
>  
> -void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
> +struct date_format_context {
> +	int tz;
> +};
> +
> +static size_t expand_date_format(struct strbuf *sb, const char *placeholder,
> +				 void *ctx)
> +{
> +	struct date_format_context *c = ctx;
> +
> +	switch (placeholder[0]) {
> +	case '%':
> +		strbuf_addstr(sb, "%%");
> +		return 1;
> +	case 'z':
> +		strbuf_addf(sb, "%+05d", c->tz);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
> +		     int tz)
>  {
>  	size_t hint = 128;
>  	size_t len;
> @@ -794,7 +809,10 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
>  		return;
>  
>  	strbuf_grow(sb, hint);
> -	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
> +	if (strstr(fmt, "%z"))
> +		len = 0;
> +	else
> +		len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
>  
>  	if (!len) {
>  		/*
> @@ -805,7 +823,10 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
>  		 * character before returning.
>  		 */
>  		struct strbuf munged_fmt = STRBUF_INIT;
> -		strbuf_addf(&munged_fmt, "%s ", fmt);
> +		struct date_format_context ctx;
> +		ctx.tz = tz;
> +		strbuf_expand(&munged_fmt, fmt, expand_date_format, &ctx);
> +		strbuf_addch(&munged_fmt, ' ');
>  		while (!len) {
>  			hint *= 2;
>  			strbuf_grow(sb, hint);
> diff --git a/strbuf.h b/strbuf.h
> index 80047b1bb7..fc4c796a2b 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -281,10 +281,6 @@ extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
>   * the length of the placeholder recognized and `strbuf_expand()` skips
>   * over it.
>   *
> - * The format `%%` is automatically expanded to a single `%` as a quoting
> - * mechanism; callers do not need to handle the `%` placeholder themselves,
> - * and the callback function will not be invoked for this placeholder.
> - *
>   * All other characters (non-percent and not skipped ones) are copied
>   * verbatim to the strbuf.  If the callback returned zero, meaning that the
>   * placeholder is unknown, then the percent sign is copied, too.
> @@ -339,9 +335,12 @@ __attribute__((format (printf,2,0)))
>  extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
>  
>  /**
> - * Add the time specified by `tm`, as formatted by `strftime`.
> + * Add the time specified by `tm` and `tz`, as formatted by `strftime`.
> + * The time zone offset is specified like hhmm, so e.g. -600 means six
> + * hours west of Greenwich.
>   */
> -extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm);
> +extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
> +			    const struct tm *tm, int tz);
>  
>  /**
>   * Read a given size of data from a FILE* pointer to the buffer.
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index a1dcdb81d7..dc0bed8d90 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -483,4 +483,16 @@ test_expect_success 'unused %G placeholders are passed through' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'date format "%F %T %z" is the same as iso' '
> +	git log -1 --format="%ad" --date=iso >expect &&
> +	git log -1 --format="%ad" --date="format:%F %T %z" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'date format "%%z" expands to percent zed' '
> +	echo "%z" >expect &&
> +	git log -1 --format="%ad" --date="format:%%z" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
