Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA618DF65
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378274; cv=none; b=Oac7bASzF/KGwwbVt+j+Koop6UDm/71Cza4Y/x00T1V0unNkLsm7LT4adjt27LAqBkDsRmsdR9p/gD9eIHsSWRO6Qh9x6g4re9f5mksBWe9ZGudRDT5D3vz6P2ntS/VZRBz3epgr/XbKZaZmqwQwZuNdDxOqw/UDUZz0g0DK7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378274; c=relaxed/simple;
	bh=H/5i++KX6/z42nGIz/fa+GCeLrg+bFhbuBZ0ZCJq4qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7DPd5AwtsW59MdK1uW/6J4caldTLvvv+kY6AZys0BNPBgPlv6uiBPO3VYecZ8Z4oUKBWJkATBJiZDevSf9NQrMjUH5XMKH8ukijjjFQFbD2TUnOpUfJqaK3Wc3+quw95WnR0jHXKu2/YvyvcUUGf1FLU+/vs+IIg7owq2fwBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW2ORsdO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW2ORsdO"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so614695666b.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728378271; x=1728983071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndNXBobBma5P7T55EeKEo8mtD3mJxPqrQZeuTmM+m7k=;
        b=HW2ORsdOHfeg+9MzmSB+1WGNyoGKvkVyVGQIy4+vtWbLaKhqQeT8cu0f5v14XFxrSs
         E4XwuKfuhdZq/Yd2faAzkfsNNqjsNKstPb7HL8+1PdgeNVyhY3MunavWp7vLt8LUSfMO
         5js0MK1A4qBQ/ZyVvqjkLbDD5zY2E0jcl57ZI0l5YrzLKePF8QO+oiL4CzQMwt/dHRxW
         d006QY38+JPIL2/0zw6lF16zlcDt9Q45JNIxMzxjnICrsDX8Lmi6oXe6smBesSy8oj+r
         LcJTY9mecRJRwiiLknvjKldMcXyEnBEFh9O9/UKATvprz4g7LKZNCYlbuodAqXMp8iwo
         +lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378271; x=1728983071;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndNXBobBma5P7T55EeKEo8mtD3mJxPqrQZeuTmM+m7k=;
        b=WFguVlyZ2yKt+7Lhc3LdvbaaZnr1iaNlfLJGHiVE7BpJs6EQ1cORZ/Jbh6AScYyOE0
         kIzwcn15eoZeihMVpCsTipY78jbAFFNTXW6KiT/haIeksushA9v0UygFdrdKLE8oSpCi
         fWOSlrDYZIITpvbN1+K/BQz91xEfiwFyjObch4vJWOhv1reb6wBA7bdeupGnOyKUohp/
         u8JbXqVr0oe0LLFNhwr4vfIG90VRg7Gi8bwQIHBXRB6fUNfaK6qXOCD52rdzr+cA0PYJ
         qu8aNS89drZHY/CXc89QlWc7DtRRtyU5cVUEEGzhinD+BqE0oZKT7BmWIUwQqWrz564d
         BJHQ==
X-Gm-Message-State: AOJu0YxOXepcYeGdl5Rjy9ALJtnhEsbGDR0lYSeBnnJqJSvCcnwu+m0y
	1oHRcRpbpbJh+/hc5gAJqsmgPv8U4vb5XcMNvgtDwwPjzk98FKPa
X-Google-Smtp-Source: AGHT+IEZ6S28I42RwMydgW2h/kmeIg/Wbl5rdO1R/r32RXLDup70LH+Ut1EiP2xdWyAB0bhhuODCYg==
X-Received: by 2002:a17:906:fd89:b0:a86:9c41:cfc1 with SMTP id a640c23a62f3a-a991bce40demr1634144766b.8.1728378270563;
        Tue, 08 Oct 2024 02:04:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f74e13csm284837766b.164.2024.10.08.02.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:04:30 -0700 (PDT)
Message-ID: <986be8f5-f8cf-42a4-8217-e3ee185ad27d@gmail.com>
Date: Tue, 8 Oct 2024 10:04:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Applicant Introduction
To: Chizoba ODINAKA <chizobajames21@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <CACwP9ara-N1PGYi8wt3MsDvs50thXf9iw2w4n-syZD0wwXXqfA@mail.gmail.com>
 <ZwNvu00mQuFQD7Ps@pks.im>
 <CACwP9apjMAwwA7cqdKmyj08=wENV4+NpeUdojz54c4=6=pNWEA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CACwP9apjMAwwA7cqdKmyj08=wENV4+NpeUdojz54c4=6=pNWEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chizoba

On 07/10/2024 20:11, Chizoba ODINAKA wrote:
> Thanks Patrick, I do like to register my interest to work on:
> Avoid pipes in git related commands in test scripts, based of,
> https://github.com/git/git/commit/c6f44e1da5e88e34
> Test script to implement changes  - t6050-replace.sh
> Code sample -
> `test_expect_success 'replace the author' '
>          git cat-file commit $HASH2 | grep "author A U Thor" &&
>          R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git
> hash-object -t commit --stdin -w) &&
>          git cat-file commit $R | grep "author O Thor" &&
>          git update-ref refs/replace/$HASH2 $R &&
>          git show HEAD~5 | grep "O Thor" &&
>          git show $HASH2 | grep "O Thor"
> '
> `
> I do like to hear your thought on this. Thanks again

That looks like a good microproject. Please feel free to ask if you have 
any questions while you're preparing the patch.

Best Wishes

Phillip

> 
> On Mon, 7 Oct 2024 at 06:21, Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> On Sun, Oct 06, 2024 at 01:12:19PM +0100, Chizoba ODINAKA wrote:
>>> Hello, Chizoba here. I am interested in contributing to Git - Convert
>>> unit tests to use the clar testing framework.
>>> PS: I also have read:
>>> [1]: https://git.github.io/Mentoring-Program-Guide/
>>> [2]: https://git.github.io/General-Microproject-Information/
>>
>> welcome to our community, thanks for your interest in contributing to
>> Git! Let us know in case you hit any issues while working on your
>> microproject of choice.
>>
>> Patrick
> 

