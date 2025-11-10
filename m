Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1932FC866
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786516; cv=none; b=NReRk4QVyhNyBIQzFsi74aFT9CY2FS4AXiv444IXVUeI64lkFoDA7SWtBV68MTZVBhuNxmK1SVTJmlW4r/nIYb0OQearxCRjpq20bFlkA2LYOcfvYXUKJTZtMSvwt5QxoLSR3/gF041W4AwP1EI49Z7KO6hvMzSjnpbzxfv/b54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786516; c=relaxed/simple;
	bh=VeIfvzyKXe8EpRlgIZPyKjptFbI3kcxRlfwz7PrB6T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lvGSMuI4G4TlcITRbMtmYnLL2apIO9dXicgKx5eVK4A5Rllk9Yt2EHiktwGss46DEHuebtQpmlq5LiC7bTxgr2Z9Lw8R1GReQID/V4rd3w5aiDdysGLLp+yxR2Kr1eg1Zn6KEs1h51KdrE5UhNV1w0lkFshWcPtNxpamEQs1NXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+SKHXPt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+SKHXPt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so2264720f8f.0
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786513; x=1763391313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9z0c9+L1nQOdnEgeXiivKMuoGRlhvIRPfgcL1aiqKE=;
        b=P+SKHXPtJ2zaxLTzRCmaTrePwcRQAFZ+y1zoTEk++JO89ogTWQpC0qbu3Sa2aHyyv2
         /XSya46eon/vNrXeAr6C1qB8/qrdEXxAh4XUBrx5t4+UIRBPaFs3OBph2gd2ygS/U6kN
         N2B3GOl46CcqCVq2cI1oScNjbn046I8iFKayG41e8LU3TOlqGGUtWUzhm2NwwWUYKjx3
         280kjcyWWa6CryMfP/70McumLE4qKtwIx2kk7dq6H4oIPKW9qj0MKOEDkPDAF+AtzxTB
         ZBqjvxwtIzaEVsdBpsKy3v87XaQ+3ThVG6W9rhYZQ+FYCe8L31Pos7RvBJwWLUfGgpHc
         dE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786513; x=1763391313;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9z0c9+L1nQOdnEgeXiivKMuoGRlhvIRPfgcL1aiqKE=;
        b=PQAWBDwOtv4MxMVQsrE7FBXCM5o7ARc09rqOlRy2xtn0By4sz6gkBVCAm+4lTqJ+sA
         5SBSFeH6u8qXnEhK6qahJ3cxsVnYi1EsSjLSQLO10uvomUt5YEQ9bmCTw/49hmWcksQJ
         uDVenN5ICuQBwcd66yllZXp7JOJ9tIE8F2wVwkOceP0XmoNGy/JIIfMQbmFbVUU2CkEZ
         dI6MJ6/qTdduBe6czkZ3q7xXhOgDn+/bzVJnt1FLXT4H7duDvLZi8rUzwpm70wFpqoJf
         lYvalYK/yp7L4KwYWIrAOhqTYRTipI3CMvpGBEF0vwW4rcXr7V3NIeR7voF7KaFIdQET
         yKBA==
X-Forwarded-Encrypted: i=1; AJvYcCXIA+by2qbC/HjUso3XnOFCIlDevg+7UTI2z53aLe+2jy2v3SiQRGp1qhvt11jXXYwPpyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Li+mjUr5DMQq1iICz7FtcWwhDPT3R/Fll7r8hd+8QxoHCZuh
	HpYcOx8z8H8GHuBYctgVYXfYqzVrBbqPs9kYCB3xJtSYXMC/6StU/IPlQUIH8w==
X-Gm-Gg: ASbGncsEimi/8mgkcQaJMyhCCulaJaO7jQYgA1/Y47bnURk06UyNO4tdrnoO543ewEC
	5WWPoFFhlsKLL3pK9lDNXB+NaDpgXryrnROCmEm1Z2Mrtu56o4/4dXr8oftSvRysyqnTwiGYrNo
	ffZNcSwrBgxxD7QIm7h8kchGkigQr5k8y8qqpyCXaYnqcELETBdr/aSDb9ObtIyv/bpYrwvSlF4
	O1b+7VdawQKndIouDRClCdlqb1b3Op1tDlVpKoeCafo/G8W7zGCKoE3p47ZHjQrxexAMT/gfLQX
	FkzV9AOKDZ/70j0dIftYHmENWE6gJAh24fQZpoe4m8bdQFFYXNintq14pl1OKgiz6EyUmTiYjCF
	RbbcE5lgn92YvLeWYKe5ek4LOxcFAAkV4OYvjGf9j6zQFV9zhZSuvHJURBvKAB2dFGjkBnRI0Cn
	rsHKruGHwJU0i4EjQL/3SAIUq3LEIp4vUDyjDsVt0V2zhiSu2NETFiF/l7rNc5KJ4=
