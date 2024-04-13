Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65A42A96
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020804; cv=none; b=tsfT1/QOPlCAYhDQaZ5FsXXV1ypB2XTDaviksyBaQXmuac8aAn6dvKw1pvdEBF3hdtbeXHxphR81UJmuIaHZSnI1aG9dUJ1+FhrpuHWilI/99jUXUwYStu6eIa82Enxqw3ouv9+fk9Rjx7tJ6ukobI6rR+nhQMmEDj59u1CC+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020804; c=relaxed/simple;
	bh=bZqUY7oI12zl5Ez/yRyqhHa33VMQiDFURwpJyufCHVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VwJFRum3JJaF7ODlZ6s56G9EunVGsEGH5XUuJRtllx2n7xaj86ce8Z9aqAdGeXe6sxDQ7KLcKxeTumzytwibOW9JXNcfU4ljykY6UcZ/Tdms5qGmPZqZ9mKzEqZI8Qm44Kq4ZACcB/MdWiczDDLwbhZ1EDBVuzGcqmP6GUPpv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoY9tfSy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoY9tfSy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41821ef0a74so2731005e9.2
        for <git@vger.kernel.org>; Sat, 13 Apr 2024 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713020801; x=1713625601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hdSOQgloPjDBYi/3e1aIlNHTe2cZgXUR2VcIjYVTu1g=;
        b=DoY9tfSyYyJ0cvn2+mkiqSIFAia4xtETUYIDTJnj1hZiA94hpNJEpa279vYj2yrFvc
         5wqSFam/o/u26MUkr+2LauNNZuPubC49NqlCV9trytDf62EFKWAy/OeQFfnAjQNIOsiV
         5A2cnkoAJWiZigqO+OKWQf1VPgs5OwfAFwmM3F3WuM9v01BzEK6Fq0pV6eniU3BjqhPw
         fGFc+SbQxdU2Z7UWj6bdu9gglCqdEVYxT3JjIWNHBW5B3Ilrsz7RX2E/lbOHHk/7DBRA
         WTzeWaxoUqwxGiCL43HNSQrRjVoU0cB7T7lYVkX+dLlbH1ExSR1fgKpvWgSLJ8rLAiRT
         8Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713020801; x=1713625601;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdSOQgloPjDBYi/3e1aIlNHTe2cZgXUR2VcIjYVTu1g=;
        b=UeU3hRjpDhpnA23PyHnw77ETUx3Bx+FstANM2h09R+KSIcPzouCNqZkFzwCxg+joB5
         /5fcEY8+pYiva6VIoFl7bPPJPH1JueripWSQBKxmnLdVKYrivSDFemnUrDMKom6ZU2zX
         q789qYYbrSah/Mpg07Dqoag3Vr446DCiAnIsFmG4GnVeK1IxbWdVz9icjx4FcawHghyA
         EJAcnxAbqUy1F3dRnsdsnm/k2fmhljGc1CLWHt7LG3urb9IE5mTVRsws+xa8XJg2DlV+
         VHKcQ1aralKW8d5ujLqWjDz8kOEG9TkiBXts6X5YHzpSX+dwczPmL7LwIB2L4aJKmlXI
         QqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV10v9H9yllz6vYRUgXObcBlXKwABFk6paC6ztsJWNCDV58DKMB9sdrtKLs+cDfzrbsOIYjZM6rd/aemFwd+yWCAl+k
X-Gm-Message-State: AOJu0YwvSnoAbmb28s+mJ5G+uN4WMHfH0bogBYTRnGshFnC0dKUBbGZZ
	loJaXcTO4+yrB4LBr5BzDE+LLDbb2e4SX1RMJG6eB0sp7kcpq6sn
X-Google-Smtp-Source: AGHT+IG6QNwL9/5J5My29VUUHZly9kV/bEItN/pdXNNE04OVvscjbCLIuGLUpy+qfAYvbnR9ZQpjAg==
X-Received: by 2002:a05:600c:1c05:b0:415:f755:5a1f with SMTP id j5-20020a05600c1c0500b00415f7555a1fmr5038324wms.29.1713020801052;
        Sat, 13 Apr 2024 08:06:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b0041563096e15sm12510165wmb.5.2024.04.13.08.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 08:06:40 -0700 (PDT)
Message-ID: <eff5b9b5-1efa-4a63-8a98-a5630a17fd94@gmail.com>
Date: Sat, 13 Apr 2024 16:06:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] launch_editor: waiting for editor message
To: rsbecker@nexbridge.com, =?UTF-8?B?J1J1YsOpbiBKdXN0byc=?=
 <rjusto@gmail.com>, 'Git List' <git@vger.kernel.org>,
 'Junio C Hamano' <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <83b34572-498b-438c-8437-dfbb837e60ba@gmail.com>
 <02b701da8cfe$59be3370$0d3a9a50$@nexbridge.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <02b701da8cfe$59be3370$0d3a9a50$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/04/2024 18:24, rsbecker@nexbridge.com wrote:
> On Friday, April 12, 2024 1:15 PM, Rubén Justo wrote:
>> Subject: [PATCH v3 1/2] launch_editor: waiting for editor message
>>
>> We have a hint shown when we are waiting for user's editor since
>> abfb04d0c7 (launch_editor(): indicate that Git waits for user input, 2017-12-07).
>>
>> After showing the hint, we call start_command() which can return with an error.
>> Then we'll show "unable to start editor...", after having said "Waiting for your
>> editor...", which may be confusing.
>>
>> Move the code to show the hint below the start_command().
> 
> My thought on this move is for esoteric (but commonly used) terminal emulators. If one is on a t6530, tn3270, or w3270/9 emulator, for example, the emulator switches modes from text on the POSIX side to block/full screen mode when the editor is launched. Printing a message after the editor has launched has the potential to dump the message into the terminal emulation buffer and get caught in the commit text comment. This is not desirable. This change could have seriously undesirable side-effects.

Writing to the terminal after starting the editor is a bad idea for the 
reason you describe regardless of the terminal type. I don't think there 
is a sensible way to avoid showing the hint before we know whether the 
editor started successfully or not.

> On the other side, if the message is not displayed in the emulation buffer, it is deferred until after the editor closes, which makes the message a bit pointless.

I think the message is there for gui editors, with a terminal editor it 
is obvious that git has started the editor and the user doesn't really 
see the message because it is cleared when the editor exits successfully.

Best Wishes

Phillip

> --Randall
> 
> 
> 
