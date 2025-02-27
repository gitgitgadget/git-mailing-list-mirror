Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF41B042A
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673609; cv=none; b=BQaBy+g7MzsD67ZuCshOxJqJT5hMmzmqgfvc7ABNOOp4uDThs2vz/50YIqyuJZFWIFsbdEPTGA2q3sRW2TMUWKvvh0npX7JYqnzzv/N9/rBXD/IfeIO28mCtb4n25X17R4GZiZ2FvJMPuq1MBmYawrIj/qN3e1GMPHJKIwhFmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673609; c=relaxed/simple;
	bh=ho9SdRPvjg27B4Pbgq4RrBDW3uvsXFIV8F6dsgx22lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TM1sr8yNOs2ufRLzP0rGDIutz9OXR4BPOAjOSIyJrzAZXYzkXsxBZMyneS2aNtJ5qY4NVZ2VHFrlqS93iu/P6w+VQ/uCEvHmHzOqizZoYF76nRwQPU5fMrFsRbLcz/knyyJrm5hdXmmdOC/3PPJ3r77XD5Z2d8lfgDioZfV6hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpKv/htX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpKv/htX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f378498c9so1155878f8f.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673606; x=1741278406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hmswuyNyhY2pgi5jPaSji+nDZzuOCQcy/lWpucSZAko=;
        b=SpKv/htXnFvLNtTBpZE9pt9NuCNJx2/c8Exq+KTJI1KvHdGYOKwTJ45WuLN+m6x9Qg
         znQIZ3LAePWgH2RIoC53eikZJG/7sQcLMjBaZaKa3hJWE99DXJxnWRys+y2x2rIi7JqM
         oN+u599+3QAoKHswoRqboxsvrG3G5l+e+neX2kybJB/XpkfSvXwASGWEO8+fbTs3h7Y4
         anUBEDpJlYTSCq2Zu4hB6TJS2xtBrGzY3pTni1pvfRIN0IgvAtRsRnKYvHJoWI2yMSv1
         XuOEhm36YMGWutj/JrfwluQROOZbVSyyJ/c55BVEtIOw57URA4pQ3uTokf18dc07GzyC
         tulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673606; x=1741278406;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmswuyNyhY2pgi5jPaSji+nDZzuOCQcy/lWpucSZAko=;
        b=M9tI9gxP8ygtfFvvNO67L7bi9oSojs4R/o6ffgWm9BzsNEr8RIAJGM7YcWvJsr3MCA
         tcccdnj7Hm3aSc6+Vmo0R4PcEnhIW6UPB92eMNsjQXNmDD+9mMW7fp2ZUzWzhTjhxxDT
         Hlh3hNIinAJQk/es5Ssw4F8WZ1XGRNkBM/oNqyEHjTPXsNAutV1K5M33wyKnm3yCFWMA
         22OkgT5L+ELYCLYg3aXHHqwgjIFN9Mbw1F5P2nOOUC9ZxQzTTm8ZicNeuMRgz/lgvJ45
         BMzUPYi1sSK+iQiVDC8wVH/c1aRSYskPm/IUTcycooOAj1Z/boPViAZ6tNUrm8Vwh+Cw
         7cdw==
X-Forwarded-Encrypted: i=1; AJvYcCUn7gRVz0AkdrOF77og1lfHS19W9bcs3wp8ddvbCzZayg//hk/fHJA1xirjWesvN0JdISE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWygi8SmYrM9z0JZ3ANY44OrzY0Uqk3b91HFS1sUCFiDSC0JAV
	wlloXMcy2J8N0Zec4JjwemoMZp7cEmEAH+790z2UpRBrVMAn41YhemihXthTijE=
X-Gm-Gg: ASbGncv9h8fXmaQ408yt1jTZoDvL3rZ1W/OtJE1407VFzwUUlgQmvS5MsbUcHP/k54A
	2KuHh58ohyVfNqRHE5wV8VkRNChNSMr58OAOLSlX5Nxv/SGU4fxzp0Y1SCu1JipYZOIuVW3ZO3T
	iy8hZiyEbknW2+h88coEfeJN0Hk6Xjl8zN6E4SrKzp2r+NZiE0BCTUSzrProiR4RUouHHLijK6/
	+dNhtqm6pRgHi+T7GjLW43ShhjTuHwoZJPmPCqqo0Rlh6NzfKfKFyPHEMWP9AKFukmask0leHCP
	OwJRrVD9A9dhYawEZOhuDwerNXgeg4pYI5gjBpViNMyw/psVfjBNHclvGXHz17YJK0PdFzKA4jD
	dPFVq
X-Google-Smtp-Source: AGHT+IF5bjo60XT7SdSY7m5bE0C26qmB35LLibOrmtPdYb/koEfD3KrhDxA0xg3athuI3yLI1tYW4A==
X-Received: by 2002:a05:6000:1549:b0:38d:df29:e14f with SMTP id ffacd0b85a97d-390cc631b46mr14374208f8f.43.1740673605950;
        Thu, 27 Feb 2025 08:26:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a5b96sm2551734f8f.29.2025.02.27.08.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:26:45 -0800 (PST)
Message-ID: <f455db00-2064-4c2f-be2e-6c5970843f03@gmail.com>
Date: Thu, 27 Feb 2025 16:26:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: \b character escapes in CLI usage
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net>
 <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 23:36, brian m. carlson wrote:
> On 2025-02-26 at 07:38:22, Jeff King wrote:
>> On Tue, Feb 25, 2025 at 11:44:33PM +0000, Yaakov Smith wrote:
>>> 
>>> Should "git config" be smarter here and print something other than a
>>> literal backspace to the terminal, like "git fetch" does?
>>
>> So I would say no here, in general.
> 
> I agree this is the right choice in general.  I wonder if we might want
> some sort of human-readable output option that might escape these that
> users could use.  The output might still be machine-readable, but it
> might be easier to parse than the current format, which has some tricky
> edge cases when a config value contains newlines.

We have '-z' to avoid that ambiguity. I agree that having an option to 
provide a human-readable output would be a nice addition.

Best Wishes

Phillip

> We already have precedent for this in core.quotePath and could easily
> use similar logic here.  That format, while using octal, which I find
> ugly and hard to read, does have the pleasant side effect that it works
> correctly with POSIX printf(1) (which I'm sure was intentional), unlike
> hex escapes.