X-Google-Smtp-Source: AGHT+IF2NkHn9yeDZqYsmEMIhkXLhnkPBC1GQF6q/qvlQaQJ0VKhmEnXjXuK8pyMdcFhv57KdDHwCQ==
X-Received: by 2002:a05:6000:430d:b0:42b:3878:beef with SMTP id ffacd0b85a97d-42b3878ca88mr4456171f8f.61.1762786512544;
        Mon, 10 Nov 2025 06:55:12 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm18831688f8f.32.2025.11.10.06.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:55:12 -0800 (PST)
Message-ID: <7aa91693-bece-4fa6-ab14-f914d6fd49bd@gmail.com>
Date: Mon, 10 Nov 2025 14:55:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 11/12] diff: highlight and error out on incomplete lines
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251104020928.582199-12-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <20251104020928.582199-12-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2025 02:09, Junio C Hamano wrote:
> Teach "git diff" to highlight "\ No newline at end of file" message
> as a whitespace error when incomplete-line whitespace error class is
> in effect.  Thanks to the previous refactoring of complete rewrite
> code path, we can do this at a single place.
> 
> Unlike whitespace errors in the payload where we need to annotate in
> line, possibly using colors, the line that has whitespace problems,
> we have a dedicated line already that can serve as the error
> message, so paint it as a whitespace error message.

This explains why we don't need to call emit_line_ws_markup() in this case

> Also teach "git diff --check" to notice incomplete lines as
> whitespace errors and report when incomplete-line whitespace error
> class is in effect.

Nice. The implementation looks good, I've left a few comments on the tests
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 9de7f73f42..138730cbce 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -43,6 +43,49 @@ do
>   	'
>   done
>   
> +test_expect_success "incomplete line in both pre- and post-image context" '
> +	(echo foo && echo baz | tr -d "\012") >x &&

'printf "foo\nbaz"' might be clearer and save us forking "tr"

> +	git add x &&
> +	(echo bar && echo baz | tr -d "\012") >x &&
> +	git diff x &&
> +	git -c core.whitespace=incomplete diff --check x &&
> +	git diff -R x &&
> +	git -c core.whitespace=incomplete diff -R --check x
> +'
> +
> +test_expect_success "incomplete lines on both pre- and post-image" '
> +	# The interpretation taken here is "since you are toucing

s/toucing/touching/

> +	# the line anyway, you would better fix the incomplete line
> +	# while you are at it."  but this is debatable.

I think it is a reasonable default.
> +	echo foo | tr -d "\012" >x &&
> +	git add x &&
> +	echo bar | tr -d "\012" >x &&
> +	git diff x &&
> +	test_must_fail git -c core.whitespace=incomplete diff --check x &&

Do we want to check the error message here?

Looking at the tests below the coverage looks good for "diff --check" 
and for diff.wsErrorHighlight

Thanks

Phillip

