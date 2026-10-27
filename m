Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098174;
	b=hKVx46uei8h6RGZGMOGBOFdyf6XStWTURxf1zzQY2OKZvcvdJpwpnYD3UbjFNWJJytrt
	 pR06EPAi1/jS6iHgX7y/O8Px5ykfBZGi1D47iYXZlUm6laehS4gJ8ysGu+qLW22uejLxh
	 f0HUhEaagM7oaETSZMXDzxZcv213t2eBKysz8cEPEzwZRtBMhifdnfx1IehK9zAwHnHIS
	 fGU/Pwnb160xtLRLjvn6+Gz7MW/t7X67SVilW+tgqp2Ktq/qamuJfYqXHNK/sYTZ94Ew4
	 kJYt1JoS+x0+hoRAsEui6iQ+JinHZWcxK92/MJsowHBxGNy4eYT3xp/1vqJa+kFzOAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EMb//4EKdoCq7TKsPzgSME/9IbLsBatRr3ePKTk15wo=;
	b=p3fJXFB1RuigyZ4+vbtUbyAhPPXEdclEha3svFtny8x2pghg4utvXKet8kCfd6oRhQAz
	 hH/shL++uPSzL3yOGBJSGiipvXo+T6py95DqMuJ5qCz9JR8cw4W1EFmYFkW5einQwaOVi
	 z/AIWl4K4vfXDU8TnTnBsXitcV3hI96PTiBitwOAykM9oEb9wCbCYYL/gdLF4IFGQAB+b
	 GPTSXibtG9aeFzSSZvK7rHU06AlcU0S4/4joAQblnFjnnYDlGJ0Q505Q5Vi2szRY+U9xa
	 1T3wxTn/2BWDYsJt+KF+lEVDd7NarhVpu1HiMaH7+8qdx2N4NExz5qWktXCDGpDFNGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgo3i19i;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999B60A2602
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5999B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgo3i19i
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df54150dfso2130587f8f.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098173; x=1793702973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMb//4EKdoCq7TKsPzgSME/9IbLsBatRr3ePKTk15wo=;
        b=pgo3i19iFQrXa3KHMpoonKTrdWS3zLW8zeQ9k4loh0BL/BIGhi1kwIh82KYj9qgkry
         2Mj5xsfTWzdi+GWRQi9dnvbXQh0kj+gV1nN/ANtOd6A+x+WP+8ZOHv9N+JGaqAyqZ5OD
         oY4PPBMIL468D4PlJxZcbT9oMy7Emu18FK+S7hXizAPQy0wbWJqknLkfTz9pbqkRA8Zq
         Zd0bcfR85S0H6wZ+KysbjeUYW2U/MUcfikB5mnu6/KwGEdVQf0NDEAan8rox81L2r4eO
         d6PbaiQIiqBxIFcKb3vKU6TWOsM5UQX4eonkKw1mq9Quje7Tf/aq0216QuoKM41lff0b
         x+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098173; x=1793702973;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMb//4EKdoCq7TKsPzgSME/9IbLsBatRr3ePKTk15wo=;
        b=NePE9YjoDwURXELabFqfREHOGL7tRQndfaLHDiFiwUBIkvNJo5KUE1ymdzETiGfTmE
         bdcJDmU88xnCqKq9f7P9SAWK+K/49/+aQwf3jRM65QwxPES6w5WoU4d6f33Wn1zvvfnI
         3kwPwP6l++rhiGw47NfEgoFhssasY2Is3ZjfwZ9/KnV7l/6n7r4++8fd/f8SuFToAvMs
         gHsWs5P7XfXhu4yGurcJQ9N/z/ULZpPQtwYGXB5ogOkvEm/iRMuVMRGolJCI9c3snbhl
         bm83T1pjMM8Sb9pAHFa6ifExlLS4YtuHV10L37Tlpqth9U8lNoucb88CmoQ/yPgpixh0
         4v1Q==
X-Gm-Message-State: AFq9FYKFz9MLmfOJLrm8+WuPh/F/buhXHwvT67PswNAs/h8PGA3ZJpZ8
	7AgaLGyf82ITLiNflJkBLSNSsXzLE4tUhKdq6qtXd130gknDSa+R8dcQ
