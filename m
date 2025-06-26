Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116C20D4F2
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961073; cv=none; b=kV5qrtu7/ZmQbGk1Qkm9jIT1OB54ozGHBalMYTuQPwGLiOye/s/WDEzOv70g3v8MX0LMKBk4/tIzU1g9Tt183XvhJhTxAFcAI71RlAfoLohv3b5rkdhSrVjHK+Tl3HB7VmXFd34w787wdkHFTiiSr1wk4qPRjVVCbeMIc/KsQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961073; c=relaxed/simple;
	bh=lI1zzQ3DcQY0FH+mYIwuJVHxigvFVe6CsyTUqMKrsFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqZN8t9CVT4ePm0K5e5Wm9LXx2mmFAGOlt+fnNTFMbEFbYCOVylPfqX1TjkYdUMHpfEFWyCgqaa7RpotvT6J3zpVUlMO+3pH4RlUQTFhnxSnVjIvTJ75j78iI5ex/8Gu9nO0HOaBHFDT2kaSEeQg5YN8EEBZOotmfUHwyXj0oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq3QzgCu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq3QzgCu"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso730226f8f.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750961070; x=1751565870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUo9rMWEAayHhqR8a5Sg4uQuhAgz2zTccMz8hfkEAAc=;
        b=lq3QzgCuq5Sgj5Y1JmGGynskh1dGHrOjz0hiiRqlBE8yoVlnGrIrrGmNzwzkn8lS9v
         JcEh5tfMMJSWE8OYz2+nHcEadGglQAFJ3+OoPN7uIRooc7DJQGiZbPuWJ6TCokdWqmff
         LclCEfU2VovekxSIoe1t7pSGromf3vC/dCagDjLGS8lulOiQFkQzRCcHjNWTCd5b3HcM
         rV+MnxVUxHbcLElYlJoLUV1C1eHQemqYoXiD+HIHXgLLClZ1Pk7A9xZ82UIJwSoVW5sd
         uWwnqZW5uN01Ne8cww1PhCumMEjcHNpqI/vZRDUkB2efB5/WrnuE+Tuw9W7AOHNIAWaL
         F7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750961070; x=1751565870;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUo9rMWEAayHhqR8a5Sg4uQuhAgz2zTccMz8hfkEAAc=;
        b=c0iijjyi+R3qDtLjxvCEXiR3ENEQKD3xnmpUsH6SxL5RHTh6fCE7EBS1dsWQ3MYUA0
         Ws4VPpI+GO0W+Hay7pyaES44c9zLg5eiNx8YGVb5kYVHapKX6ewWHnzNZgcm6lLKd2Ga
         QJ2vOAa1IfjmP1JB2McpDqXJfmWoMvGoJUrGxFH4+d49Tck6TLhIAVkjE5o0/QMqJKyX
         ANnVgW/RihK4WS5sZurZzEYNPrBpKMOCm4aECaY+otf/TfnBa7WvOVgBK82vqJPzxsdI
         VHANLd90HSR7Bt4DkpG47KvRZ3o8xB5AAKK6U2U4DXSdBiU+DtyL02bXLG6+7cPppSe1
         joyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ90NZ50fwcb23Q9Otbu3G4xJzJ3IlMd1zAm0eOfiZ9qIHf5Y/7f8D+Ue71HJfDhh6Dbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNIxRXKECGk34ij7Lp3L+h8UNaBRWkSLF5yztBKTS2i7r59oQ
	S4Dt1E//CzK3njayzXyiIbbsBYBPmF7fTqN/7evJW6qhoW6ZZpfVLNI58S5itA==
X-Gm-Gg: ASbGncucR9iJGFHLNzGRq2+qiTIBgmBVTetdT003xnKVMI7+QhDwIwUHn1/ZqHjYzJ0
	TG4j+e+kBrN1ae8XzMN0Dq0KcvrBUx8R84Fnrcq5mvXZmDD0+0L+Wcm22ThTFD1T1j6qy+JjXeF
	GlQkx6dWlLFUG18KaRta+JgAVKhXwZdWyW6hYx8nDo0scfRj2AUHQjoz8pZ3vML+DF7P955e9+P
	l3xxjvBVANIXR1ER7XXoGdABnsIb0vkjbin7pwYAtXKM2aBkTmmUmRjcBTcpXcco98+u8CCrqI+
	kMvDu4aa136Pto6ITWW40uGr0SkIyrzKGyD1UMINtvxB1qSUMJmyRtv/wEQ5vEwM0SIzTpe/i6/
	jSjRNnKhm3VGzcfM8kKgoeM/Mg3N3qNObftFS0NR6+8qO
X-Google-Smtp-Source: AGHT+IHxAzHPzFrQZj9GQ9lFbP8ozsx1hpogV+zxgs+TGN2iltDL/PsIgh7jGgpvrSl6He+j9KtkMQ==
X-Received: by 2002:a05:6000:2013:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3a8fda35a5bmr535329f8f.10.1750961070291;
        Thu, 26 Jun 2025 11:04:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5? ([2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7814sm527609f8f.8.2025.06.26.11.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 11:04:29 -0700 (PDT)
Message-ID: <087d437f-3163-4c63-b6f5-e5d726016359@gmail.com>
Date: Thu, 26 Jun 2025 19:04:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] daemon: use sigaction() to install child_handler()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
 <d7c86948-e0b0-4864-88f8-fd1222e0dffe@gmail.com> <xmqqy0teplfa.fsf@gitster.g>
 <wanrtwacxrjmmpfnjwxhgdfhlo4uvnktijnc2rxdzlnkpe5r4a@3b2e2onpqakp>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <wanrtwacxrjmmpfnjwxhgdfhlo4uvnktijnc2rxdzlnkpe5r4a@3b2e2onpqakp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 26/06/2025 17:36, Carlo Marcelo Arenas Belón wrote:
> On Thu, Jun 26, 2025 at 08:33:29AM -0800, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> Thanks for a suggestion.  I really like the "everybody in these code
>> paths are prepared to receive and handle EINTR just fine, so we do
>> not have to do the SA_RESTART" observation very much.
> 
> Except that is unlikely to be true, as the code has changed a lot on
> those 20 years (including that it now uses run_command) and that we
> had been effectively using SA_RESTART under the covers for most of
> that time because signal() behaviour changed. An obvious bug:
> (ex: 20250626161038.85966-1-carenas@gmail.com)

I don't think the syscall handling has changed much since 695605b508 
(git-daemon: Simplify dead-children reaping logic, 2008-08-14) when we 
started relying on poll() returning EINTR to collect children that exit 
while we are waiting for a new connection. In any case my comment was 
based on reading the code. You're right that we started using 
run_command() after 695605b508 but when I read the code in run-command.c 
it looked to me like it is pretty careful in the way it handles signals 
and EINTR - what part of the code are you concerned about? As git 
supports operating systems that do not provide SA_RESTART we should to 
make sure we handle EINTR correctly in this code anyway. As far as the 
patch you link to goes, it may not have been handling EINTR as 
efficiently as you'd like but it would still accept the client on the 
next iteration of the loop which would happen immediately because the 
connection would be pending when we call poll().

> I think using SA_RESTART by default might be safer,

The counter argument to this is that it is masking bugs that happen on 
platforms without SA_RESTART.

Best Wishes

Phillip

