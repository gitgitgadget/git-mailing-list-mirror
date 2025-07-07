Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA562264D3
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880943; cv=none; b=orHucOs6tIaQQXjD4WfPY0oRMwX6M2Hhhc4m15X2+7aqZa8XOt56ii0jZKNxrSKG1dYE2oKWVdWd41E+gTAR16Qp5FopuyLN0NLW9eNYAt774GBIB4709dWvuCnj1sZGehGgA/7swDpLNkgSO95oRnat5oqVRWFJClKiYwLCGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880943; c=relaxed/simple;
	bh=yEQya4GZug68R+vu2CgGdcAgNC4kgZT1XdtyE89g4Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCy4ZBeGHMXR6XXvxjvG9SjKMgxukRJD+GcQwaqE8rTdF23L0c78XdpgEbCIklxZQusDj2fUrdFeKoV5AuVKuYKnkEqWTpDWWF+dy3v1w3GgQFrL68v/2+ApUO3qiga+wU97pSOP+GSZqskXEDRlPESFd6HRB7SLDlV+ohKPcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTS2s9ST; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTS2s9ST"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso1469533f8f.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751880940; x=1752485740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m0VB1D2fWMzSmFdvpDz1UbOizEwfjPFYYhdbxiytpwI=;
        b=PTS2s9STmsqtd0ApytD8NFTZdY1ByvGFUlfsV8+3aecSbKyKDG2giBaQV/4HQRywen
         y/0ZT0lD3rpfDB4m2aRUH1HuXbLTV/xxhtvleIjiMA4WHeNeF31BJDQoUty8ze7B9ZnY
         +b3Lbnmk+eYVH3hs+BF5KVy95BjrrNXt3hK/r/MRcLHN+01B45E1RoUsAvr+hlKuPe1w
         g4Elk60O+5xTCceIFA2T99YX/Qqkwg62n74Vn8fttMPsnhAhGnPfGzBGQxvg7QvEjet9
         hbOGGgv7XoVl2NIHkMejEdcIyjuClIwUouQO0aUzFDII/4HHikbJ1/fY+dp9qYzAxGny
         HlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751880940; x=1752485740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0VB1D2fWMzSmFdvpDz1UbOizEwfjPFYYhdbxiytpwI=;
        b=iUhIe2lXUP7BbZkHSXAE+FEgwqVh6lkj6tm3xxQvZTFbABHkJxtST7gRbsEQFLcmey
         uewZXeYMuzgRIwK0qRt4Ijy/Hbzzl2eZYdbl8ZXmJkqFCENcV2712nKtta1K5i9VxAlo
         YYhCXEQSy3K1pMJewfUp8n6s/8VloHQbM9TvLXEIPftrDbHmckmJnNGTJ0a3XTI+TDy5
         uq8ZMS7lNm3aWR3zv92wKo4qk7TXon5hVvvCMc9Tf1llKxFGUI6Vd2RBMXcW8KsJ6YuZ
         tJ47HSXQsPQpv83xZ6V7Tt5sNNo/z/bf+4bWY+Agoz0qDglTyDwKI6+9jnlNQ/17Qc6p
         W9VA==
X-Gm-Message-State: AOJu0Yx6I9VVts+xxAbiqWO8okdO34pxVclzSiYVOQvMGjJABMelATk2
	0X7wE8UXT+Awlmv0bcw4LkLYyfunFf+UW3coneq6Ca84p17SNijXUEWBYOP7FA==
