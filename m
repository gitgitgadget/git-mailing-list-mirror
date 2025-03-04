Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41B1FF614
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083948; cv=none; b=E45Vrexi6BCT/Zl9BxPIP2SQBdid3L9Zp2WWIkh80Nka71MSUWGQGYUGM3DD79WRqTXIM/48k6rmmIs58TSC7xZ5NsN5qiUrrkqcaMRyMudQBPL+RsLtOZsXIbbafRsLKa2UXpJAKKQthQVxLYAKbBQSIUY0BLjA11LZnvUTT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083948; c=relaxed/simple;
	bh=Q6Z0QxgzlhHeK2nBgNB+TS1bbHZux9JKDv0F+hNjNXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOfScGKFv99usl83O4v6BiFADeJXRKjRbVEO9Y9t+w5NPNbd97BU3fwF2e0o0M6MnuRd+a5f7f7Aw99MjLI2ZnnLvwRnw8XuJive/JJOBjgXG64hCGp6ElT85QK8X0oy8e6F2EPCpwZjXFJXZXIvGa6Waxf6/xzLN7MA2Lq0S+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4tKE/3R; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4tKE/3R"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf5358984bso466553766b.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 02:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741083944; x=1741688744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1yT03A61q/gf361fLyOr0ufh6I99OphCivyP4O6PMQ8=;
        b=N4tKE/3RVtl1GJL1QRstS2Ig3ioCs5JvCWUtSgHUc6/DvnIFkidlw6v4dB3+UiLuEM
         2aJCT0hqdR+8pBRHXCsX7Jqasz3x+lfk1evvb2d2fKXWtQtB3eJq/1j6mOiRtiyRwY8c
         lGZ1lzr+mjcbUBVEOOrHHONVOJmVnfA7dpBbZyhE64JDRtDD00iXz9/vrwaQ2BnIGPEM
         VdYfbZzjoOEtq2OWieJssZdqNRpk/+O7q4y1xDaX+vuAlQUwErU2/Bk2SLffOodyFN+0
         xOyN83B0BUyfPO3iuLmLATyKaZVBxT9StlnKvtqCNuqBdJ1EjFUSBK5aj0ClVPY64ERp
         QNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083944; x=1741688744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yT03A61q/gf361fLyOr0ufh6I99OphCivyP4O6PMQ8=;
        b=Fp5y23HYgZVu1CBLo4hyVmFs7z6jxuejqsTPCTDKToUNI82UpeHL0iX4tkGHJV6Qh/
         V9jKw5CDnIPRLdW7FvRW0lIvlotQNdc1XfP/aObD1JkU5X9YRN87qIifd8S6RKr3A0yM
         YRmcgPuTEFRqk1MzCKWWfB1u/C2sf4D+oaezehCqJP018LqdiK4BpDV0Cgm2bwwxYT5S
         AqmUgFYFZwWRUZf2ZNpqvodlpggV2yGIiqtLA+77NxeHzDR0HIvvv1JbK4uf6kDC6d0t
         ISTFN651xGNmpoqu/hseBa5TktTUyKkL/yz0jWlarW+Ll1k0awhYH6bKX/60SQwgNn3b
         aSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtkb1xbkuvK855mj4qkbQ3j2DlYS8U6EhPFdG0o498Hym/eT4MG7jw8gB/g1hUlGFQXJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEf2HDwdgfwA/Mk0Zerg5dRYcAqjn49KMJitSiUuACnkERplQp
	0f7RRVhpVUlP/+ffkL7QRcRfEX+esvA1y2MaLwFZqYLD/KJrwGSY
X-Gm-Gg: ASbGncsVxLFrutBhoz9JWeew25uRcHkmDwtcWTzR9+94PR0g6cR7NmaSxZ2Vgo9dkpn
	ERCyCkSq4b/d20kTG2UdKIp8jOevK3fYYa+DSuiVFJFncwodJOcq+HjQB2439fTehM+hT4Ak1mb
	k5rgYiea0eXgTQ+ry4D0Vw1+4sgHs6en5qp5dsZJrDpGGczIb4D4vWKgZT0V8V+SzOc8OEXUbK/
	KRmjAtkmeithfqp+//9sNHd3ZpRc+lzU9VN60hldG8T5Ga4cuweKtEDkuK1vQYEPOr2vEVm0M/c
	YV8GEbE4/M8mOT3c7iGIc2tD6MqLDxyJ+4ZMNxQZpc5VDKxU71PeltNjFM5uZn5aRUWBYH2NOsB
	6QQ8QFIO3rPJlwqs/XPD7Rxk=
X-Google-Smtp-Source: AGHT+IE3w2gMB3JgGbz2DCUKQozxtYnbSB2VKMbjpzyh5Df36hMOBy7fLgpTOVMc5pbiRdWFpJt4EA==
X-Received: by 2002:a17:907:1b26:b0:abe:fdfc:47d6 with SMTP id a640c23a62f3a-abf25fab3e9mr1925421566b.23.1741083944290;
        Tue, 04 Mar 2025 02:25:44 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf5a6e59ffsm539981666b.171.2025.03.04.02.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:25:43 -0800 (PST)
Message-ID: <a2cbc3ce-c58f-4003-a7e7-53d97fe8e67f@gmail.com>
Date: Tue, 4 Mar 2025 10:25:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
 <xmqq34g79e8k.fsf@gitster.g> <618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
 <xmqqikowejmb.fsf@gitster.g> <180271a6-eb0e-4c15-9916-b2ab5760f4ec@gmail.com>
 <xmqqjz9b6xr1.fsf@gitster.g> <d2c934cc-72be-4aae-8661-3331d3936219@gmail.com>
 <xmqqh64e3snx.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqh64e3snx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 28/02/2025 17:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... There was some talk a while ago about
>> adding a mechanism to select "git 3.0" features at build or run
>> time. If we add something like that I'll resubmit with this change
>> guarded by that feature.
> 
> Documentation/BreakingChanges says that we can hide it behind
> WITH_BREAKING_CHANGES compile-time switch, and that is part of
> 2.49-rc0 already.  The linux-breaking-changes GitHub Actions CI job
> runs with it defined.

Thanks I'd missed that being merged. I'll re-roll with the changes in 
this patch guarded by WITH_BREAKING_CHANGES.

>> Perhaps we should make the confirm-before-quitting thing a "git 3.0"
>> feature as well?
> 
> I do not feel too strongly either way.  Sometimes I wish it asked
> for the final confirmation after all hunks are decided.  Most of the
> time I do not feel that way, which almost always is after saying 'q'
> to finish the selection.  So I dunno, but my thinking right now is
> that I lean a bit toward negative than positive.
> 
> In any case, I think we should indicate the (selected, deselected,
> undecided) for the current hunk the user is being asked about, which
> we talked about. As a workaround, we can do 'g' command to see the
> list of hunks and check the indicator (+/ /-) for each hunk.

I'll try and take a look at that in the next release cycle

Best Wishes

Phillip


