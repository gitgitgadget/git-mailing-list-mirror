Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA47248F75
	for <git@vger.kernel.org>; Tue, 27 May 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334273; cv=none; b=KLw9gIF1Edg9mmOuqHNnKxfqPAg6c79Ez1m5lcJtaw4GAwovCUunhgJQrdH4zayzKdMYJPhD9ErbeSjSHj4dqVGPKZVoA5wQu+k7CKByrPemaz3pvceS6zxiG+dGWyiziUFCOQ+TWbrvkY9L1BhqLvl0XOWdSHhEYNPVg3wt/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334273; c=relaxed/simple;
	bh=2AdONCqzU9QCv2+2m5zJcmP5ka1bVpXP1fuDrjQ23CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZXxiRxF1gyET5IQ1wcTXhnmh3+r2pFczQdJeaSBcRHCGiZXAhhxfZDqw17b4untwMq7c5SZWHTNkTF75ewRsNbakRaIUbYp8adbHtdOR/mBgdrRiossPnbL0XKd2dV3qAH922Os7uOeEHiKm5uNVcDMoiRBSbxn77UX+mKkEkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMefxBM2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMefxBM2"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad216a5a59cso381689666b.3
        for <git@vger.kernel.org>; Tue, 27 May 2025 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748334270; x=1748939070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=++c82Z3psgPcGk6vsUt3aT4ruFd4AUV+GwvigwpLejg=;
        b=VMefxBM285+f54JYaCVoYTJTCIqyQWRObitcJS0Sw37nFTKa0JLIa1D/qbsrGyAPlM
         Hw4xzG5fB8dWi17bifuRv4bCvi2tRZ3NE+nFWfyOAntcHN6RJgoW5IGbbOBiT+uGxedG
         UjnVZgJVJuGkQdtGFWfuOz90s1pzDMhqk6V+CNQmDoamhrJNztxzCQ+dqkPy6AmS3XH0
         vpsusrbk4ZK7sfjZjTKeozLQjysft1TxvcPTfudXk6Je29dEcPILpGgZbPRljkvAvmER
         GCdYxwGygHLRLsFdWFEsHnAKdVR7PBzjJgcJPH9eoDUfAupb2MtjtGVdm3ERVriaZ9KI
         Athg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748334270; x=1748939070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++c82Z3psgPcGk6vsUt3aT4ruFd4AUV+GwvigwpLejg=;
        b=S40rlCI7heCxdy7H+2hcy/m7cUHD0AbdeVHGhpCcTW9cii8Ote03BIvmCmAjfFgEVs
         JWDwI6Q3Kt0/vPvZt55ETWOpqJDMQV9+HQZtwi2+LNNfDji87tVu6a9EIpgECJr+jmh6
         s5ODJCMAdthvSDbVe54uJ/AnDEvDw3QAPQAHZigDsGbTZaQx+bdH9WIE6FhJ7IJqr5KD
         6nBdLowaip4LjHqz6Eqqeg0P126+paMCwcXHQc3EvUoJXMwFaTu2trhY1weqC0yIYVoQ
         CiR/49LqFJu5G6Lb7nBcBTh0hRGKW1ZVN2IwFR2+6R0VGR1QPc8a1IglKB/2zxmv893b
         0F8w==
X-Forwarded-Encrypted: i=1; AJvYcCWbD+MW5dZAU4HIUbjWXJUuAARuVDyQD3hQ9kJ2yKAEaI0ZutL9xB3hTCB9GK41BkMQojY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3LS35EJZQh9LFDqGGoKU3sbRJ8zDcCnE6wYZnPkCDyJgj7GC
	gD+M99MeEMvk49FrlRuSQwS2OzgkE8LP586Mv+JFKFr+uG+WgygS1xGa
