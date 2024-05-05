Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E6A29
	for <git@vger.kernel.org>; Sun,  5 May 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714873079; cv=none; b=HsSfpGHsjxQqxesPZ5bhOcznB07yO/gzYbE3FSA9gyv/8kS3vsViWqcb3jvxSJevvWXC3/S1OqG25LLP3SImzNVnzHOu7hdrP6bdcPOdTslFcemIliC8fuzkjzTLYHN8GbXHV/xUxEtk4CWzSVEFne+mlijIKckIo+XQsXt5/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714873079; c=relaxed/simple;
	bh=lf4SJU+UWrowkOiRn6BaviF1lub3U2qlNWDawGMbve8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCHrGyAgEYK1gs1utVGH/ZayluAV5HKg9jV+xgUIogK9TicbJqq75eDy0DduEouLHzIKY4RMEmigr7Pm/21UPqHMmYL6cHd5w6+yYqaoiYZfuubRfv7Ed0RsSgx8PxbK/NAJMN/W6Rbrf9OT+Go9vWnx0ZE+GlWqevxQVCDHnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=acby0fY+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="acby0fY+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b433dd2566so581694a91.2
        for <git@vger.kernel.org>; Sat, 04 May 2024 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1714873077; x=1715477877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DBXxZ3IbWHz17hBl6+cN4iSCEBaBoayLn++5BrmEp0=;
        b=acby0fY+Q3oKKHAIT1PA/TkEIlIqL9KhsDojHM/hPqugmBbT3rs/AlrMEDAJumYc4Z
         +BMirP58pjPWovtxOxP8hF9Y+cMI9tStk0XZe76BJKqQmbYJMUcOki8ixZu38oyZa4SP
         lJGNTxDz86x2XwmP+JLrLMUnskJm2pOaU8E71expzzGFoLXCXffxxy+l+bRtAZ3Acj7A
         MLlJSdypcAY8W/Z8cgsL+JsgCqfC1KLuPw5K1/itmATjXdjJMLEGjNC9cJ9eEtVK+oMR
         Jg35sbymyOwFNiqGvtFvt0UdbQYlK7xT4WXdJ7HyOjucXZHjrUOqesLGoY8kHLseWc0A
         1tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714873077; x=1715477877;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DBXxZ3IbWHz17hBl6+cN4iSCEBaBoayLn++5BrmEp0=;
        b=doOpNfVrr/bbCtEt93Cx35AA/n0NmpuIaiV+I/NSrpJ+EoQT8bskz4AS936y5k272p
         kUAlWLyILuIeN22bOSVHtwCS0OWUMzAsuQ+RbzqlbtLJFuJQLiVSueBe9B89fhcnE3X8
         brRbTXFgqXZMqn8Oie1rzUpXfJPY1Ha/5aShbRWl4mKfGNHedQKlheWIeh8F8TGxrY0G
         d9zcNMwaqYhrRUGyMt8CIvJUT3Hd4o6DmwLsiZYUGZymsazt9yK+YeAahireQsvG0qI2
         9YTMulUGVx2bmzfAnI80TytLUdYDWVx57kCyg3pY5QG+0mX53VKEJQLK+BGRXrgR9E8I
         gxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpczP0DkKRkn3ezgRzXBSQ7/374gtkAEpqty9EjtWPLY0uoH7/+0+crpL7/UOC7vI5XfXCTE32iae2WGSSmrqoQoqp
X-Gm-Message-State: AOJu0Yy9oX1NEKg1/R5yizADy7ZXMT5UcX3jQjrMNhpf6gHWKlm3/p8s
	Zt173h12BsMkLutRcg3J2iPuzSU0+HIWG47a+L9xoKxMeBf3FHZT4IDA057Sb+nBMVUsR0PGTpj
	91wob4+3IDZLjBNLqqfzBUIJZYBM=
X-Google-Smtp-Source: AGHT+IHD72w8NCY3MUhvVxXhfhh2TkAYdHvbDTVIdrWqcyR7JOT5+mL71SMtq8p0LuW0GshWKezZz7JJ3pol4nQxOH8=
X-Received: by 2002:a05:6a00:4b4d:b0:6f4:4723:98ad with SMTP id
 kr13-20020a056a004b4d00b006f4472398admr8187150pfb.16.1714873076938; Sat, 04
 May 2024 18:37:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 May 2024 18:37:56 -0700
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <18343148-80d1-4558-b834-caaf8322467a@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
 <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com> <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
 <18343148-80d1-4558-b834-caaf8322467a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 May 2024 18:37:56 -0700
