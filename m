Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095F2857E4
	for <git@vger.kernel.org>; Tue,  6 May 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554406; cv=none; b=EL/mvgvONXTCde5nLEsIS5FNeDJy+7gH4PN2l372+f7qcarXSfQrnXMcsZfF5gQ8VwsJZ8M+2iQ11BNRkEfSxLxS7rAWN0KrSK/7f+mP9I4umhXpZ//gMXUNzpz27Joj0iU0YJPiUOba6yPlB5GrjMPIV1yEuRNpQyE92J1u30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554406; c=relaxed/simple;
	bh=s2mdleRhVfGpA+TYanNN6Ntrm/fcjh77JBuWIsqxCp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzMpT0Gvety5CR558mJGTJggis/e32zHHUCIXrxV6UEEvtsCSjTffpEAFQnchPcE+Ylr6xCtKu799oMUuqYFSKMOc7D1uW9foymgc3541u6RAiboHcSt4CAM1A8og+drog2yPwk1VlASxyDfk2sNPeR0RI6x12UduRDeZz9EeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGmZ2pDd; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGmZ2pDd"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7080dd5fe92so50810177b3.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746554404; x=1747159204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+9bdVtD9uf00sSLHqtGtwfzn6B/BktHeqj+Fo9jdgI=;
        b=nGmZ2pDd6bkfnyo2PfQ2v7SQEWc9GRH64G2OEy1CWS3YlJzdjBlNURWGDPv4WB3mYu
         Oi1o6NwcxLT90ANCTyLHgqfIFdgoNnZDOQwt+opGJq7QK4A/q/Jjd02/jmnSkmJfjTPk
         5K1QQDOXhJzXo9dc/hsgzjMMFk6h3D3H7kqayFPHzc1Jf49W63sm8bJpQYhqjPnMBGXj
         5kwbhgVUYiz3GaDd6ahE+kXi6z9MJSglBY5WiBkFuK9UMvvyl8Otb5zy8zF9qiuO6D3A
         PbcNsrbEbhOzj0t8YoaM8484VOjmDluYAPLqLF/Gq/qwdzBKVIO4OqLNvIVBMFHEtEDg
         yFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554404; x=1747159204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+9bdVtD9uf00sSLHqtGtwfzn6B/BktHeqj+Fo9jdgI=;
        b=PqgZwtjYGN7SfYVBz0onXWIa3gPShxC6EvkYdbRFZjwCISI6jewxsgccYSKATw/NMD
         ro7QgIB9j4SypFnihUvJYFQrxAz4kXk8DNJosPT7JP1UD+mzWqAbZWdG0dhjxFJjjNje
         F3yQJDjm+pm3eQbUyh30aoe5icH3PdvgPAyes7K+gNUDNlqrls0/RypItC9UnoJkV3O6
         uA0gqBsjSYsiZ+03OWHqv5Pyqsb56av0XKIaN1zyx4Bx6gUQ76GDmf7mgw/PdFgL0iFI
         ihoSaBIk1gvbTXLCgd38Ctgwq/X+b6ZT9NUfWGojq3XKIHqakwxg6N2zwjs3/Dk/4QOV
         Eh0g==
X-Gm-Message-State: AOJu0Yz3SCg5NqnBlI28fZ+kTxiTmnX4pvEpFVwhBTGdg8j1C+Nwa8jt
	hqugOgG4ybekztIT/vWEMkHoUfLei39g+zyo3uAFLYySmFVAaEgw
X-Gm-Gg: ASbGnctOXxi/zB7f86eDndVRm0lKDxQ/NM1ISIQKD7czngvkfejkMKmJHexViuMAkRg
	SFYPmZlnCtOv0btpsKDkfwtZ4OXAyVNTARnGNU08Jq61UzBEVC+QqIMpTseUBN+WPyiEBv5ZIMs
	v4RDmWn/o8RhL936J8b3dM2W9x0EP60Ri1e0u9VbuSiFIGSiQrd6bNoOqJe4Pq6Tv8CxC5012Yo
	5Widr7HUD8GBs8+dd0Iz5UJ0I0a7gO7EMH3JwcneppzuMA7IxBA6z74tFSyizcNsRnKC2oqacnI
	32iaDkuLbOn61w6Ux0putEUTp2i1UwmNIc2FBTC3P8NHu7zP/hWzj69LrrHA29Wc+E390bQVHkX
	LrFoFp5hFHvwBQQT8
