Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CE91F453
	for <e@80x24.org>; Mon,  4 Feb 2019 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfBDKyW (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 05:54:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:55043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732921AbfBDKyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 05:54:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0cs6-1h7rWh0xKA-00up0b; Mon, 04
 Feb 2019 11:54:17 +0100
Date:   Mon, 4 Feb 2019 11:54:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
In-Reply-To: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1902041138550.41@tvgsbejvaqbjf.bet>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xkZ7NI2kZwnN9gnJPZx6LzmClfhsUO06IwKXzELgJaC7jHNj4Wc
 Rs+r4l9tRdZiQOCaudWgNB2ihObjqjdQP25UJ+xNv+bzhwugvO0Hei/PU0JafV+3wzcSDpH
 7+Mq6Bivg4iyzA/IKNTE81MkAqag7VTwvsvGgpxPWj7nguLP9sJQAVEG3YVWKSj9ZKbxr/F
 G79IRWe3cT/xTgKd25Y6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0wLxCJu0Ac8=:e8S5hfslw9t8d2UvkAy32a
 yhxhH07IXKZn8QHgwpAcoeocPE3DTAkupfWBC8MQOC5DT1WDP4+JMHd896T11xDCpvvtRkuF7
 tzysDJmkrtBkd/rZHOA9XG0E/S7/rAM0uReRNj+3nibCINSZkkSt7SkV6BHsbL+92YN8skXi3
 3C9e+6XBjzc/L2zXnWPpZf0MFdrrtEqOyE5qlyiNqcnrMl1c3UYPbfXuvpvBYTH2guBB0ziL3
 6N1CNxh2syFfkN7ydK0F7ZEz/EbhRvk6uOnW8Ro/DDkgexkOfo7NicoGZEhR8Ys8C+knKQ3ei
 9p+Y5RfObZPUhw9rf2VJF/bD6NpDVC2VzKXi67NVoIfPvvwoZ9Qh9oDbxTgOkg3htaEBT7sMM
 aD/4Y7dwAuIoZnxC6eLTUOU5amMQ56/Tv9QkT5EL3lube9IIRKbBBA5F1WAoqqNqoTHh22K/c
 c1INFPjSZEiU2jBmLnt//1nhcUMtby9m9aGpo6c7Wwq5YDMy99Xz5nvTgThC9hHcTf+4mwSD3
 3erV0fKwYqxp4ohk/XC2T4WONbWdEQz8LX7KfkaBa/06qrEGD5H5G1TZ9XhXIX/PhSRajyxLR
 A2nOEBMr7UjvMkRPb9d+VY/NMBuZKaMsuF2yYogT2QJ4pY/WSQlflgvti6sQ7m/bueTGkrTxD
 qmHpsgVNHacUjYXZssSo6Fpeht9x9NXR8u2dNXsTrg44y8R1iwFfEK7tM+R5Xv8C2ukrrUECN
 IGA++Wf4OLWgFshNiX/xnN0Yaw+bxye7bcCJtpiGEtAw/APVfRETJU0UTzHwgeXgTpAs04MO9
 Ds4O3OYBF9FmhTiJSGVdixd6gMZCJd1OoEeDn7yYar6I48FBtpboE2du70+xt1tab4J6BSKV/
 Epr3RB0ze8D+MqBsa1Bx6K5fTsvinQ8jGKXvDqZjk1JUHVpaiidVk/+afsmT23LZaOG+JlOTq
 11EBjM/T3BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sun, 3 Feb 2019, Johannes Sixt wrote:

> strbuf_vinsertf inserts a formatted string in the middle of an existing
> strbuf value. It makes room in the strbuf by moving existing string to
> the back, then formats the string to insert directly into the hole.
> 
> It uses vsnprintf to format the string. The buffer size provided in the
> invocation is the number of characters available in the allocated space
> behind the final string. This does not make any sense at all.
> 
> Fix it to pass the length of the inserted string plus one for the NUL.
> (The functions saves and restores the character that the NUL occupies.)
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I found this, because in my environment I have to compile with
>  SNPRINTF_RETURNS_BOGUS. Our implementation of vsnprintf in
>  compat/snprintf.c writes into the end of the buffer unconditionally,
>  at a spot that is unrelated to the formatted string, and this leads to
>  "BUG: a NUL byte in commit log message not allowed" in some "stash"
>  tests.
> 
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/strbuf.c b/strbuf.c
> index bfbbdadbf3..87ecf7f975 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -270,7 +270,7 @@ void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
>  	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
>  	/* vsnprintf() will append a NUL, overwriting one of our characters */
>  	save = sb->buf[pos + len];
> -	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
> +	len2 = vsnprintf(sb->buf + pos, len + 1, fmt, ap);

It is really unfortunate that we use a non-dynamic code review system
where it is pretty impossible to increase the amount of context lines
easily.

And in this instance, a single line before the shown context would
suffice:

	strbuf_grow(sb, len);

Which is in line with moving from `pos` to `pos + len`, and it is also in
line with saving the byte at `pos + len`. And since we must consider that
byte as part of the buffer, and since `vsnprintf()` wants that size of the
buffer (including trailing NUL), `len + 1` is correct.

And since `strbuf_grow(sb, len)` would not in general grow the buffer by
exactly `len` bytes, you indeed fixed a bug.

For historical context, when I first implemented `strbuf_vinsertf()`, I
first grew the buffer, then let `vsnprintf()` write to the end, and then
would rotate the bytes into their correct location. This required the
implementation of an in-place rotation scheme, which was a lot of fun, and
totally unnecessary. That `sb->alloc - sb->len` parameter you fixed was a
remainder of that fun side project.

Thanks for fixing it,
Dscho

P.S.: Side note: I just realized that we could also write

	save = sb->buf[pos];
  	memmove(sb->buf + pos + len + 1, sb->buf + pos + 1, sb->len - pos - 1);

instead, i.e. not move the first byte just to have it overwritten by
vsnprintf() immediately, saving on moving one byte. But quite frankly, in
this case I do agree that readability is more important than trying to
squeeze out the last bit of performance.

>  	sb->buf[pos + len] = save;
>  	if (len2 != len)
>  		BUG("your vsnprintf is broken (returns inconsistent lengths)");
> -- 
> 2.20.1.86.gb0de946387
> 
