Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7667637
	for <git@vger.kernel.org>; Thu,  9 May 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715238691; cv=none; b=ZE5gcYPar1wOHghwz4OkrlNXNYwWO66ASNhQrX6BUK2wnrw8vKjt/KEY4I9bOkY1N3oTzKYZnTXfoeVlUguqgmF7u3055Gg0G2vmYZDyLct7dtGYqXTMEGuzRrbnZbGjJTsBpisx/UT0ePh/t5OesHMMSwvl/9YLqPcCAupMHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715238691; c=relaxed/simple;
	bh=3o7l7ilqyb8zTXuJ+4t+GGhHB/A/T8wyD1V+RnJOZ3k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwYSiJlhgbVom6i4omqoivSAWObnXl5DC935nEy09lnj9Pjn8XwhFgf8brbV4YPDhIDrBSxV/tK69+PyW+OOFSWqTvdZXZWj6x6Dc++x57hen7QtHpDHj6IulrcKHinQZmlwlQqNnAJwIiQr4CFPkMg3TN3OlISSiOf/zXjF8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=bGQ9mOMb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="bGQ9mOMb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so504362b3a.1
        for <git@vger.kernel.org>; Thu, 09 May 2024 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1715238689; x=1715843489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLfHAeyFgPS2kTGJbWCEnL2eC02QEX4rBvdVkmX1Ors=;
        b=bGQ9mOMb0q/aoJV+U8r7x+moAbhfSIEwc9dcZimabIpAsZz7X2uCqYJ/08HYtFHB74
         yn375AiVyDw+Hx+2/PscBNNFosKhrsGcmSpO7u47GTkgmUJWx3+35dU6mdr4npDqKb1O
         U5kMh3KNdOsBEjPDBnXBY3rpy1B9FT/sEWv7gP6r0U8Ox4PyekBYy1vkOlFy8UeVoSoN
         0lBgQJgYMiGem0w6wWLHkCHK/NBO6CGpVaiHHBMubxUauG7eIa1qG09TDzWL2fNv0V8Z
         h3qBg4N66rQIlfRhwdtgYPog1b/tfIFEl+SkJnPRZcz/sYZvpPCJ2R6s2O2qN7bV/yb5
         IN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715238689; x=1715843489;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLfHAeyFgPS2kTGJbWCEnL2eC02QEX4rBvdVkmX1Ors=;
        b=Hm3EnsLR4g7on56adxYdbsHJjnwrmGmkQymaIb2wyRfsaZzBtkJIPEFqjRW6tELS7w
         p5CFWUPtGBkls78wdPJhUXCbMZA063nfXmg14hLfORgbIbmgplAQV+WxYXWzoWIRhX/7
         8QFygtl9mOcq28lhESKJR9Ze+QHVv+uYCgoy33Zx8BxyLw9nBZsLxAZy0HL8Cnd6lJaq
         nwGvYTaS1SH5UL3eEq3DNKsujprkkMN2E/6DBeVhv3YXG2p5A/8ROWvwr9ElYgqDW2NW
         sn4mkl8XkZAmZGDFAEYig7KEjtQOqovEQQ9XEu3F0JgzYaL9epDNDDfq2QgDh1fA2Fk5
         Ab0g==
X-Forwarded-Encrypted: i=1; AJvYcCW9uzVxjO+pR7J0zGRbhgR678RgrgBfpmLeXvPBasUuPXEuwMOwuB72LFvkyRY1h8dkhsuoOpxO11568mqFDj8I7FrQ
X-Gm-Message-State: AOJu0YwEstMhotCHypQskkL6IauWt9aSWHZw0raYl5N+FdExikR9g3bz
	9Vug/uxoH9iSYSHEbcsn/bMEAUYM8Mt62ym6TaB7jfx8na1a4zvogPjPXnRdz0vcY7ZzxDk05DX
	ZjrYqgDqvqQOWnTsd7f1wSueD/RI=
X-Google-Smtp-Source: AGHT+IGovmmAdxJolqEw5FLqH7gmEipumA/4q+bZcRR3ohmoGX3swEJxuc/YhUCR+NmsMcbDKpiqa5gdHU7Jwu0Kdhs=
X-Received: by 2002:a05:6a20:e68f:b0:1af:cc9a:4cf1 with SMTP id
 adf61e73a8af0-1afcc9a4e81mr3937922637.59.1715238688815; Thu, 09 May 2024
 00:11:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 May 2024 00:11:28 -0700
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <a75133dc-a0bb-4f61-a616-988f2b4d5688@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
 <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com> <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
 <18343148-80d1-4558-b834-caaf8322467a@gmail.com> <CAMo6p=GJwmStLrW6cDDKrch2cXn_8fe0GsBHi3hpe5Uya72y=w@mail.gmail.com>
 <a75133dc-a0bb-4f61-a616-988f2b4d5688@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 May 2024 00:11:28 -0700
Message-ID: <CAMo6p=FS3ShvBdutprWBiAVef6A1XjsXB1UJSQBk0s5euN=tog@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

Sorry for the delay.

