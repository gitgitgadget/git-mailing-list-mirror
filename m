Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBF2BEC45
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633773; cv=none; b=r2MoqT8x1CF5C5g4qNFu6e/A8A22+Z8zrDuXiD75jxvEZV2k6MzZOZsD5I7CruCsaF83SoC30I16A3MrZwc396JuSIKUYKCNE5eWYOIPDRkjh0fyWZ7/+fyMCJi1ofTGitUbrtl0ExFyNDuEXhu9nI32zmRklldNSwPmHYEUimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633773; c=relaxed/simple;
	bh=jUSV5F4xQxMl5fNdpuuG6GXR0XUn7yKpvBUd56RrqdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLnS4muCVMPqgNSAL/NU/fM6oD7qiIYdqsgDFMRarrCuew0pija7bum4g8frsdYwYsSYS9atVSlI7lr11Qbri1Y17BEOYlVUZh+Ons0ChHLbypzi1Rd7y7JvFNRGcRXd0HxfqVIFlneqa000uJLPbzDy2ievpsycTRIqFx3F9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCGdUUI3; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCGdUUI3"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48336a6e932so8019975e9.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633771; x=1771238571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ttUPiKCIzdRYzKAbm4YIKarkuyui2g5VP+v1lVZ8blM=;
        b=XCGdUUI36GjqE49HV64UQDufBBtGC56MCFE0InrTW+hWVZ1bHHAoWx1PgXGGiWnsbG
         zhBaUbRVLln90ntuiVB6wxCkmA4+sM3pvB1SJ1cnZM6NQgKz/zbZNBosfDsFjXFwa2lU
         N0m0HvHK7qt5Cxe8S1F/CjCl24xo/HQY989vSzRiRqDbtU+1xaVkBThSxuPlV5rJ5V1H
         9hasaNu79vBkRfXxQm0wLuFoBLvvACvm0Wx9wyxfEFHuJ/xePWE6+eFoHiKPOJwaF9cC
         qYVV6sAEs3VC/N5uztmljGbd9k3pWEOV5P9pttVOhtb9hfzgUoE3r9D5ME0pzOoRu/bL
         5y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633771; x=1771238571;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttUPiKCIzdRYzKAbm4YIKarkuyui2g5VP+v1lVZ8blM=;
        b=OrhYQqG7vw1ZeNYpKI3fTRnONqQWHAe+xIq2aojw4nZpTWj2FG0/G4DCE1Eu5XA50B
         bFsmIPGlhnUZhLo/NbFrJ3Q/mZ3MmejWrb4XtnmM0nVNM5v7W8YdlNbq+7Y+nWYb/sdp
         c4kCepIKpdnJe6AawWI/ns9jHUhPCuVjO1NBTIzD8TftiCgXvI508bSgt3D6suqUvacN
         n+r3vU7gMUa/Uxl4RlwliTCI464KB1fC6GFYeIwmEddnJ3AGwGwzj1J8zC73H5hDRD66
         VGkvUM+82tnskfpw79XO5+aGHJqvbs1QSin8djwiB1abcP3IeOJ3X0kbaYU9N1loYKaS
         i+Jw==
X-Gm-Message-State: AOJu0Yz09tkr2r/t0D0xF7tuHpuyk1EgT+7EjP8kgZdTIo9lwY2VNWtz
	yYoR5EUcOLkOoo1bAFdbGIZ203qerZShI+5O3tBCe2iniJbxJ4fYNCAj
X-Gm-Gg: AZuq6aIK+jsew/ysWWRRQUV+cR+UjMUceXGo0v1LefckP6gMigcBdHbhYFiEWhGYVgn
	5SsjHMsgH0Qc0hGUzK+ItG+ypG+3QvqfojM6f8YMd/w8jjiPR/yoafKikiAxVIlGmmdqTh6flnb
	ASXrytAYaCIKFaxqA4+v9H9tS8f7HewZJVkxmeKSej74NwdJM+o5YIOoAvPc3AzS9chY4XCqv8+
	vpVnd7J8WBrMFPEpgjXml1U8yeBoj9+ql1wdnqtAICFiVT6pT45ksD4xmWI7ArkLdRbnzmcYzWB
	zl/nn3v+GCIlQFy6stx6SQZFarBM0u8S44w6/b8OBsdeU8fG1ooNS/PODMllYmKh7kJNsErosQB
	e08fR1T3XZZ8j0jenfFarSB8iGKgCtZnkGt3/9+/32cH0+3bOW9K6OlI+D3RZPEo/0g+kIqRF2x
	U47MTFcXMdtrvAY9Li2sZ4PXiYI+OJn9rJqYrrBTWi9rIO1k0px+8MmWFBMebQZ6CAIA==
X-Received: by 2002:a05:600c:3509:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-48320216069mr131269045e9.18.1770633770906;
        Mon, 09 Feb 2026 02:42:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d8e8d4sm319667605e9.15.2026.02.09.02.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:42:50 -0800 (PST)
Message-ID: <b0c456ce-94f6-4155-8cbd-3dd75a9cc52c@gmail.com>
Date: Mon, 9 Feb 2026 10:42:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] templates: detect messages that contain a separator
 line
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Matthias Beyer <mail@beyermatthias.de>,
 Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
 <xmqqldh4b5y2.fsf@gitster.g>
 <20260209070018.GB585828@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260209070018.GB585828@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2026 07:00, Jeff King wrote:
> On Sat, Feb 07, 2026 at 01:27:01PM -0800, Junio C Hamano wrote:
> 
>> I have no qualms about the topic up to the previous step, but I know
>> one of the things that I sometimes do will be broken with the change
>> in this step, namely, when I know what I want to write below the
>> three-dash lines, I would commit with "---" and additional notes
>> below it, so that I do not forget during "format-patch".
>>
>> When the commit is turned into a patch email, possibly with some
>> other material like "--notes=<ref>" that adds notes there, the
>> resulting message will have two three-dashes lines, but because "am"
>> cuts at the first one, and "apply" knows that the garbage lines at
>> front, including three-dash lines, do not matter until it sees "^diff",
>> this works out perfectly well.
>>
>> Admittedly, I myself do not send out so many patches as I used to,
>> but I suspect that there are others who have discovered this trick
>> independently, and they would be unhappy to be interrupted by
>> commit-msg hook like this.
> 
> I do it, too, though not all that often. Once upon a time I had a patch
> to teach git-commit to auto-convert lines after "---" into a note (which
> would then be formatted back out via format-patch). But I found for my
> git.git workflow that just letting the "---" ride along in the commit
> object was simpler and easier (since I don't care about having pristine
> commit objects, as their ultimate fate is to be dropped in favor of what
> is applied upstream).

I do it too occasionally. I had planned just to use "--no-verify" when I 
did that but maybe we should just drop this patch. We could make it 
configurable as Kristoffer suggested, or, as we have the raw message, we 
could look for a special comment like "# allow ---" but I'm not sure I 
want to spend much more time on this. At least "---" only truncates the 
message rather than applying an unwanted patch.

Thanks

Phillip

