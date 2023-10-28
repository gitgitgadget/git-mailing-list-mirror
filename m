Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAB33C7
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkJQcuY5"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E9B8
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 14:11:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so426141f8f.1
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698527486; x=1699132286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngSFBlNIMXcq17gV6R9xHvB1PMF2z8I89lVM45mnEW0=;
        b=GkJQcuY5YSl/GUZQMgxSHRR5LRG0z7UylebNuvkwXNN/S0u9m9ni+abNWz4ma5zmQW
         D1ECOnLBdkEdBZpZOuIBWtX7DNhclHbCYtrW3zxpln4WrJuLHMvp+tP4bkNhDsnUnxxz
         d0yvacYpTGat1ON9ICyz/5gxDv38wmTatIb23SRunYuys/fv+2LawUi14AkIAveug9dQ
         1xq/KoIiSyBzYSSKNs4Op5O/h8CT9dcVv4v/qgFbSZOGrwdfnVQ+eJgEm+gj5HxKErAS
         M02xOybzPHkI9Qzr7zunlLt5iBbsHkRYDmePN4xX/2a0Yygg7VJ+4ni3YQMiH5adeF80
         DBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698527486; x=1699132286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngSFBlNIMXcq17gV6R9xHvB1PMF2z8I89lVM45mnEW0=;
        b=Dqei03VshkXCTGpXjXCrBmrK+G2Sum9XcP7WHQ+M2miBwkSdzkH5TVmtLFoZHz+FF1
         UK+pfrTrVfR3w47ynmVWv1XlcY45/6QQbVyqg9zn21bgOZzYeX9cDEO5ahBqWwAH0tgy
         Qc0RnIjOBihEh3lGi933YIpo2egUABPiyDpbKnRo/42qi79dsCn0JhTqcdmJDNxKPakJ
         f6ujf4KY+ahZ7HRbdtMagB5uJn3H/4NEroXb85+ovderpYX4r6+XwZ4dY+nTcL2F/P3m
         9KlsKaOOopulf73dUC/tYix8C92sLRlnZJNGQKyGmUiJhfiQTMAQ8Zc+8gairJJESV1s
         eGPw==
X-Gm-Message-State: AOJu0YyCVQnhMWc3lUTwtD/Gm1cf/heFaPgyloHIKNuk7L4CArR2XZLr
	ZUthu79cf7DT+XGb4R7yPo0i86jPqpqj2w==
X-Google-Smtp-Source: AGHT+IEMsKr3KSVpO1DQ2zZXiYzwj9RYfbBGcOr5+Gxu0sUBcd30Mi2G99kRSPn04zTzRJLAtTCqOQ==
X-Received: by 2002:a05:6000:4b:b0:32d:570b:c0a4 with SMTP id k11-20020a056000004b00b0032d570bc0a4mr4445527wrx.27.1698527485735;
        Sat, 28 Oct 2023 14:11:25 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id az30-20020adfe19e000000b0032f7d7ec4adsm1757724wrb.92.2023.10.28.14.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 14:11:25 -0700 (PDT)
Message-ID: <26e8ad28-a534-4a7b-8653-2bf580d316b5@gmail.com>
Date: Sat, 28 Oct 2023 22:11:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Liam Beguin <liambeguin@gmail.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <20231028022048.GA1784118@shaak> <ZT0oVKPzVi5TsrdS@ugly>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <ZT0oVKPzVi5TsrdS@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2023 16:27, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 10:20:48PM -0400, Liam Beguin wrote:
>> I agree, %aa isn't the best, I'm definitly opened to suggestions.
>> My preference would've been for something like %ad, but that's already
>> taken.
>>
> H for host would be available. (not to be confused with h for human.)

Both lowercase and uppercase would be needed though, to mirror %ae/%aE 
and %al/%aL for choosing whether to respect .mailmap. That actually 
rules out the %a@ idea as well.

Andy
