Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00CE1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 19:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfARTDo (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 14:03:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfARTDo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 14:03:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so5458306wmf.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X+u0H+AndVMxjWTiO9hNgx4PBEJruOZZlDuyDGUuo/0=;
        b=pshCjIDydfdUVwwG9z9QpMrzxc9Zb7JiSIGMphcRHmiucIF4/Jo4F+84QN7gpO0m/l
         iYxYhlP4YX4/HxXii4P+9CMvhtpdvMhpTsfMAZWOiXa8rJaLaTe8uyZEXCicZiHGv6VH
         r8FmYJXZuBJo3BRgrUUIhsDpdY80t74UAB4MNs4nnw92N3htP7KAryMHF4lcv724NIg9
         fz0AMCa8Qm/Anqi0OIlsFeC4qdDRzwquxVJxGCpR+hCWfLc0GKGjCZfwGMIclpY4w8py
         4oXt5iZgP5zY7nayIxvic21l8ELl6n2WbIdLWEbGDWBoP0uF+yx/WaeLJbiNN4526ZQO
         ZCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X+u0H+AndVMxjWTiO9hNgx4PBEJruOZZlDuyDGUuo/0=;
        b=EcL0HolkmG4c14wQraBh4fp2c5bglMOEIhYD/pP/lEIHvuXQk2VX8BcVSBJdIuiOQL
         InB/AzJf/4A9lWZFeaWWfsMHV8wmTna3NwG0ynsGWAaoLtaMIiJsN03w4W0E1B3JK24i
         gbbMgmVcyuFv26Qr7IBM7D8tzTIwDee/dQ5OD2DMVQEiZDtJRahzx4VBOT6OXYIM0crG
         SzuIEm/a7/ahh1ucnfIGd1y4PWkB5YYkvH958uJKONnJc2vK8zhFcvre8Ov8VeQfBt87
         nXxW3n2jvcgX+j+filocGWrJqOxR88PSTjQ6HxQpYN783T72cF5mxgF2Ayd6sDoT0lyT
         zA/g==
X-Gm-Message-State: AJcUukddDCaEOcwBJ8rrwsyBuTt0akyFFXXYckYSFibO8/KSSr4tdoxp
        aVb9JRUXlirxH9pbdzgD6p4=
X-Google-Smtp-Source: ALg8bN5bF/SYujG+sGm5sy5gZAozzosx6R1xFr28yq1xIx+FCXmub5EJGNTeyS5CYnO7h8IbiT+HNA==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr16710788wme.135.1547838221569;
        Fri, 18 Jan 2019 11:03:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j33sm131437654wre.91.2019.01.18.11.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:03:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/5] Add `human` format to test-tool
References: <20181231003150.8031-1-ischis2@cox.net>
        <20190118061805.19086-1-ischis2@cox.net>
        <20190118061805.19086-5-ischis2@cox.net>
Date:   Fri, 18 Jan 2019 11:03:40 -0800
In-Reply-To: <20190118061805.19086-5-ischis2@cox.net> (Stephen P. Smith's
        message of "Thu, 17 Jan 2019 23:18:04 -0700")
Message-ID: <xmqqtvi5kctv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> Add the human format support to the test tool so that TEST_DATE_NOW
> can be used to specify the current time.
>
> A static variable is used for passing the tool specified value to
> get_date.  The get_date helper function eliminates the need to
> refactor up the show_date and show_date normal functions to pass the
> time value.

Hmph.  An interesting approach, but the implementation is a bit too
messy.

> diff --git a/date.c b/date.c
> index 43c3a84e25..24435b1e1d 100644
> --- a/date.c
> +++ b/date.c
> @@ -115,6 +115,28 @@ static int local_tzoffset(timestamp_t time)
>  	return local_time_tzoffset((time_t)time, &tm);
>  }
>  
> +const struct timeval *test_time = 0;

Shouldn't this be file-scope static?

Let BSS take care of initializing a variable to 0/NULL; drop " = 0"
at the end.

