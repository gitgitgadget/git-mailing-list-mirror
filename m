Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93824191
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771027492; cv=none; b=PV4mn3Ip2L4IrdaTNjyAZRD5vY8+wtbA+kcfuG9IYhxCxrDpAe5Dil7H+5tBXAi/VVrJtdGNsO0yh0Q5qdAK3CiY8gp4gDoODOkmk47QMtySFkWhB3EJsb3SyPs3clLXFoZO6ki11L0ajJD2FZSAHG+CsINU7GAa0mx75Sgj4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771027492; c=relaxed/simple;
	bh=lcHZsWqz+9g7r295g1NMsT+dGyjoIX8h9KA5VDS08o4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uD++lcUarK9CTwXXMyHRv+rK+sjycjvIlklPIdchf3V+fTBKlWB6KsRvN+cuFvbq64lvIZs4UHaGxzRflZZiVAKcmAeUVXPNj66fZwBa4d2lSQPUWUYz0gLtF8q4JHD8Rri49mMJ0gpkf1GkCFcDkuYN2tBt0Ujmn2MHRDpSXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4f0o8Yr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4f0o8Yr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797a75e47afso7892307b3.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771027490; x=1771632290; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SphdNtPUiWnyb9UlVqOUsAjlMhQR1rvM7nZDCQpz7U=;
        b=g4f0o8Yrw8nDJhjqBu/PV8i/eympeGp7eUy95Xqx9qQzY2QZsrSWBh1FFmFNiD80fu
         2mvq/6o6WiyFG5kquoygpqoDtnhwlGmgYg9R6vDEmHqlPHcwACtMijl+NrdxWTalQYAh
         6atmkBRxeIsu2KUmCjIwfJFZJpkBqsSwfOEhByjJLZ7MaBCjd1UbJWBKmv3IPYMr+iU6
         BZ7w31sfHRWVUiR4vyH/AXFxTysXkrqEAtgbQJKpZeim0h70y/KTiPd2Em2byQRsaY+o
         k9zDCbeDVyYuQNXPEYbm02muYdbpuNvrtTJa0IDKG6CutFQrzb4WJ9mSE+mg84cBkr15
         3B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771027490; x=1771632290;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SphdNtPUiWnyb9UlVqOUsAjlMhQR1rvM7nZDCQpz7U=;
        b=Mkbckm7AM/H1C8hyDZI2ziobv0kXE2ZiQUyzYxoYwuf8Kbb6ZddPLR3hFrurDWkh/6
         sHHG0V3FWCJ3C4Ur7AKrjaO1fHRgUn4Ue3bje3Rv0HRH+IEVtskJIT8uLZtqCpbKeTKz
         94IRuNYhgH0uF4yyc2WcOoarHeVyyGb0TBnySFsrS7tN8E9OY6f9ys/HuGTriJr3wWym
         x4Ah5dzYH/B9JVS1fTck2Fq9Vo8H6XeaIaSDhYsrNRjWAXlyB+rENDYQRrnlE2NvpKHR
         mqmPhiweFfhMne1uYEITzxDAU7MjI2wt9ECs1gi/OJ2XQnJrFdEInssTpKpy9cBmLJ4X
         y6Dg==
X-Gm-Message-State: AOJu0Yzp2X+AA+3iVlU0APCxWLb2MOZaM/cYBGXPU7nVr0IW6iw2Cij9
	CmwnR8INGDQedKewy0/VFyaN//AsdhX2WScqndaDmGoEPIP/6AVEVpEuHWJkkQ==
X-Gm-Gg: AZuq6aLJVeO8W6x0eC1cJtT07W6pFBrAIMQjIYLVLK7CnYN/Zv1aLGHxZd53RX0zJYA
	HqrCmk/PY97mwzt269bt6uH6JIu9tv0pxMAU3wpS4MglDCZGKEoEXS41O4osNqRCQUvrPDBlrCA
	al/0Wbjy8PX1H0jVuMm0YxhdcYdD04k/0ZTxsgQs+MR6SrkFGx6bDZLxxMFWwLlikEkOruQWB7K
	nqN8fALxXjudqdQ75T7c8S7dI2qOZxmq8BrLCHmvV2KONACb7cEnZ2YxL9AvKF+cXWuwo2ZKo9L
	IWHCHFBuq9PClpj36QrbNlapi6pIn+YZ2caY9F5s8HWFGL8jMzxbm196ZNSIgmpcPW7QXmVynQ8
	upWDtbxmHg5pCOA5aAIkkeqRjjBmCzA3hnEaaYvLNwIIifnjktpXyavBorc4CAA2I62UiNgmdkA
	0h7jMSs6JV7aj3T0CMC8jsmb95X+Ue24kCHy1ikRf5D4m5GFNksvwsGpk=
X-Received: by 2002:a05:690c:f14:b0:794:cea5:2ce with SMTP id 00721157ae682-797a0c0a55amr29709627b3.5.1771027490559;
        Fri, 13 Feb 2026 16:04:50 -0800 (PST)
Received: from smtpclient.apple ([177.118.182.126])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c267fcbsm77063777b3.53.2026.02.13.16.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2026 16:04:50 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAFNBzOckR2yfGvLMHm0VZW+iKJTgFxzfxQAskdBV2HQ_3yXggA@mail.gmail.com>
Date: Fri, 13 Feb 2026 21:04:35 -0300
Cc: git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03F6CE03-751E-43D5-80E2-E799D97B09B2@gmail.com>
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
 <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com>
 <CAFNBzOckR2yfGvLMHm0VZW+iKJTgFxzfxQAskdBV2HQ_3yXggA@mail.gmail.com>
To: Ayush Jha <kumarayushjha123@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> Hello everyone,

Hello again, Ayush!

> I=E2=80=99ve incorporated the feedback provided on this patch and sent =
an
> updated version as a follow-up patch series:
>=20
> [RFC GSoC PATCH v3 0/2] Make read_attr() repository-aware by
> introducing a lazy bare state
> [RFC GSoC PATCH v3 1/2] repo-settings: add repo_settings_get_is_bare
> [RFC GSoC PATCH v3 2/2] attr: use local repository state in read_attr

Two tips about working with our mailing lists:

1. Normally here we sent next versions replying to the cover letter
   of the first version. You can use the flag --in-reply-to in
   git-send-email(1) to do that. (This is a Git thing, some other
   patch-based FLOSS projects don't do that).

2. When we reference other messages, we use the message id instead of
   the subject. For example, I'm referencing your message [1] in this
   sentence.

> Best regards,
> Ayush Jha

Thanks and welcome!

[1] CAFNBzOckR2yfGvLMHm0VZW+iKJTgFxzfxQAskdBV2HQ_3yXggA@mail.gmail.com/=
