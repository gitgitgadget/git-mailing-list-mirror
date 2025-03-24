Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5B26281C
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832986; cv=none; b=iXzK7Xi0EP6EoEyPkJ22QYN0spJ7CEpaBWINdJl6bpz7wnjyrBDmvQnx49TPV+PfYGoccyaH6a86T1wWL7aF1EzYU+9ogVhKsggo4+Wg3d/j6cazjO/aY61GHM77nMo9hj8UZdkUrq01uxIOKq8jiyRLH1oFbJfsQhYKTYEkLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832986; c=relaxed/simple;
	bh=GROUECrL8i4MGhdbWIBVVlM6c74Vzdf3t9pHTRUZnBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b41N30toI5dQJLpcQU3CHE/ZGR1jVTJigXL0LP5gdUF/558nnIrBzKnyewpcUGK/pkksC5BsNsTHP7kAERhLUcdZpq3Dnk/YjB5yV2jCriz1Wo3b7OFOXtyfvKkgCvG7aB5yFUrZ2E7UTF1eRCvaY45O/PP2C2eSMrzCJLaRMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izc0oGsl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izc0oGsl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso49644145e9.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832983; x=1743437783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6eyaywt2xJg14Qfrc4ZcbN2H64wmxNKCBXsxJ0yQrQc=;
        b=izc0oGslCI+jMdl0C+kdiiSwPAEu4LbUYmpCARbUSF1JkD4e9vG5c8503hTOiRRbxb
         gH4j8tU0w/tmCtWLqAecpdXG8hYMAsSw075/Ei9hSxV/R7eNBftyPXBpBMKOMtpMM504
         LrplNFwJ4paMTnM3tCqBKhZj7Fue17Y6Ucb7JuXyGuqP2mr3Kz8FIgmziRBv9Eal/jYC
         blYdvEEkNP7BhcLHpkDjSRHxWe21AfjrYQa/fUaOnyb7KyyJAKrFq1jRDjRxAcCq2+1l
         Cr0Xj9/jGmuEjQqtepn2Ut5Wrp6PSTktt76ERJ0yDNxPZBNG3R7TQ4FvieBzwAeLQKZT
         a4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832983; x=1743437783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eyaywt2xJg14Qfrc4ZcbN2H64wmxNKCBXsxJ0yQrQc=;
        b=rp2gWCqb4fBMLSM+niZEPoQp5tZTQXc7TOB0VP0JivUbnCjTswrfGV0hiW9mswvk/Y
         NBHFzQOMSHUSPHkV7sroZc5f5wlLXyedys0gLgICEPBV0TVf5MNjjqiTxB7nOpzc+mwz
         Surxn9odBbwXRJHdEiVcEWMer0Q0VEvPy1SqSKMi3/eDC31l+6RugOsJBdhiqELNBDnG
         z03sjKRTpfFxXyumtV9JwMwCSfgr6l2AlcJGGomoEFCKPXwPUmA5u25xNHNKqk9yLpbK
         eF2bG5U46w+++Jhqmy1bHWVWdsGAFuUxE7rDlNWvvd2TLcN8gdmRWzeKP+U7nZNAtPBX
         IsOw==
X-Forwarded-Encrypted: i=1; AJvYcCVajhCcchCeER5vgufGYfj2/3c3BksW/oQUVSkAWGzjm5hrn19OXctvMii2/JvVnAxOWiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xZ3hIOKnbEBDsP9nN3440KDhn7yo0s8vkvV0jHxFVDXcMAmB
	8WJffpG2J1sYMAC10aOXh/VWchSIS280gS+Se4gwULigm0hnjpZH
X-Gm-Gg: ASbGncsbT+epillppEBrRlxCOu3UWOkmKxZmcZ/KM4sWcvSH8akQKURtC71kuBzIGjg
	lMl4qVsAPiXi2PIjEz7saGTcPvMRrbEt1vb+WB4Sg/sC7csPFhet8E4FBIpoDOz1fly8og4dDH6
	Bn1DierudgY3QX4bl/cqwu7m7LVyDF484u/oAjDaAJ4hf08qXsE83wCel2RD+CDV6+MiSe2NmrY
	rrKkhGR+iThkLPdik8fdZxM6n81Z6TGAEGG1WF0KO8s6qOUOZnPOUTZ6xTkv9+iwhicLt/pQenW
	KXq+1mk7ZqtQZVkVmJjLhrewUv8ZtKu+Dh9W/0BzXkTZYMzW+iI9+OBLsGxhFvI4daUQbPVOAhL
	4tfn7+nh5vvASFS5nUCZu
