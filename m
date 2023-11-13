Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C9224C3
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpHJiiOq"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CEFD59
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:02:15 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso56406371fa.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699894934; x=1700499734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e4hmbbPTJAMTmyNmijOuKWLletO76t5U1TF4ppkHg1w=;
        b=QpHJiiOqcLvmDIITENtvhVlaRLSyeK7w8p8Rt3pWYZ9uzjSjOZtXSGnhCITrFpj1b9
         3cksIr8yLlB8xXp0rDLtUcxYDOQactJphQPgVEeo2ufHvCmU8U+tOea5Ok9Zw5nIY3ch
         PnAKBB3NvAtl5IBAI/en+8WJcpn56dbY56KtAThZoe7tx1h6snwIcakbldyoXnvRi9G+
         R6c0Tdt9U4rvxIN4JJ+35YO/sItbcnUuD73GmJ9YEUMdlB3c7/pLYihAx3zu0MXaxpTB
         OxZwz3+XriUwMNo+70mhByEhRKdBsrXgu7rTWMPXI19fNl6vfHK1OEOJTiBTkcivZTap
         BcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894934; x=1700499734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4hmbbPTJAMTmyNmijOuKWLletO76t5U1TF4ppkHg1w=;
        b=ttmFSrv1BZLzeWP1U1E4IpsifTQpux7HZrR5yRSEQUeA7/Wb8n/tUN5jvYG3sUhbPR
         xsI9lYSrD9yJAiDRGc1OllGb1Jb+xuu2thQA0KMJKKNVtUwtf8PgKFtwDuvTDwFUvISj
         NG44yZVvJ+IrtH/4052UvWSfPoA84WWEUHeFAjZOxWUYG6KMfFZbACmDARZc2wqKbwcE
         kkDY/8KPnSKVq7xB/EcPyOh/xiI/+4wNqvWkhuSw/lVJwxql75BKMp1LMJmScWKZ1t1V
         tuDtZXqFaJGyILrw/lOPTL9z9WIIwpoWw68Ki6XUhNgPyNvOo0Z3jIJSg93bxPUIrtrP
         syZQ==
X-Gm-Message-State: AOJu0Yz7BDFyCO472PpZa1RroMxMvh3e+ravDTWEb/LtsTzq+iU4Hbx/
	m6QItizU6IaIklETkxwDWHGSMtKzFm4=
X-Google-Smtp-Source: AGHT+IHa2FSNpl8awgtMYtiyJNb/13fQXwJS3Wsxmta90mQIqC8NpfXK4n7e4zoBbeUYqh7Us8jXFw==
X-Received: by 2002:a2e:9b42:0:b0:2c6:ede0:9371 with SMTP id o2-20020a2e9b42000000b002c6ede09371mr5631965ljj.19.1699894933729;
        Mon, 13 Nov 2023 09:02:13 -0800 (PST)
Received: from [192.168.1.101] ([84.64.93.134])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b004077219aed5sm14543234wms.6.2023.11.13.09.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:02:13 -0800 (PST)
Message-ID: <93f5b051-1449-475e-8b7a-a145485eee4f@gmail.com>
Date: Mon, 13 Nov 2023 17:02:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/4] rebase: test autosquash with and without -i
Content-Language: en-US
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231111132720.78877-4-andy.koppe@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231111132720.78877-4-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2023 13:27, Andy Koppe wrote:
> Amend t3415-rebase-autosquash.sh to test the --autosquash option and
> rebase.autoSquash config with and without -i.

Thanks for adding these tests. I'd be happy to see this squashed into 
the previous commit, though that is probably not worth a re-roll on its own.

Best Wishes

Phillip

> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>   t/t3415-rebase-autosquash.sh | 38 ++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index a364530d76..fcc40d6fe1 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -43,7 +43,7 @@ test_auto_fixup () {
>   
>   	git tag $1 &&
>   	test_tick &&
> -	git rebase $2 -i HEAD^^^ &&
> +	git rebase $2 HEAD^^^ &&
>   	git log --oneline >actual &&
>   	if test -n "$no_squash"
>   	then
> @@ -61,15 +61,24 @@ test_auto_fixup () {
>   }
>   
>   test_expect_success 'auto fixup (option)' '
> -	test_auto_fixup final-fixup-option --autosquash
> +	test_auto_fixup fixup-option --autosquash &&
> +	test_auto_fixup fixup-option-i "--autosquash -i"
>   '
>   
> -test_expect_success 'auto fixup (config)' '
> +test_expect_success 'auto fixup (config true)' '
>   	git config rebase.autosquash true &&
> -	test_auto_fixup final-fixup-config-true &&
> +	test_auto_fixup ! fixup-config-true &&
> +	test_auto_fixup fixup-config-true-i -i &&
>   	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
> +	test_auto_fixup ! fixup-config-true-i-no "-i --no-autosquash"
> +'
> +
> +test_expect_success 'auto fixup (config false)' '
>   	git config rebase.autosquash false &&
> -	test_auto_fixup ! final-fixup-config-false
> +	test_auto_fixup ! fixup-config-false &&
> +	test_auto_fixup ! fixup-config-false-i -i &&
> +	test_auto_fixup fixup-config-false-yes --autosquash &&
> +	test_auto_fixup fixup-config-false-i-yes "-i --autosquash"
>   '
>   
>   test_auto_squash () {
> @@ -87,7 +96,7 @@ test_auto_squash () {
>   	git commit -m "squash! first" -m "extra para for first" &&
>   	git tag $1 &&
>   	test_tick &&
> -	git rebase $2 -i HEAD^^^ &&
> +	git rebase $2 HEAD^^^ &&
>   	git log --oneline >actual &&
>   	if test -n "$no_squash"
>   	then
> @@ -105,15 +114,24 @@ test_auto_squash () {
>   }
>   
>   test_expect_success 'auto squash (option)' '
> -	test_auto_squash final-squash --autosquash
> +	test_auto_squash squash-option --autosquash &&
> +	test_auto_squash squash-option-i "--autosquash -i"
>   '
>   
> -test_expect_success 'auto squash (config)' '
> +test_expect_success 'auto squash (config true)' '
>   	git config rebase.autosquash true &&
> -	test_auto_squash final-squash-config-true &&
> +	test_auto_squash ! squash-config-true &&
> +	test_auto_squash squash-config-true-i -i &&
>   	test_auto_squash ! squash-config-true-no --no-autosquash &&
> +	test_auto_squash ! squash-config-true-i-no "-i --no-autosquash"
> +'
> +
> +test_expect_success 'auto squash (config false)' '
>   	git config rebase.autosquash false &&
> -	test_auto_squash ! final-squash-config-false
> +	test_auto_squash ! squash-config-false &&
> +	test_auto_squash ! squash-config-false-i -i &&
> +	test_auto_squash squash-config-false-yes --autosquash &&
> +	test_auto_squash squash-config-false-i-yes "-i --autosquash"
>   '
>   
>   test_expect_success 'misspelled auto squash' '

