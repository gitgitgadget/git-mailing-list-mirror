Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E73161A3
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474898; cv=none; b=nvRfMr234S5lKngRFXpSwt61Zv+Tz9dQZbsq2FBZ71wzDW3HQRdqCiBTf1NksuDyS9EFB7+FlteExc8fdQpSUkOoADSB6CrkDUIWzq6SqIKCZgV+Kp4SliOCGN/HZ9vlFdye5sVMag8b6aUHF9H2hssBDn4SMzwpatBNDYxjjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474898; c=relaxed/simple;
	bh=7Z8xMe9V/DW0ZAti+1aKXQNjVkzTAy/bWxD6xvXpAi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqT9wGbg1SFvWv8L4nHPYnU9HjYYKr4JfINfJEOJVK9gcc6h8QPDLArL1iYsCK4inmekF8t63ognnmicipH0d/xYQRxIWbAvcX33rXQOlHpiertm+U1ktfm9k5SsrCI1uKv5lOPStyuMtfaFgmhIrlLw48oa/2e2U2yiEvugeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6snuhdM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6snuhdM"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso6220855ad.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772474897; x=1773079697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqE+Q38IRcWkBReYBUyxzHIU3qh0/GK4C60CwGdzE2c=;
        b=J6snuhdMKLNi+Zf5ZSFii30IhOti8KiY17hENB1UQShYonpll8LMTSfRT1in4VbLir
         30VjUMcP+e2wWToK4uHQagQM+Tv9BjC/O8v+VA7owVKe6vwZB+yvbL5QFyS0dwc3ufPA
         zEY3VbASjr7cBtPddHb5PUXaVONbM3a/XgUAmCt/+kEVpjGZb1hrVFigjeh9K3hKW4lG
         H0k8yftaYB+rL1j+LIHeh/eqS/eeLWdBppZhfan8lcPwAFz9qiYH2+O6URvwxaawi7JO
         NYJmkqlWjZ++GCaVSWvfX1qDbiDhRKMRM5H4DVhncM4WuURxszglh8i2r8HhUl5hVzaw
         BavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474897; x=1773079697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqE+Q38IRcWkBReYBUyxzHIU3qh0/GK4C60CwGdzE2c=;
        b=p+oO+rEezppClAZlERtbF0js0cSK9R/OOEOoe6I/2MmUMopKn9KX1XzuNYFT+3C7qZ
         Eulo1jj+ftg9L9Nh57iP/dtr/NK8slXcA3EO+yXudZaGAcauP2P8smcEHW9vSWx/xBwH
         8FcquFqJUHf3FY/An/s5DruqPIOgjlnNxq5ZaEDAaOaPKgCs6qI4lyAWTogEJZfXwWOp
         lmHCU/DZmPlmErh2jYXfcQpWuNZ4rLGEhHI4nSBF7CrhCbCgEHh3zFCu+lu2V1CsXxJm
         OO9ZVuPx1rSdanYbKlnJGbVIdgSytNoWf/julQ1UZga5LJnmJ3cUJ2dXajRYvuLTUK1K
         DOuw==
X-Forwarded-Encrypted: i=1; AJvYcCUy4SK2GKEmdfgsf6jv3yAlBDnnJhTaUi8vepdQbAof8If3Qf2XTovQ9W83dEIOEQJ41LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvKjKpQn71NmHMuRIgXarfzyzwXAzcwsYZgIMJoq2HJ69Vtgu
	cVwUtpvbtfO/zpYIWz9tHh6jQRW+Vp66kBzQFsXgPVqfzDMcg3mb7luA
X-Gm-Gg: ATEYQzwFdQjQqkOC6TJ4JOUmL/uTSmeV2vACPVW4nyfT4re5vKF14lN5d7N0iO0t/kp
	65mhg2r7Cd7QwikxouK4kQrDPIr7Obr8KKOaGFrbgkRrcaDi0W6GimFzjozSevZpsrP9VjOeBOc
	EySyAOBf/NDaaeK7swwbsSn4L+jK9JgRolU8jBDCFF5n+IuiGXbJXE4pMhgCqujDMkQkqJ/xidi
	gGTw3/Q8/5gq0N1ZabR5NyYhBUY47qY0S/+Uniar2RcPIPIIr0UrEwkqtWuMHHRCirSqAucQlhm
	AGIUbHM331hNubmnET+78Q3fGtlp2F7ztvwDNvymRMAyY8VrY88/mPYiR0R1Rgqff4/It7l+4qT
	SkfSW9tVM0eI6bDDI9rtpfjeWuKRUzhmUBR3JF7mV33+MKd/AH5rdJHgzN8Q8QZftku0AyZ7ZD+
	LOiw5biTQvrRLzBRT8XaIxE1BHpV5MNYHdhDrMEuoZyx2OJz/XG61RBbuHIPDDTfTvEYIGiIKhX
	bJx8iQ=
X-Received: by 2002:a17:902:e806:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2ae5a704bf1mr23143375ad.15.1772474896351;
        Mon, 02 Mar 2026 10:08:16 -0800 (PST)
Received: from ?IPV6:2401:4900:6336:2198:13bf:d9bb:7f7:8dd3? ([2401:4900:6336:2198:13bf:d9bb:7f7:8dd3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4802645bsm56023595ad.12.2026.03.02.10.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:08:15 -0800 (PST)
Message-ID: <96d93ef3-7843-4be7-925e-202888670373@gmail.com>
Date: Mon, 2 Mar 2026 23:38:10 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
To: Junio C Hamano <gitster@pobox.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: SoutrikDas <valusoutrik@gmail.com>, ayu.chandekar@gmail.com,
 christian.couder@gmail.com, git@vger.kernel.org, jltobler@gmail.com,
 karthik.188@gmail.com, siddharthasthana31@gmail.com
References: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
 <20260226201643.5152-1-valusoutrik@gmail.com>
 <BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com> <xmqqtsv3uoc4.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqtsv3uoc4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

On 27/02/26 04:03, Junio C Hamano wrote:
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> Is https://git.github.io/SoC-2026-Microprojects/ the latest?  The
> above URL points at one a few years old.
> 
> Anyway, this list however might want a bit of updating.
> 
>   * I personally feel that "run_command*() to internal call" is way
>     too involved for a microproject.  All the low-hanging frutis have
>     already been picked in this area, I think.  That is why this does
>     not appear in the list of microproject ideas in more recent
>     years.
> 
>   * People seem to be finding more instances of "test -X" to replace
>     with test_path_is_* helpers, so that would be fine to keep for
>     now.
> 
>   * Ditto for "do not place git upstream of a pipe".
> 
>   * "Do not use signed int for collection of flag bits" may have
>     outlived its usefulness, as it seems we are pushing more and more
>     uses of enum for collection of flag bits.
> 

Thank you for your suggestions. We've tried to tweak the micro-project
page to remove the stale ones.

   https://git.github.io/SoC-2026-Microprojects/

Feel free to let us know if you have any further suggestions.

--
Sivaraam

