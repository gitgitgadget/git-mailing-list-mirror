Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7D2E2664
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902008; cv=none; b=T2E5UGuUtC4B69ghoFcd1j8NoKbSQxsp8of/xUPmupY8nRK/8lJ6qu8mn41UkYjoDEoAmkC66XFBRC+sZ+CSoPK5q++J320zYhZjzMTvjIo9IeaFiKDa5NGxjakNjP8EgTDuKkdp+9yZ4bfQYjy08DhzpJRsPldYOr+KnjU5OYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902008; c=relaxed/simple;
	bh=zsXMY1bzcLO4eWC2lnMmDHzW9Yaw7JsVxzyS9Hogk3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5GFIVHUG5799ux/ZK6qBtptMrRFTi31FmmjXlNEzYr1357RiBgw+rcSfCQb8KArVqH1rVRHw+i2M4dJirxfnw21300TT7zfZZ4TrEuXP30TapKcxRDm2oS5rz3QnEN79yM5dLNjbQZ6GeW1eOKH5YHsWhS664/Qlft3cVz+Xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG9mp7N5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG9mp7N5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b45edf2303so3079000f8f.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902005; x=1752506805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rgv4+RFZOGst3zugsF+4H9ngyXiuDWzVIi7H7Ik5n7c=;
        b=LG9mp7N5iw5QCx7SopS3EMHelIIqqGLGPMWTX2ZEiqyDUhPxHRGZw+dT/ZAlgLkRN5
         POAyWLyuqLAyajEqNKop8GMtiGBQIO1z+vUR4vSyCeeJz7Vqb7NdQGwQz5sF4F+50lU+
         hyjNvFmHdNCQ8oc86TdbFuneZUsZ5XC0f/XKHZ9xRLJdi2cbaCwDJv8G7GDfLifRtnO2
         t8otLoT5wU+K00OA06s/rvvOZ04SrKUlZ4ZIuYVyPm8if7Alci+MfLdGUC/D9/yuOqRA
         hWDEmxvGe31PRyixuHwLeJWPTIV0EELveGIfWdKA7s3zw7psxJKSMq/5s//mZd7dxeX6
         nU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902005; x=1752506805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgv4+RFZOGst3zugsF+4H9ngyXiuDWzVIi7H7Ik5n7c=;
        b=uNEBIJADuSeYYjUl1dkEJSt0CST55nk1obbwxvxY+5PKGVZIMsb8oliFsaobCWQCbZ
         ijz26a9NYcoDg/o2j95Jv13K5bJgNT6nMgbBF39sokTdyXO7jduE0RCYBdBWM6pFp5Nn
         qYIf0+UlUI9V06GRlsE6qqF+YlUAcXZXtJvhKetIjMTx2XctJfiFbOLl2IWzH21PmpGg
         BFmoC26HjmM+os8f7No5mUutxlAeefIomIXAN+j9hMLK+9mB9gE4/gUHXlltcDgtcQz0
         yMbr1NROH4HCxIFRCu/vpiMTpjLvkmsJ/t2xU0dOsdBYl3y1zPseYOqnjsm3mqsYIrTL
         hgRQ==
X-Gm-Message-State: AOJu0YwIJPVE5HWghTCc4sZJwI6zjcy9fIx7jp/+4CbKX/S5eJcRg2jZ
	UIcJaiFJGsyTteSux/hrxfpHrCAkrRMUjiH/PS8uvuG19nG/JtGpbpPs
X-Gm-Gg: ASbGncsMyQCbxZVKAzmPzS22i+lMfsl4R2sXAcrUBW4T9tOco480vIcYu/4XArTE4/W
	rHx1wDW9lHcOuUBm0tAwL5IzBQp8E8Hgf5CzcFr0qPNP6i+PBPpqGMQohXvxSRv77XKJG+FA+Ve
	NpEQOOapAyf04NiS471dVavAkl3tFk84sEh2/hqv4WEnDBO6qaQRo8bowiPddNKo0aq1aerFuR0
	hlb0I1D/ayUWAmEcK3hVtXOysw3cy2K9Ey61C7KC14+Y69uezxud68Iu5kuCuq5AEglqx7XcPoB
	FMcr6T9XlxmJOIenHVYfvivM5MI21Lrrvgw8MdDVUmSz2o764tw7fNvEpcFhupLrmSTKGg1yQgZ
	wbeHSNQTZIqOAKhPvwK/4nHBD32vXEzpx3yjxw770vOH225aP
X-Google-Smtp-Source: AGHT+IEFi06Z29/cPblyvqaNFiAfYmUrKAs3I5dWLEZakRmjoKdPy9YObC5IHxEKkzgNu1T9iRV9bA==
X-Received: by 2002:a05:6000:4715:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b49aa2166amr7420747f8f.21.1751902004624;
        Mon, 07 Jul 2025 08:26:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97382sm10620703f8f.56.2025.07.07.08.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 08:26:44 -0700 (PDT)
Message-ID: <7130651b-76a6-4eb1-93cf-c9e237d398d7@gmail.com>
Date: Mon, 7 Jul 2025 16:26:42 +0100
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
To: redoste <redoste@redoste.xyz>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Fabian Stelzer <fs@gigacodes.de>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250706173450.12995-1-redoste@redoste.xyz> <aGuNCGNk96DK4GzX@pks.im>
 <05d66f9c-78b6-4624-a0e3-32235df05105@gmail.com>
 <DB5W4LH0MI5K.EJ0IILQ1IWR@redoste.xyz>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <DB5W4LH0MI5K.EJ0IILQ1IWR@redoste.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 15:25, redoste wrote:
> On Mon Jul 7, 2025 at 11:35 CEST, Phillip Wood wrote:
>> On 07/07/2025 10:02, Patrick Steinhardt wrote:
>>> I think this exported environment variable now leaks into subsequent
>>> tests, doesn't it? We may want to do it in a subshell.
>>
>> That's a very good point.
> Sure thing, I took inspiration from the previous ssh-agent test and it
> exports the ssh-agent variables without spawning a subshell, so I
> figured it was fine, but it was only because test_when_finished will
> fail in a subshell.
> I guess it's probably fine to leak only the ssh-agent variables
> accross tests and keep TMPDIR in a subshell.

Hopefully having the ssh-agent variables set after the agent has been 
killed doesn't affect the later tests

>> The idiomatic way to test for an empty file is "test_file_is_empty
>> <file>" which avoids spawning wc.
> Thanks, I will update this.
> 
>> As this test is an abridged version of the other test that uses
>> ssh-agent I think it would be more efficient to tweak that test to check
>> there are no temporary files left over. Our test suite is slow and
>> tweaking an existing test to improve our coverage instead of adding a
>> new test means we don't make it any slower than necessary.
> I moved this test out of the other ssh-agent one according to the advice
> from brian on the previous version. I agree that spawning multiple
> ssh-agent is definitly not the best for speed, but is it worth it to
> make the test failure less clear?
test_file_is_empty will print a diagnostic message if it fails so it 
should be clear what has caused the test failure

> I feel like it's not the best to keep checks for temporary files clean
> up in a test that (initially) only claims to sign commits.

You can always tweak the test title if you want. The way I see it is 
that the changes that are being tested are related to commit signing as 
the invariant that we want to assert is that temporary files are cleaned 
up after signing commits.

Thanks

Phillip