> Hi Linus
>
> On 05/05/2024 02:37, Linus Arver wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> On 02/05/2024 05:54, Linus Arver via GitGitGadget wrote:
>>>> From: Linus Arver <linus@ucla.edu>
>>>>
>>>> The new "raw" member is important because anyone currently not using the
>>>> iterator is using trailer_info's raw string array directly to access
>>>> lines to check what the combined key + value looks like. If we didn't
>>>> provide a "raw" member here, iterator users would have to re-construct
>>>> the unparsed line by concatenating the key and value back together again
>>>> --- which places an undue burden for iterator users.
>>>
>>> Comparing the raw line is error prone as it ignores custom separators
>>> and variations in the amount of space between the key and the value.
>>> Therefore I'd argue that the sequencer should in fact be comparing the
>>> trailer key and value separately rather than comparing the whole line.
>>
>> I agree, but that is likely beyond the scope of this series as the
>> behavior of comparing the whole line was preserved (not introduced) by
>> this series.
>
> Right but this series is changing the trailer iterator api to
> accommodate the sub-optimal sequencer code. My thought was that if the
> sequencer did the right thing we wouldn't need to expose the raw line in
> the iterator in the first place.

Well, having familiarized myself with the trailer machinery I was more
comfortable updating this area than reworking the details of the
sequencer code.

To me the sequencer code is a bit hard to read so I feel more
comfortable updating the trailer code as I did here in this series. I
also have another 40, 50 patches in the trailer area I want to continue
pushing up for review, so I would rather focus on that first before
coming back to the sequencer to try to clean it up. My other trailer
patches make the trailer API more precise and aware of the separator and
spaces around it, so using those richer interfaces later would make it
easier to clean up the sequencer area, I think.

So in summary I would rather not get into refactoring the sequencer at
this time.

>> For reference, the "Signed-off-by: " is hardcoded in "sign_off_header"
>> in sequencer.c, and it is again hardcoded in "git_generated_prefixes" in
>> trailer.c. We always use the hardcoded key and colon ":" separator in a
>> few areas, so changing the code to be more precise to check for only the
>> key (to account for variability in the separator and space around it as
>> you pointed out) would be a more involved change (I think many tests
>> would need to be updated).
>
> So the worry is that we'd create a "Signed-off-by: " trailer that we
> then couldn't parse because the user didn't have ':' in trailer.separators?

Even if the user currently doesn't have ':' in trailer.separators, we
still hardcode it in as a separator. So the trailer.separators setting
doesn't matter.

The worry is that any further refactorings of sequencer would be quickly
obsoleted by the to-be-reviewed patches which enrich the trailer API
further which are sitting in my local branch.

>>> There is an issue that we want to add a new Signed-off-by: trailer for
>>> "C.O. Mitter" when the trailers look like
>>>
>>> 	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
>>> 	non-trailer-line
>>>
>>> but not when they look like
>>>
>>> 	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
>>>
>>> so we still need some way of indicating that there was a non-trailer
>>> line after the last trailer though.
>>
>> What is the issue, exactly? Also can you clarify if the issue is
>> introduced by this series (did you spot a regression)?
>
> There is no regression - the issue is with my suggestion. We only want
> to add an SOB trailer if the last trailer does not match the SOB we're
> adding.

If there is no regression then I don't understand the concern.

> If we were to use the existing trailer iterator api in the
> sequencer we would not know that we should add an SOB in the first
> example above as we'd only see the last trailer which matches the SOB
> we're trying to add.

Hmm, both the original code and the code in this patch iterate over
non-trailer lines. So the behavior is the same.

> We'd still need some way to tell the caller that
> there was a non-trailer line following the last trailer.

FWIW in one of the patches I already have currently (to be sent in a
future series), I expand the trailer API to let the caller check if the
current iteration is on a trailer or non-trailer object (they can do the
check by looking into the key and value). And in another patch I make it
so that the key field is never populated if the line is a non-trailer
line. So the capability you seek is achievable with those patches.

>>>> The next commit demonstrates the use of the iterator in sequencer.c as an
>>>> example of where "raw" will be useful, so that it can start using the
>>>> iterator.
>>>>
>>>> For the existing use of the iterator in builtin/shortlog.c, we don't
>>>> have to change the code there because that code does
>>>
>>> An interface that lets the caller pass a flag if they want to know about
>>> non-trailer lines might be easier to use for the callers that don't want
>>> to worry about such lines and wouldn't need a justification as to why it
>>> was safe for existing callers.
>>
>> Makes sense. But perhaps such API enhancements belong in a future
>> series, when other callers that need such flexibility could benefit from
>> it?
>
> For me the main benefit would be that you don't have to spend time
> explaining why the changes are safe for existing callers because they
> would keep the existing iterator behavor.

But, I've already written the explanation so this justification seems a bit
moot, no?

But ultimately I think it makes sense for the iterator to be able to
iterate over non-trailer lines because that just brings more power to
the callers that need or want it. The sequencer code is such an example
--- whether it is suboptimal or not is a separate matter, I think
(indeed I did not look too much into why the sequencer stuff wanted to
iterate over non-trailer lines when I was writing this patch).

So in summary, I'd prefer to keep this series as is. We can of course
revisit the sequencer code's use of the trailer API in the future. Thanks.

> Best Wishes
>
> Phillip
