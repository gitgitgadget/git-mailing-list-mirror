Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75727A457
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537432; cv=none; b=T2JEO2F8DT7LanfUQfeYjBZ9hR9tWxUR7naH5Jo36UHxW84W8fVpvDiKzcMvNL58GQFmQYNLjkVswktg04ivo1Up7DluylD9NOsFru4p0bxdkvPWF8EaunIFYp6+5RJgzkFYUYBaK7I0qJ1gANnTgAuRKdCE7uVlgzGjEjSG68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537432; c=relaxed/simple;
	bh=7bMk/NjKOrPnrfr1YycEpBuIckajLt7Zaz7PxqyvOLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZJtm+uDlInvOHzUXifGhiPu9/tjzGJJriArOQNaybVqZzONrWvAI+n9HqCFZI5l+qjjDZ4fMfwF/J4mx0L1WhX8q2woBfweRT9j98Ynb0GBKportrYNbv2bMdVD1oFYDW4g8vsPgfzpeYXwbsrFqkdOTiklI/w/7oQPBIlpMZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTpE0XDI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTpE0XDI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso35792445e9.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537427; x=1747142227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARTQ8g69MfaSa7vn2c18QVED8QWIU9W/w3Yco4/r6yk=;
        b=DTpE0XDIpjOhJ5MPs8axUMegyGDkkBboSv80kwRSKonTdrXLVGrfwIh6wuO3QyT6Ar
         bjofXbBIlUfoLYGdDV61K7vSNL0P//BsVw2HqcRdXvZA51QhDE6URh5EkoMzz/Wn+f3V
         wN10FFiF0bN5HFljJlUaHIOMy/d5Hgno8Je70ybJGD8VlIEhFiunVV6bU7LgukY+drlV
         HrRhRJEgt/oOOzDmVA/lAtr8YXt/BjRGsYc3H+HqeKbzNDbEbCmOd7D+Y5LtDyd3pRc6
         6UvBmMU0QfcU1X3ibGJNMulBl1ws8fkbbPklm6afdBDr01q4GldEJtku3U+06Dfj5Nqv
         aaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537427; x=1747142227;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARTQ8g69MfaSa7vn2c18QVED8QWIU9W/w3Yco4/r6yk=;
        b=blca1IOHxCEr+e/XryHeCVwSMQ5Goh7kcg1iPFn/JdiGLF97RJ0fVMmxkvAr/5oFwO
         c7ETcHfrMAvA67+nCg+8uuXPraKu81dJr9DaNWgLhQurhO1cLYU+foBz3NfKPyfhGEAL
         WUepnccKf6FtbkETFQPYUUxyQhQR6bX6b9WXjIEwv/eTbZHJZbftH+AoCIfhf477XdeM
         /9nhIhr9xlB8xu4TWq/PKD9CirT2vYHF/QvnVZd3wEiSOl8TfuHN0Wsx1qkNqyHxrmEX
         HGwl/L/HG/2msZUnd9EcHtnDmRlXBkTmau9+Ys69B93ksoXfxjedJ/q+bVMCZs6zwUyI
         s6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCV0tmgAdK2Yx3n1q6m3y41OAq6PtrIr7WRsamLO2Cg2P/A4BG5/wpS6Ih7SNncPCYJSyNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UaAos3tj5XtikkAl8xZBV2dqV7rXKnWlzsS1BQgFq4kHTk1y
	utT9s2ufyqVLBmuvPhTj4y1aqOBemCz4JaxkUXoddGd/I4+aXcWkug2cPQ==
X-Gm-Gg: ASbGnctqzyccU7st3v9j1P9JRRiAmq5zk5veKfyUugxJ9vX08nshxk1pylRu2bS1KjM
	9dlavohzIj/SPDM6nBdjVWObMk8+nYfgEeo7GFU99cSS9WbZOAzGevbmdBF//Afj/0GJporsTwO
	1osinKFsueWPkdiT5NObNPULcOHkRqQSv8YcysXzEP8Q3X8ODZ26YLeGOC9t9GWPzTVTvR4R5d6
	bWIUJO3UgyN0+mz4Hbcf/p01bjNxF4hZRc1Xl5SzCDMlSsGeccVV2oFplOF2Ltn7S+DHbMRyToq
	CHUcg9yGJqCzbTyEev8bGdodLnZzDLuFbyZgBfzJECl5TjflSTjsZUawHJzxQ7LtmMZug0RgTS2
	gJ0aXW6E8glcgca7fjw8C0iI=
