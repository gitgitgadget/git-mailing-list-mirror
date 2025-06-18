Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB04219A97
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275930; cv=none; b=ArQXKDklFjhib/lH0i4Kfu2lcDcIbB6N1fSfKJwHTH6U+g3TBNqtL6l5i+EJ+5bYNKiruQkj52rkk5acRJEApjsp/ORzCBwMnHf8wz61FIARV80s/RGKGG/jtbDQFEDJaGaiDT549MLdnEdBTZu1BDZgM1UfLQNA+cBJoo4zCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275930; c=relaxed/simple;
	bh=l3RlmFPREOOdrOYTjRo2c5Afp0jJRzRIojb1aOQ9CrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzjZgg8Oscpxzpg4p3IQAXry/5cvI2714BWYeCGKf6tXblqqAht0HftlXnQvDQtczRkgFPQeulle1XrjYglAKk6oluIS5o6EdRq13/uHr0BwbLPislNFuzzmAUSiDCfXcXkk5r90bFIbhxx0VxtNs46Pqy/g3LKeeclf+7CYLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZD3w3KA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZD3w3KA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31c978688dso54986a12.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750275928; x=1750880728; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3RlmFPREOOdrOYTjRo2c5Afp0jJRzRIojb1aOQ9CrY=;
        b=GZD3w3KABe46xp47EMpCxNXwBAixYFxvgUnq9/zjkeaGG+dDNaj/LA6pZ3UEmO5ff8
         n8F+yqysAOdJNBFaXhU/MKWkcMUi5UZ7wLc5WYo1FGi0Kuuhc54qRjgO/farpPATWouP
         DOpAMiUY9fCi2VQH6/s3Q5K2NFXFhPqwdly1xhC5A6JF1aCepiM/xDq5XIY0xzBfqjEt
         8Au7vcOSVU3JwM+aSsxN9/KkCUoj69lFe7uzMgnqIC5vFydWK6xI/u6F/iA3zihl0d+u
         ud4IyPm8vCWENSKiuj+K29jmZFd5nZZyfv+t1qOSBs5Wb8M5fwyCjaamKRvt96fDd3fC
         FaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275928; x=1750880728;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3RlmFPREOOdrOYTjRo2c5Afp0jJRzRIojb1aOQ9CrY=;
        b=pWUS/aFzwOoTWJM8QpVSl8bgJAX+NRO9k0l3epKByCtlrfKdpvnTboBA8HiRwS/9b8
         FrfjOL+ZYFHLGJUP5q++TWWLjdhbsvpKTgOl43nd9EBXFxbc1lcJc5wol8OZN4hGAdCW
         JterlohqVttwHSqBlJ1HRxFRPwTjRUl3cwi0JkTZuHlnLiuiKRMh0xceqSoxAg8DcWIm
         czrtjT7AHU5bJuOBM7yVoVX4Wi3frFFcwTchlcinOGVMDdJngiKjMjZ5doMFZzJwYwOW
         Ci/NIOfHEzwwMcwWjmbYFFvG7+AFcKfm5l++TjhNqQh/LjMyUsIW9gGUNtlfnIs+m86Y
         B/4g==
X-Gm-Message-State: AOJu0Yymx7dzhu4D9C5PfNhjtvQqTba5JCo1ZWWYs9QIewCwXEd9PWDh
	e3KvfVz40MzE8sDsEG0zXjbi75ZvSuOooEn7DI5M2pS0eJz+pQJGMusS
X-Gm-Gg: ASbGncsIigvns9XBNfGetEcWZTMQqrDjQfHeiNMKyXVRhi1YiKITZ5wXcXHoV7EzEO2
	zlKS+LIKWMAJzBbkCWicPCAgI4Ae5y5xb/u3qoWZ76d6xVMtW1LTVbXlq7hLckqAcQN/Pc0M9dB
	7HTi6DL7jdMYc7wphEdFalkkilhgPUj6KPlwWYZT5A+ErCro+/X/cxQcd4ppllijMrdT4L1LL7P
	H7MqkxNHCczZNFafyCMJWi8dFJrI830dK6x+zftyj6d2005/9wupuzPHRmwiDR3nRAnB+DcPUl+
	jhEaETzgy1hyR4p3PpWuN8fKQVlbzLoPYUHi8aQY4njVKiXkmIWwUg==
X-Google-Smtp-Source: AGHT+IE5rSqsS0EEP47+Qrm04T7daNlvwguv+u3FG3D9ezTHDijM+eskxdeelFFbF6W6DTlQDooP7Q==
X-Received: by 2002:a05:6a00:4b0f:b0:73d:fefb:325 with SMTP id d2e1a72fcca58-7489cdee02dmr24220833b3a.5.1750275928181;
        Wed, 18 Jun 2025 12:45:28 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::de7b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748df06a4f5sm3223572b3a.85.2025.06.18.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:45:27 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] cocci: do not directly access the .d_type member in
 struct dirent
In-Reply-To: <xmqqsejwetli.fsf@gitster.g>
References: <xmqqbjqlexzd.fsf@gitster.g> <xmqq4iwcgbzb.fsf@gitster.g>
	<87ldposxyk.fsf@gmail.com> <xmqqsejwetli.fsf@gitster.g>
Date: Wed, 18 Jun 2025 12:45:26 -0700
Message-ID: <87a564sujt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> This change looks good to me. Atleast it will catch code that fails to
>> build on niche platforms, even if it cannot validate existing backup
>> code.
>
> I do not think it is necessarily a good idea to allow building a
> binary that is known to silently misbehave, though.

Yes, but off the top of my head I cannot think of a great way to check
that DTYPE has backup code for systems that do not have d_type.

At least in the case of 'git diff --no-index' the tests will fail if we
do not properly detect a file is a directory. So at least we will likely
know upon running 'make test'. Still that requires manual investigation,
so not perfect, though...

>> Your fix for the 'git diff --no-index' looks correct [1]. I'll build libcurl
>> on an AIX machine I have access to in order to test (not an
>> administrator on it).
>
> I do not think you need libcurl if you only want to test the diff
> --no-index change, but anyway, thanks.

I assumed that it was a hard dependency and could not be disabled. Am I
wrong?

Anyways, it was quick so no worries. I posted my findings [1].

Collin

[1] https://lore.kernel.org/git/87frfwsv4r.fsf@gmail.com/T/#me995c8f49943f0606c236e8e5e9ea8163602e65b
