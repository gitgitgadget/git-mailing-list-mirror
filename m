Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102E27FB1E
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771471781; cv=pass; b=Tiuj3t/NLwzuU/NPo5WUkD6dc5EaK4QJgECCw2ElxjFov4599byxsesO0y26j/ZikVRpnfb9gBSq3D/KC+8S2aFW7N6mwZLUfKCtZXZi64r1AMdMEPWGYfPvp6xncbuYSQsb+ujSBN4FA238fTMjYHMKQxztHhVtYqzqGTzMKQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771471781; c=relaxed/simple;
	bh=bYUaL7eAFQbg1PtTKnSXbTW4R9/FdxJO0ZdqKk6BxzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLVJSRd2rnWcJIQ0X2YC/uQDVQxIUmoFIxpd/vwOdSQuhRw7tp2v7BTAJfhaeRjBL9NKfYAxm6xh9cPFBhFWqhJOvOkVn5iNBVt8TytH566tsSpddxRgCLHGiw1m/W9pZtUk4ErGnhxij+wClQ/K6Cy446ksaE+J1oJ7xSpEXBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2baacadad3eso7218eec.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:29:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771471779; cv=none;
        d=google.com; s=arc-20240605;
        b=kUjtEf2KiqniKwtC5tsjGu7Moxbn8ytM9W92wZeK76dlqnB4znm1v+/DR6j3ThJur2
         /Nr0MAV4R5OmOdhZb6mkCWtFPD4TkXmD5xwRiq1Wd+d78VUiNX2FstYgC1tGvJOf1kQn
         g9SSCAh2BEwrpM9+6kxYDvgwOnj3XDlLTR55tLldZy2Q0rW1alLGlS8yPXUDB8RcM8bV
         r64a/OgO8IT+eMB0yGxxyIK1dbJty9Gjt2xJrlonIWKH8nm5hAw6W5+m45SkIyvulhQA
         FnHF910Tenkzlw+C2FzXj8N75Cc+2PDawFc6vb95qR7PclsMxGRJY5S8TfgD1B3RyKsf
         3HUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=j8Mo2vyTniEMRUgDjJP24hqy8HN7JwssdXp5zqiqs7Q=;
        fh=ooHiwiL5e7Dkdch6gj1DoeZT3jYODTtLPLg+ee3uKDc=;
        b=d+AhjO8Lk8rZ5in5svQeneIEh/dq2ephZPeGpEc04vjOdJf8xvQyUey+mNd+j4RmOF
         nMvLokaX8gZLE249eBgrkPZT9+6nceQQ7Duhiqv7Im20Wet5hrg+4aZtsBCmGQ5omCxH
         m385wswVVN2CzPwKbj8bCdElpa5ONCN2Cs9Lz3VuCATSQGZeVEHskyKO/jTrOKx+NSyQ
         hrM97UIJTytZ4s+CuB3QYN6cvRVoU6lCk3WVyYEXYUSERyTYW/+jAXTjt8QSWE0VvZtl
         GJskkEAbfd+c7YBfnRgj5W4cWRB0ngirfHln7wVqMeeZXUPn4u0gYFW2P8JiIwqoH8uC
         X8hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771471779; x=1772076579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8Mo2vyTniEMRUgDjJP24hqy8HN7JwssdXp5zqiqs7Q=;
        b=RxpE6FJI+0qAq6Jg3duEgpMkRpyQoDqXJoy6WPxVYgYRUlL5Ap2S2coiElgDqM8k7V
         rr2eZ6K/WCF+f3vA4lysgx7pzmcEdzB+J3SGM9XaE8b3gq0P2oP8G/q9kOML4DW33n2z
         GD1C15rGA7hEaUEtyq2KeKDpT75hueUBYMXK3JTiuDO/kK1bYPdQ2IF93iKOy2zgyKti
         R3hVB6PSAmSz3PHMZvX0ejBEOM6CY46pIwt9GXXLWCdp87kyPMTmLhrmPyBlTuR0e0rh
         J8m2lvhnerbGzv0sWDPUzREOA9JzPVg4B2eS2JY5i+zPLzhnS1gDmYtS4PWpaIyyN+mZ
         s8/g==
X-Gm-Message-State: AOJu0Yz1lAdALxMmq9B5j1WwueSD0mwAVJygR8rdqFTDJivXEWIvXCQA
	OVBiReY8qEIWvoR+wl1BcFToyybyuhBX4UcazBsVLPg1X6OndUWUFAOOz4m1LqZ6HaQeez1Wa23
	BtHlqUNIh19TtZDFoYsJIhU/k6gac0ME=
X-Gm-Gg: AZuq6aL6/XqAH1uC6jqkrXxz4vujc5nJy9pWeK7NuilaqQBe6/Aexo8qlqY9fYBmDvO
	Bt8j3NRjBTYX3l2cQgUqAUSFJjXtSe6cvOsHJqmWVQh4WHej/BR0Cx0GkeORNJDijL2QO8VhnzG
	IIUxwxSMUvu/EHDmM90BmC0xnYUz/Q33EEV9tkRRxYIAF3oU3jXiQ5k0Vjcf93LLxXoAsHXV7Tc
	FQwKGkbNzcBi/7ykRmfH3+z4NsXF6QOtEV9LnTk1xupQwM/Ri6f4/vTN0Mylgt1PmAMUCupgY9E
	XyXxd/gy8Q==
X-Received: by 2002:a05:693c:2c05:b0:2ba:7d5a:a816 with SMTP id
 5a478bee46e88-2baba09cea6mr4584181eec.4.1771471778696; Wed, 18 Feb 2026
 19:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com> <20260218211845.96009-2-lucasseikioshiro@gmail.com>
In-Reply-To: <20260218211845.96009-2-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 18 Feb 2026 22:29:27 -0500
X-Gm-Features: AaiRm51xY-NVMZlVHOTVrHfbFDb97CSqOUtuxdLdCstsITUgFrpjoDkDqcNuf8Q
Message-ID: <CAPig+cRHm1vDABoHNKiuBRRsvk90Z1qGeeu3DT3VHdzEfJeP=g@mail.gmail.com>
Subject: Re: [PATCH 1/8] CodingGuidelines: instruct to name arrays in singular
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
	avila.jn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 4:20=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Arrays should be named in the singular form, ensuring that when
> accessing an element within an array (e.g. dog[0]) it's clear that
> we're referring to an element instead of a collection.
>
> Add a new rule to CodingGuidelines asking for arrays to be named in
> singular instead of plural.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -656,6 +656,14 @@ For C programs:
> + - Array names should be named in the singular form. E.g.:
> +
> +         char *dog[] =3D ...;
> +
> +   and not:
> +
> +         char *dogs[] =3D ...;
> +

While this is generally true on this project, it is nevertheless
incomplete. More specifically, the singular form is used for an array
name in cases when the individual items of the array are the typical
subject of use, for instance, when the consumer of the array is
walking the dogs one at a time. However, there are cases in which the
array is generally employed as a whole, rather than as its unit parts,
in which the plural form for the name is preferable. An example would
be when walking all the dogs at the same time.
