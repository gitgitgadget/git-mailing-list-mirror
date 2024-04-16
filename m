Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B585948
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260498; cv=none; b=g+oijIMiXKaPLuuiQ5DVH4yojOlf5KfULXpNXWxf4UfATTeKbWX3yua296rkanB+I1UCY0DZVRNzL2Wt0YO7RbnaH+5DxSc5HcSOEhJYHjYIRENXD8SQuJAZMp8V0JSJhL1EOQuw2kjnpqTGljCjxvv1JMzt1lto1/YoKWub9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260498; c=relaxed/simple;
	bh=4GA5i9fEt+TDwMPD5xPEBLp9AqO6NuQUW3INVWS8B1Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=PipiFA7nBaCxO9TcYkBbSOcMnDQr9AAwS3jhIWJTe9W02WLqTIeCEyrz3Frj1naNZyhqMAmmZAucSV+MChzCX2EcPUIXaOs6FbGpjyPMM/kfGYV6mmmG+mManGbGsBRHgrxr9/KpJ1JXXMVng45dLdBB5m8PAlh9uBLU+Me7vKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOMbzVL0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOMbzVL0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41890fd335fso3113655e9.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713260495; x=1713865295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QhWcL3wCfb2RGqmNZHeY7ZSCZ6vNNk3N3WhKVSiTVY4=;
        b=hOMbzVL0rY23bTH87NL4Wf50l+yrl4+hp1lGaB3gw37Ruenaxj4VyTg1VnRKgf854z
         Hr7+oWGKagzgYJnDD49zmSdzJ6goNFfOc1Iw6/XANxkWsR/a5rNUCfJcnd4qGkgTz/XB
         gNUxIwDYJX7+VIFweZTckMB+IeQQyLoZWEEv1h8SNFz1QDgwA0DQ+3hVKnmBJg4cpU7b
         R+gnSlgEdzn8qm/V7nubMF0FRdGgG11HgqRs+wxkRFGj4ZakbqqZgKr6GgVmPwwYDzdV
         GWVFvHp3N1AG0wrF3po5e5dCFDbaKI/A5kA2llFueZ90PNY1yK/t9Lnu6/D10yDD3Pie
         9Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260495; x=1713865295;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhWcL3wCfb2RGqmNZHeY7ZSCZ6vNNk3N3WhKVSiTVY4=;
        b=F6jSgrbZLyCrO3cPvqPpRtzsO6XG3k+eEoOPRQUGJDFXJKfqHeyjzOp30mdL2DyRJG
         2SbIDHs1S/GC1K7NZ2egUM7o3AUk0DXsW7PGT1JTghLSSmd7Bdg6XWKjCvupihMLwQHz
         fKNekQmpr7RselSp+fdCVBa/ic0VrlNT+RLnpuJ6JOHb3wF9MaENWpjtTqjEZbzFw9B0
         lTxYJ43cYU6XxHqkXaPUWm3AQQuX3VzC+2SLzKxzop+gpMjsOGEJzpE/q8BEK5xrZ0cs
         Q5aBUBpozR0XkHt78f1+gyvgb4o2+fLE18T6e9iJYNnIl/RSHsj1NwyopCylSkl+vtdn
         +zfw==
X-Forwarded-Encrypted: i=1; AJvYcCXb5S4H9bnaLG25nxpb6PtXkdP6LqiqGOL+BthK4ikvweI/Vrr5towKYR+ymWNc68LIyDM3sQPuUzKeKDezclGqs5eO
X-Gm-Message-State: AOJu0YwAowiY+S88/uCeSiJe9x4gIV6nzbhEVw9ZOo8QyfT7dlyUGCHS
	TZ7cDxKkqtgya29W+rb+hO9bVA5bidQtTmq7TLuEIvwWnCZzBHd8HBJdeA==
X-Google-Smtp-Source: AGHT+IFOwijCaM9Gwcl3EFrATdtD1Qa5ffjmX73njopavLMTNwEZG3lcxkjnwQcds3j1ogJwQ+oHgw==
X-Received: by 2002:a05:600c:3148:b0:418:42d0:15cf with SMTP id h8-20020a05600c314800b0041842d015cfmr4838231wmo.35.1713260495340;
        Tue, 16 Apr 2024 02:41:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b00418631f91c1sm6914458wmb.28.2024.04.16.02.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 02:41:35 -0700 (PDT)
Message-ID: <15f9252c-212f-43eb-84f3-6046fb2fab38@gmail.com>
Date: Tue, 16 Apr 2024 10:41:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: response to invalid option
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

Thanks for working on this, it is a nice follow up to your last series.

On 15/04/2024 20:00, Rubén Justo wrote:
>
> +		} else {
> +			err(s, _("Unknown option '%s' (use '?' for help)"),

As this is an interactive program I think "Unknown key" would be clearer.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index bc55255b0a..b38fd5388a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -61,6 +61,16 @@ test_expect_success 'setup (initial)' '
>   	echo more >>file &&
>   	echo lines >>file
>   '
> +
> +test_expect_success 'invalid option' '
> +	cat >expect <<-EOF &&
> +	Unknown option ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> +	EOF
> +	test_write_lines W |
> +	git -c core.filemode=true add -p 2>actual &&
> +	test_cmp expect actual
> +'

I was confused by this test as "add -p" doesn't seem to be printing
anything apart from the error. That's because it only captures stderr
(quite why an interactive program is writing its some of its output to
stderr and the rest to stdout is another question). I think we want to
capture the whole output otherwise we can't assert that the help isn't
printed. Something like this (which also adds coverage for '?' and 'p')

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bc55255b0a8..0fc7d4b5d89 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1130,4 +1130,26 @@ test_expect_success 'reset -p with unmerged files' '
          test_must_be_empty staged
  '
  
+test_expect_success 'invalid key' '
+        echo changed >file &&
+        test_write_lines æ \? p q | force_color git add -p >actual.colored 2>&1 &&
+        test_decode_color <actual.colored >actual &&
+        force_color git diff >diff.colored &&
+        test_decode_color <diff.colored >diff.decoded &&
+        cat diff.decoded >expect &&
+        cat >>expect <<-EOF &&
+        <BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,e,p,?]? <RESET><BOLD;RED>Unknown key ${SQ}æ${SQ}. Use ${SQ}?${SQ} for help<RESET>
+        <BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,e,p,?]? <RESET><BOLD;RED>y - stage this hunk
+        n - do not stage this hunk
+        q - quit; do not stage this hunk or any of the remaining ones
+        a - stage this hunk and all later hunks in the file
+        d - do not stage this hunk or any of the later hunks in the file
+        <RESET><BOLD;RED>e - manually edit the current hunk<RESET>
+        <BOLD;RED>p - print the current hunk<RESET>
+        <BOLD;RED>? - print help<RESET>
+        <BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,e,p,?]? <RESET>$(sed -n "/@/,\$ p" diff.decoded)
+        <BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,e,p,?]? <RESET>
+        EOF
+        test_cmp expect actual
+'
+
  test_done

Best Wishes

Phillip