X-Google-Smtp-Source: AGHT+IE6crGQ2lC+jsfRKBVBN+b/XLp9p5HHA4h8j+M5acqJJkXAs1KDDPI8K0iPCxRhvwDAPYF04g==
X-Received: by 2002:a05:600c:1c1b:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-441d04fe806mr23972225e9.11.1746537427131;
        Tue, 06 May 2025 06:17:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441bc83d471sm146254615e9.26.2025.05.06.06.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:17:06 -0700 (PDT)
Message-ID: <49ef0fc1-39f1-4771-88e4-440e0924478f@gmail.com>
Date: Tue, 6 May 2025 14:17:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] t: fix cases where output breaks TAP format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 06/05/2025 11:59, Patrick Steinhardt wrote:
> The TAP format does not allow arbitrary output outside of a specific
> test case. If a test suite wants to print any such diagnostic output,
> then this output has to be prefixed with "#" to mark it accordingly.
> A bunch of our tests generate output outside of `test_expect_*`
> testcases anyway without such a mark, which breaks strict TAP parsers.
> 
> Upon further inspection, all of the output generated by such tests is
> rather uninteresting. Refactor them so that we don't break the TAP
> format.

I think there is an argument that these tests are broken and we should 
be running these commands inside test_expect_success(). However this 
patch doesn't make things substantially worse because although we lose 
the output from test_create_repo that probably isn't going to matter. 
The changes to the highlighting prereq look fine too.

Best Wishes

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   t/t1007-hash-object.sh                       |  2 +-
>   t/t4041-diff-submodule-option.sh             |  4 ++--
>   t/t4060-diff-submodule-option-diff-format.sh |  2 +-
>   t/t7401-submodule-summary.sh                 |  4 ++--
>   t/t9500-gitweb-standalone-no-errors.sh       | 14 +++++++-------
>   5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index b3cf53ff8c9..210cce56ec6 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -30,7 +30,7 @@ setup_repo() {
>   
>   test_repo=test
>   push_repo() {
> -	test_create_repo $test_repo
> +	test_create_repo $test_repo >/dev/null
>   	cd $test_repo
>   
>   	setup_repo
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 28f9d83d4c1..31f359ddf1e 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -48,7 +48,7 @@ commit_file () {
>   	git commit "$@" -m "Commit $*" >/dev/null
>   }
>   
> -test_create_repo sm1 &&
> +test_create_repo sm1 >/dev/null &&
>   add_file . foo >/dev/null
>   
>   head1=$(add_file sm1 foo1 foo2)
> @@ -236,7 +236,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
>   '
>   
>   rm -f sm1 &&
> -test_create_repo sm1 &&
> +test_create_repo sm1 >/dev/null &&
>   head6=$(add_file sm1 foo6 foo7)
>   fullhead6=$(cd sm1; git rev-parse --verify HEAD)
>   test_expect_success 'nonexistent commit' '
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index 76b83101d3b..17ef40c0c9f 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -364,7 +364,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
>   '
>   
>   rm -f sm1 &&
> -test_create_repo sm1 &&
> +test_create_repo sm1 >/dev/null &&
>   head6=$(add_file sm1 foo6 foo7)
>   test_expect_success 'nonexistent commit' '
>   	git diff-index -p --submodule=diff HEAD >actual &&
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 9c3cc4cf404..80bbb1b7b5b 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -38,7 +38,7 @@ commit_file () {
>   	git commit "$@" -m "Commit $*" >/dev/null
>   }
>   
> -test_create_repo sm1 &&
> +test_create_repo sm1 >/dev/null &&
>   add_file . foo >/dev/null
>   
>   head1=$(add_file sm1 foo1 foo2)
> @@ -215,7 +215,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
>   "
>   
>   rm -f sm1 &&
> -test_create_repo sm1 &&
> +test_create_repo sm1 >/dev/null &&
>   head6=$(add_file sm1 foo6 foo7)
>   test_expect_success 'nonexistent commit' "
>   	git submodule summary >actual &&
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index 7679780fb87..84196a10896 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -701,13 +701,13 @@ test_expect_success \
>   # syntax highlighting
>   
>   
> -highlight_version=$(highlight --version </dev/null 2>/dev/null)
> -if [ $? -eq 127 ]; then
> -	say "Skipping syntax highlighting tests: 'highlight' not found"
> -elif test -z "$highlight_version"; then
> -	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
> -else
> -	test_set_prereq HIGHLIGHT
> +test_lazy_prereq HIGHLIGHT '
> +	highlight_version=$(highlight --version </dev/null 2>/dev/null) &&
> +	test -n "$highlight_version"
> +'
> +
> +if test_have_prereq HIGHLIGHT
> +then
>   	cat >>gitweb_config.perl <<-\EOF
>   	our $highlight_bin = "highlight";
>   	$feature{'highlight'}{'override'} = 1;
> 

