Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6E2E65D
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308924; cv=none; b=k7TibKMQ1tPUabfHSuSq76zK5AufsviCXsXpy3UYOgxRBIw+pbpe9UWctyr9Jj2dLjOx4GQo6AuzR51xikHZriJfkppwp/6WS8siOSi08BoJlcYKnJRojRAYSh4u5x2kV3FWAsjB6/PKtNnvYvOpAqEFcueNqSkrkH2XuM8qN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308924; c=relaxed/simple;
	bh=Iv560Q/2sRQQm32asXlauuBFLI3XkAhXSUI3gPT9Ljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smAi03SYaH0yQnVtLtuYUV35aDNlnOkABcWm/EqEdOVBe/22q5+08d51tzfpPcd/dgJEj20e40Z30nQfO/lGptotVvbT4RoDvr/icFv7Uw2wN5tXW56kyf2Z7uF0JlpGAsyJPHozvP5oKyllJ+DKSxFCdfScOawVTHRT8YuGbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8e8luOd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8e8luOd"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso4152599b3a.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 20:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776308922; x=1776913722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FW7jcv3rlcgxM3YsYNrax6vlr7tqDzN/oHZKRmh2qU=;
        b=e8e8luOdk2Ags5CH78PgH7+Rtjdc6q92DKvYSTqeV4ij1UC09/ITMX2EdrpELj4CCU
         kGeHLC3UsUIxs5hU8Tc8LsJj3YDAMz3glRWOwhIzLNdBtgmdqg5DGQEXfnSAMJvXgLsE
         Pbo/hqdTmIbIAHUBUgxpcrYs1v0uTJWUXnzJ6/RCHwtbYAkImmzTY32HVGRNzvHlhAZC
         oMYPhGXlqlGyMdxLOc2Gh8Pq2k6Lpd3F3meVxFeOQjG8xV+CNkjqyK2VwJVzYWAEWOsy
         EzGAnTimw3bdNqwTD9ilIcJG/kwbHdq8Ocb5sPtO1smM38c2ChK8MWyD3xt3njSYKxJu
         MYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776308922; x=1776913722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FW7jcv3rlcgxM3YsYNrax6vlr7tqDzN/oHZKRmh2qU=;
        b=qhy8YjFdB7SOVDcut1wOT7ZP12X7tpv6456zzWD/PaijflbnK4ReUuAIItf20z+ufs
         PQfchGCgjcFu8y+DL3hxiRcJDhrgWc67vAsWflhNDl5csvbJMGsDDSYFIA/o5WiESdA/
         NBS5kKceONct/DjZgm3M/u9F/57xdYmC5tTzXYgNMUbJ98r9MlJpzTOFuo5p0ggKkax9
         f9LnpMZwMKz9RT1fhIlcfz1z1ScHqWtOe06JN/3ITS68+Q4qiyYTjvOXPD3fQmkc2m3T
         JgbdyxmjuY6pnMEUUjlmOolEOVba5ilDCAYDPc0Z0HxnwIawYy84DhGIPuGIeKS6ehh6
         XHrQ==
X-Gm-Message-State: AOJu0YxehP7DBDww2Ym0aJVp44XSxXLd0jHw19SLW53AgewJanm1Qrm2
	iUHQe5RkxoiH3vhcDnpCY/sjLphBaMwbGtmXwfUhRYnkEADBmdxOcOrR
X-Gm-Gg: AeBDieuEhFq6dSQCiGoTo4Un5AeYvQ6+k45WFwBUCAyHFaFsreo2/ZfagqbsX2vuTCF
	iVf0LWWLFxEp7047TxK7ViXZX7i71UMQfEPtWM6N26XG8SPuyv9C509nXDxsGAqTsgH0A1Y990a
	V5ufITke4lHpfEXNRG+Qnc96V6AIepWePFVC5aDGbrYtON06K0QZLoioyr1plffCEn1hmWFXI2D
	/9PMngshI9pabYbZkuvqL5c2iJnUvUyUPFLpixVSQVojWZ6eaX+kR2lHPfK9kVt0nh//vXLFdEc
	bOmAdGfvuRhcH5YeJrxQnwOoqt6VJJmjDyyg0/W35iE5HCRNSivcqFAHq3+EYkMxVQ6W9JUYJHJ
	1mVxcIP6p6r3qCF1RuKasLjF7MiBTq5XRPV6MNwUtfLDvr46fmeD3qQSUSrqp/PVWEOge0DR+zX
	5MV55OHnQ6oxKg8G2YA5BebGYeWwSBg8nipiDhOWXYZJbBVgBO3OmbWx9l3SLhlrb9j+pq3W8p7
	znSu68gRGN8ERUbmrDsO/7ve/qtPJ3N7aDQTCjP0CO5ng==