X-Google-Smtp-Source: AGHT+IF6h3Km3sykbcOPA0B1OKPKaa4MC/qSLenX6bfmNVcpxACoRQ3VLby7TJDbBLIfyg1tB5/JXA==
X-Received: by 2002:a05:600c:4e42:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-43d50a1cfb6mr107188815e9.24.1742832982992;
        Mon, 24 Mar 2025 09:16:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef23esm11282247f8f.81.2025.03.24.09.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:16:22 -0700 (PDT)
Message-ID: <80c2e84e-6603-4e96-8934-8219c55d4d36@gmail.com>
Date: Mon, 24 Mar 2025 16:16:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 13/20] t: refactor tests depending on Perl for textconv
 scripts
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrick

On 20/03/2025 09:35, Patrick Steinhardt wrote:
> We have a couple of tests that depend on Perl for textconv scripts.
> Refactor these tests to instead be implemented via shell utilities so
> that we can drop a couple of PERL_TEST_HELPERS prerequisites.
> 
> Note that not all of the conversions are a one-to-one equivalent to the
> previous textconv scripts. But that's not really needed in the first
> place: we only care that the textconv script does something, and that
> can be verified trivially without having a full-blown invocation of
> hexdump. So at times, the implementation of the textconv scripts is
> reduced to their bare minimum.
 > > -cat >hexdump <<'EOF'
> -#!/bin/sh
> -"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> -EOF
> -chmod +x hexdump
> -
>   test_expect_success 'setup binary file with history' '
> +	write_script hexdump <<-\EOF &&
> +	tr "\000\001" "01" <"$1"
I guess it is fine just to handle the characters we expect at the moment 
(is that what the second paragraph of the commit message is referring 
to?), but the script it was more tolerant of future changes to the test 
data. We could always just use 'test-tool hexdump' here like the tests 
below but it is probably not worth a re-roll on its own.

Overall this series looks like a useful improvement.

Thanks

Phillip

> +	EOF
>   	test_commit --printf one file "\\0\\n" &&
>   	test_commit --printf --append two file "\\01\\n"
>   '
> diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
> index cbe50b15772..15e012ccc7c 100755
> --- a/t/t4031-diff-rewrite-binary.sh
> +++ b/t/t4031-diff-rewrite-binary.sh
> @@ -57,24 +57,19 @@ test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
>   	grep " rewrite file" diff
>   '
>   
> -{
> -	echo "#!$SHELL_PATH"
> -	cat <<'EOF'
> -"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> -EOF
> -} >dump
> -chmod +x dump
> -
>   test_expect_success 'setup textconv' '
> +	write_script dump <<-\EOF &&
> +	test-tool hexdump <"$1"
> +	EOF
>   	echo file diff=foo >.gitattributes &&
>   	git config diff.foo.textconv "\"$(pwd)\""/dump
>   '
>   
> -test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
> +test_expect_success 'rewrite diff respects textconv' '
>   	git diff -B >diff &&
> -	grep "dissimilarity index" diff &&
> -	grep "^-61" diff &&
> -	grep "^-0" diff
> +	test_grep "dissimilarity index" diff &&
> +	test_grep "^-3d 0a 00" diff &&
> +	test_grep "^+3d 0a 01" diff
>   '
>   
>   test_done
> diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
> index b2730d200c8..3bd91da9707 100755
> --- a/t/t7815-grep-binary.sh
> +++ b/t/t7815-grep-binary.sh
> @@ -4,12 +4,6 @@ test_description='git grep in binary files'
>   
>   . ./test-lib.sh
>   
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all='skipping grep binary tests; Perl not available'
> -	test_done
> -fi
> -
>   test_expect_success 'setup' "
>   	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
>   	git add a &&
> @@ -120,13 +114,10 @@ test_expect_success 'grep respects not-binary diff attribute' '
>   	test_cmp expect actual
>   '
>   
> -cat >nul_to_q_textconv <<'EOF'
> -#!/bin/sh
> -"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
> -EOF
> -chmod +x nul_to_q_textconv
> -
>   test_expect_success 'setup textconv filters' '
> +	write_script nul_to_q_textconv <<-\EOF &&
> +	tr "\000" "Q" <"$1"
> +	EOF
>   	echo a diff=foo >.gitattributes &&
>   	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
>   '
> 

