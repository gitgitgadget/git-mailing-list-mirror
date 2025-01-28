Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554F19ABAB
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088481; cv=none; b=m9bJBl3lD/9CxSpf+I5yt1fbIXxakEFwlKzGJynirJ9gi6DEzHUmKqWFoihRRC5h7ZKCJi/LU09aZUXsxPszg9TX/v9VUXWfJlAwsUyby1T0NIw6pUJreFHMMZgO0tt2cNMqV8UFYymJ4LQ6QYkgGqVzEMU5poipm05oteg0GqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088481; c=relaxed/simple;
	bh=SFFkFiR7yl+K9k8VU6R2l8VTMiWUxxd6pFkqRW4OUUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSmbFhVFdCnq2UTks+oGLzfpUawpLk8BpBo8pHeWyY2vp7ge4E6c9wt4dLzvNasqeSFq1elbQxIBkuYgFDc2PnXQeSYTzHVdew+GdTaAUmbbjOwc/NFKhDCQVkV0c7wwgFO8LS+0clliZp3eqderOEpNnTCxgn/bkCLNE52YB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV176x8p; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV176x8p"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso109999855ad.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738088478; x=1738693278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63+k10Gi/iow0n6DnCZBWNDZZanrQY1IiW5SDMa8Lcc=;
        b=lV176x8pKJPgL2DT9qjxmgxdYoDNljSO+Mp3wFTeQh9Hh8fVWhwBw/Ezv508rhy9ob
         Y1G0Cn8Y8r9kqT0RiQzIV1GKGfznoPdpwmoBkzRUMUe3RMpzO8d/WyTZ3mjiobk3gHuf
         o7XNnwJs2K2DbXvHZOoSmtf/y/XM+n67pFj2NCAPqFT+4CsFBGNJXrV4NrBXiDrSic8I
         852qw6C5WrwWRvq+Q3G/4sGwCxiu+lGuoJxtkhxCkQ4Lh1CFXFfBXTVWhpHYyIxvghjY
         cChzyVlr+CsIcqmrOULSe2JFiWYEXLLqICG8VgJFABEmHynAzEq8iCAt8Kx882iTzKr4
         LmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738088478; x=1738693278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63+k10Gi/iow0n6DnCZBWNDZZanrQY1IiW5SDMa8Lcc=;
        b=klWxTGBnWgefkdaXxUbwW0mUxDAxYxDNy/ErExtqjFJGp/Nef6R4SKUSvhQAedWfvf
         KcH4fYRcKAHOEObRfbpd9eYfpBCTOSfGzy1/ZT7MX64wgNu0awpwpyusEXJYmyNYaFC9
         FiXcjtIQnlD3fralNvTqMSRa1dAIoNsNf8/LoP4cX16rwf4ElUYZtJIyG5QtFTekpZZ+
         6URssB3fvraHqaJBKOwyGGEDZ8C08WijmlKHHMvbk9rEmfjjM1h/wQD2OrwE1UJDK7VN
         0Pa+Kal0leBhuDBFWRS6WreIfy7TxSVdqyK50lZXvmSDpJeCZc6nSRMAfT6q/QjiU9w6
         q8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVkeLYMh5j1RvTEWL7xfIj4unvucsIPNoT/D3hhKhYFxucP6W27cBsv0Vo9RIXXcuJJbPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gu5Ol96MJK6Flt/W9F/J+6KeLk5KI/2DUtYky+VrQt7ixSLM
	649apTFHtveO5qnezG/F1vmAncaL3sqv/5KTLiqQNaAV1AvkA0+ByQnhJQ==
X-Gm-Gg: ASbGncu1sH8GWsHZ0SDqKfyLFkI8CgEwNnMOpKYrMGQ5xHMI1rMJgLwzA30jFKbvhqU
	KBN0z1/A8cys+qREdxtd8CpfvOFnWa85jsaDQhKn0P1gzYcI2VIRzCmxuCu/WJyHqff/r0QnQdy
	m0KtSghkOnv3m4SODrQVTh4PQYK8BdJmIhzViNodrBQBaL8bw3lCKX0uWqu+lUfzppM6zgbm/h4
	wXe7mW4DCJk0/xT9jMDm1S3n7VRenVYBTtYEXEo4UJi8mft23S9W2axUjG8dFT57T2hrSudgdb0
	29qSkLnNgCo+zk/iAr6i0TXW
X-Google-Smtp-Source: AGHT+IFpxiB3BLvxPFaFvz6igaULPSgtM4uO5Y/L+F9d1x6ycD0KxdP6s+Rmv5VwnyjiywgxeVGuDQ==
X-Received: by 2002:a17:902:ef4c:b0:216:60a3:b3fd with SMTP id d9443c01a7336-21dd7c3cf4bmr1206935ad.3.1738088478063;
        Tue, 28 Jan 2025 10:21:18 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c9f2sm84725435ad.42.2025.01.28.10.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 10:21:17 -0800 (PST)
Message-ID: <ca0fcde5-72f7-4245-9536-c3b41bbde8a4@gmail.com>
Date: Tue, 28 Jan 2025 23:50:57 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Patrick Steinhardt <ps@pks.im>, Jialuo She <shejialuo@gmail.com>
Cc: karthik nayak <karthik188@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 shejialuo <shejialuo@gmail.com>, Git Mailing List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <CA+ARAtqfXo75PzzB3cQjDbvLxwytUK=xJiGG=VHZ1sNCcfyktQ@mail.gmail.com>
 <Z5c-jFA9OAT9x5s7@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <Z5c-jFA9OAT9x5s7@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick and Jialuo,

On 27/01/25 13:36, Patrick Steinhardt wrote:
> On Mon, Jan 27, 2025 at 12:19:26PM +0530, Kaartic Sivaraam wrote:
>> While I have not included them as of yet, I wonder if the following ideas
>> which we
>> had last year[1] could still be retained this year:
>>
>> - Implement consistency checks for refs. The idea could be about
>>     implementing further ref checks which Jialuo appears to be helping
>>     out with. We could leave it if Jialuo prefers to continue working on
>>     the same in a flow.
> 
> The biggest omission right now is the reftable backend, but that one I
> plan to work on myself in this release cycle.
> 
> I'll leave it to Jialuo to decide whether there's anything else in this
> context that would make for a good GSoC project, as he's been the
> primary driving force here.
>

Got it.

>> - Refactor git-bisect(1) to make its state self-contained
> 
> I'd rather remove that project. It would be nice to have it, but it
> feels too risky for a GSoC project, and we have better ones.
> 

Ok. I'll leave it dropped.

>> - Implement support for reftables in "dumb" HTTP transport
> 
> I'd be fine mentoring this project.
> 

Sure. I'll include this one. I've retained Karthik as a co-mentor. 
Karthik, let me know in case of any concerns.


On 27/01/25 18:13, shejialuo wrote:
 > One thing I could think about is to clean up "git-fsck(1)" to make the
 > boundary between the ref checks and object checks clear which means we
 > need to remove unnecessary checks and reorder the program sequence.
 > However, I think this is a little risky for a GSoC project. So, I'd like
 > to implement this later on my own.

Done. Thank you for your thoughts!

--
Sivaraam
