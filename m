Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AB539C
	for <git@vger.kernel.org>; Mon, 13 May 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613211; cv=none; b=TFkXBTvUgLFxoTrvTutWskmV2AuT/CNZeZbBQT2VmhCJ2kQz9asxY+AzcFliem+shSlsbkNtbSES/57OAKSjlpp88MKAHkV0/oQBZaQ/JhJwfqjBOy8WoAb5vCtfh+ZwvNggfLrJa1TYLsNIyXfbwNRDksaMPuIeWy/3BiD0/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613211; c=relaxed/simple;
	bh=IbVj7z06D1vfMb3CIihsOlAB1D57sVmAs+BiUZDz6yI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=El1YfRCSBx0+OsbL/XYRelXBGEIQczboAE/Saex2JFUrp6+w+6hNPU5azSt2EMi3T3aSh6TwaH1bS5EuoWUL7uxbWG3DnExBKn2TRrUKNN59LE2amQkAw9PkfcJwPbvGeVbynKSNLwxmZ4tXik0+6kD5DbPEHLv3ZB5esrG0dCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUvxq+ZW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUvxq+ZW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so16923465e9.3
        for <git@vger.kernel.org>; Mon, 13 May 2024 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715613208; x=1716218008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbVj7z06D1vfMb3CIihsOlAB1D57sVmAs+BiUZDz6yI=;
        b=dUvxq+ZWMmb1lvmmozDigWzSwUOGB4oRLmd/26ftFapyVW+TgAX7uWXb6gRPJZVJKp
         Zn5Rjibz0wXkI4uH0cQsZG36FBx4dvR9kij3ddzJqkW6il9UuM5TmFr7cj5RPsSJRqJm
         eeZgNq6pNNjfN78fWz9f2xz+oBIAY8mWrqlSR5OXuIUU5vaQ+1aEEGZx8BBK91Y8LJ02
         sv/lx+XHXoQRbyXVidc1F32bkxrx6iMDComBoF4GM8Sy2cziXRCM+3wAywIoMw8Jzvxb
         PviDQ596kGZaK4SnBkLSXQe99txR9LX1t5RN+eWnoxf6FJl/bIToBHkoWN+y2lzkBURp
         O8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715613208; x=1716218008;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbVj7z06D1vfMb3CIihsOlAB1D57sVmAs+BiUZDz6yI=;
        b=v3LOLoRRW+MC8mZ5h5B9wKuk3O1J4CK4gQoTyqqA4kvIcOa7tJGQosL6YGpdw9OPto
         y2G9XCrvR5ar1EGyQSUqDlHIdEODRMZXZtCOJjeWNAPfptQ76YZwcLIIM6Oj7VEm/082
         e0xtHY9ZfdeKy6w0U/1zg7rvgb8CxDmyBVhvnhrGkyKns12qm66QG/zxY2cg7HZvDswG
         2Er7TISC1aqweuGnehtSJD0V/aGgC2s9b8unMI05l0OV8NhiLtdwn7m444GZZnMGIvfU
         /3V1vxtjp6yMdNoLypS2E1nw3qteexgu6cjNb9UQV5LbMBOI/Bgy+CTkBsrup2Z5l5pc
         tjxw==
X-Forwarded-Encrypted: i=1; AJvYcCXEuP+LIZT2gMCkkfiMJivousoUpaYN6UKrpOGvSFIDKCBswhiO8YIVxesIGjbjASRGsXxScri9F+MO2us26XEyOqEX
X-Gm-Message-State: AOJu0YylEzIb2iNcsAVMShixKJcuH5hzwgOvDs5VquhuVY+Jtl78fG7d
	gj/yQrpfnLvFKR+cYjqou6nD8QrcBxcNg2vkjcr6WAMf+mtvXzMw
X-Google-Smtp-Source: AGHT+IEnx57+lpJzFKCsKa9qjvD1t7kpSvBkYzYSQQVVtRJzr8UzL0v5riWqIAxvGhZUfVbjA3Prbg==
X-Received: by 2002:a05:600c:474e:b0:420:1189:e14c with SMTP id 5b1f17b1804b1-4201189e319mr38685585e9.40.1715613208436;
        Mon, 13 May 2024 08:13:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42018b5e1e8sm24660165e9.5.2024.05.13.08.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:13:28 -0700 (PDT)
Message-ID: <52853f9f-531c-4907-bcc8-b2a3841f03af@gmail.com>
Date: Mon, 13 May 2024 16:13:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
From: Phillip Wood <phillip.wood123@gmail.com>
To: Linus Arver <linus@ucla.edu>, phillip.wood@dunelm.org.uk,
 Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
 Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>,
 Josh Steadmon <steadmon@google.com>,
 "Randall S. Becker" <rsbecker@nexbridge.com>,
 Christian Couder <christian.couder@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
 <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
 <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
 <18343148-80d1-4558-b834-caaf8322467a@gmail.com>
 <CAMo6p=GJwmStLrW6cDDKrch2cXn_8fe0GsBHi3hpe5Uya72y=w@mail.gmail.com>
 <a75133dc-a0bb-4f61-a616-988f2b4d5688@gmail.com>
 <CAMo6p=FS3ShvBdutprWBiAVef6A1XjsXB1UJSQBk0s5euN=tog@mail.gmail.com>
 <f182c3f0-4d9e-491e-9b0d-59560cd93b8d@gmail.com>
Content-Language: en-US
In-Reply-To: <f182c3f0-4d9e-491e-9b0d-59560cd93b8d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 16:11, Phillip Wood wrote:
> Far enough,

Sorry that should have been "Fair enough"

Phillip
