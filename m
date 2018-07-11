Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2941F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeGKUkj (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 16:40:39 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36601 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeGKUkj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 16:40:39 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so51729990oie.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEbET8dYpoBtMsSSyLKJrLQu+a8lvmE/HvSQAvNaUJ8=;
        b=cjNchzJC69n8SXFJZ5v++QaTVsXvxZ329QHNel+DZ4NcxKgeTA7v0MJJK0KI2Iczjj
         PIVqh918L+uGRKFCgeycslLLce3HkYZ39QGXqmxVAY62xJm6xor49kexpq1jVyiLQh/y
         +I7Re5Ke8j6C0GVMUJoFSrljbAdgrBsdzInPqQwc9tRmKdX4Ie2+bcn54MTxCHwQC4nl
         Ay7A8ExykIY691sAFCHIh7osOYrCRbaIiHUMBQbJsPwWL2WmVpiNDEqArfiAGgYHlpm6
         lu2Ez5386uiww73vTGR5jQtR2TvQxOHqGKMMN9/IOAvBI3wxIIDLeb4YpM+lO9kjeKig
         MfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEbET8dYpoBtMsSSyLKJrLQu+a8lvmE/HvSQAvNaUJ8=;
        b=udLb5NyfSh8iYkMRHSDYPqb1X6mv22NHqbUGKtMDYlfYEofIo9QxrZBo2TqarsMp7x
         aEQMssVfYqaCIM1LAWeJIbC5iFlFJrQKOtmNqB7bmdyPtRp5UmDawulOtUlgxFv1hTZ3
         9inEYwJBAIM4QZnUd5V9GI8chSAgFIU/sDT1/rc9zehfn1oO+5kmgf2USQaEwiYFSTo0
         REnxkWxrUa5nN2N2vWMKd4ItqRH+tHTvk94JmMd9dcXyx7EYJJ3BEX5Vgxz9EfA99qTQ
         RSM1xwop7NsZ31JXBJ6vBXRBx/8oQ2tgQwT9YdXilSWXiWp96GvE+VMapyC3KRsWueo4
         pgAg==
X-Gm-Message-State: AOUpUlFWjxMPXScNbSR50IxDY3c7pvMbMS3VGrVPNyPRz/TFXM91L15R
        gO5s3h1vAwnvUUeR0chH6uimjwWIMGySoA0BhTbxvspY
X-Google-Smtp-Source: AAOMgpe+hWhobiM3vxKeZw82x/r8HtM5ZYCsMtCuq+27iI3xuLV/xd9hV64LQLMGxxP8vTjWFoTZ7OLcUT+3dFkktWI=
X-Received: by 2002:aca:5585:: with SMTP id j127-v6mr199830oib.202.1531341275926;
 Wed, 11 Jul 2018 13:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan> <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
In-Reply-To: <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Date:   Wed, 11 Jul 2018 22:34:19 +0200
Message-ID: <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
To:     torvalds@linux-foundation.org, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-07-08 00:02, Linus Torvalds wrote:
> diff --git a/date.c b/date.c
> index 49f943e25..4486c028a 100644
> --- a/date.c
> +++ b/date.c
> @@ -77,22 +77,16 @@ static struct tm *time_to_tm_local(timestamp_t time)
>  }
>
>  /*
> - * What value of "tz" was in effect back then at "time" in the
> - * local timezone?
> + * Fill in the localtime 'struct tm' for the supplied time,
> + * and return the local tz.
>   */
> -static int local_tzoffset(timestamp_t time)
> +static int local_time_tzoffset(time_t t, struct tm *tm)
>  {
> -     time_t t, t_local;
> -     struct tm tm;
> +     time_t t_local;
>       int offset, eastwest;
>
> -     if (date_overflows(time))
> -             die("Timestamp too large for this system: %"PRItime, time);
> -
> -     t = (time_t)time;
> -     localtime_r(&t, &tm);
> -     t_local = tm_to_time_t(&tm);
> -
> +     localtime_r(&t, tm);
> +     t_local = tm_to_time_t(tm);
>       if (t_local == -1)
>               return 0; /* error; just use +0000 */
>       if (t_local < t) {
> @@ -107,6 +101,20 @@ static int local_tzoffset(timestamp_t time)
>       return offset * eastwest;
>  }
>

[...]

> +
>  const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>  {
>       struct tm *tm;
> +     struct tm human_tm = { 0 };
> +     int human_tz = -1;

Is -1 an OK initial value for timezone if local_time_tzoffset returns
negative values as well? It looks like it doesn't matter for from functional

>       static struct strbuf timebuf = STRBUF_INIT;
>
>       if (mode->type == DATE_UNIX) {
> @@ -202,6 +281,15 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>               return timebuf.buf;
>       }
>
> +     if (mode->type == DATE_HUMAN) {
> +             struct timeval now;
> +
> +             gettimeofday(&now, NULL);
> +
> +             /* Fill in the data for "current time" in human_tz and human_tm */
> +             human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
> +     }
> +
>       if (mode->local)
>               tz = local_tzoffset(time);
>

--
Best regards, Andrei Rybak