> +	git diff -R x &&
> +	test_must_fail git -c core.whitespace=incomplete diff -R --check x
> +'
> +
> +test_expect_success "fix incomplete line in pre-image" '
> +	echo foo | tr -d "\012" >x &&
> +	git add x &&
> +	echo bar >x &&
> +	git diff x &&
> +	git -c core.whitespace=incomplete diff --check x &&
> +	git diff -R x &&
> +	test_must_fail git -c core.whitespace=incomplete diff -R --check x
> +'
> +
> +test_expect_success "new incomplete line in post-image" '
> +	echo foo >x &&
> +	git add x &&
> +	echo bar | tr -d "\012" >x &&
> +	git diff x &&
> +	test_must_fail git -c core.whitespace=incomplete diff --check x &&
> +	git diff -R x &&
> +	git -c core.whitespace=incomplete diff -R --check x
> +'
> +
>   test_expect_success "Ray Lehtiniemi's example" '
>   	cat <<-\EOF >x &&
>   	do {
> @@ -1040,7 +1083,8 @@ test_expect_success 'ws-error-highlight test setup' '
>   	{
>   		echo "0. blank-at-eol " &&
>   		echo "1. still-blank-at-eol " &&
> -		echo "2. and a new line "
> +		echo "2. and a new line " &&
> +		printf "3. and more"
>   	} >x &&
>   	new_hash_x=$(git hash-object x) &&
>   	after=$(git rev-parse --short "$new_hash_x") &&
> @@ -1050,11 +1094,13 @@ test_expect_success 'ws-error-highlight test setup' '
>   	<BOLD>index $before..$after 100644<RESET>
>   	<BOLD>--- a/x<RESET>
>   	<BOLD>+++ b/x<RESET>
> -	<CYAN>@@ -1,2 +1,3 @@<RESET>
> +	<CYAN>@@ -1,2 +1,4 @@<RESET>
>   	 0. blank-at-eol <RESET>
>   	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
>   	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
>   	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
> +	<GREEN>+<RESET><GREEN>3. and more<RESET>
> +	<BLUE>\ No newline at end of file<RESET>
>   	EOF
>   
>   	cat >expect.all <<-EOF &&
> @@ -1062,11 +1108,13 @@ test_expect_success 'ws-error-highlight test setup' '
>   	<BOLD>index $before..$after 100644<RESET>
>   	<BOLD>--- a/x<RESET>
>   	<BOLD>+++ b/x<RESET>
> -	<CYAN>@@ -1,2 +1,3 @@<RESET>
> +	<CYAN>@@ -1,2 +1,4 @@<RESET>
>   	 <RESET>0. blank-at-eol<RESET><BLUE> <RESET>
>   	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
>   	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
>   	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
> +	<GREEN>+<RESET><GREEN>3. and more<RESET>
> +	<BLUE>\ No newline at end of file<RESET>
>   	EOF
>   
>   	cat >expect.none <<-EOF
> @@ -1074,16 +1122,19 @@ test_expect_success 'ws-error-highlight test setup' '
>   	<BOLD>index $before..$after 100644<RESET>
>   	<BOLD>--- a/x<RESET>
>   	<BOLD>+++ b/x<RESET>
> -	<CYAN>@@ -1,2 +1,3 @@<RESET>
> +	<CYAN>@@ -1,2 +1,4 @@<RESET>
>   	 0. blank-at-eol <RESET>
>   	<RED>-1. blank-at-eol <RESET>
>   	<GREEN>+1. still-blank-at-eol <RESET>
>   	<GREEN>+2. and a new line <RESET>
> +	<GREEN>+3. and more<RESET>
> +	\ No newline at end of file<RESET>
>   	EOF
>   
>   '
>   
>   test_expect_success 'test --ws-error-highlight option' '
> +	git config core.whitespace blank-at-eol,incomplete-line &&
>   
>   	git diff --color --ws-error-highlight=default,old >current.raw &&
>   	test_decode_color <current.raw >current &&
> @@ -1100,6 +1151,7 @@ test_expect_success 'test --ws-error-highlight option' '
>   '
>   
>   test_expect_success 'test diff.wsErrorHighlight config' '
> +	git config core.whitespace blank-at-eol,incomplete-line &&
>   
>   	git -c diff.wsErrorHighlight=default,old diff --color >current.raw &&
>   	test_decode_color <current.raw >current &&
> @@ -1116,6 +1168,7 @@ test_expect_success 'test diff.wsErrorHighlight config' '
>   '
>   
>   test_expect_success 'option overrides diff.wsErrorHighlight' '
> +	git config core.whitespace blank-at-eol,incomplete-line &&
>   
>   	git -c diff.wsErrorHighlight=none \
>   		diff --color --ws-error-highlight=default,old >current.raw &&
> @@ -1135,6 +1188,8 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
>   '
>   
>   test_expect_success 'detect moved code, complete file' '
> +	git config core.whitespace blank-at-eol &&
> +
>   	git reset --hard &&
>   	cat <<-\EOF >test.c &&
>   	#include<stdio.h>