Message-ID: <CAMo6p=GJwmStLrW6cDDKrch2cXn_8fe0GsBHi3hpe5Uya72y=w@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
To: phillip.wood@dunelm.org.uk, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Linus
>
> Sorry I'm late to the party here I've left a couple of thoughts below
> but I don't want to derail this series if everyone else is happy.

Hi Phillip, no problem.

> On 02/05/2024 05:54, Linus Arver via GitGitGadget wrote:
>> From: Linus Arver <linus@ucla.edu>
>>
>> Previously the iterator did not iterate over non-trailer lines. This was
>> somewhat unfortunate, because trailer blocks could have non-trailer
>> lines in them since 146245063e (trailer: allow non-trailers in trailer
>> block, 2016-10-21), which was before the iterator was created in
>> f0939a0eb1 (trailer: add interface for iterating over commit trailers,
>> 2020-09-27).
>>
>> So if trailer API users wanted to iterate over all lines in a trailer
>> block (including non-trailer lines), they could not use the iterator and
>> were forced to use the lower-level trailer_info struct directly (which
>> provides a raw string array that includes all lines in the trailer
>> block).
>>
>> Change the iterator's behavior so that we also iterate over non-trailer
>> lines, instead of skipping over them. The new "raw" member of the
>> iterator allows API users to access previously inaccessible non-trailer
>> lines. Reword the variable "trailer" to just "line" because this
>> variable can now hold both trailer lines _and_ non-trailer lines.
>>
>> The new "raw" member is important because anyone currently not using the
>> iterator is using trailer_info's raw string array directly to access
>> lines to check what the combined key + value looks like. If we didn't
>> provide a "raw" member here, iterator users would have to re-construct
>> the unparsed line by concatenating the key and value back together again
>> --- which places an undue burden for iterator users.
>
> Comparing the raw line is error prone as it ignores custom separators
> and variations in the amount of space between the key and the value.
> Therefore I'd argue that the sequencer should in fact be comparing the
> trailer key and value separately rather than comparing the whole line.

I agree, but that is likely beyond the scope of this series as the
behavior of comparing the whole line was preserved (not introduced) by
this series.

For reference, the "Signed-off-by: " is hardcoded in "sign_off_header"
in sequencer.c, and it is again hardcoded in "git_generated_prefixes" in
trailer.c. We always use the hardcoded key and colon ":" separator in a
few areas, so changing the code to be more precise to check for only the
key (to account for variability in the separator and space around it as
you pointed out) would be a more involved change (I think many tests
would need to be updated).

> There is an issue that we want to add a new Signed-off-by: trailer for
> "C.O. Mitter" when the trailers look like
>
> 	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
> 	non-trailer-line
>
> but not when they look like
>
> 	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
>
> so we still need some way of indicating that there was a non-trailer
> line after the last trailer though.

What is the issue, exactly? Also can you clarify if the issue is
introduced by this series (did you spot a regression)?

>> The next commit demonstrates the use of the iterator in sequencer.c as an
>> example of where "raw" will be useful, so that it can start using the
>> iterator.
>>
>> For the existing use of the iterator in builtin/shortlog.c, we don't
>> have to change the code there because that code does
>
> An interface that lets the caller pass a flag if they want to know about
> non-trailer lines might be easier to use for the callers that don't want
> to worry about such lines and wouldn't need a justification as to why it
> was safe for existing callers.

Makes sense. But perhaps such API enhancements belong in a future
series, when other callers that need such flexibility could benefit from
it?

> Best Wishes
>
> Phillip
>
>>      trailer_iterator_init(&iter, body);
>>      while (trailer_iterator_advance(&iter)) {
>>          const char *value = iter.val.buf;
>>
>>          if (!string_list_has_string(&log->trailers, iter.key.buf))
>>              continue;
>>
>>          ...
>>
>> and the
>>
>>          if (!string_list_has_string(&log->trailers, iter.key.buf))
>>
>> condition already skips over non-trailer lines (iter.key.buf is empty
>> for non-trailer lines, making the comparison still work even with this
>> commit).
>>
>> Rename "num_expected_trailers" to "num_expected" in
>> t/unit-tests/t-trailer.c because the items we iterate over now include
>> non-trailer lines.
>>
>> Signed-off-by: Linus Arver <linus@ucla.edu>
>> [...]
