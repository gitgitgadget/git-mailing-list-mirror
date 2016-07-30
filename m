Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C9C1F858
	for <e@80x24.org>; Sat, 30 Jul 2016 10:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbcG3Kbm (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 06:31:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36375 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbcG3KaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 06:30:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so18980368wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 03:30:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Z9Fm21poYFE5joRNGLj5jFTBILby00ABFaHaMOgiNUk=;
        b=P6J1E4mwbrMA+DL4FJ8GIuGBoiwqYpqEeFtgPqKr4exg9KTt0+ZzRx89s/U2NbHOqj
         PL47fxLHrWuE4MZ1uzuWTkuQ3/UT3WsJHS8sC3qPiWJbqvXTodzAPs5CZVZ7nSykglyq
         ClomsfwDI3ty0qy0Z+5Jyuyek/qpKDKIs/9prpVtXw1P6ic0tYO0egv1Gu08nSSvpZEK
         Jw4E3gykbqMOPl43QBkAoJtBQSFwyC5dDkC5dp4jUwlVd+jd8zXp21bk99xh2y6oowQx
         PjbcuqWK5ikwpCr7aKJKH8Z5lBas/4WW6FD5Va4siud8wf+D1bobyf4iuhFgb1ZZbC0a
         pyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Z9Fm21poYFE5joRNGLj5jFTBILby00ABFaHaMOgiNUk=;
        b=WA53npC+rvTr369LYxCs5QpVXwgqD39F0c6qtmDAzC8rnNSCAbbH51ZxkoLpF4htcs
         c+UsYdtLm2M8xDjWNJL/RYVee6LZqQtMJSZcAtOYVb8iC8MBajNY8CBpq4/ggbNxSWe9
         lf8fSewyUpiTW+p0j184vN6oqZqF5EPS/Krn7rSytOo1d/RAKp4H+75+a5dfiyEoVpEP
         v6sOelnFaoiqO5nVPqSayvmS9FJ4mt1gbDUDEoNzhEgYlmS9AejMIQWRhH8Fw6Q41xNj
         uEDD005LK7K4KqBi2vYuRHKlAkTc+56iuX7rBn0Pl38jbyj6cBF8+85txDFHEM+H1C12
         c6pg==
X-Gm-Message-State: AEkoout7Qc9HC3UC4XT0QG/i2PUp1BgsEdb+XF23ECMO5wNnyO6snVopMasOZ9CyKbrqNA==
X-Received: by 10.28.203.143 with SMTP id b137mr23324182wmg.96.1469874621118;
        Sat, 30 Jul 2016 03:30:21 -0700 (PDT)
Received: from [192.168.1.26] (ddi132.neoplus.adsl.tpnet.pl. [83.23.86.132])
        by smtp.googlemail.com with ESMTPSA id o142sm7138951wme.20.2016.07.30.03.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 03:30:19 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] pkt-line: extract set_packet_header()
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-2-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4081bc44-d964-79ec-165f-f49f33823c17@gmail.com>
Date:	Sat, 30 Jul 2016 12:30:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-2-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> set_packet_header() converts an integer to a 4 byte hex string. Make
> this function locally available so that other pkt-line functions can
> use it.

This description is not that clear that set_packet_header() is a new
function.  Perhaps something like the following

  Extract the part of format_packet() that converts an integer to a 4 byte
  hex string into set_packet_header().  Make this new function ...

I also wonder if the part "Make this [new] function locally available..."
is needed; we need to justify exports, but I think we don't need to
justify limiting it to a module.  If you want to justify that it is
"static", perhaps it would be better to say why not to export it.

Anyway, I think it is worthy refactoring (and compiler should be
able to inline it, so there are no nano-performance considerations).

Good work!

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 62fdb37..445b8e1 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -98,9 +98,17 @@ void packet_buf_flush(struct strbuf *buf)
>  }
>  
>  #define hex(a) (hexchar[(a) & 15])

I guess that this is inherited from the original, but this preprocessor
macro is local to the format_header() / set_packet_header() function,
and would not work outside it.  Therefore I think we should #undef it
after set_packet_header(), just in case somebody mistakes it for
a generic hex() function.  Perhaps even put it inside set_packet_header(),
together with #undef.

But I might be mistaken... let's check... no, it isn't used outside it.

> -static void format_packet(struct strbuf *out, const char *fmt, va_list args)
> +static void set_packet_header(char *buf, const int size)
>  {
>  	static char hexchar[] = "0123456789abcdef";
> +	buf[0] = hex(size >> 12);
> +	buf[1] = hex(size >> 8);
> +	buf[2] = hex(size >> 4);
> +	buf[3] = hex(size);
> +}
> +
> +static void format_packet(struct strbuf *out, const char *fmt, va_list args)

It is strange how 'git diff' chosen to represent this patch...

> +{
>  	size_t orig_len, n;
>  
>  	orig_len = out->len;
> @@ -111,10 +119,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
>  	if (n > LARGE_PACKET_MAX)
>  		die("protocol error: impossibly long line");
>  
> -	out->buf[orig_len + 0] = hex(n >> 12);
> -	out->buf[orig_len + 1] = hex(n >> 8);
> -	out->buf[orig_len + 2] = hex(n >> 4);
> -	out->buf[orig_len + 3] = hex(n);
> +	set_packet_header(&out->buf[orig_len], n);
>  	packet_trace(out->buf + orig_len + 4, n - 4, 1);
>  }
>  
> 

