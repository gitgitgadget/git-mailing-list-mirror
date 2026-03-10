Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9B1F30A4
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102183; cv=none; b=GMpp2AT8hqBl5dVXzdFhu3Z6hVyMSYztBQLLoi7p4h1jhZa0cJ2x+6z48yiwn6mk//mKB2HreT8uyDawHGSu7ZnPdlkOm6yi+Q3fwgp+1qFM86E3ydE+7wv01nN4adUmNjnX+jneflLQ5RXsMjlG0jSHoe7Y8W9ZayB5k2d4a/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102183; c=relaxed/simple;
	bh=NcSjhdTQk6r68lMBfMusbvSjWrq1DxxjZr9J7IDW8S8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pWwUBXBaxCGeTK+OPhAemuTeyvFriXqTbM4HZ9r5LIMBY9BUQlWngCq9Nvmyy7WbI0SYFkv3qV1u4/iiyG8hIlIT1v19yBlHZ2OpxQTvPMeXLmU9GsAWd9N65snthCswFqL59YhYzFXMmN1WtdOj0C6aKOucR+aNdHhHOaQKcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7gVgqJt; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7gVgqJt"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be1d9c356cso6933919eec.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102181; x=1773706981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcpbxHSScxU0HbkTKCBZULaxuWY3oeif8EOmDIEHipo=;
        b=S7gVgqJtEPNnH6aQIjnLODNjyKDlI5zE96Vy7apaLH87uClk3YBKpWFyOR4JqA34O/
         zgUhx0B2oJyOD9CyL0CYeYq6SbqMMJ+35IM50N2a4JnzbRjdxpsrDeo/vtDgnWZbvJ0S
         eDJzGJC+fOefoDhJK2seEOhi61Pt5nb3zBU5oWArslPM1XK+ygvh5XUWiWyeToBUaySb
         8Dv7sWz9sWFjOJ2qY49dktMJjHnJ8+8w9CzXlJb1NhOp9aE8PJBw9zwXC6ucBaTKBApc
         t7tayCvpyr/UbM/q8RFaJnsWNGmo0Kuob5uurvyuu56fUJ4k+8sR1csExEzoU6GsQGQP
         heNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102181; x=1773706981;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcpbxHSScxU0HbkTKCBZULaxuWY3oeif8EOmDIEHipo=;
        b=MuuShIR8P11C9SiuVOMa8xK9mV1MOyqsu+w0ZUhJUIOf5yKtDAzTsacQ7NGaybXHrf
         hl8rUWkZL3Htet8PQcGfRSfFSQlUItPDjnV4P9ITunXq+LgTQPd4fmxr+6qPLl+GZCWl
         gj4eo+FJ/cjoWrqboaxo19Hr9U5/Wu8/2C1DOowZe6MUyRHmEi1O/pNn63DzDHBPRPyM
         oMIpKZhM/bZD/A3a1gqc6hS7sJi1/wzDGZE2YP+h+yO81W1mSIDFc0dPL3vJLHIAK7M7
         isTOzs3BxipLdQEYvrkPO8hBJNW9P8joN0LQNrLl3Q9I4PSwDHbpKLDgEeGQINskZuI8
         BhJA==
X-Gm-Message-State: AOJu0YwIPqjjdMECjU/fVoGTNZqT755e0OvdFc/x9gGEnoaHbh03Z+tt
	SghxLv8WF+ZoFqnnlg/23rklSIh7/noKMCtahYSL4a2lSXnn5SpRmQza
X-Gm-Gg: ATEYQzxQVJN0Jz6pivFxrb4mt6WFHNV/Rm5aSuWTtKSDtrKaLAfFR/7TUeHke1hxXBe
	DNVSRk8TPsCX3F0vNwD9gy8U+nQlLySPj6rUnfLSFVSrdhR2jhXXS/69SikJEDpegliuySgN1QR
	c0ppikZ+w6cYxpV7+pmRolnbgwY0la9QhVNBPq9P2nFmWjBx7KoCfKy3ypqARJfqvpv2JN4m102
	rIzXtvgRTVpiP+ad5+Dcq5HXUoYZqlN9aMA4GwPOjIwjOzymPwnPRQWmDiyJZvsLJNLxi3izpqz
	uziYyYtztaY/WdyFQeTMqqebRqYZtp4FLEmjWgfxQcUtB2OodEGaAwUXQ6UbZOUed57/jCCyEZM
	7XWOcL8aQWYqSPBy+FzEE9pbTtzxu4bUmKRgQKXxXvLzsJuubcHtdOrCGKdVJleFcEKvmUJPTk7
	+824x4GIqkBbQsH9Q=
X-Received: by 2002:a05:7301:1291:b0:2b7:fa47:3b37 with SMTP id 5a478bee46e88-2be4dd81d45mr4903344eec.0.1773102181249;
        Mon, 09 Mar 2026 17:23:01 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::36e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f8078c6sm13604871eec.5.2026.03.09.17.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:23:00 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Derrick Stolee <stolee@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] dir: avoid -Wdiscarded-qualifiers in remove_path()
In-Reply-To: <xmqqbjgx6obs.fsf@gitster.g>
References: <3ad40c3d0762c2e8c14792dfb68cba9f63a883a3.1773026586.git.collin.funk1@gmail.com>
	<xmqqbjgx6obs.fsf@gitster.g>
Date: Mon, 09 Mar 2026 17:22:59 -0700
Message-ID: <87a4wgwn18.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Collin Funk <collin.funk1@gmail.com> writes:
>
>> When building with glibc-2.43 there is the following warning:
>>
>>     dir.c:3526:15: warning: assignment discards =E2=80=98const=E2=80=99 =
qualifier from pointer target type [-Wdiscarded-qualifiers]
>>      3526 |         slash =3D strrchr(name, '/');
>>           |               ^
>>
>> In this case we use a non-const pointer to get the last slash of the
>> unwritable file name, and then use it again to write in the strdup'd
>> file name.
>>
>> We can avoid this warning and make the code a bit more clear by using a
>> separate variable to access the original argument and it's strdup'd
>> copy.
>
> "it's" -> "its", if I am reading the above correctly?

Yep, my mistake. Assuming you can fix that locally?

Thanks,
Collin