X-Gm-Gg: ASbGncvr1w+pmxGbdKk0tjiT9XKpcCbNVoa0/7aCs0ItuIJDiGAdxs1EFnbOz0YVbc6
	q59wxwA/gSXzQOYHI+CD6xtO8D98f7Ws9O5CxU0Wp5wYQhkN/4iVPfVRUgsttvawTWcOolaV3CX
	u5LmQoz5Rxj0VZUN92UOmXcX0YKZt/6IKBpI1mrSS/gwoPqZJoMeZmQuv8kuC898WAWZILZYTCs
	XLsfAKO+kVZbsEqrzc0l6ra/TQ0HCcxGNfKb9L+fcBBvw4snR77UqAhlcHWoPcrPuySKJFvjajP
	cr7dvNdERb8aFkJRAfhorS/z44eM9prmn3QgbEeXv3Y72NBecY999AK/xzmY//G39rq4NVUo+hM
	70ND9yJCyGypENscjLJSshq/PPfjdCPl/XEAGyA==
X-Google-Smtp-Source: AGHT+IEedH3hT3W+xJZ56yZ2V4of/KroE0vQ5tLzVD48ur6rn7G6Qi3GcaOprepZB8QgaPB5DpJ8Xw==
X-Received: by 2002:a05:6000:4b1e:b0:3a4:fc52:f5d4 with SMTP id ffacd0b85a97d-3b49aaa1405mr5038719f8f.47.1751880939578;
        Mon, 07 Jul 2025 02:35:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285d877sm9569233f8f.101.2025.07.07.02.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 02:35:39 -0700 (PDT)
Message-ID: <05d66f9c-78b6-4624-a0e3-32235df05105@gmail.com>
Date: Mon, 7 Jul 2025 10:35:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] ssh signing: don't detach the filename strbuf from
 key_file tempfile
To: Patrick Steinhardt <ps@pks.im>, redoste <redoste@redoste.xyz>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Fabian Stelzer <fs@gigacodes.de>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250706173450.12995-1-redoste@redoste.xyz> <aGuNCGNk96DK4GzX@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aGuNCGNk96DK4GzX@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 10:02, Patrick Steinhardt wrote:
> On Sun, Jul 06, 2025 at 07:34:49PM +0200, redoste wrote:
>> +test_expect_success GPGSSH 'check temporary files clean up when signing commits' '
>> +	test_config gpg.format ssh &&
>> +	eval $(ssh-agent) &&
>> +	test_when_finished "kill ${SSH_AGENT_PID}" &&
>> +	mkdir tmpdir &&
>> +	TMPDIR="$(pwd)/tmpdir" &&
>> +	export TMPDIR &&
> 
> I think this exported environment variable now leaks into subsequent
> tests, doesn't it? We may want to do it in a subshell.

That's a very good point.

> 
> 	mkdir tmpdir &&
> 	TMPDIR="$(pwd)/tmpdir" &&
> 	(
> 		export TMPDIR &&
> 		ssh-add "${GPGSSH_KEY_PRIMARY}" &&
> 		echo 1 >file && git add file &&
> 		git commit -a -m inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
> 		echo 2 >file &&
> 		git commit -a -m file -S"${GPGSSH_KEY_PRIMARY}"
> 	) &&
> 	find tmpdir -type f >tmpfiles &&
> 	test_line_count = 0 tmpfiles

The idiomatic way to test for an empty file is "test_file_is_empty 
<file>" which avoids spawning wc.

As this test is an abridged version of the other test that uses 
ssh-agent I think it would be more efficient to tweak that test to check 
there are no temporary files left over. Our test suite is slow and 
tweaking an existing test to improve our coverage instead of adding a 
new test means we don't make it any slower than necessary.

Thanks

Phillip

> 
> Patrick
> 
>> +	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
>> +	echo 1 >file && git add file &&
>> +	git commit -a -m inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
>> +	echo 2 >file &&
>> +	git commit -a -m file -S"${GPGSSH_KEY_PRIMARY}" &&
>> +	find tmpdir -type f >tmpfiles &&
>> +	test_line_count = 0 tmpfiles
>> +'
>> +
>>   test_expect_failure GPGSSH 'detect fudged commit with double signature (TODO)' '
>>   	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
>>   	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
>> -- 
>> 2.49.0
>>
>>
> 

