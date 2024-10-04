Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36FE2421D
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032454; cv=none; b=nTsb1dvbPcPM+utfizSYkwUfw1zrJUrCxU9iwQQHYMhXyJTXWAAwzbajD9tW8fbxRWx+ZGyEfui0gXVMXttLjn8KyzcmpLImrAoEFFcBYJvRFUsjw7N+RZQfLBWCwj3uIYrDN++uxRC3Whk4eeZrE7RwrGFecQoej1/R6qS0or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032454; c=relaxed/simple;
	bh=qAlkFXtV85Q7MB7IaMJSEtFN8bR8Rq5KJLuZQDKs3Lc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ZwvNXol9tynMQCOymL/tVuvsM4waIiS1Wkvg3dKWdbLceGhQgDdsVj/DkF/BImB22DxpfiXGrRXkcJoApCwJI8SVNZgF7zKRVDUOjTDOE5qi9P1K9WB4FGLvB//vPtAIJM6/f/434IeFuyY5MS7IRSh5g0NUbOCn3mFzcshFRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROSjsT0M; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROSjsT0M"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso364460166b.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728032451; x=1728637251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=586yEATGhtJIBOZwTaWCGFNIZJwD/PjYUjeREJLwf8k=;
        b=ROSjsT0MeO8qdUhLtuS7nq5/QePuO4TqpGLd2UOOnsamb84ajauKnJhWCyUmK8GcSA
         WgS8u3Lk2BXt90EPFm56byv+doUxVfq0DPqE1/1VzMN5M5w8CcO7t7rWIq6DJ+0n7oJ8
         pRfUoahX8rzHb9CCsz0qhdVrydrMUKm5Mr/w15BBAI7ewQJvIDH42gAR5V43kZa7XyRX
         xzFsOaMVRR5pNUfw59RlOWxXnzpWsANVNOBUtt8wzxqQA2ABb4mHt2VuWHzKGS0tx08R
         0roaiCXifMGLu310ogJJsp/X7++/vy8KVl5VRhba3tKTSpPGU4ohPaVsXVsgUo6YMVMo
         MPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032451; x=1728637251;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=586yEATGhtJIBOZwTaWCGFNIZJwD/PjYUjeREJLwf8k=;
        b=cajxyC37Ns6Ct6CerxWJrIww1I0jLWR5ADnKE3tDfquzh7TzNG+gW3mg511F+1RBYh
         va1ipiMBRIO/AQpFQTJa+T6/T07P1A2onzolSQRfKRBwCiY4k6aPJRknTZts7C13Ztxi
         9r2dgFBNhSfQSCCHZdOOG/YzhL2uHQ5ORQPgGwxlHd3DSkjCgbwtLGQgN6uqp14p3B4v
         h5IrfOjJTuDP3c7axF0AOWqVsPOxCDBiPNV11+lPw29stFSh6S46tHz86LHSD+IJHbo2
         bLKWjtd1UAX2L9VVyjUROZ05D+Bq4WiabI0IEbOjRRJrNx9w6igeob3k/KKUbSUpqNgR
         5ptw==
X-Forwarded-Encrypted: i=1; AJvYcCULJReyevIxTiw2BaRIuZy/CqO/K6BhvJv6Qjb6baBRnw8SISw4ViMqdJes/enqea5QP8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/c/TZSsdxEocyNccbPm9psyXKRqwzf2ryeOjMzQQ1LUPPGUx
	uoYI2pWmuFvc4SBkHrySMkxMI2tqyMkurOXq3D7isptl6RxMFDoX
X-Google-Smtp-Source: AGHT+IEtTCGUkjpcKFhoPREGvRUEXoFYmiMyOTJvWyWqC1WgrKXnfF4LjhIP8oquagXw+Is6HN0nPQ==
X-Received: by 2002:a17:907:1c1d:b0:a8b:58e3:ac1f with SMTP id a640c23a62f3a-a991cf387b7mr184533666b.12.1728032450668;
        Fri, 04 Oct 2024 02:00:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910285b0dsm194690766b.23.2024.10.04.02.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:00:50 -0700 (PDT)
Message-ID: <c37e4dd0-9ad0-4d96-9d0e-ee13d64eb7a0@gmail.com>
Date: Fri, 4 Oct 2024 10:00:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 Emily Shaffer <nasamuffin@google.com>, Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
Content-Language: en-US
In-Reply-To: <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 02/10/2024 23:04, brian m. carlson wrote:
> On 2024-10-02 at 09:54:52, Phillip Wood wrote:
>> On 30/09/2024 23:03, brian m. carlson wrote:
>> Part of the reason it works well in rust is that it supports discriminated
>> unions with pattern matching and has the "?" macro for early returns. In C
>> the code ends up being quite verbose compared to taking a pointer to error
>> struct as a function parameter and returning a boolean success/fail flag.
>>
>>      struct git_error e;
>>      struct object_id oid;
>>
>>      e = repo_get_oid(r, "HEAD", &oid);
>>      if (!GIT_ERROR_SUCCESS(e))
>>          return e;
>>
>> With a boolean return we can have
>>
>>      struct object_id oid;
>>
>>      if (repo_get_oid(r, "HEAD", &oid, e))
>>          return -1;
>>
>> where "e" is a "struct git_error*" passed into the function.
> 
> Yes, I agree that this is more verbose than in Rust.  If we were using
> Rust (which is a thing I'm working on), then we'd have nicer error
> handling, but for now we don't.
> 
> However, Go still uses this kind of error handling, and many people use
> it every day with this limitation, so I don't think it's too awful for
> what we're getting.

I feel like I'm missing something - what is the advantage of returning 
an error struct rather than passing it as a parameter that makes the 
inconvenience of handling the return value worth while?

>> In conclusion I like the general idea but have concerns about the verbosity
>> of returning an error struct. It would be helpful to see some examples of
>> this being used to see how it works in practice.
> 
> If I send a v2, I'll try to wire up some code so folks can see some
> examples.

I think that would be really helpful. A couple of examples in the cover 
letter showing how you'd convert some function from our codebase would 
give us an idea of what using this api would look like in practice.

Best Wishes

Phillip

