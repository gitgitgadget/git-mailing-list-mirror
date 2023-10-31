Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D5107A5
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvkkMCVO"
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453E118
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:10:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32ded3eb835so3980296f8f.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732653; x=1699337453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnjK7gbjYlT6cXbPtu8C9Ruk5eOLmLjqGuN2sZ8RS10=;
        b=dvkkMCVO1z47uVY0xdiNH1+QYi8LBcgB2r8ar1lQ4I7gNbyp4wt5MJn7ECGunVoZso
         +L+0kMFQL0sLlzRCMS1PjdxW9QtQPWnHSoYxUdQvDW0ntQCqKCWJQT/v2W0JNvSFdFDe
         tc1D0V7dEPN67Z0X1EyX3v5icH7IebetJSMVN2e/kz+AhUdqXGY30jXPJvTIpd1i+IM4
         fXF8a7fZ4qxYS7KDxqJRBIQ48cgQG8msfmp25ngPY3yjaL2+Xit8AK8TtTBH3Ew8hXnO
         IpmtT8fhIq6OOehEsxCN7oKHq42G3t54oYzW+I0XFQKMkDhoJApwAF8ZBRN6nuXvjSEh
         IFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732653; x=1699337453;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnjK7gbjYlT6cXbPtu8C9Ruk5eOLmLjqGuN2sZ8RS10=;
        b=cCpxw9zd+e4Lyv4hh1DragHsvBGPc8CudNPwibCjUxMSKt7ibyYqAr7YQ9Qiad0HWq
         lNyOhAOJiU9EQEHg2a33OkqRPdOQSi4SqWxVieRijMTXGXoVWzM5agi0WuyGuKlYx97+
         RiapJ5JqMxM3UIrYfbJapKw18GzV1UFhzy77eaWMsslWxfqyoV75yCx3HepusjY21WAq
         u8y5XTF4f6xeRDHdFcSAwAQAdDl2N3jFlQOaJ5y3Jri2SGW8nqFvlgARA4PpRUECbsLl
         iF68MxqJkYv/p5/3Y7tJ55b6ec28DmIv+hoFu0MQc1aF1UWMscPMLGcwfX25uatdKhpI
         FvMA==
X-Gm-Message-State: AOJu0Yx4tOdi8Ek1FZsU/Z14zvp/4ZSQ6tJK6ZbEdgcPcsBYzreqNu1j
	tfeXL2rIXxCgYfjAb+rZELOk584mSPQ=
X-Google-Smtp-Source: AGHT+IFCoSyekKLZlkq0oft4G5dkWseu5x2fnysd+o8Xqbr9T2xKJgXbHUX+d+wd6HCSiqgka/ot/Q==
X-Received: by 2002:a19:5207:0:b0:508:1a25:4bd8 with SMTP id m7-20020a195207000000b005081a254bd8mr8215198lfb.25.1698732093015;
        Mon, 30 Oct 2023 23:01:33 -0700 (PDT)
Received: from [192.168.192.11] ([178.127.214.205])
        by smtp.gmail.com with ESMTPSA id g4-20020ac24d84000000b00507b8f6c468sm95462lfe.295.2023.10.30.23.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:01:32 -0700 (PDT)
Message-ID: <f99b99ed-1e24-49fc-9d61-2cdddf0fe860@gmail.com>
Date: Tue, 31 Oct 2023 09:01:31 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Content-Language: en-US
To: Taylor Blau <me@ttaylorr.com>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <ZUALkdSJZ70+KBYq@nand.local>
Cc: git@vger.kernel.org
From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
In-Reply-To: <ZUALkdSJZ70+KBYq@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Taylor,

Thank you so much for the review and feedback.

We use a mixed environment (Linux, MacOS and Windows) on
multiple projects. And some members can work some days from home and
some days from the office (on different PC).
So, using of scripts a bit uncomfortable.

Better to apply once for everybody in the domain
git config --global merge.ff one-only

I'll try to fill the proper test a bit later.

--
Ruslan


