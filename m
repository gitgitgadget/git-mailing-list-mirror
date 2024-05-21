Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD69475
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334597; cv=none; b=SsTQuPAnWW+aqbFIqwQTrddnSBvZXMCoMUXghehcqUCCGw36lhrMxvtgzpc2kqsUkSDhxjunH3CqaaeiX2GBMZLA1u9Xk6urlDO+JtVm7UAi33j9GtbzbYaGL0hhd+0zQqVTCEu00FT1wZfG71pyaz3CYnHHpBYnRflbPehUf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334597; c=relaxed/simple;
	bh=fdYX+DNqKlIlAI2MWtWzBsrbnIchfw7KL/Pe0EsDK7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0moNGMUZvb2nfnwgX7HqBzpO+Mz4VpUPmn7VfoXvjuslpMcmXn8usAbUAk9XAxDx/BCVodU/xfZ3bMLPoeQz81GJm4dk7ZJrFjt7zpcPbt/RqahD/X6s4ia8+rYc/mpS0inmqaePuSpc0zYy8D/m87j67i5Uv9zLvhCDTcA9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792c031ffdeso388172385a.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 16:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716334594; x=1716939394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oWIPRA/SWUzNrgn6fe6wvEY9TDnmmuaZu5wb9oaS2o=;
        b=DmGdWCAre6XZghNt50vuuhymWflCX2abeQ3WF4ERD6fOldjMEsWBuGby7gxbVwbNqR
         HZ0/W7KFDxB1W8m2lNZOBy7g1YhABF8Ig5jhxGyJ053ajyOy0kh2dTnUhUF+Nb8CExFf
         Q4639D8k5x2cK0Kdmy199ch8hkjBzkpVX2ScUOA4qu1X1Bck9Zv52Jo7Wz+z6THc0x3O
         Cui/hs/k2O0vFfbMzapbmR//exMHT8OJHa7MltY2mySWq3z2a82i8JgTuZvpmqPfw21z
         NRmiwFZvl6GzR4mycnQmqYh0vD505EohkdQhXSxl64pPkrnfekKIg8c55NruXU0gj17C
         /1QQ==
X-Gm-Message-State: AOJu0Ywq6DEAodfKz4hubOtrwC9/BeYJP5xnNtTQzHIOQGdqp6maPP7N
	ZMmJGSf1cQ1YWjpedc3v90cRJIB6cj0OT64hK/B/mfOq1gFRjEp8cxFdQXjqqNWTzub0c5pjYvN
	NkvyYq0s1fEPr6jqSqEPf6e7zgfRy4w==
X-Google-Smtp-Source: AGHT+IGvYRxU6xR3ptYB3NyALu2SoOWmePJFLubaJ249ab8EEoCyI/PfoKB2+xqAcxr3Gj1zeNd7TYU4rctOHnhzrr8=
X-Received: by 2002:a05:6214:4343:b0:6aa:ad37:8208 with SMTP id
 6a1803df08f44-6ab7f36ba57mr5405256d6.31.1716334594418; Tue, 21 May 2024
 16:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
In-Reply-To: <xmqqh6eqiwgf.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 21 May 2024 19:36:23 -0400
Message-ID: <CAPig+cTcmpm5kHLwOzcJ4RfmfJwfO1qB4VVcngcvh=_zL5mm9w@mail.gmail.com>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 7:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> In an "git add -p" session, especially when we are not using the
> single-char mode, we may see 'qa' as a response to a prompt
>
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
>
> and then just do the 'q' thing (i.e. quit the session), ignoring
> everything other than the first byte.
>
> If 'q' and 'a' are next to each other on the user's keyboard, there
> is a plausible chance that we see 'qa' when the user who wanted to
> say 'a' fat-fingered and we ended up doing the 'q' thing instead.
>
> As we didn't think of a good reason during the review discussion why
> we want to accept excess letters only to ignore them, it appears to
> be a safe change to simply reject input that is longer than just one
> byte.
>
> The two exceptions are the 'g' command that takes a hunk number, and
> the '/' command that takes a regular expression.  They has to be

s/has/have/

> accompanied by their operands (this makes me wonder how users who
> set the interactive.singlekey configuration feed these operands---it
> turns out that we notice there is no operand and give them another
> chance to type the operand separately, without using single key
> input this time), so we accept a string that is more than one byte
> long.
>
> Keep the "use only the first byte, downcased" behaviour when we ask
> yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
> 'n' are not close to each other.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
