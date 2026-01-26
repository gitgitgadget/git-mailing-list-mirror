Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D52328251
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420879; cv=none; b=gXBzcJtnSGriwhPElOMRhiVQQTflWy+0onG/Kbp4F8fuXVuluGzrzjPiZnbnpp1Y+xVffdbvt/S3d8gLEJ8tVRV0+BQMkAbZDtjBrV+Z5rB0d1KNutbG2ikhabAJWwAUu4YaRqDB9kH8NtLplhilMP9pPRKkqcD0nLcU4Uqpmh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420879; c=relaxed/simple;
	bh=qefNVz+AgH9sg3kfFPNCD/7T2O2an7oHXtOe9AhXa7Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g7Aad+/m9ZCBcfviyY3itzDiHuS0Yk3Th1WHZY/zOBEpGlzhbQXRy0yCLcZAf9LwVgOaU4grBaebvxFhFFV1Zdo9JyZip4SmgZKykUKV9EVuolzsMYIDPGqSNfLdeIRWclFsl+Pl7PYZMSwj6i9NisAFQ8IV7mm7W94sLels87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQNIdzJ9; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQNIdzJ9"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2686463f8f.2
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 01:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420876; x=1770025676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzHbneq81tZsjnf5cMYnnWQ11Dj3lk7LiEA6HOzB0KU=;
        b=AQNIdzJ9Zg9/PKyhkPYu5oUSkA3TxQ44FnZWd6e0Yzaym9NWsTclyjJdOhO5bT1yGC
         /MEzyTe7ja5BujNYDBupyqmt2R6rOh8BLNtA5IHAPqmIcfa3BHARsr4zT/35BszK8v/e
         1OipsEQN+MJpNINze3opeztfGI9UbYldHDgXu3TQNIZtx3C1Z+XvueePwOLq23zuuukV
         WHJqIdwYw+loFZKy78fAzHHz6/lqFmznBqdlMU1I5C8qk00W7CSF979k1Zyvthb/trbU
         4i3/e118Jwt/NGSBIhsrvQcTk6SXOoppV90k3dI8pJC7xz/A5aNC/pdDAif8im8WHj2d
         XqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420876; x=1770025676;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzHbneq81tZsjnf5cMYnnWQ11Dj3lk7LiEA6HOzB0KU=;
        b=Q1KchAawM7hdk1m1eyiBrL/dl8TFodPRRUhSVPt5HG/FwrtoHiusuQkvAeKKvPeHVf
         UBh7WWXFXgFZDZkU6Jjgx3ZVDOC+e6UTPfWNUM4L5rcft0RnT5ntlV5C7NzUQkbBFtOR
         KhCv7dpKuW8keDXwpGLcVjhVcMbSSdKJdhWIL+mosrQzT9ObAo0JWcbA14GkVoa+ABGy
         3KX//5RJLg9tUZD+ekgKoYfjXEyOvzf7OO9pvbUt4He+uAp3P2USWw5FIhamsHOlNRRL
         ZTqizzt+/Z+0QctP/QQgFpkvcusYAIalXyx7efnbSqCGLJ/rKrPNNMuPzi/aT87BF86r
         KXCg==
X-Forwarded-Encrypted: i=1; AJvYcCUi7PLKPe50TA9PJNjJbK27+d4/OsKwPZ4iZquX/L1zHm5PN8ONlWIIxX30J3K8Xfi40cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxupbKeMQQLiFb7gaXi2gXnvK4iV1Uvo2jWp26sZsHm7R81k+DS
	93EV7YPvdpsoA7hpN3tLXFnv44/KYERtZqvFQ5E4R5kXVDKHc3iiHGbU
X-Gm-Gg: AZuq6aLI0SA0xUDMR7I4/nzcBU+5+8UlIbJEMFnqM7y7yhIRC6pG7yGTMj7qaL8h7j0
	cdmeg9KUphG2kyxwz62SzqwskXCq78u40/epjj/k7G8KrIl5fHq7v25X5aEwezihci4wjXO0Zt1
	zN/CWfzha1f2yNfeOkClJu0+D3a7f/zMudyZzAWfjaX8BUpyn9BR/rJyOKn4i/nOhhadh+KkNXR
	K7utrx09moLKjw3UIWhokoNqJmtlN9VNhCxwOwWQcKvE4zuHQ860eIRJLrS1Ee7vIs0lTyjf5Yg
	ZTrMVBTche3B3MzsGgVdB3f6/NnipIaHd0yIp0N4muBsYsAf12sNH7lE750B32RVzdBnyWuZYYI
	12+voLtgi9TrcvwPOEPHFwYvvJ3fiV4qPw+RaGqRM3+Z10Eww8QH+pobvzui/xUsofErv7JY8r7
	GZKKo0XZVOjWXgYO9xpeS6ziVeI8Wbm56q3J+BQ0jS+U6LYpLNwAg1SF+f+vEegS+Fxw==
X-Received: by 2002:a05:6000:608:b0:430:fc63:8c8 with SMTP id ffacd0b85a97d-435ca1888a9mr6615880f8f.35.1769420876469;
        Mon, 26 Jan 2026 01:47:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm29699556f8f.32.2026.01.26.01.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 01:47:55 -0800 (PST)
Message-ID: <82b656a5-e5c8-4056-8ec5-4bdab9ef7128@gmail.com>
Date: Mon, 26 Jan 2026 09:47:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
 <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com> <xmqqa4yc5brq.fsf@gitster.g>
 <79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com> <xmqq1pjk2sv2.fsf@gitster.g>
 <a29ce07a-9585-475e-bb3d-4742f2ec400a@gmail.com> <xmqqqzrggr39.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqqzrggr39.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2026 17:46, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... If "git svn" was
>> implemented in C then we probably would want to check it for leaks even
>> though it called a foreign program. That's a long winded way of saying I
>> don't have any better suggestions!
> 
> I am not sure if I agree.  If Perl interpreter used to run the Perl
> version of "git svn" were found leaky, are we willing to go in and
> plug leaks there?  Not likely, particularly since it is not what we
> ship and we do not have control over which version of Perl the users
> have on their systems.  So we say "Perl is foreign and we are not
> equipped to plug leaks in various versions of it on users' systems,
> so it is not worth spending cycles to test for leaks in it".
>
> If "git svn" were in C, linked with libsvn without using the perl
> binding, and libsvn were found leaky, the story is the same.  We do
> not control the version of libsvn the users have on their systems,
> we are not equipped to plug leaks in there, so it is not our job to
> spend cycles to test for leaks in it.

I think that unless the libsvn that linked against was built with 
-fsanitize=leak we wouldn't find any leaks in it anyway. When I wrote my 
original mail I was imagining C implementation that forked "svn" but 
replaced the perl code with C that called the appropriate functions in 
libgit rather than forking git. In that case I think there's an argument 
for checking that our code does not leak. Anyway this is all rather 
hypothetical as we're not likely to rewrite these scripts in C.

Thanks

Phillip
