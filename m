Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180278F59
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308580; cv=none; b=YAXnWtbQGo7qgBuHIUZBqLdtns6RwDmXPcFbaQQhCuFjjKlvLQg81yA+Pks49UNDPr6oDhOgXz/a6VrOG0Uc0fGarpInMI3NRqEsomsYyv+Sclnw0/EQmva/sNx2pLXQmVi7JMbI6rR3rYUDJ0MK9aabYzY0wZhc19HsnqiVLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308580; c=relaxed/simple;
	bh=JT76X4+g5cA5pM8ZqPKzWaEopK1wujnK0BLTltaxzN0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GO3PTlZgxqKFd2bc9oh19TleQZa5Q4hlYj+6RXxUwXkAiJ3daoHJ16XOW3ksdhIvAIf0M0U29i1jJkESEz2WMMb5djJjAiZWKYutUEY7jxyrD8sXES33nO6hyadI2oWuYNAg1q4ic2NXgARCfQTkYc4g6v40DpSw96hLnFuE3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atPAbvRZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atPAbvRZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b5d49ae47so20806265e9.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308578; x=1756913378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEnNbckLBHajDayYI51+7fNCHf1cJxFprESfhVXVDg4=;
        b=atPAbvRZEe6Nwhr0x3pzFOj9nr8kpflAl2U2/8OcBm4vDeQIlv+pzwmVGUt/1FJ8zy
         YyQ1UP6a5vPYBUWliXWBC1fmF98kJjXYsFrSU5nKvmyf1yt262Y5fssYqOlnh1mAyTCn
         XQwGvvQgLsfUoFQHwK9S/T9gByX564PB9bu4hoT1r3h6nvB2OuGsfYCNrtOjBkanvYar
         aXuS73sSGYTlR0MHoP3b1meu0+UMrXidzTdZekSiMnamdP1wch2q3gVrbYe0aZprp+wk
         dXs3gBxtTc2dniGBVoWibh4kcDkp2Z8ODEZ/iUpAR1C5YFuIW9YXRJkKvaZfCOyh1NZ7
         oQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308578; x=1756913378;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEnNbckLBHajDayYI51+7fNCHf1cJxFprESfhVXVDg4=;
        b=Mk3vIEGEqbnBFPso5EaG0/Vep+LRCW0EZi3/NxJbJAGreDG2iBotv+nKBtYl47dzDn
         Sv1CPFO18D+77CdLOV8FWEPpcGOy3S7KYsbKNERSNzkbVyFz4yI9WRRn0sS9QTZlNJa/
         6qqV5vzPZdE8Ymz6qI/SdQltdDnPHFHoXfcRyAet1l9mMrCLoyST9Z4vcp5SkRZ3IJnD
         1xL2C5LuI+Ncy6kvZFouf4JymZUoCJ/LfzI77FvA3j+r1lXQ2FTnRmlGPVP367SM7ia0
         46XTBUvqD3RUDZ6+drfgbktA+poWn9ml/D5Ng4W5gRsitoSXEb+DtQk7EDMqTCQnhhuq
         0J5g==
X-Gm-Message-State: AOJu0Yx1D+q7i0LnmU+F9u+xy8LL1Ut55QQ5q5nk5J139zQqvj3BWxEH
	S9Xs/P6oWOU8HVK74FspOX7W7wCcRpTb1JktCqmJuGiWa8NIe20Hi376
X-Gm-Gg: ASbGncvGQwEy76uKGKbRypf32jgkw9fhSjePJ8DHyUYQrYJC6zgh3o2/rq5YDIl3d3t
	HAJLMFDfXkiIaWbkr2ReT05BgCRpjbXqaRSdFW2hN4HbbLGQ79u6hIiOMkwhF8DOPH5+olZtm/I
	AByC2igl0VXCtQRSNlS/J7c4goBNNY3RYCF6ok2itrxG/v9hAbBjThmJL7BVAPn+oZUdkEej/DY
	unpvubxYFQF1DBuKVDmL28w2TZ/5aNQG0N741ywDOnowDu3y5q4l5ZCj58A/MBqicgQjsrzgmMw
	q4OC61WOd/cf9SQHd9CgQMcddkP/Rls3WG22fkm9uJF/71Zh5TIk7V6mOFt4VvAjM6+liinML1e
	CBwL90UZuExaL1jsS4O46GV2SZtR2KmyaqBQp8k0T32JEvAQ5HHFW9O+TQa/rcQQWsy0Gf+4dtB
	ER1g==
X-Google-Smtp-Source: AGHT+IFrazR67DJtN3ervvst8HKgiNx9koQFabt9r9OBRZBPDWF0Mmt9UAxBzU/6G7P248lD3ut/FQ==
X-Received: by 2002:a05:600c:524f:b0:459:d8c2:80a6 with SMTP id 5b1f17b1804b1-45b517cbeb0mr192323335e9.33.1756308576817;
        Wed, 27 Aug 2025 08:29:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0f320esm35172565e9.16.2025.08.27.08.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 08:29:36 -0700 (PDT)
Message-ID: <90a1f901-fcce-4275-b1a5-8ed50620f50d@gmail.com>
Date: Wed, 27 Aug 2025 16:29:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/3] config: warn on core.commentString=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1756215326.git.phillip.wood@dunelm.org.uk>
 <5dd897c95e680c4e3f26ec3945fe649b4b61681a.1756215326.git.phillip.wood@dunelm.org.uk>
 <xmqqldn6krmi.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqldn6krmi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2025 16:52, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> As support for this setting was deprecated in the last commit print a
>> warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
>> Avoid bombarding the user with warnings by only printing it (a) when
>> running commands commands that call "git commit" and (b) only once
> 
> "commands commands" -> "commands".

Sigh, I removed "only only" which Oswald had pointed out only to add 
another repeated word. I've just sent V4 with the typo fixed.

Thanks

Phillip