X-Received: by 2002:a05:6a20:3d08:b0:39c:cf9:b8e4 with SMTP id adf61e73a8af0-39fe3ffc2e2mr27157676637.42.1776308921951;
        Wed, 15 Apr 2026 20:08:41 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:6400:e3b3:3e97:389e? ([2409:40e3:30ab:6862:6400:e3b3:3e97:389e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957c0641fsm2794289a12.0.2026.04.15.20.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 20:08:41 -0700 (PDT)
Message-ID: <3e07118b-f98a-4bf2-ac7a-39c1f114a651@gmail.com>
Date: Thu, 16 Apr 2026 08:38:36 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cat-file: add mailmap subcommand to
 --batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, christian.couder@gmail.com,
 ps@pks.im, toon@iotcl.com, jn.avila@free.fr
References: <20260331121111.9614-1-siddharthasthana31@gmail.com>
 <20260415150943.40493-1-siddharthasthana31@gmail.com>
 <20260415150943.40493-2-siddharthasthana31@gmail.com>
 <xmqqa4v46ptu.fsf@gitster.g>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqa4v46ptu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/26 23:58, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
>> index c139f55a16..0f499c9d1b 100644
>> --- a/Documentation/git-cat-file.adoc
>> +++ b/Documentation/git-cat-file.adoc
>> @@ -174,6 +174,18 @@ flush::
>>   	since the beginning or since the last flush was issued. When `--buffer`
>>   	is used, no output will come until a `flush` is issued. When `--buffer`
>>   	is not used, commands are flushed each time without issuing `flush`.
>> +
>> +`mailmap (<bool>)`::
>> +	Enable or disable mailmap for subsequent commands. The `<bool>`
>> +	argument accepts the same boolean values as linkgit:git-config[1].
>> +	Possible effects are:
>> ++
>> +`true`;;
>> +	Mailmap data is loaded on first use and kept in memory until the
>> +	process exits. Passing `true` again does not reload the data.
>> +`false`;;
>> +	Mailmap replacements are disabled for subsequent commands, but data
>> +	already loaded stays in memory.
>>   --
>>   +
> 
> While the above may not be telling any lies, I think the focus of
> the explanation is placed on a wrong thing.  What primarily matters
> to end-users is that toggling 'mailmap' to true makes the mailmap
> applied to identities before they appear in the output and false
> makes the identities output without modification.  The fact that you


Make sense, the sub-list was over-explaining implementation details that 
users don't need to care about.


> read the mailmap data only once and keep it around even when
> toggling the feature off, just in case the feature gets turned on
> again, is an implementation detail that is of much lessor interest
> to end users, no?
> 
> Perhaps delete everything from "Possible effects are" and replace it
> with a brief explanation, e.g.,
> 
> `mailmap (<bool>)`::
> 	Enable or disable mailmap for subsequent commands. The `<bool>`
> 	argument accepts the same boolean values as linkgit:git-config[1].
> 	The mailmap data is read upon the first use and only once,
> 	even after the `mailmap` command is given multiple times to
> 	toggle it off and then on back again.
> 
> would be sufficient (I would omit "even after ..." part, if I were
> writing it).  What is more important than the optimization aspect of



Agreed, I wend with the shorter version without the "even after" part.


> this implementation detail to end users is that we do not re-read,
> so if you update the file while you are running "cat-file --batch",
> even giving 'mailmap off; mailmap on' would not cause it to re-read
> the updated data, and "upon the first use and only once" should be
> sufficient to understand that.
> 
> The implementation looks great.  I do not recall how good the tests
> were but this round does not change anything there since the
> previous iteration.


Thnaks! I will send v5 with just this doc change.

Siddharth


