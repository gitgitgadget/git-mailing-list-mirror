Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE421315C
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408556; cv=none; b=I9nr3RbniRHdn/FovzGyjCuyi8Gs5FN/B096vHM3FT1kuYjRP3gMOgoR7coo/TCHC0gvYvnuQnhz0eyJLnI3R94N6xfZdHkb3K9bfP0/zZTJh4AdhOyLPArIz7krGAkwKb8KUhJPbVTW3bnIYT6ZFg7k/5RLjCAZ9ehxeUuRG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408556; c=relaxed/simple;
	bh=gx9Kv53IGf64PMi5wNnBO+DUTz/077zCocTibWulhZs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcvMxAE6noSZs35ahXeE61d4aN3G4k7n8wAhNHV25FGVYxWSz5WJeNqyqyLq/cmKdrEBcxNeMxK2jKdWP/G3t8Zx/CYL52bfDRsK7SW82Jhrf1CE79aPiUpntM3VHsl7pgmqOEbQ7rlcOnH5rTw57tYJFzI+lbtmQ8VEnkdLT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=omCwFszm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="omCwFszm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720be27db74so4099365b3a.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1731408553; x=1732013353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7CDHuVLfBRFHPe3hhN9DhCBlpe8e3DepYmAl3Kjl0k=;
        b=omCwFszmwj1ShgGlYVB7sxOCuXQ8tZIwPWWr+K6UsSEaF4LLIXOg9I+f+gMf2YAZN4
         STAaf/FNa6nYRhiN9zbHnWkmaOYlES8Xh/2zKdu2X84f35/DhB8xWpJtBPQFSCr2dPAE
         UEuREuRMaUlI2VKMNTUSxgpbbmyDQDbds+ugQSUn53cFSrqiORyppDOo051dKpovk/Pw
         VMh+nYyQgHfBUn1bdd4IU2MNRjknG/czIqLiNRM82d4hkrYic4EfJclzlUbIx1NkqwFM
         McNGBuG7+QewoXkC+YCJGsbP5w2lBuCRR3S6kYOf7WP+bue6WRc7iO1Vh7tqcfvnJ+nF
         xUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408553; x=1732013353;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7CDHuVLfBRFHPe3hhN9DhCBlpe8e3DepYmAl3Kjl0k=;
        b=AstjlYI+XvFABdJTWGZQdEZlrPSQqbHuMJVQHWH/JgcJ7xjTKgjeolBp8BStqAagpR
         F6XLTOBotJDUZlNsWLxsUIzmwIZg8pLyhmoBfVhw9eq9I0wEw3VDbjCWMxhRm8K9+rAN
         HN7Msv88l0fyHdwx5HXAKNhx1hrhfWMOSk/0E+hG6ae5lv6YfBL0BEYmnCZKsSpSgSBB
         dMudAJlIcX/+dEUyvWRaOX+p33tJ6rKBe3sVaLjfmpMBYJBJTnx9/iQEWlB03MdtZX36
         NYtsu8izW/9E/4/hEhPODAXZB6MHJjt6eD9pzfp0ES7AbWMprKnaEuXLH3c4wod/fEdZ
         asJA==
X-Gm-Message-State: AOJu0Yz0vyzRVR8kAY2T3uLYuqsPpsK7Hm2WG5KAK10adSv6esoYUIMy
	krK7k0iDfe5MDJgtXDOvUdoC1aCJbeLoKYm/pJgpkSmsyXuRUJCIPS5hHXlHgmNguqeJ2l3zW1v
	mDj4Bu8FAIrK+qHzGxZqn6KWoe/c=
X-Google-Smtp-Source: AGHT+IHivLKx2LqBLCix/N9oddilxJ0Xvkryrw257mX/uqxzOE9uxgwTuQH6wDxiNp6D5VaxmDyeqEh8NePsIm2d9/c=
X-Received: by 2002:a05:6a00:2185:b0:71e:74f6:f83a with SMTP id
 d2e1a72fcca58-724121c7bd1mr29921228b3a.3.1731408553499; Tue, 12 Nov 2024
 02:49:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Nov 2024 02:49:13 -0800
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <xmqq34jx8adx.fsf@gitster.g>
References: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com> <xmqq34jx8adx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 02:49:13 -0800
Message-ID: <CAMo6p=GOjmUQWHE9QH0wUY=FCzN4-mjknryWRbp4dQW4MFthqw@mail.gmail.com>
Subject: Re: [PATCH] trailer: spread usage of "trailer_block" language
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Deprecate the "trailer_info" struct name and replace it with
>> "trailer_block". This is more readable, for two reasons:
>>
>>   1. "trailer_info" on the surface sounds like it's about a single
>>      trailer when in reality it is a collection of one or more trailers,
>>      and
>>
>>   2. the "*_block" suffix is more informative than "*_info", because it
>>      describes a block (or region) of contiguous text which has trailers
>>      in it, which has been parsed into the trailer_block structure.
>>
>> Rename the
>>
>>     size_t trailer_block_start, trailer_block_end;
>>
>> members of trailer_info to just "start" and "end". Rename the "info"
>> pointer to "trailer_block" because it is more descriptive. Update
>> comments accordingly.
>
> All makes sense.  Often "_info" suffix has very low information
> density, as everything is "info" in a sense ;-)

Exactly.

> Will merge to 'next' (unless there is a belated "it may not break,
> but it is not a good idea because ...", that is).

Yup, sounds good. Thanks!