> +void show_date_human(timestamp_t time, int tz,
> +			       const struct timeval *now,
> +			       struct strbuf *timebuf)
> +{
> +	test_time = (const struct timeval *) now;
> +	strbuf_addstr( timebuf, show_date(time, tz, DATE_MODE(HUMAN)));

Style:
	strbuf_addstr(timebuf, show_date(time, tz, DATE_MODE(HUMAN)));

> +	test_time = (const struct timeval *) 0;
> +}

It is a shame that you introduced a nicely reusable get_time()
mechanism to let external callers of show_date() specify what time
to format, instead of the returned timestamp of gettimeofday(),
but limited its usefulness to only testing "human" format output.
If somebody wants to extend "test-tool date" for other formats, they
also have to add a similar "show_date_XXX" hack for their format.

How about doing it slightly differently?  E.g.

 - Get rid of show_date_human().

 - Keep get_time(), but have it pay attention to GIT_TEST_TIMESTAMP
   environment variable, and when it is set, use that as if it is
   the returned value from gettimeofday().

 - If there are gettimeofday() calls in date.c this patch did not
   touch (because they were not part of the "human-format"
   codepath), adjust them to use get_time() instead.

 - Have "test-tool date" excersize show_date() directly. 



> +static void get_time(struct timeval *now)
> +{
> +	if(test_time != 0)
> +		/*
> +		 * If show_date was called via the test
> +		 *  interface use the test_tool time
> +		 */
> +		*now = *test_time;
> +	else
> +		gettimeofday(now, NULL);
> +}
> +
>  void show_date_relative(timestamp_t time, int tz,
>  			       const struct timeval *now,
>  			       struct strbuf *timebuf)
> @@ -228,7 +250,7 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
>  	/* Show "today" times as just relative times */
>  	if (hide.wday) {
>  		struct timeval now;
> -		gettimeofday(&now, NULL);
> +		get_time(&now);
>  		show_date_relative(time, tz, &now, buf);
>  		return;
>  	}
> @@ -284,7 +306,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>  	if (mode->type == DATE_HUMAN) {
>  		struct timeval now;
>  
> -		gettimeofday(&now, NULL);
> +		get_time(&now);
>  
>  		/* Fill in the data for "current time" in human_tz and human_tm */
>  		human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
> diff --git a/t/helper/test-date.c b/t/helper/test-date.c
> index a0837371ab..22d42a2174 100644
> --- a/t/helper/test-date.c
> +++ b/t/helper/test-date.c
> @@ -3,6 +3,7 @@
>  
>  static const char *usage_msg = "\n"
>  "  test-tool date relative [time_t]...\n"
> +"  test-tool date human [time_t]...\n"
>  "  test-tool date show:<format> [time_t]...\n"
>  "  test-tool date parse [date]...\n"
>  "  test-tool date approxidate [date]...\n"
> @@ -22,6 +23,18 @@ static void show_relative_dates(const char **argv, struct timeval *now)
>  	strbuf_release(&buf);
>  }
>  
> +static void show_human_dates(const char **argv, struct timeval *now)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	for (; *argv; argv++) {
> +		time_t t = atoi(*argv);
> +		show_date_human(t, 0, now, &buf);
> +		printf("%s -> %s\n", *argv, buf.buf);
> +	}
> +	strbuf_release(&buf);
> +}
> +
>  static void show_dates(const char **argv, const char *format)
>  {
>  	struct date_mode mode;
> @@ -100,6 +113,8 @@ int cmd__date(int argc, const char **argv)
>  		usage(usage_msg);
>  	if (!strcmp(*argv, "relative"))
>  		show_relative_dates(argv+1, &now);
> +	else if (!strcmp(*argv, "human"))
> +		show_human_dates(argv+1, &now);
>  	else if (skip_prefix(*argv, "show:", &x))
>  		show_dates(argv+1, x);
>  	else if (!strcmp(*argv, "parse"))
