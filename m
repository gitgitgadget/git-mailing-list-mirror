Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343741;
	b=CXk87mT7g9zDAcq6xkXXg0pGaKz5VeqIA6kGSTlpYzcTjEHDFjwIlzxk0HYxVYXDG/7M
	 nO6JC2a+PZYZTRiaUD5bD4kHzqUJ/zmgRbJoggstUQ2CH5pGG4hgxg6zwK7VQtCg3OnPv
	 FSXwdQWOWNaJ/AQowq448A3mcnyXTpFsRR54ft2r5QTLPCAkoeEzafgQltUO9aG4ZbXEp
	 UbVMN0pIlMrNExBp0y55HMO1EHrjV0ZnxygnvrG/7a20Jz9b8nZS3T7vBMkn1TZqpVsy8
	 /Q43eJdNiLujc6Wi91rAcRfgmSHvuI01e/OXQL/xUTCCSseOg8PQo39KFrhTdbKfDKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NLXcUy8jhrDy+jq6jbm2+QnuWgqluv92y0lD+VZWF7E=;
	b=eB2Z/K/1p2nVX35Q8i4bNjS6zmHKRMULX/aLf8qVO0ERz1omPHT6bWkB3rB+63io8H/d
	 jvWCL221E2aZPCWvLEhousnCZiNVTsxrZ/Z4vJLqOPcEF47++wyfDgHrQeGoschmqbJTL
	 EgJLy0K0P4+er618w/cqD3BprMj5OxDojtd/A8hz0s/6OpA88EjhHxk70YZmSw8DcdiWO
	 dnIMRux3ED35hAllbGN9cgyBu8ZzonQfg5f28aGkwgbZeGKz1/NXTDKrMvOTslOtbsaGX
	 VnCyeCu7dmO2BvZIF0xugm8CU2nv1K1M7zhUG5eQYOCESGmYlNwuFMEwNQoWGoQVOYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElXSz5Tb;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5511606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5511606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElXSz5Tb
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-945ae2daa68so303374785a.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794343740; x=1794948540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLXcUy8jhrDy+jq6jbm2+QnuWgqluv92y0lD+VZWF7E=;
        b=ElXSz5TbEneOEdijz8upj/UO0yUctrhEBReAY7GuGwEqQO3jmMt5doG7vvk+KY1kdC
         vFVZNHdoH3e96d8uUYPI/cVuon1F1HyllxZ1OVRfGrhznIifWX1h5CBCv2OB/T8775Z0
         JLqwaE9HvSPWffnnox5xhxEy5PcOzrDWs11dWwnnVpjFWtFHUXh7UwsbqOqcR8rlNPOu
         MxVeeGg0qj53AtxCFesIQ/o5ZABU+jy6FtD9O2rUgs9DIj+LKvK6cjjdFPNkN+cH0hnl
         4cAGJQNfPny+IlQSa/jHdG08NKx1+W626KuIapjO9AbjOx6pMnlZ16THgsHgOJr+Zz+o
         X9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343740; x=1794948540;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NLXcUy8jhrDy+jq6jbm2+QnuWgqluv92y0lD+VZWF7E=;
        b=UoEtb60H4o6fANvugQVxM97JjUkoE7FSyJASEFDhtJ5WmBak9KVSj+EbBA813N4IW3
         Dn21msThRvNu0smeJkILP7Abx3X+lg8rpzzLNkLHfp0fvnk59DlkBSPZwGvBtGYVH73y
         vFRGu/cHhyg4ESzAViG8KDNI+80uOpMNTrxoqnEZd6dv9Kf8H3yzt2mCz2R/YTI2Ju1V
         j4N5pUAq85paiOfKEHMNdakC4gJY34L9ftT9excrlQNt7pImiRfobQ++kvhwm+WNSN85
         WQCwRGOUmaxjUG309GXwyFH3rf2qr3a0h+77wIhYYKczDrgKxCI9ZTzDlyEveHG4kW1T
         g0Zg==
