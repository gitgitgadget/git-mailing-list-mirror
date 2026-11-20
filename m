Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185215;
	b=R5fpGFWcVrGXRaibUK13f7rwMz4EgQ3YXq0MV54zRwXD25LUfifLIzhgHPOR2uXQoMwa
	 8Xjt5IXsZ12zqCMVtyDYUaolrGRIGXGwDHB/BSZBQsKNA/yBUHV3iv1wR+9o/GwTvgc7Q
	 Cb/s/J9o9vykYyy4oZtfSnxSCCsW19b1OSs2MNmHvB9bbTP+b4EvHGR24t8FKkjyJ1v1h
	 qUzQ5bFlhlsVztmke3Juzh/R6kzAYed+j27Cug31auqrgToR5biOEhC5r8/DYa9xnpxUC
	 t4PTKQkaJJq97gu4z7cVW5S2m7Ez/7l9ClzPqr36v5CcIYKyy63Z3YreaLquGSMFdGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kgZUwW5OgVNmb+zH549NbV9n/X8QLmkj0lull3sXsH4=;
	b=rqcZVaqEOCCQ0S1du+9CS+64hDbnmTItuOTmZDE5iQAeAVWyxJA6c44h42tRI4CjdKHz
	 KwqfRlxhZYBWrvJ50BstEBLs1dSEf28HIoOUfkdM1Ir+PPswTm1z8V3h2GFiBhclQsCCH
	 UilSOlYOAveOt+7uw/6FuBtPuSashbvyIzFdQtma+L4Z6sg2qKrvLPNFqRk9FQopgLd0s
	 Dig6VA87uR7rHjLduBnYVqzAKlHFngQpM25xTBiCwVbNis91iLYfRUalA2xiD2FPaEWhC
	 F7z5KURB246OMEfpw37CkLxzvt9LldJt9Pbb2rNv8ghtPcpGVHdR7ez64pEGALNLBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iARPI6rH;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73237606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73237606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iARPI6rH
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so1072567a12.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185214; x=1795790014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kgZUwW5OgVNmb+zH549NbV9n/X8QLmkj0lull3sXsH4=;
        b=iARPI6rHpSvYh6ZFl/sqJT+FFxjogZEjUoB714zpzKrZ1HwYcpi4u6ViRm/zDUSovk
         Y7NE/BzCHnGB2ee7z8UE3pZOtrU/FUIpu3WE04xWfPgz1TRlBbbvfWz8ZV1XVuQR6J5O
         xIlEejCOg/4LAgzJZWkxSCgE4RMDUX1Jg2vTM0R3OSTtpndBYLXWBoZR0fIpzcDDs6bg
         WpFHCvWRsIe+R825gsZgczsPia96HRQjbrunCVUnmLuHFmbOArK1gyix+GCF2+mxSeag
         wTWdx3YfXfLEWL6K0a58/JyKZtooMuKKdG9ej9vX/Tx3Ubkg/RMM1gZOTLVLyRgA8KIU
         mM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185214; x=1795790014;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kgZUwW5OgVNmb+zH549NbV9n/X8QLmkj0lull3sXsH4=;
        b=mo2qpKGSZKQu7h7NA7mOMvp7TD8cFooWiVp3FmFOGXRSjuvjuQ8eSm+nytSuBboRDn
         QqMSLNfjuidTWlpkXCViEteBK6hBx5zaAYwEWlCFnrBn2pZV2NpgI7BPC84up9JA+oRF
         PdXSie0a65P9zG9fqQdQeL1d6RcwkWYjadkvPv3bfQX6+sRNWRm1xoYnntdEI9m3a0B8
         +mEHww+X8Wy9sP2J46HBnGhhd3SdG/de0ES1kF1EAQL3XmqmfHsoLcVg/LcNvSIX19/t
         zC54fOSeMtA+hnvZLWx6f+drYuy915pNoZ7aFDNuIWUPe/xVn3fS788BtZOsAtWlAnQO
         DdDw==
X-Gm-Message-State: APuU4Z+Lb44cAdYkpVwGDbBy2x+i8Yj1jGcJfZeNlDje++pILjlJsSjU
	5GyHXnJfZ/GjTSz4D181UEvMJQR14MJGx+QL9uCdNmYz3h+zWk0lKQc88DXEng==
