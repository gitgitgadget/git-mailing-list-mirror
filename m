Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E19175BF
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072971; cv=none; b=klD6lOKUQmDRvMd/UQs1rG/N8uU7P9jdnpU1pCy4XfIbvrzk+BmVn2D1A/yB0JY9HOuwBKyL4eHkVT/CFClZPQFjl3/MOGd00V8DRnmc4+06vSIFQHgc/+2ZAiBX7jM9WA98RFPQLQ5XpY5EvtNJYM5mtD2TZgWpqPc4TBFUqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072971; c=relaxed/simple;
	bh=NWVaN30B9wkv1MJV6pHLrKT7rGFFe30lnnc7V0qw9Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5kpFaZBSdbperY16ziI+uwzMtw8hN/INiLNv1iRAclrkecr8qh2E5kprjAUthyEKgTlAyNKgZCVEB3RWgt+Wc2V5GnJoSAjWzZ7JD8/R4kyYFUVPegacfEXMPKJYemY2sw+l1EfAbwdQKnCVdFyqnzSeRer+QAHKCjuzMZnVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2yypGkU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2yypGkU"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e78eb213900so5029557276.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747072968; x=1747677768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zloins913Gy76w6+NWhCWx00sayCZSHy/VmTUzdGuY4=;
        b=h2yypGkUlzIZPw5XNRViZ6U1B4bTRIz7ClxhnVsAx3+d34UolSrdR6iYH+AAJ1mfdZ
         2kWowWAd74+E6c6N6HqORSxcJZ1/auvIazCJF8+y8/YappsqHHOglB6MW6IHZRBXjEn2
         2MHi6i3pQT+g41EpqBI1lAWtP8ajZ5vr3UIdgj/KV/deiWSY1/l1ewxHgFi0aXOEDDJC
         F6mB6WxPLfp7MbPI8NoWHsdC3ek3WxI5q8Tg5xOD956dP6mBSrwvSL467Eiw3UdStyX4
         oeB/KzkrIRA9j5uNInxdbMDsAGrsMzBTHPVSY7ePf0sZ4pG4yfoyWYEMkR1y9WHa8w1i
         beRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747072968; x=1747677768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zloins913Gy76w6+NWhCWx00sayCZSHy/VmTUzdGuY4=;
        b=LFvyehrLTC7z5mA/y1L9c6Ejx767VZ62n9Spv/Hd1N/YMXwxLb0a/3dL/haPAyyZ/q
         KBEvbse/9qdBhF9XfUy0/D+a0/dGU8Wou4idv8WePioq72PzXVcSelArrmvMtBEjsW/l
         zS9SX20EZ/4XrPGvG9WWJwCDcwnTjV5il8pUGtaX/lbJi4GPt3WuUZawdV6DLqW05BP5
         WqE3oKv1h0e6XYldb1uQiHfPO6+YIT/2LU3o064b0bHr1yLqqjDBPbErXYPUSMw702E+
         s6dYMy/R37FXpK2H3+JVc3m+mb9Im2rXT0rSJ9IpMn7mAoApubcqdQusCxm/0iMt8/Im
         u7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXZQ5m5moriB5c6oxRuYTk5Y8jQqRsEmBaoUWkG7lY9Mqk+eTNuQPbqgn0WLr81ADZHVII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlNm+PUfFNp9P7xJlbkkD34MmGbPEckFSfdKD7OJwwrURpVlX
	ea0UdwPAK1lrOm0Mw47Ir0ntBzCOxNRzE6oGMpBlV8WBP0lkdbcu
X-Gm-Gg: ASbGncvSgIgTf0/o6fOubufPzfEftfl0uPl/8W5NrHPPRuFQPOgh8ZmJ4mVHZO0iEA8
	8gMWijNf3NquPN8UO5+h0zI2Zf2N/h5XSofzBsdGNqcDhz/kcd1hQSPj45+BjKA0HOcLYirB/kB
	8h+1uQw/k80lmM8mAr9GmY0GFbuDVE8DqgK7thJUASb2FNPDRTZ9l5TvrS8A1yph9ODgEGjOrsh
	KZwo21vfih5TApeEbfZSgZYZszZTKNRgqmxknbIUMsQl1bqUdDSr/ku4EpgkiMUNOCHeo5oXRg0
	nUyDxxXuW9KVUyBFdJWpUV4lCVUGw2g3sXHAMPjTQn1CmRbOpIBxbZaVl5BPEvZ9styIwmCz6bI
	T+iQfidO1CG8JD4amOKOb+8dfp9YQYFpQ040mhuU=
X-Google-Smtp-Source: AGHT+IE1cAMkulrTd6QHsASPY6JxFJ5nLlrCmO92imZa5XLhcgvH8Jh3DuACipduNwh3Wt92vxu2iw==
X-Received: by 2002:a05:6902:1893:b0:e72:f556:2644 with SMTP id 3f1490d57ef6-e78fdcc95admr17026719276.26.1747072968206;
        Mon, 12 May 2025 11:02:48 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7911299b8dsm1566271276.31.2025.05.12.11.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:02:47 -0700 (PDT)
Message-ID: <82c2c073-3fa6-4023-82d5-bdb772c3790b@gmail.com>
Date: Mon, 12 May 2025 14:02:26 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scalar reconfigure: add --maintenance=<mode>
 option
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
 <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
 <684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
 <xmqqcyckayb4.fsf@gitster.g> <35ecaa1d-589f-4d28-9d97-78bae8de2d41@gmail.com>
 <xmqqy0v1sp05.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy0v1sp05.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/2025 1:44 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> My intention was to bend over backwards to prevent a behavior change
>> in the default case. However, I'm coming around to understand that
>> we don't need this background maintenance to be redone every time
>> and can become a no-op by default. (Other new configuration will
>> still happen.)
>>
>> In the case where we're fine changing the default behavior, then
>> the standard --[no-]maintenance option will work, though it is a
>> three-way switch where the lack of its existence means "don't do
>> either mode".
> 
> Ahh, OK.  I misread your intention.
> 
> If it is common for existing users to disable maintenance, perhaps
> by mistake, together with configuration changes that are not quite
> right, perhaps also by mistake, and if they used reconfigure to
> recover from such mistakes, it indeed may make sense to nuke the
> current setting and enable maintenance unconditionally.

The original intent of updating background maintenance in the
"reconfigure" command was primarily about updating the schedule, if
needed.

The recent bug in the macOS scheduler is a good example of this.
Users will need to rerun 'git maintenance start' somewhere in order
to get the "correct" schedule. This bug only needs this run for any
single repo, which makes the 'scalar reconfigure -a' command a
somewhat strange place to get the fix.

> As you suggested in a part of your response I omitted, we can
> annotate <mode> to give hints on the valid choices to help users,
> without changing the default behaviour.  I am personally fine either
> way, as long as we clearly document the reasoning behind our design.

I'll create a new patch on top of the current series version that
does this, calling it out as an intentional pattern. It's previously
been used by these examples:

 * --fixup=[(amend|reword):]<commit>
 * --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
 * --tool=[g,n,]vimdiff
 * --exclude-hidden=[fetch|receive|uploadpack]

One place where this kind of notation could be helpful, but appears
to be absent, is the '-L(<n>:<m>)|(:<method>):<file>' argument for
'git log' and 'git rev-list'. Perhaps this is too dense, though, so
it would be better split into '-L<n>:<m>:<file>' and
'-L:<method>:<file>'.

Thanks,
-Stolee