X-Forwarded-Encrypted: i=1; AL+hErEGfHRreYRxGm94xUtoHjF9N8trAomn5ayw7G9oL5mCTmMZTlm8jbvlRbQQyhp9bOZVrvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zBGL9hoEH+kfiT/F53Thc1EKaO2D6zcWIzBIgP43OcnY38mpA
	LyEb0gwqJ8JNKMUwTG6aZ9u77bhaNMT0J0fH8KFKOsx+78VxiBWmoMlm
X-Gm-Gg: AYBFou24ulY/Lcd3Xj2LCKbGVnJl2DQV10TkEr96w6utPGt1noN584kR9f8FnjMk9WL
	ChwYJ234Z8rbMacinVeSlshhapPCJXZ7jmKYgnkJq+nO8BsrYGrP2WEhiOA6JZB1k0+CvYH9TEk
	dngM16DoWnBCGb9rN3eUmj4YoonuQRX7d2M9q94wVMfo+j3TF6p8mG4mmQvNlnGcfLxbE1yRS/S
	NqZQypJS3/rsE7yweNeAT8KtrnXJygbipxnZ4CMYx8SaNfmYTX7eDQWah7acXaR06dpukSTiv7u
	hBV2uQOlF6N4sEZ8lf2SJKPCMHL+zB4XcWV9VYGZ2x3LvVwISSKFqn0H+eBt5zV4Dd8haoanDKo
	fJNw7ICmX/wI7nB7TffFw2/ut6tUpoSEVcFZos3tKLH6D7LyI9/vE4LTlTdcYTrQMxT6mHpmHxS
	WN+IAxuFOAGcUr8IYt2Ips0QsbLA+BwQjm4V/s6ze+Djm9ahmcrNgqC5mZDSl3UbSrXOu2A/B3P
	OVmttVX/VDlugtZXeWsBRZINcF9VMiLdoO/iGYFGgBqvs3wTGOQ8bqmBBvSLL+J+DJDsG9s8k/M
	PrPconkme0rusiE/EpyndBTxcs9+RDmomcFcMWKh6/l0QKYgdiHZ5u/++/twK2PoUuiO924vgod
	RumU736SLv1kt9vSuxStrD6RY9wr9CzKGte+r/WHtTbGy3inzAtrHBMBPb61F/QIgPfrOr+YsHI
	9m/VKc0aYELPi44vb+xU0BvLtjxZVNE7OsO9WBjqu58WeReO08JPCTjEmuWu1Azh6ut6Fp/FIw2
	n+R
X-Received: by 2002:a05:620a:4155:b0:93e:6e6a:b686 with SMTP id af79cd13be357-947ae88a464mr107895385a.29.1794343739830;
        Tue, 10 Nov 2026 12:48:59 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7d10c4sm308779285a.32.2026.11.10.12.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 12:48:59 -0800 (PST)
Message-ID: <90f09054-9013-46f6-b4de-9be88d1f3126@gmail.com>
Date: Tue, 10 Nov 2026 15:48:58 -0500
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
Subject: Re: [PATCH 2/3] checkout: advise when orphaned commit checks are slow
To: Wyatt Holden via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, wyattj.holden@gmail.com,
 Wyatt Holden <wyattholden@microsoft.com>
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
 <a9b81eb87684fa9bfbc83e845eb67ded8d7cb6d9.1794337920.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a9b81eb87684fa9bfbc83e845eb67ded8d7cb6d9.1794337920.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 2:11 PM, Wyatt Holden via GitGitGadget wrote:

>  	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
> +	[ADVICE_CHECKOUT_ORPHANED_COMMIT_WARNING]		= { "checkoutOrphanedCommitWarning" },
>  	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },

It looks like we have a slight whitespace alignment problem here.

Thanks,
-Stolee

