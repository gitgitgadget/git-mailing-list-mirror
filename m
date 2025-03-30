Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87417A2FA
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329520; cv=none; b=Mezn+RQyFHi2g7xGdBcM+hJUu67TaKzTGcyKF0UbxI1FqH1QbJw8kUntsrSSFv9OzY5CX2Qrq7q7jIhUYDPetLw8N6q4IsLOwhRKgDCe/44akV94q+SmHOoOX5HuoY7w6oe1ZyUCK02r3EM2V7MIqhAAJbMPda/iJBU+vLfucs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329520; c=relaxed/simple;
	bh=yyMqt+qnkAs+J01ujPtldTgeFK5rCh89cZP2NMNYQws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QqxgNXLDUlL5wUKl/sBPgi0irapeaYyo6e9OuzJ3dDlN/mODlvFe+3ORkA1l6Ddpm6eFxyo2gO7+5Ft4RwCpoUEX3lpd+tNOUSOKrE/QP9d1/fuEpj3eciBQQWjr5pinK16Q/tFqtxH/Q9iMuOahJuDljZzd7TwRcUpHw9I6af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxDQSvoh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxDQSvoh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so18780005e9.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743329517; x=1743934317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m49LXx7Oe037ZfV31oqLOywJYy1G3XQMytNdLtX8k+E=;
        b=dxDQSvohQjTVc2omiFbkVAcq7qBLX+Xw+KL1ltAWPq63bWBKvOyCA0byJL2MDlFKyB
         PoFxVuuuKjg8+kqSPtQ1WHpCIASOSNuffiy3lPAhc+XBP7pFLb5fdt36COU6kIn7Ny7R
         Ewj/lwpkRiizdBTAyETEnwf8WEyYDWhk2n3vsqUzl51zA6pyS+EPH2EziWSifkEcoPlp
         gDKN9dRzEAbGKkM8jTkHZTTRcB8nc8Ka1c7PXbG2b30hXihLkKeOs+YgJGDF76d0bFsF
         FV1FQtn+/x5jmiNchzDYhw44syv+A0QYXeLm8ECj636hgwyLsSKjDWEuQmS9jsWuvSXF
         kvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329517; x=1743934317;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m49LXx7Oe037ZfV31oqLOywJYy1G3XQMytNdLtX8k+E=;
        b=JQhCNmMehuL83acV7FEzeDUtPSN1UZDoZ3aX7qJfK6EHCcbdYK+Jkn3HHFvpbQ0YTv
         n5XJXYrc9z9CcqaVovGs+l1XLeemkjJtR/0jvq80NkjkGUGUQ2M+WTnO+pgS1bKplaV5
         sqLVadHK4brct7QNPPKQiuVLSisB1JLBGD0uqUrEiqMRLh3klBPYAMoCquJZNp/LRlWJ
         Ui0rpU8GxIFNmxruxuljMHYcjBU3m1Tuc/jryOKOXzQjeFjE+Wavh12GUqE1GXun/l37
         hyOGmcTzLkBcCrbuv+MQdCDOjN/5OHifssHFnOrlkznVFclEOrxZ00ArLewDO26JVuTa
         oaiw==
X-Forwarded-Encrypted: i=1; AJvYcCV0QnoyzhGdWypJS8m9NUNCajaigdyTtVXqa47RS3Z5qwdwPt12DgA9MBGHERhsW++pBj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxloj1SLTvkSNctEWQAdxmd/dbmHjTluIAJ0/8P9mh99H/nDuiE
	C3szcvl1QBew73ACTRxwRUa5PekExBRGIKz/xzSzu2NVOXC7NJSWwV2Dhw==
X-Gm-Gg: ASbGncu0+AWvJhbWaF9as78u5CtGUIiLSlpLnBYzuBQ1x3fLZI9MK8vub9SgtH+cPct
	L3uzmNR7dsrQqGuTux7hXtSx+ILMrYbABksDd6d60nyyGCJQ6HVzOvcK0Diw/WgLjbdbaYcB9mH
	H83PSo+YaA+Bu49j1VKEHbKLxegiykl+0L0o0q0Jrm/6hmxpPfFVWiaiG8bssMJKOnGzvSi82nP
	ncAbJy41eKZIfCEkU6FfOmeI4IU3uAu2tp2Us1W0N00Jed607aLCuoUSZP7XpTOliAPsoOz+BdA
	cnnV85bASKuAhBIBTgPTzaZMwq0taWS5VARTQKk+B6R7VPz+ykGNIeDIcOSnikIQrASe6LE3Tow
	uJWjnPFh4sQVBGvZaakhC
X-Google-Smtp-Source: AGHT+IHYHOfEXyk3LdwNMJxY255zq+Qjv9x9TUsVtHU1pxY0p3pIKgzvCmAWqxqRev8Vah6WLbTObA==
X-Received: by 2002:a05:600c:4fce:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43db6247a29mr51894645e9.14.1743329516766;
        Sun, 30 Mar 2025 03:11:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d91429c36sm59724845e9.0.2025.03.30.03.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 03:11:55 -0700 (PDT)
Message-ID: <f8a7d089-3150-4212-8ad0-c9bbb3858776@gmail.com>
Date: Sun, 30 Mar 2025 11:11:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revision: fix --left/right-only use with unrelated
 histories
To: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
References: <20250330055809.1019090-1-m@lfurio.us>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250330055809.1019090-1-m@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

On 30/03/2025 06:49, Matt Hunter wrote:
> +test_expect_success 'rev-list one-sided unrelated symmetric diff' '
> +	test_tick &&
> +	git commit --allow-empty -m xyz &&
> +	git branch cmp &&
> +	git rebase --force-rebase --root &&
> +
> +	git rev-list --left-only  HEAD...cmp >head &&
> +	git rev-list --right-only HEAD...cmp >cmp  &&
> +
> +	test $(comm -12 <(sort head) <(sort cmp) | wc -l) = "0"

Thank you for adding a test. We have a helper function test_line_count 
which provides a helpful debugging message if the comparison fails. 
Using that and avoiding process substitutions we'd write

	sort head >sorted_head &&
	sort cmp >sorted_cmp &&
	comm -12 sorted_head sorted_cmp >actual &&
	test_line_count = 0 actual

Thanks

Phillip

> +
>   test_done
> 
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e

