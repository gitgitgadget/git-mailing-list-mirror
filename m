Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD719379C58
	for <git@vger.kernel.org>; Thu, 14 May 2026 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794432; cv=none; b=AX/QTr9okZS5YQ0uHX4uL+AKb0GQUesSjA8UdRv22lnh6CoukDRnOrLZMc+7HGUFX60kubYTxUsN0DK9Iqlw9uKRStgA+YUzrZ8HmR48FJ8QJhHTIZtXWNKH/hIvVsKhAZVqTkRU/6OEfqhWht3P5Y78T9pXpUkUOQIaCAlQgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794432; c=relaxed/simple;
	bh=jTJQswBaZTj+MIP2at2xFWb/5Z7lfFwxEtBDxR2y1VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgysGS2GHvbvHDe3EZaIPGaIpyFdQpitPfWZYT0CuzJhO/52uTvVFVpJ3MtRMFrv+y8L+S0RYAQWkHh+Dy1rFQpdLXKDOWLSKdFKSofKlSz1/mXdPAolD8+GgGJOX2d3dEvfVZXkI6vWkIPADAUh2Jr7ucgxtmdWHm9bGXH0oh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Zk0sJt11; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Zk0sJt11"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id NddewX09Y9QrZNddfwWRBA; Thu, 14 May 2026 22:30:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1778794239; bh=YaYmhM5hAlvtEEF2ZLCzEr7y59MtVWdJWpdcT1Q8Es0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zk0sJt11zi0HgtcuG2W33nZUBZ1k6KY2gAAzK7ceM61fYic/JY/NVsjztAZ9TmR1v
	 lFjuJtJ0H9V07mmmraikbsvyL5gVerUfDeUq5YALjee7hjtzeZ3FmaISAXw0kAypgO
	 FGE24SAOYg9Jtt/zsOJtOFrp5Gplrr4hBREX+UXo5SprdpQLIYFlvOvnL9LAbRc6ko
	 1b7KRhSuT+MYWcLCEpgCjPQxKzHvFNwes5jIUK/YuKNt7M2cEWqdkT4dS1rTUys4ZE
	 S/nu2i1fQrZp6FIaiR1ClizV0EIhPIlTENbhtAVY7RD69+6L0gY3iETe1Q+pUBIKyT
	 ZyXC9Sjlzj9yw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C9tKyhP+ c=1 sm=1 tr=0 ts=6a063eff
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=PKzvZo6CAAAA:8 a=b5vF7GWAmqmo_lLt1xYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <a4da346d-3800-40ea-8828-970b15088bf3@ramsayjones.plus.com>
Date: Thu, 14 May 2026 22:30:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trailer: change strbuf in-place in unfold_value()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJEdh+1wuMIDfiLLGOo015TfXGkgrethfQts8uO4eohSZyEys/5qn2R250PdVQ1gcU6lZvWuNJIKLT67xf8A0RCqZBcYSBkerx84S0e1LOdthX4SPU9R
 SucJfiByje6m2ogRd42VMc8NPfbRox2E8Cg7qy6ziZynh65XE3rxwt69WtajT5pS7OKPz7Fi3qHoVDqrCN+TIAgW8mj7G25vHMA=



On 14/05/2026 7:40 pm, René Scharfe wrote:
> Avoid an allocation by doing s/\n\s*/ /g (replacing NL and any following
> whitespace with a SP) right in the strbuf instead of copying the result
> to a temporary one and swapping them in the end.  We can safely do that
> because the replacement is never longer than the original string.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Formatted with --function-context for easier review.
> Inspired by https://lore.kernel.org/git/20260513185408.GA147423@coredump.intra.peff.net/
> 
>  trailer.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/trailer.c b/trailer.c
> index 470f86a4a2..b89fa12fe7 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -988,29 +988,25 @@ static int ends_with_blank_line(const char *buf, size_t len)
>  
>  static void unfold_value(struct strbuf *val)
>  {
> -	struct strbuf out = STRBUF_INIT;
>  	size_t i;
> +	size_t pos = 0;
>  
> -	strbuf_grow(&out, val->len);
>  	i = 0;
>  	while (i < val->len) {
>  		char c = val->buf[i++];
>  		if (c == '\n') {
>  			/* Collapse continuation down to a single space. */
>  			while (i < val->len && isspace(val->buf[i]))
>  				i++;
> -			strbuf_addch(&out, ' ');
> -		} else {
> -			strbuf_addch(&out, c);
> +			val->buf[pos++] = ' ';
> +		} else if (pos != i) {

Hmm, isn't 'pos' strictly (always) less than 'i' here? (note the post update
of 'i' when setting 'c' at the head of the loop).

> +			val->buf[pos++] = c;

So, this (non-newline-or-'trailing'-space char) is always copied.

Not that it matters much (depending on how long the first line is, I doubt
the difference is measurable :) ).

[Unless I'm not reading it correctly, of course - in which case, oops!]

ATB,
Ramsay Jones


>  		}
>  	}
> +	strbuf_setlen(val, pos);
>  
>  	/* Empty lines may have left us with whitespace cruft at the edges */
> -	strbuf_trim(&out);
> -
> -	/* output goes back to val as if we modified it in-place */
> -	strbuf_swap(&out, val);
> -	strbuf_release(&out);
> +	strbuf_trim(val);
>  }
>  
>  static struct trailer_block *trailer_block_new(void)

