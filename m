Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE589311C25
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939415; cv=none; b=gCKkNY8vluaqiHCKPfVYB6PIqPlycpYn9ntHF6mm95IbPntRifjyLoYKGrSiKVbaWE8cz3dNS9xXTKoFZgAqX3Tdh3/SFG58LmrN6NFtx/RsSIwBrbBqEd4t6L24UNMJVr23scfLmSXR/q7AvTFHWvNavqbAJuNO3E8KDAi2ZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939415; c=relaxed/simple;
	bh=RQ22MYBOOvgBbsIJmnqc4h8p6+Lmyxx0ZMjTaxpAxnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntLoeXlqXC6eIMPGSyMmrlFF+GyDtR3XNh+zsfWugMUkeaV6e/HAiwQv1NPmF3btP1In90DAMzAWSKwgQ0dNrGYaGMe4EBENVjcQaaUbnsgZtvs6Nkv1Ulf6DFd0zSEv6FZyxVeauZutlBFEicBu6X1yFVChz/e6Qpny4Xa6pLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDTFMucS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDTFMucS"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso4019621b3a.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939413; x=1755544213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aMUEVpPBHREekB3idnM7dUB57tJUrj6LzvACriv4h0=;
        b=EDTFMucSgQ6qRi08jre7lfkPbkdP+Gol0SOSzmpIZHa48eSM8sQ1vuj14UAWE4lZDY
         ljeU/UDy7iII4M41pYZ7CWD7lxTfGM3kOy6/0EcCEHidB9x/mTXU1Mn0XNTtlOhaLtcw
         rukcuqGN/0ObrytXGooA/uuhmPy/+TSoEPsMnG+QE2T9z20lWEOZuKnwL2v7EnEKU9E/
         8RxiKX/g2LVAml4HrNsCRmTzixP0n3P0aM6A+MVZQun0F/mivYEPo+0N+l4GT7i1W0yQ
         h3nD3+HsrwdCWsOQZuu54ZCHxYD6N3FNjfOneHaHw2a66wZ7WiD4mUfGyli5Z5/ZCZW2
         X6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939413; x=1755544213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aMUEVpPBHREekB3idnM7dUB57tJUrj6LzvACriv4h0=;
        b=G4GDMLp/Eicmg6n5aRMBhLgpC5htyCT4IpngyQmafaKM+WsbKaJV9YiZxCtpfgYgTw
         2opafHO7FKzSfqaK5+EVXzbtXYUMZ4h4pK81klqJgUq5gG6TP3IHFCS7XW2V+dCxNSXl
         bl19iXMYuKmLRl1e5QLkEQPQybiyjCHbiJTQO+ixebzmQbRbGnsdAux/ZHmhOCIuAHCB
         tQcu3UwVsmYBILc/4yTVwOrTN+XtCOOzhGzx0XSWXXZouYcuttcazW+6wU2pA7hEX/ug
         C1a/Qe0tsdX7XZgmlcFp1J2H4UKxWdzZxFYOhoKhJRlxhpbXpXHb/wIaFTv4AaYhdgHc
         q9sg==
X-Gm-Message-State: AOJu0Yz/5l5y11NTiz7Tk3r0n4Q14xhqrutYyvhlx5oJ0gY1VQ8Fsg5L
	1vVFtcLtGGZsUl/U9GRoizjwcArp2kvpUFmvEgJwxDfkUrKa1l4nVLPv7njrrVCg
X-Gm-Gg: ASbGncvvopC78f5kGtDXW/0x4qk7vzWZisIf2QrF8Ioaa1Eoe9CTBS/hWWD2CjFw5Qa
	egCWcfX/HcmNO75hHh7sw4V8eS+u1OMVMsFKxBGpwKcjYc1NCr1aflv9Lw8X/u7wN+uoeYFM6ec
	FpZ9dwby/Id+yAuxeeZtuxrMlesk5AHjlzSXnnyPgYUX0epjvvr/oT9hHX2W/Ln6cxK7AtGiYuV
	NinVkV3QqlG9MD3ubUyXSmEtviEkYXYzM71JpQZDypU9/ZZIaTZmRrIdEHJfRNB4QoW+gRX56v6
	hGxHg0PQTsC9nWR2s4KFVQnZ4wXlzkQFzWzl+skrD609FFwYFrfqgeRmUUAwlH30+3IN9g2BMb1
	UzC6wCjj+xs2ndIKRv4z/op3C5eRlMGH9qmQwnbwAu4041lJ7DaTVZxCMlQ==
X-Google-Smtp-Source: AGHT+IEH7fGANWnCDHXKkIf6OG6j0SQFq604/nlcmtmiYbkAiOpee54dajkqQjASK7L7g94cqfYYdQ==
X-Received: by 2002:a05:6a00:10c2:b0:76b:fe65:71f5 with SMTP id d2e1a72fcca58-76e0df2969emr978487b3a.20.1754939412838;
        Mon, 11 Aug 2025 12:10:12 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa92sm27576779b3a.45.2025.08.11.12.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:10:11 -0700 (PDT)
Message-ID: <ee87e67e-7551-428c-843e-1a4f57548f9f@gmail.com>
Date: Mon, 11 Aug 2025 12:10:11 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Minor Bug in git cat-file (git 2.50)?
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <b37629c6-b730-45ce-b839-e782aafe238d@gmail.com>
 <aJmvykqFbsBJR_xk@pks.im>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <aJmvykqFbsBJR_xk@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/25 1:54 AM, Patrick Steinhardt wrote:

Thanks to you and Junio for looking at this.

I agree that this shouldn't be considered a high priority
bug.

Do you agree that the below should be what I see?

>> # I would have expected:
>> hint:   78981922613b2afb6025042ff6bd878ac1994e85 blob
>> hint:   78981922613b2afb6025042ff6bd878ac1994e86 blob

The reason I'm doing this is because, just for fun, I'm
trying to implement the disambiguation code in Go, and
I needed a test case.

> Hm. I think the problem here is that you intentfully corrupt the
> repository by copying the blob to a different name. 

I didn't intentionally corrupt the repository but I couldn't think
of any other way to do what I needed to do.

How would you have done this?

> I'm not really sure that this is something that we need to fix -- the
> repository is corrupt, and git-fsck(1) should tell you so.

Here's what git-fsck said:

% git fsck
Checking ref database: 100% (1/1), done.
error: ee1a0d672b283dc03c94a266647e505ad340dc29: hash-path mismatch, 
found at: .git/objects/ee/1a0d672b283dc03c94a266647e505ad340dc30
Checking object directories: 100% (256/256), done.
dangling tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
dangling tree d4607c312181a2fdbb66e8accb5b006156b6b733

> Did you hit any real world scenario where this has happened
 > in the wild without intentfully corrupting the repository?

No

 > Or given that you explicitly mention Git 2.50, has the behaviour
 > changed recently?

I mentioned Git 2.50 because I wanted to write a useful bug report.
I have no idea if the behavior has changed.

Thanks for your work.

Jon