X-Gm-Gg: AYBFou1zEK8G5qCsVSWQ6nMB5mM6KgpYy8WVdq3RNukY5xZC7tKAwKY2mvXBl49YwJM
	tGHWmg5FuQXyu+lXG4v01nkcafvXnlzPNei5jyTUmxC17WZpFGuB5dSHxLz1WpKoLGh3u3pa61B
	oruEq5XDMsZ5FVzWIenA7A0ClXrEjgns9YhmwyHWVfC5josLmPD6hqOSGA2ookLkM0g0Mr1Sf2t
	3e/BwIMUayPpRPQITULNS1QCFibW7IZRe4+6ICemV/CUOVzgwZl2X3yaeDFW2zdcH9SZbIPyi+c
	r6oFkAe2PjutCQe+B0XjuISAkK8TreyrxfDLXOWuwv5A9edgfNDf4n1SwKcw0yfN9e5uNtu/gvV
	BhW2H0WMlbZz2tAza2ZI36TQIqVcvQJVoroimcOEWPH+7WpQMA71oKbECGE0tdqasoocsb2dH4u
	/bM2XHgR/g1H8nmRazlI3a/uptmIdLa6+HcpdfXqs/xphEE6FFS/tJHH4GDih7tLQhq/X/38+W9
	XGm+DKW1euFJ+I9FNI3MFjponCsBcGHLIsuOdfhw2ar9KsCNPy93N4ogd8Yt+N9F+n/IM4OHVgI
	10LjpLnph/Gr10Xguu6CLnVscuNoh4is5R8evTOqvGqoaRwu2hLUL6FRzsR8K9MvTX0pCiG2GdR
	gNLwwZx4fLHaeE03LwctEE67yN5HE
X-Received: by 2002:a17:907:a890:b0:c41:266:68a7 with SMTP id a640c23a62f3a-c513aacd82cmr355062066b.10.1795185213593;
        Fri, 20 Nov 2026 06:33:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdf022sm99407666b.67.2026.11.20.06.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 06:33:32 -0800 (PST)
Message-ID: <67c5d781-bfe4-41b7-ae1d-0b0c473e9979@gmail.com>
Date: Fri, 20 Nov 2026 14:33:31 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: skip continued lines when matching section
To: Junio C Hamano <gitster@pobox.com>, Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, dmnk+artist@google.com
References: <20261119192307.2683812-1-dmnk@google.com>
 <xmqqbj7ktjp7.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbj7ktjp7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2026 00:44, Junio C Hamano wrote:
> Dominik Maier <dmnk@google.com> writes:
> 
>> When a value in the target section spans multiple lines via a trailing
>> backslash and a continuation line begins with '[other]', removing or
>> renaming the section stops early at '[other]' and leaves the remainder
>> of the continued value behind as an unquoted '[other]' section.
> 
> If the behaviour was to treat these as continued values from day
> one, I would have agreed that it would be a reasonably design, but
> offhand I do not know if this is a breaking change in behaviour that
> may negatively affect existing configuration files.

As I understand it, this patch changes the way we parse the config when 
we're renaming or copying a section to match the way we parse it when we 
read config values. It does not change how we read config settings so I 
think it is simply a bug fix for an unlikely corner case when copying or 
renaming a section. It's a pity we don't share a common code path for 
the parsing and end up implementing it twice.

I had a quick look at the code in this patch and I'm not sure it handles 
values and subsection names that contain carriage returns correctly. As 
far as I can tell

     printf '[a "b\rc"]\rkey=\rv\ralue' >/tmp/test.config

creates a valid config file. For example

     git config get -f /tmp/test.config "$(printf 'a.b\rc.key')" |
         tr '\r' Q

prints "vQal" but this patch treats '\r' like '\n'

Thanks

Phillip

>> @@ -3434,7 +3525,7 @@ static int repo_config_copy_or_rename_section_in_file(
>>   	const char *old_name,
>>   	const char *new_name, int copy)
>>   {
>> -	int ret = 0, remove = 0;
>> +	int ret = 0, remove = 0, continued = 0, in_quote = 0;
>>   	char *filename_buf = NULL;
>>   	struct lock_file lock = LOCK_INIT;
>>   	int out_fd;
>> @@ -3496,9 +3587,12 @@ static int repo_config_copy_or_rename_section_in_file(
>>   			goto out;
>>   		}
>>   
>> +		int was_continued = continued;
>> +
> 
> This triggers -Wdeclaration-after-statement doesn't it?
> 
> (administrivia)
> 
> I do not consider myself an area expert for the configuration file
> editing code.  Please do not directly Cc: random people unless you
> know they are specifically familiar with the area or they are
> positively interested in the topic and they will regret if they miss
> your message if they fail to notice.
> 
> Thanks.

