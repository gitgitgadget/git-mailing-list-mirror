Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FA1E0B72
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169595; cv=none; b=dlWuRrBVlFNl2PgL791t2YKdE6Mk+VLz99DFmbhVEL8SfYKo5Zgzpn8zi42ROT+h2r4SUoFSHRwd1f4HglK0t2mn3Cb0B/3SGJyT1MmMN3dufuYxWFOzCtRPGhyjJZH2hwRu6fdaMUG4kdr7Ss8JxF05Lw5GVuDchlKQd2+Sv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169595; c=relaxed/simple;
	bh=0sW/z4jhBwzHNvbUnN+y9k69NAHecy78tFRa+CG6p3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYbym4XkkvbWFkON9+Pr2dxDoJG27+eliuTYIcB3TPsCuhbw4UTO4vk+k5q6dHoDRehZJVe5X68O7SKvkm/gk6fMT+JG+4KSvWeiU4i3E3cWkNaBGkGajC+q+zlEmBjKxRw3ENZ8Z6Exnr+y9RUNqn8nVSjyg5BynXNqJTyjFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4K5iZtP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4K5iZtP"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso5960738f8f.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738169592; x=1738774392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9/fYiDAAt0FJ2DlUkZwoA/3591RboF68dHmROVRe9EI=;
        b=B4K5iZtPYwTwwDlhlVmV5AzRPyWFZsQ2oMHAmuHPUdSnJo8oJn/xmJACjDQ0fzqq9l
         c+OdcewtXV34WMBkH5N7YrWDnqHCtAbiDifysRcZUsNGAD8jOUs/x6SF2+C/IuhR5+xR
         gOEDoSiNwVctXDhrwLabBvcgmRjpWR789EdVOMG11gC60SC2NVVACdyUQ4cR7LPqSFhi
         rEHFve/ri9+6KikiF31gCEe1nfbiDsFcot3OGgB36z1q86pkL0EpyprNrNFwOB83qcrY
         I28EhGHyTTXC+nXAvoitBAfcDl+D9mkk+VZwqrvuVkAl89UQmp467FyHZUcT9uk0mmK/
         6vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169592; x=1738774392;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/fYiDAAt0FJ2DlUkZwoA/3591RboF68dHmROVRe9EI=;
        b=fPffuf9FZP2yH4ikRiPpD2NcvUMc7H35tNTwz9IfNoXo46w1mkaPdonh8IXQ0cN2BY
         fmk+jg1a+yoQzx3OCEu6CKzY7nv1bH1y/X7qG1JRaxy6QTrtdBsGRVvzn9iUTSkvK89V
         ANqsgoB002btf+h7xAZvAj7yW/VXOhrlyf21anOoRJS0SzTWsW1a9c/3Lq4NxHo1oj/t
         zP7J6JecqObnnxHnH4/n2OimlWwTdDB0sqj1vTv9FDsKUzusJiWm96bJynNeh8SGRrhI
         Axu6nBV8iPbSl2xafDNbomjpbV5RvT33OO4DnSaeKVeCFtQpKP3HAU5jg1b22Ag0ITwj
         I8LA==
X-Forwarded-Encrypted: i=1; AJvYcCXLfeiFUL7MItvBIUhNGH6heMigipP9CZBlCalYwFi/0/n6wnOG6IY8PdHSyqNBeyBBWzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNjFxc1gO1Uybnpow0MOpTXGpL1TYmmBtKeJkI53hJl3OpEpM
	vWdwsWpMaQVTegm+D2CUnGx3yS6ITCzjNFEUdwcGnL7XjcTILg+a
X-Gm-Gg: ASbGncsv0EMXylV+Zl7GTgs/xFYzEBsSharSlyuRzA+PWB4R0jbO0Ztt7MCJ8JzUmU+
	Ejdtzs4FzfN/Dy0yOw6sNUb1pRv9jUw9NTik7aaqAYgP5rKKsj0tL/D+UiSv5/Dhr7WIh4/yLBJ
	TuGls3ss3y5QaVPyx/kf2GCpM7RF7l7UAZomNcqCCrsPhZm44J2qdXe1aOWssc+KUnlxRPPBgSw
	cMEqJvKUrT2v1xebn95cdtszcguMdicMPI+4r43pBQKiOgauexN/DAMWndHUzk7EvLiGbA/S1ck
	SKCYrAyUD2i4hxo9InsPih+PXdUjKaLlLs+57lUAZ+ygn25AK9IZOeTzB3r2Qz/ufoWS1Q==