X-Google-Smtp-Source: AGHT+IEHpsptNgeQj/Izdu/blS1/xcir1YTVNVRmEQE4YS6xm6M4UobhnmneDEZ+A0Z80ifUBFcTeQ==
X-Received: by 2002:a05:690c:688b:b0:705:750e:851 with SMTP id 00721157ae682-70a1dafceb5mr4726027b3.37.1746554403902;
        Tue, 06 May 2025 11:00:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:d190:934d:4c0f:2336? ([2600:1700:60ba:9810:d190:934d:4c0f:2336])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c46c022fsm28210547b3.112.2025.05.06.11.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 11:00:03 -0700 (PDT)
Message-ID: <3e307bf1-52ef-4280-bada-5cc50cc7a817@gmail.com>
Date: Tue, 6 May 2025 14:00:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] scalar reconfigure: add --no-maintenance option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
 <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
 <6fac9c4c394b9882a2f7af6209af389edf384e4d.1746458844.git.gitgitgadget@gmail.com>
 <xmqqselin30f.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqselin30f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/2025 5:47 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> When users want to enable the latest and greatest configuration options
>> recommended by Scalar after a Git upgrade, 'scalar reconfigure --all' is
>> a great option that iterates over all repos in the multi-valued
>> 'scalar.repos' config key.
>>
>> However, this feature previously forced users to enable background
>> maintenance. In some environments this is not preferred.
>>
>> Add a new --[no-]maintenance option to 'scalar reconfigure' that avoids
>> running 'git maintenance start' on these enlistments.
> 
> It makes sense for --maintenance option to be between enable and
> disable when registering a new directory to the system, and when
> cloning somebody else's repository that causes a new directory to be
> created and enlisting the resulting new directory to the system.
> 
> But wouldn't users want "leave maintenance-enrollment status alone"
> option when reconfiguring an existing already enlisted directory?
> 
> As written, the design easily allows enabling of maintenance as part
> of reconfiguring, but disabling cannot be done the same way
> (i.e. individual enlistments need to be visited and their
> maintenance disabled manually).
> 
> IOW, it is a bit counter-intuitive
> 
>> +--[no-]maintenance::
>> +	By default, Scalar configures the enlistment to use Git's
>> +	background maintenance feature. Use the `--no-maintenance` to skip
>> +	this configuration and leave the repositories in whatever state is
>> +	currently configured.
> 
> that for clone and register, --maintenance means "enable" and
> "--no-maintenance" means "disable", but when reconfiguring an
> already registered directory, it would be natural to expect that
> "--no-maintenance" would explicitly tell the command to disable
> scheduled maintenance.

I can see how this command is different from the other two, and thus
a three-way flipper can actually result in three different behaviors:

> A 3-way approach would make this part something like ...
> 
> 	switch (maintenance) {
> 	default:	BUG("..."); break;
> 	case ENABLE:	res = toggle_maintenance(1); break;
> 	case DISABLE:	res = toggle_maintenance(0); break;
> 	case ASIS:	res = 0; break;
> 	}
> 	if (res >= 0)
> 		succeeded = 1;
> 
> ... which would allow people to easily say "leave the existing
> maintenance state alone".

This does mean that we'd need to have a different toggle from the
typical OPT_BOOL().

What do you think about something of the form --maintenance=<option>
where <option> is one of these:

 * "enable" (default) runs 'git maintenance start'
 * "disable" runs 'git maintenance unregister'
 * "keep" does not mess with maintenance config.

Does this sort of option seem to make sense? I'll wait to see if
any further adjustments are recommended before I start rolling a
new version.

Thanks,
-Stolee
