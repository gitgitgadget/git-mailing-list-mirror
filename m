Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9756220985
	for <e@80x24.org>; Sun, 25 Sep 2016 11:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966033AbcIYL0s (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 07:26:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35388 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938708AbcIYL0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 07:26:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so9714380wmq.2
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Qc80ZFYgZSr8WY+0j6LFZAO8cWW2oGRzxRGUyM3Klbk=;
        b=0WyzkCoCmPxS1r35C9aanX+3RtIWnAm3iE9VdGHeoq2JNkm4COQOR5EZkqlioBpedU
         VQssYbRpN17TNwAlFFB1SHTlPjXFm0Y8anXVWvv3tzU4exbj5xbq61mgweqemrMe/nKk
         t4SeJdSK8yYPljivruncmS5IsKp1rWbiQfFhpqwC1IDn0mgSm1W0sC5aemvD3okGVjzW
         x+iwJcz1lXTl0Pr1/wkQ2S1vA/Zwxg8CHu65k6k9jndzD4S2HtpMBQQ6OvF8rXPmK2+0
         ddmJDxXznsQBWGlBfbzUlnxoRDfY+fciOXtk3nGtGvAu1HIPXeR1WXgLqs2GdRXSMDbC
         YHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Qc80ZFYgZSr8WY+0j6LFZAO8cWW2oGRzxRGUyM3Klbk=;
        b=UWMc8XmK6dbleoXYIgimpaXw+cYp3XrznxQMSuyYI5nkeMZp11oAwH3CR3+e5RRu9P
         yCwqhkYJu9O5uFBq7LyTDlFKfisrSkZ9XXlfmgjjD25g/e6gVk7KkgjrfC1blHlCWVxE
         9BnIBUOE2ygBxh0MvXxyhxRlR98oDolgBRpCGrKjswAmt3Nv/Fq91utsCyRh3C3a7LD2
         awC4v7EqbojDkQiAOaChhe0E8vpHu1kliHkO/m8G+f6yaKdXnhcdVawJozqBgKcUMVhG
         Kr4EmaTyf+STU4OItkmyRK8leuVi6pPoUYuqOirhxcrs5fgFnqF18tEHN1tQY252pM3b
         oIeQ==
X-Gm-Message-State: AA6/9Rl/2IC+XLaRChQE9+1ud22sGgYx25TrmzeGmtRWqwNUGQQJGdMd7TeeC/pPwgFLyg==
X-Received: by 10.28.132.82 with SMTP id g79mr9675989wmd.3.1474802805176;
        Sun, 25 Sep 2016 04:26:45 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id c5sm16630854wjw.29.2016.09.25.04.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 04:26:44 -0700 (PDT)
Subject: Re: [PATCH v8 06/11] pkt-line: add packet_write_gently()
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-7-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <55c5a86e-4055-f36d-bbf1-e8bae919088a@gmail.com>
Date:   Sun, 25 Sep 2016 13:26:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-7-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_write_fmt_gently() uses format_packet() which lets the caller
> only send string data via "%s". That means it cannot be used for
> arbitrary data that may contain NULs.
> 
> Add packet_write_gently() which writes arbitrary data and does not die
> in case of an error. The function is used by other pkt-line functions in
> a subsequent patch.

Nice; obviously needed for sending binary data.

I wonder how send-pack / receive-pack handles sending binary files.
Though this is outside of scope of this patch series, it is something
to think about for later.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 19f0271..fc0ac12 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -171,6 +171,22 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>  	return status;
>  }
>  
> +static int packet_write_gently(const int fd_out, const char *buf, size_t size)

I'm not sure what naming convention the rest of Git uses, but isn't
it more like '*data' rather than '*buf' here?

> +{
> +	static char packet_write_buffer[LARGE_PACKET_MAX];

I think there should be warning (as a comment before function
declaration, or before function definition), that packet_write_gently()
is not thread-safe (nor reentrant, but the latter does not matter here,
I think).

Thread-safe vs reentrant: http://stackoverflow.com/a/33445858/46058

This is not something terribly important; I guess git code has tons
of functions not marked as thread-unsafe...

> +
> +	if (size > sizeof(packet_write_buffer) - 4) {

First, wouldn't the following be more readable:

  +	if (size + 4 > LARGE_PACKET_MAX) {

> +		return error("packet write failed - data exceeds max packet size");
> +	}

Second, CodingGuidelines is against using braces (blocks) for one
line conditionals: "We avoid using braces unnecessarily."

But this is just me nitpicking.

> +	packet_trace(buf, size, 1);
> +	size += 4;
> +	set_packet_header(packet_write_buffer, size);
> +	memcpy(packet_write_buffer + 4, buf, size - 4);
> +	if (write_in_full(fd_out, packet_write_buffer, size) == size)

Hmmm... in some places we use original size, in others (original) size + 4;
perhaps it would be more readable to add a new local temporary variable

	size_t full_size = size + 4;

Or perhaps use 'data_size' and 'packet_size', where 'packet_size = data_size + 4'.
But that might be too chatty for variable names ;-)

> +		return 0;
> +	return error("packet write failed");
> +}

Compared to previous iterations, where there were two versions
of this function, IIRC sharing no common code: one taking buffer
which had to be with place for packet size info, one with a separate
local buffer for packet size only and using two writes.  This
version uses static buffer (thus not thread-safe, I think; and
not reentrant), and memcpy.

Anyway, if reentrant / thread-safe version would be required,
or not doing memcpy turns out to be important with respect to
performance, we can provide with the *_r version:

  static int packet_write_gently_r(const int fd_out, const char *data, size_t size,
                                   char *restrict buf)

We can check if 'buf + 4 == data', and if it is, we can skip
memcpy() as an optimization.

This is something for the future, but not very important for
having this patch series accepted.

> +
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>  	va_list args;
> 

Best,
-- 
Jakub Narębski

