Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4C54BC5
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378344; cv=none; b=g8ZJWIXFD5xJoMzsqrNkXUvq41V09WTvI6P9KFnOIyx6+R4HTeNjd/h4RoheQYSqmN+S79uawZit0ygsVXwBSV/2XU9XYP4lfPuMZOHCK14Flrlb3Q1Mok6N+KJMKpqrBfAReFVwjrueH5yQYZWlBwLxEnyoJgZL1yDfi+v0nXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378344; c=relaxed/simple;
	bh=KUe/rpQxgCiAdl0ZA0eoOWHySpfziUsGrRP9lalc87M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuMqUStLZlk4YyYFBm9uA21Q+x1CWU59LgrJPaDsiXNfSS2rFU9xGttFTgef4x3eWS2xI4FhRuMovNkjYZZ42/9Lo4OuvnG007NL3zoSf1CqrIjOsWK3fqoWk02JFRsyXuI9mpjK+xJkuUEq94uu9u6DnInCLjxSUsc4ZqGV+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJp/6Ti7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJp/6Ti7"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512a9ae6c02so2576389e87.2
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708378341; x=1708983141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUe/rpQxgCiAdl0ZA0eoOWHySpfziUsGrRP9lalc87M=;
        b=dJp/6Ti77i7toKywQe9uDM3V6DP6cUu840uxaHD1mtH6lhxgGFy7kydhdQ41aBtGe8
         x7/aj3q+Kd3gC8l740cTbwcMwXoUyOF3Pw7gJB3yoqF0KpozZ1/vC0fQp6hxMuNX2wRr
         9txZ+Hz2a2xhcDLjmJmiXK/fOjIdLksU/7/yP3BWNkO6qyv7VLFMAEVSx55c5SJHs5yB
         6KAcrn7wBxmHxGbtLPz2vlkzqG+KCOH7LepUEZFveiOiaA93KwC+OAdwQ31lqVQYReAc
         WiMpxjoZsS5cUARalbhj0NdALPzb0Bxz2cEYKBHjDJRKniXgpKD2VHFDyeyKFT4ZF7L+
         MQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378341; x=1708983141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUe/rpQxgCiAdl0ZA0eoOWHySpfziUsGrRP9lalc87M=;
        b=tE3MEfESq/IN6vQLfPCME3frq1QzDEyxjKVNsLdfqH2HuDBxg1Dqv4i2cqczRsJ+2D
         +cOXRdDyUwoOgGmEDi07in6M1VKCLnVocozBKQMUjfCHgW6M7IG1sosca10rnIbcLpVA
         1IxJGLGOQfSN7tKIkGGUkMzz4Md/CyUhKuZGzbC1/8mdjduWt/982NPlzl2iWPqlRxsD
         0eqvzjsk/tuiFMgx7cQKoB6LCp8FgG9vAK+lYi2Qn48eREqmMCZjGZ3Zk43ZrIvu47Qw
         2uWOGNlXr4s2Fb/FfCBJXIT6I/eHyxgncEREWlbdfC5NoVQWq/+rfj2vChmFAtTEVWF3
         6CaA==
X-Gm-Message-State: AOJu0YzbrmS+t6M6cwNNwjvrZ2ScAeGe8gDDU8lrDMyrggmm1sSza6RL
	r/hCa+co239CUduZtZOpRuzFVjoyY9a287fBhiMReDZn4EU+/ozTY5Zu+9nuIUotTmZPs6+5K7V
	z9EP7hQhBj4znKKet2RtpNXI5J9o=
X-Google-Smtp-Source: AGHT+IEZPraOX0Yh2HGrlOM3Z7WqcZD9iec4v/FrmHyxhR5jl+Evy7NhzJSQQ7pIEafYWMUaH0RLaiT6R5VYVs/a+dQ=
X-Received: by 2002:a05:6512:23a4:b0:512:8a75:6ae4 with SMTP id
 c36-20020a05651223a400b005128a756ae4mr11187708lfv.66.1708378340290; Mon, 19
 Feb 2024 13:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <7c656b3f77546ae917ff192031c62d4521d9df8c.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <7c656b3f77546ae917ff192031c62d4521d9df8c.1708124951.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Feb 2024 22:32:07 +0100
Message-ID: <CAP8UFD0JV8VEC-MDu86Mzrya9G7JBZaP2vXjFKwcKddEkh=y5g@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] format_trailers_from_commit(): indirectly call trailer_info_get()
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> This is another preparatory refactor to unify the trailer formatters.
>
> Instead of calling trailer_info_get() directly, call parse_trailers()
> which already calls trailer_info_get(). This change is a NOP because
> format_trailer_info() only looks at the "trailers" string array, not the
> trailer_item objects which parse_trailers() populates.

Is the extra processing done by parse_trailers() compared to
trailer_info_get() impacting performance?

Also when looking only at the patch, it's a bit difficult to
understand that the "trailers" string array is the `char **trailers`
field in `struct trailer_info` and that the trailer_item objects are
the elements of the `struct list_head *head` linked list. It could
also be confusing because the patch is adding a new 'trailers'
variable with `LIST_HEAD(trailers);`. So a few more details could help
understand what's going on.

> In a future patch, we'll change format_trailer_info() to use the parsed
> trailer_item objects instead of the string array.

Ok, so I guess the possible performance issue would disappear then, as
populating the trailer_item objects will be useful.