X-Google-Smtp-Source: AGHT+IGwBWi5LLgI//oSDCGgisvf4CtffE4FkX309vbXennAt3pXQ1LYFwgVL2CAWFRJgYs43/WDhQ==
X-Received: by 2002:a05:6000:1569:b0:38a:418e:f3f with SMTP id ffacd0b85a97d-38c5192f72bmr3225763f8f.3.1738169591963;
        Wed, 29 Jan 2025 08:53:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc33e3bsm28227105e9.30.2025.01.29.08.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 08:53:11 -0800 (PST)
Message-ID: <a3f49105-e66b-4bfc-9fa5-902c77765e4a@gmail.com>
Date: Wed, 29 Jan 2025 16:53:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] commit.c: Fix type conversation warnings from msvc
To: 20250126125638.3089-1-soekkle@freenet.de, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, sunshine@sunshineco.com,
 =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
References: <20250126130038.3277-1-soekkle@freenet.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250126130038.3277-1-soekkle@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sören

On 26/01/2025 13:00, Sören Krecker wrote:

> -	const int tree_entry_len = the_hash_algo->hexsz + 5;
> -	const int parent_entry_len = the_hash_algo->hexsz + 7;
> +	const size_t tree_entry_len = the_hash_algo->hexsz + 5;
> +	const size_t parent_entry_len = the_hash_algo->hexsz + 7;

As Junio has previously pointed out it might make more sense to change 
the type of the_hash_algo->hexsz. What is the advantage of using size_t 
here?

>   int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
>   {
> -	int inspos, copypos;
> +	ssize_t inspos, copypos;

Note that POSIX allows "ssize_t" to be narrower than "int". We have at 
least one platform where that is the case [see c14e5a1a501 
(transport-helper: use xread instead of read, 2019-01-03)] so I'm not 
sure this change is a good idea.

>   	const char *eoh;
>   	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algo)];
> -	int gpg_sig_header_len = strlen(gpg_sig_header);
> +	size_t gpg_sig_header_len = strlen(gpg_sig_header);

It is really unfortunate that the compiler cannot deduce that there is 
not any truncation here as the longest string is "gpgsig-sha256". I 
wonder if we should add a helper for cases like this something like

	int strlen_int(const char *s) {
		return cast_size_t_to_int(strlen(s));
	}

rather than having to deal with the fallout from changing "int" to "size_t"

> -static int find_invalid_utf8(const char *buf, int len)
> +static int find_invalid_utf8(const char *buf, size_t len)

I think changing the type of "len" is an improvement (even if it hard to 
see anyone creating such a long commit message) as it matches the 
buf->len in verify_utf8() which is the only caller of this function. 
However the conversion is incomplete. If we are to accommodate buffers 
longer than INT_MAX we need to change the return type as well. As it 
stands bad_offset is changed to size_t but truncated to int when the 
function returns. Patrick has already pointed out that the type of 
"offset" needs to match "len" as the loop does

	len--;
	offset++;

and

	bad_offset = offset - 1;

verify_utf8() uses a variable of type long to track the position so that 
should be changed as well if we're really going to support size_t length 
buffers.

I think that a good approach to fixing these warnings would be to ask 
"does it make sense to use size_t here?". If the answer is "yes" then we 
should focus on converting the function to work correctly with size_t 
rather than on fixing the compiler warnings. That way we are more likely 
to avoid subtle bugs like this as our focus is on the conversion rather 
than the compiler warnings which will be fixed as a by-product of the 
conversion. If the answer to the question is "no" then we should look to 
change the types of the other variable in the assignment or use 
something like cast_size_t_to_int() or case_size_t_to_ulong() as 
appropriate. There is a danger that we adopt an approach of "change the 
type to size_t to silence the warnings" which leads to code that looks 
like it handles size_t correctly but in fact contains subtle bugs.

Best Wishes

Phillip


>   {
>   	int offset = 0;
>   	static const unsigned int max_codepoint[] = {
> @@ -1539,7 +1539,7 @@ static int find_invalid_utf8(const char *buf, int len)
>   
>   	while (len) {
>   		unsigned char c = *buf++;
> -		int bytes, bad_offset;
> +		size_t bytes, bad_offset;
>   		unsigned int codepoint;
>   		unsigned int min_val, max_val;
>   

