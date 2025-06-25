Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942E202987
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840841; cv=none; b=ghVNlJ5QNJtuVbHwayUoUKvJ5XXm24WQi4vhoEaA5aWGxxWxfyG/dKOTGuzix65QS5CbmGWumd9GUbNx09xotHtOdoqk5J5RgruAuaadS7jLXUi9NENgZ1IvTguH+les8vZ1v6/MDTN85QMg8ezMVPAn9/e1CbQxxr3nr3M08gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840841; c=relaxed/simple;
	bh=sKVTfcJxuyl8UxUANvu0WAzA6WqOjPfWxeVTmp/CSKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=V9MZhByKIJBDkBGdRs65SPyJIrBgqY5tlUIGSECICdfiTKg3RvtLtgoQOtfwmy2ANSyH3gCNJx1AXZiJBAxfONxLLLkX2Prnv8mE6sbGWYd4+Q1Dl5zo12CJBVTsBVgsA+J1ZhvjKpW7sxTHq8wC9e/YViPcxkrvh9S85azymjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INwpXV7d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INwpXV7d"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so348295f8f.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750840838; x=1751445638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IdnQ+KPRSteT5ByKc/gNoml/b4Q4fOj/NjKB/N+0EOI=;
        b=INwpXV7dLE3vw7YVFIHqo8lqt145APr+JfQcjgaFxItrOJlXuAQHfzFmof5V5wP8dd
         BSrGwjWbeuBo3Gwt+9wJO3Fn6pZCumOhVfaluJhDshjzu3Hv4joNvUJLpIaV9GtsI6sX
         fbI8dsPcKnFJmcXCgQTXvEUXDvNTKuUfL8IKQWMU/J2CWp4eFanfZip+AEp3IiuxTimI
         ngQ4Jt6tPvVD2coJl09gvjXDQhIXHidNlMbUGlMzeFimNVZPNrKblcgXFcCzlgKb4WTK
         HoLtQEslZBvnV7k4OHtq/a9RltmDSH22ljaKy0OpeR2iCejVtmpNEV0Aa5i4adUqHi7R
         vLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750840838; x=1751445638;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdnQ+KPRSteT5ByKc/gNoml/b4Q4fOj/NjKB/N+0EOI=;
        b=YWOPx9Vb6dMu/4ORxbD6WOV3W/zxXde2gZGnWA2yvfNyHVxL2xtjfpPUxskp+HjcAl
         OUUVqU1rSUTrXKzH/gJVpTqu58Zu9oANdIk5yS7/zrSxe5AzNFjOKrA/27XjBY47r0II
         NRV1fUtaC8/k80tZbR2Km5p1guZ2KoGMpVuqXTmsSChePXVMve6J/UFRejw/H5dBLMOF
         ASC4RVm7P4Th7A6BTfu/thROeLI3GvPYsSY2yoUehpQunMn7TSR1jYZLVEERGdSWOw+Y
         Ns4vSZCLfj1cYSzYuIIaOJbtJsP9pWvyx0Wywsv3/JAmdMVuXmI6jvaDPL4KHMLlV97S
         s/ug==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ2oi1VuCg9BX8ZW4gqOUaqIc8bXnS36uvayyj6c4wXz5MM/im2hdbeZdD71G7tcjxOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY3UR1o4s5AwbLmFx0SzxHPPfbxwBQze1hY8Xjat9IK+TozEL
	BRmhs+MB6lbBFU8jiACivRKMyShTxVH7mSj6x8OsfJNXSjPZ8/qWB9hQ
X-Gm-Gg: ASbGncvXuRByS2dDq3JSWLLFPZeyKTCto6RMTiBrjQFXL5qDMNY41J9kJ9hLmNAA+n/
	QLOOvQFAU23zoSlEvZNrscKcopGjkSbditfmEkWdhXQcPTgZJdORu6jZ8iEoEIWsR0ojOhNqpqp
	ctWylsNrTCfaTqMQU/NQ7iDwyoV4V7b+2Myiptx7OVfa0ELGC04uT5QBGXTtNPLvjZTFB/7xFi5
	mGQQ/kK/AZWpDZVzOPiZOXufvzqWD5kQG++OheZPmfqonoAF/XONQ44kEka+ET632sd5ma2yLLt
	+fwhwGRr8DJrHA+2lCG0c60aWpScHpvLk5MUJEuMcFB9SWqRzU6bdwApFqvigpsh8hJ0HmoYAjW
	VrFPEdsO1Jka9/N6od1c68SaSu29fB3K2xQ8I+w==
X-Google-Smtp-Source: AGHT+IHfZf9zoHCMRzeIdGpDO4fODvHuzX5/739Yswu0OVbln2/Bxk315qn5MSkUO1y5Ujb3UAeRBQ==
X-Received: by 2002:a05:6000:4702:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3a6ecf5d3f4mr1668135f8f.27.1750840838383;
        Wed, 25 Jun 2025 01:40:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80ff799sm4066894f8f.69.2025.06.25.01.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:40:37 -0700 (PDT)
Message-ID: <323b46b1-ba9c-48f4-a8ff-f889f8173ff5@gmail.com>
Date: Wed, 25 Jun 2025 09:40:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2025, #08; Mon, 23)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtt462bye.fsf@gitster.g>
Content-Language: en-US
Cc: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqtt462bye.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2025 01:57, Junio C Hamano wrote:
> 
> * ow/rebase-verify-insn-fmt-before-initializing-state (2025-06-09) 1 commit
>   - rebase: write script before initializing state
> 
>   "git rebase -i" with bogus rebase.instructionFormat configuration
>   failed to produce the todo file after recording the state files,
>   leading to confused "git status"; this has been corrected.
> 
>   Comments?
>   cf. <20250609221055.136074-1-oystwa@gmail.com>
>   source: <20250609221055.136074-1-oystwa@gmail.com>

I think we're expecting a re-roll cf. 
<7e796844-97e2-4b45-a76e-4c1fcb1da3ae@gmail.com>

Thanks

Phillip