X-Gm-Gg: ASbGncvnHlu8fzcCUhwGjOeZ7K+5LvF7HarRU85+lJYdqAPw5xg7trP7vpNEOShSpPv
	OhmnjhqDYBTbmplL+G3B/xAO0o2xlFHhKzr2/kkekyn+j5lOYiJvaqCthjLs4qHyyrHylfOaSk/
	P40/NY0Q5aFlnu2gN+E+7J7a+I107epUmyHE+PnZqm+zVWZXD3iA5Ce9DdXEesPy/hPRpFkgToy
	nNhTTDDvnTbfuY3Cm4Ee9U5qPw7nJJh0kmATSE7HjlMfiq48Lb+65qowD0yPlplu9N6goI0aowx
	ADnDyGb8tehlT3HuLjLIDHA2k87PxjlXiWA4o6H1wI0GepuG451bpld9yMjyo2Kbx8SoU0vCiAE
	9O/puZ/MvhePmdfHPT1V66d1rD+I=
X-Google-Smtp-Source: AGHT+IG/zR5GzHo/UHUB1jlq3NDbWwU6v+HpBAdMICbosRn9OG0KCWw/OkD/7bT4dhBbRgLGUq/5fA==
X-Received: by 2002:a17:906:3617:b0:ad8:5782:7f15 with SMTP id a640c23a62f3a-ad85b0d0de7mr915070566b.27.1748334270218;
        Tue, 27 May 2025 01:24:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8848c24d3sm174636866b.133.2025.05.27.01.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:24:29 -0700 (PDT)
Message-ID: <ab009472-d15d-4894-aa83-0ab8b0d2dfbd@gmail.com>
Date: Tue, 27 May 2025 09:24:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
 <10280d7d-af36-468d-82b8-e0e780c38ef1@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <10280d7d-af36-468d-82b8-e0e780c38ef1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 26/05/2025 20:44, Kristoffer Haugsbakk wrote:
> On Mon, May 26, 2025, at 16:01, Phillip Wood wrote:
>>> diff --git a/builtin/notes.c b/builtin/notes.c
>>> index a3f433ca4c0..ca4782eca19 100644
>>> --- a/builtin/notes.c
>>> +++ b/builtin/notes.c
>>> @@ -180,6 +180,8 @@ static void write_commented_object(int fd, const struct object_id *object)
>>>    	if (strbuf_read(&buf, show.out, 0) < 0)
>>>    		die_errno(_("could not read 'show' output"));
>>>    	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
>>> +	/* strip trailing whitespace introduced by blank lines */
>>> +	strbuf_stripspace(&cbuf, NULL);
>>
>> It doesn't make any difference at the moment but I'd be happier if we
>> stripped the trailing space from the commit message before commenting it
>> out. That way we know we are only stripping space from the indented
>> lines produced by "git show". If in the future this function were to
>> start appending the commented log message to a buffer passed in by the
>> caller rather than a file passed by the caller we wont mess up the rest
>> of the buffer content.
> 
> Do you mean doing the operation on the output buffer instead?:
> 
> 	if (strbuf_read(&buf, show.out, 0) < 0)
> 		die_errno(_("could not read 'show' output"));
> 	/* strip trailing whitespace introduced by blank lines */
> 	strbuf_stripspace(&buf, NULL);
> 	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
> 	write_or_die(fd, cbuf.buf, cbuf.len);
> 
> I think that’s cleaner.  But I don’t see how it makes the code more
> future-proof.

Because it is now stripping buf and not cbuf. If in the future we decide 
to build the message in a buffer rather than writing it piecemeal to 
disk we would change signature of this function to take an strbuf 
instead of a file descriptor and use the buffer provided by the caller 
instead of cbuf. If we were to strip cbuf then a naive conversion would 
end up stripping the buffer passed by caller, not just the output from 
"git show". Various git notes subcommands have a --stripspace option and 
calling strbuf_stripspace() on the caller provided buffer would break that.

>>>    	write_or_die(fd, cbuf.buf, cbuf.len);
>>   > [...]> +test_expect_success 'git notes add has no trailing whitespace
>> in the editor template' '
>>> +	test_commit --signoff 23rd &&
>>> +	GIT_EDITOR="cat >actual" git notes add &&
>>> +	test_grep ! " $" actual
>>
>> Should that be " \$"? What you've got seems to work with dash but I'm
>> not sure if it is POSIX compliant or not.
> 
> `$` is the anchor metacharacter in this context (end of string)
> according to Posix.

Right but what does the shell do to that '$'? It is not escaped and 
inside a double quoted string.

Best Wishes

Phillip

