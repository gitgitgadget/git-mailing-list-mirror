Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C982EAE3
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303190; cv=none; b=Bwk1S+JUH/fUla0usu7ECX3mJrmn9I9GPTitKnsFz3TpsD7SPjhZU2IF2q334dcEXalsGV48IvdY2O6TOPxVyQzurD7i2fsxhDNwncCkWXXRgLlGV4kOBdaFJ2mz2ZQ+059W/v2aFI8iAfTQXQRafUjK3SQ3JlXRqOCV+rTXkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303190; c=relaxed/simple;
	bh=PUS1//6kUhGQd1X4Sr5tzPydDnnygfWDyPoL32kLf+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LqZzr/Ala8xDaPTBhScIyT4AKm5GVVGANmTSq8uuOAs0pMj4WMIcFDRKzTrdrF5tlyJaY8bVx5vjNvQpfEoSLdWHAgo9cxEQjz0E/IDn09kQEWfc8BPYMLdyHivgWrYnzz+uZeyKQS+9yGiBw3WW7v+DTixcNDFoJAfzxe7CnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyi75p3T; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyi75p3T"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a522224582so2454138f8f.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751303187; x=1751907987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wa0l2ebJbP/o61H1kCPonqVSxz2WZVRHR37YIDQfy2s=;
        b=fyi75p3TTFPGkUN6VQdlzbshlzrkGsKlDxy4xpIyogdmHefBtH/rnfl5tmqnJKBahK
         pNlvGYpdlpmr/ZyM26FO5Ikdo3CfTxR+C1m2fBLAdgqYMFMzbcM3AZJxKXSRGDvl9Bmo
         iWOnDywlAzTf4AZmZgk5XBt7YgFPX+57AauT1hpLOqrH3NEbGwC4n6RmIOMFL0oBLV2q
         KgGTBAtsEMddQCXXaOH8CnlOfKMzqWh54hY+TIyWu6dSbRRrYG/eWMAcTzA+I74PmcId
         EYAyu2UoAda9wf/Yx5WKz6JW/WL/HKup1ViTb146WGaOmDmG0uwn2r/KIRfbsYxH7bY8
         bX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303187; x=1751907987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wa0l2ebJbP/o61H1kCPonqVSxz2WZVRHR37YIDQfy2s=;
        b=IsaS7N/Mkl3UXyKF1xaXEQcFblWbkgLgC4hiQv9zBWNnY8rU9z7U6DHpXYJGr2Vcua
         qrBaHKac4Wcz0crw+ZV2UmatT1FM5sKWDgvv1r4MzpJkGQHE5w2JheE6cAMEXnAmgq3l
         WDRaEMS58q7V1sbKtnsFH6zOnD7GPcqK/J8XwGZ1YyTV+pGzkhtkUv5N3VK5YryXgagN
         XHpDnunJl9bya6rUP7ZayaCmtXBWfFPYY5r5Yf9FXQVgyzz7/wL6h4Okfgu6txE/Y6FC
         lw+H07QZPhsGeC6Itrv07yH4sI1FTzdGzFCx8svq3DEVGe+ILMOfow3hVA4A151dpkjA
         bxWA==
X-Forwarded-Encrypted: i=1; AJvYcCU7FBjochHr1voXbq3UhwqfG3qchDypwl0Sn8H3Cvto/cBS2H2/z2Fw41bX8y2uw21YxMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZA8il0XU26wbADV6ec9sTMSoGul6ZLzmOJ1lXJvyzY9Wz7F0
	cdCZSjsKRjGG1nAGrsP9eMGDMusNlMzTX/UrFb2Pf3TkeTn+jl1peGGUT6CFQw==
X-Gm-Gg: ASbGncvuAYrEbVxKOhHXTAkBOfJ2nHyWihG+WJYGOttnsQe7MtCetaBv+oZvKkQkNus
	rJ7rIOWlItZ2i8SoCPzN867+ZM7VrEKpVSqERhbY2jVDIXUeClmo/MGJ9TYnuW/5zS/6T39Z9RS
	WkpqWnPfBLDchVZyby9I6C2mx2G2HaR76NVSUJ5snZ0MYSMY5kB256jGgtbTou9/wNzAmsu5Gsh
	rgksTH194bd4x7w04G8PjnVY35HTSVlG1+4xhLXaJleGP7/OGvMgMML8BQoXIOaT51nZOZnDq+M
	QaHKqgJ85WPxKfupOfWpues7+ro5Pwa6V8tYJlqtqwdmpT9nrvCR2+SANeQbbGaSH0D5pefT4C3
	0WZV21HhRMOlexWAE6jmiNpv8zR4DZbgYG74rz6jnM7dNlbU=
X-Google-Smtp-Source: AGHT+IHvjH5S5sZopuv3VK8PxlnEWjpOl6kAnzMWOMQNFBDmLgV23tNNhIeUGE7+DrStR5uBUs1SYg==
X-Received: by 2002:a05:6000:2b05:b0:3a5:1410:71c0 with SMTP id ffacd0b85a97d-3a8ffdbefaamr9577455f8f.38.1751303186484;
        Mon, 30 Jun 2025 10:06:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8515:f93a:c957:e0a3? ([2a0a:ef40:700:a501:8515:f93a:c957:e0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4235cbsm143308905e9.38.2025.06.30.10.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 10:06:25 -0700 (PDT)
Message-ID: <9b3623a9-b596-44bc-b267-499e568a7f60@gmail.com>
Date: Mon, 30 Jun 2025 18:06:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `cat-file --filter` is broken in 2.50?
To: Dan Pristupov <dan@fork.dev>, git@vger.kernel.org
References: <6eb10e33-4001-95a7-d2ad-3dd2a5c830ab@fork.dev>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6eb10e33-4001-95a7-d2ad-3dd2a5c830ab@fork.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan

On 30/06/2025 17:07, Dan Pristupov wrote:
> Hi,
> 
> `cat-file --filter` stopped working in git 2.50.

cat-file did not have a "--filter" option before 2.50. The option you 
are looking for is "--filters". As git accepts unambiguous abbreviations 
for long options "--filter" used to match "--filters" but now it is a 
separate option. Being able to use abbreviated option names is useful at 
the command line but they are best avoided in scripts.

Best Wishes

Phillip

> 
> ```
> $ git version
> git version 2.47.1.windows.2
> 
> $ git cat-file --filter "HEAD:changelog.md"
> <content>
> ```
> 
> ```
> $ git version
> git version 2.50.0.windows.1
> 
> $ git cat-file --filter "HEAD:changelog.md"
> fatal: invalid filter-spec 'HEAD:changelog.md'
> ```
> 
> The problem was introduced at eb83e4c64b5a3458569593c2ab0c29365f10a82f.
> 
> Then it was merged into the main branch by 
> a271b05066a1fd2c3a62508d9908d6c5df14a1cb.
> 
> This seems like a bug.
> 
> 

