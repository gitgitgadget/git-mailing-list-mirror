Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933714F9D6
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209622; cv=none; b=fAzsa22lilt3p7b5zOI2YFcT4YblGjLXWE+m3HNsDP8cLyUkfU0oQsnHy0uWQgToZAqK3UvmDwb8mgOzwRfextawz80q6SWSbdmGZN6wRC+5GsBxKvvEQZofY26EQdioRLXUni53gvzx6mKklzDAYEFeCLlZjl+VjTYqAYYPr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209622; c=relaxed/simple;
	bh=Hp2wYkOu+L+uaHvLysla1S5eloJYiSlGar8reWuWXqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWk1DDlVQZ2NJLmot4mviwGLwzr7dcgAuOnKmoZ1dqHmhJiHEd8SH1AL5ID+ek9dbZzWl5ekVXxJEHfejEfuTX2hxRk2L6CJfNJAwaWC4FpUESRtNW2eO25n8kBvSajchLzDygIZfny8HDjKXDbyV2xxr3uxY6wqP0Dgi6uHfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0blhqYB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0blhqYB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so33358435e9.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765209619; x=1765814419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmOurGj8+KYBSaS6mJZN2Mc14B0nfCMBeRKHK51WSR0=;
        b=b0blhqYBYW3I6iUqXJngivX3jlAsqc+i6VDoUGLXkN4JqhOU2PaBdGOCfLJhPWmpaV
         tIv4xwqrH3210gDG7VMPq6iYqK/FH5+9SL3q4aWXswf91DrN1sVCXx5ijKHNMNUv8ktw
         +EVNXDelKgdLPHfLLQ3Ey7iaBd6N5dBh0EK0v8EE/01r8NiiNbvvHdwvogfcl3nrEW4T
         UUosUloxQanSQ/6awP8eNdTjTDsiPMl277CUEzooGERaY3kAddQfE7RbPeM/Zljj4ouK
         rqY6eihQ+FOMFt0cS+Uw/gEOs32snPZ/9TB2BkoDLG4YRKu38lDIYErVDWu6stBeIeQR
         eLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209619; x=1765814419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmOurGj8+KYBSaS6mJZN2Mc14B0nfCMBeRKHK51WSR0=;
        b=N7EeoQ+TEEZ6w4Neyf4unYheiG2QH+RDuISxejN2n33suZ/4pyBcHY77r30XI7/YRJ
         aeFnRaTt5CRWFexSfET6jLsInJyIKKXnmNAkmWqmskjpATnEOJSdjOqyfI6gdskho25O
         bz3x4+HYB7OnYdu3zLWKBs6leMynUgQB3V27m2Rke4qp+MumdWR8UCp+jRmW2CvbdRrs
         OZ70xxZDLfGEooOCXeCY+/j4f30Tsk6QHFjOxOCytCJZRLY8netQGuUiUc3/dXY1C3c/
         C7WtXsHuhzAIWX5mhNLKzz1ixDYp4ZaY5VpYY4u8NMgcmoVsozx3cGgdRsZQDIDNkwDQ
         ugig==
X-Gm-Message-State: AOJu0Yy7nMyTCKAZPq62ufgIycy/7LYc7FJ7BBPd9e7F3cJ1qnx7l4zp
	wv6Di6NPoktofuIQKz7elFDzICRiQxJzDZ/tgOnfy3T/4X7+rR7jl0/Y
X-Gm-Gg: ASbGncvUw/NKkn6LuXWpIBaLC1BVPoFRzl8B26CuVzpnPI/XQy0xH69MhUPqRRkypsk
	rVUQbpQCz6awq4OpoAEJZUB5ocZR1YoDzxZ3Wfd80gMlazYi0EljQ4L+mefH7zqOnK9f4HBu3Gj
	VHza/AaGYzqYwPVERy/+aPvUc2R4aaux5hyISA6UKIiI3upWWZaSKp5BkFGAeAVexKiDJPKV5n4
	AW1bZyoIlP1TUlA8xLAjiHIRDOIbcZPHVuh4h64gKz047fGNmBtPnoALK9l4OsQLteFExJud15S
	XNfecth2YvGZ4jesiROXm47YDwDZEj+3m7VV/Vs+9I+Ino/5o5eV2tmJvRDzTOU8ID3WfjcRvqY
	BH/FXBRVaZpwgoop582KxkuzizIo6c97jp+e9q2wI7wSsL/PMzzM34YQF7AWM+3dzO6xbfOFDMY
	iz9VCLb6gdetjIe7UVFCI5fnz7qZE7cbOP74GpwIP9AlxogCi8WXIs4lhuIi2AxUA=
X-Google-Smtp-Source: AGHT+IE1MknZUaRgLAbqaSrNyuh2cWjO2WWKCkCZmlsR7Aa6v3YYrzA4o2KdCFIjtQROa808y8EQYw==
X-Received: by 2002:a05:600c:1547:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47939dfa531mr98085135e9.8.1765209618519;
        Mon, 08 Dec 2025 08:00:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226e7sm27332995f8f.27.2025.12.08.08.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 08:00:17 -0800 (PST)
Message-ID: <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
Date: Mon, 8 Dec 2025 16:00:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Christian Couder <christian.couder@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, Toon Claes <toon@iotcl.com>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2025 07:28, Kristoffer Haugsbakk wrote:
> On Sun, Dec 7, 2025, at 22:58, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>> [snip]
>>> base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
>>
>> All looked sensible.
>>
>> The second one looked a bit sketchy, but that was the phrase used by
>> the log message for c4611130 (replay: add --contained to rebase
>> contained branches, 2023-11-24).
> 
> How should `--contained` be documented?

Maybe something like

     Update all branches whose head commits are replayed. Requires
     --onto.

Thanks

Phillip

