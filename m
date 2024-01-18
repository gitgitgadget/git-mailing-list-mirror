Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949BD25639
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595117; cv=none; b=iwQtgGEeETukwKZYxPc4v9qaiuMEefEzLQhpDtKqR7Usbm3oOSHF9NNdUgM3aL2Ae9mCp53oJ9UaY909ixAJicrOSUHpSJAFYvbW7TDPBZtu5dAmO57QMwnDVyiNlVT2IgDc9ItZvxWXVhUE5AaF0zAi2xiXzI9EQsOJFxBBu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595117; c=relaxed/simple;
	bh=SM00jN6nrhElcoXuyOW4fmRpBrvZ6IhRMTab0l3mprw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:X-Mailer:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSbLzzyruMpmDSdq29+TMft32CYbXR6ypsgAPem1Jdo67kAwc8C2BYVfOT+6p9aQ1bdLEEYmcrqC9GX2kcz93jJfw74iBKToxreMbnzMHLPqN72U99FCb7lCvZ5qzVd9rgzvmYMSJIETW6EUD2e4C6fdPhEX5ROaBD3I5n3t/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrJB7eBi; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrJB7eBi"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-598a2136259so650025eaf.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705595115; x=1706199915; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbeHi9DsMjMa0sWVd3/cwBtTMHKNN+3OpnlpHFidS4=;
        b=YrJB7eBi1ChO1W5JakKJNanueYgfuA6Gk4bZRS9nD0lAcFcCA5dNcPVsvvBnXSwNk0
         u0tjEYoQ5Xid26WCmS0ve7eemj0Gy0jFjRMhN7W5cQoN2WOEK0jUwUN4XM4LWj8KFyLt
         0G353E1HpgNWq9NTjHXfg9z8ug//YpXhDnJrigSeTRACiBjVsHMNtTiz3ZlOV2SVYDBt
         ocNwkG7hRJ3JV/IM8AqyxZUKzW9Wa0SwBEBY5hxyPpPA1e8niYMYr2Dr/DCXY5xK5Sdv
         Ie6N0THDl6F1kG+bhlBW2yvwsBxAvHEgyGDO8tton0ut15VG2+eh/I4ilhgs3DfRyaiB
         IV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595115; x=1706199915;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbeHi9DsMjMa0sWVd3/cwBtTMHKNN+3OpnlpHFidS4=;
        b=HOCJRAvNDui42rhQLKUbdl/AUhykK3q+0mUcrBcPaoB3Yu+uPm5ZRJ1QUKi54J0CRP
         M1ZVjbnTgf2zMrjsdTKZg9ozuHalBjJ68eUw4p10oaCG+/bRfIv6Z4gLds7b5jUmILDS
         ol/+VYrT5jVRKXQy8Gvt3tLtn63Utr8Nh/BB9RN5HhDBt5zWHbRkIUUzenG54gWKAK0O
         kKlZldhBxTdEXNdtUg9T1YiZSgqORSBWK5CXELrQGAydGdCs0JOxBA+u6SSYDhN4jysR
         39F52h3yrw+3A9pQIg8gUdBHzseaNX5pmGQP+0k9g2N1eUHWiY8TiH8OxPln7bbivwIn
         e8CA==
X-Gm-Message-State: AOJu0Yxvj4AIRRkucKEMogYc8nVQE7nAl30W73BfEimIUTssUXxTk3B0
	9GKQL5ptMw4Fzh5Ifp6ckmnZQeMaY6UZe2OOTFvP4zCPWDU9ffC1C9LtnBl7
X-Google-Smtp-Source: AGHT+IHkMR+0oXH2LJQDvMfqd+k6cSnPU57jfQB1A0GNDlP47N3riXujBGMaGDRGz+c76aagTr4rig==
X-Received: by 2002:a05:6820:2b13:b0:598:c118:30d1 with SMTP id dt19-20020a0568202b1300b00598c11830d1mr2136546oob.0.1705595115517;
        Thu, 18 Jan 2024 08:25:15 -0800 (PST)
Received: from [192.168.1.160] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b00783484abba5sm4862516qkp.90.2024.01.18.08.25.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:25:14 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/12] t3210: move to t0602
Date: Thu, 18 Jan 2024 11:25:13 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <31D22360-5F20-43BD-B8FC-0BA2BC3A2EA9@gmail.com>
In-Reply-To: <ZakMQP3r44eVc5Dh@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <0e2b6e197ab2fbfc81a42fd601b6aaf41e38929f.1705521155.git.gitgitgadget@gmail.com>
 <xmqqil3rtqxh.fsf@gitster.g> <ZakMQP3r44eVc5Dh@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Patrick,

On 18 Jan 2024, at 6:32, Patrick Steinhardt wrote:

> On Wed, Jan 17, 2024 at 04:40:10PM -0800, Junio C Hamano wrote:
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> Move t3210 to t0602, since these tests are reffiles specific in that
>>> they modify loose refs manually. This is part of the effort to
>>> categorize these tests together based on the ref backend they test. When
>>> we upstream the reftable backend, we can add more tests to t06xx. This
>>> way, all tests that test specific ref backend behavior will be grouped
>>> together.
>>
>> So, ... is the idea to have (1) majority of ref tests, against which
>> all backends ought to behave the same way, will be written in
>> backend agnostic way (e.g., we have seen some patches to stop
>> touching the filesystem .git/refs/ hierarchy manually), and (2) some
>> backend specific tests will be grouped in a small number of test
>> script files for each backend and they all will use t6xx numbrs?
>>
>> OK.  Sounds like a good plan to me.
>
> Yes, that's the plan. The backend specific tests will be free to also
> exercise filesystem-level behaviour in order to pin down that things
> work as expected. But once their behaviour is nailed down all other
> generic tests should refrain from doing that to the best extent possible
> and instead use Git commands to do their thing.
>
>>> Signed-off-by: John Cai <johncai86@gmail.com>
>>> ---
>>>  t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} | 0
>>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>>  rename t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} (100%)
>
> Is there a reason why you picked t0602 instead of the not-yet-taken
> t0601? If it's only because I use t0601 in my reftable integration
> branch then I'd like us to pick t0601 here instead to avoid a weird gap.
> I'll adapt accordingly and rename the reftable tests to have a t061x
> prefix in that case so that they are nicely grouped together.

Yes if I remember correctly, that's the reason. I can move this to t0601 then,
thanks.

>
> Patrick