X-Gm-Gg: AYBFou1eSs/8XUpSzgQOc5VmJLpD83BQnYuT9zoqJCG0orhQAwtjp+6BzoQH4tznEPw
	0LdS+ShXRMsEWnw4ul11ckqan8lPsYkrU13NrpD5exLEIpTV4Ls9N63VW5IuBkvGwuh+53uoWCy
	4p30ndvHl79LLIpuEtoRGFy9UjzsnNOGM7FOUjYPx1ouesEHc5OAAxBbyM8bwg6MFHwVX55nGJL
	SF2EG0Gf0KQdhXWJHsYuM8VUaFMO3yxUH49vGEtEoXNDD6b7nv8LqshdUZN17sdSsFktdom3yaR
	aMaPumly63wWdviKn/zqQRO2IIdoyuJOHmTT7RfxxtDECf+IYWugq5DKMQYiwzvR/fE/fKgNh//
	ZumJ7crETNu+wkhh8T1Q3EIdq/6qTHjl3iw/6vhSZwhlGa6lb4LI04l/ZvYWAJYiTw4lcy+o9hY
	H8jO0gfb+RUWNrYbpXLNDrc5+PZoDF6J70Qv6Uq/wY7Cr/hzQNqFgH81WsyT0lypB2zW+kK/v4D
	h6eoRMAJbZgj/q8ozZBCzo5CRwjSe+6V1miSnfCxZVDCUxgUd9xEaf5l4FKLKA8Ij3uLXz1o6pX
	THJjjsS/8+LGwCmPEgGrQba3MtuzpPjvL1Djx3nvDXIQxw63uO0Si0A=
X-Received: by 2002:a05:6000:607:b0:48d:ff81:5201 with SMTP id ffacd0b85a97d-48e3eb9930fmr21627389f8f.41.1793098172588;
        Tue, 27 Oct 2026 03:49:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4806e208sm16892106f8f.40.2026.10.27.03.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:49:32 -0700 (PDT)
Message-ID: <97fc0f78-a8e9-48cc-9b6d-5356d083ccb1@gmail.com>
Date: Tue, 27 Oct 2026 10:49:28 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] CodingGuidelines: allow compound literals
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <a4b382c0373e1b410c4c1ef74b313f86076d48aa.1793024062.git.phillip.wood@dunelm.org.uk>
 <xmqqbj8gp3pv.fsf@gitster.g> <auBGiu_-qJMd07ua@pks.im>
Content-Language: en-US
In-Reply-To: <auBGiu_-qJMd07ua@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2026 06:36, Patrick Steinhardt wrote:
> On Mon, Oct 26, 2026 at 02:11:08PM -0700, Junio C Hamano wrote:
>>
>> So we do not have test balloon but we know we still cannot use two
>> constructs from C99 due to MinGW and older IBM xlc?  Perhaps we can
>> raise test balloons for them by now?
> 
> Huh, which are those two constructs?

The format specifiers "%z", "%zu" due to MinGW and ".a.b = c" in struct 
initializers due to IBM xlc. I've cc'd Johannes to see if the changes 
around using UCRT64 makes any difference to the format specifier support.

> This also makes me wonder whether we should have a look at what C11 has
> to offer. Skimming through it though the only thing that I do find to be
> interesting is `_static_assert()`. We essentially already have those,
> but they are extremely hacky and their error messages leave a lot to be
> desired.

Yes static_assert() would be nice. Atomics might be useful to reduce the 
amount of undefined behavior in our signal handling but I've a feeling 
they're optional. Would _Generic macros be useful anywhere?

> One thing I wonder is whether we can now start to replace the split
> between e.g. `STRBUF_INIT` and `strbuf_init()`. Right now the issue here
> is that you cannot initialize a variable at a later point like this:
> 
>    struct strbuf buf;
> 
>    buf = STRBUF_INIT;
> 
> This is because `STRBUF_INIT` is simply defined as `{ .buf = ... }`, and
> thus the compiler would complain. So instead, you are forced to now call
> `strbuf_init()` on that variable.
> 
> But with compound literals we can define it as `#define STRBUF_INIT
> ((struct strbuf) { .buf = ... }`, which would make the above code to
> compile just fine. And as a consequence, `strbuf_init()` essentially
> becomes obsolete.

That would match what the test balloon was doing for temp file 
implementation in the reftable code I think. It's probably worth 
converting STRBUF_INIT() to give us that option for new code. 
strbuf_init() takes a size to pre-allocate "buf" but most callers pass 0 
for that parameter and I wonder how scientific the hard coded values 
below are.

git grep strbuf_init | sed 's/.*strbuf_init([^,]*, *\([^)]*\).*/\1/' | 
sort | uniq --count
      79 0
       1 100
       1 1000
       8 1024
       2 256
       2 256 * (32 + the_hash_algo->hexsz
       1 32
       1 80
       1 8192
       2 b_seg->len
       1 dirnamelen + 257
       1 dots - name
       3 from->len
       1 ident_len
       1 imgoff + extra_chars
       2 len
       1 len+32
      10 line->len
       5 PATH_MAX
       1 PATH_MAX * 2 + 300
       1 PATH_MAX + len + 1
       2 q_seg->len
       1 sb_src->len
       2 size
       1 size_t alloc
       1 size_t hint
       1 strlen(arg
       1 strlen(url_decoded
       1 tgtlen
       1 though.
       1 url_len

> Now I'm of course not proposing to go on a crusade and replace every
> such site, and I only use `strbuf` as an example here. But is that a
> direction we want to move towards?

I think it would be nice to have a uniform way of initializing structs 
like strbuf that works whether they are allocated on the stack (where 
we've traditionally used *_INIT macros) or on the heap (where we've 
traditionally used *_init() functions).

Thanks

Phillip

