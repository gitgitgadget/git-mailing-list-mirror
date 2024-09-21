Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546FA79EA
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726901683; cv=none; b=fZIwRCXmtIgoe6sM1v0T87QKzAA8w20cK9OTwRn/tzly6RFj7QR4Pd7+nkkRw7IBusOHIoqOkiTU9pjagZ1PvEAlWC8khKekbvCGwitdGWzoAFAs9xUKYq2txCLtCfJJ0w+do5Lk2wKRslMjVs9tAWZe10goL1U5GpSEH2ySgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726901683; c=relaxed/simple;
	bh=0gTq2S3s+tvQILx8DBgaZJ6LZQk1NyE4Yd3VlLO9IQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDt/uKqTE4pqJToYRUC2PHWRh10AwKOI751sKZtEU1JMDtJKuKhKRBjsQhoZ1BM72M546PA2ZPW6eyF+Duzr5ymwKBuCoRkXLrkxSmF/XIoqXbzdKuytt0TjuiXLuZXmA5ocNW+ffjrY6SJfRUwLB5euZj1UZZCbH9PX7iPV6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esemtm5E; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esemtm5E"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a837cec81so182783666b.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726901681; x=1727506481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gTq2S3s+tvQILx8DBgaZJ6LZQk1NyE4Yd3VlLO9IQw=;
        b=Esemtm5EJugaCkkppCRIX83WvDPYlRG5Pdu9/qNgslPCuJv2Ah1F4RA7bCgThPwRq2
         3Hcf7xody87AH6vzK0KJnAK/O5Cy+79S5uKAfMErd+pETLbLUWq9I6QmwzRkJfDUHrke
         CcI4ZDa2yPsh9P/icqshhcY1okV2gN7GEJ3bBiPyZDFxVDb4mdcLS7pWclcdmq7mohjh
         oFKY4xafpQpYVomDH36Cj0tH/kweC7JaGZarlz5JmQ7EFHdGVBLRLNhrNn7v9mDS7KeV
         ZhyeONJTui22rEge/Dhrw8//zUCv6fMGhqE4CUWvKeqrXZ5wWRCn6aVYED4FobxdW/Cy
         d/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726901681; x=1727506481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gTq2S3s+tvQILx8DBgaZJ6LZQk1NyE4Yd3VlLO9IQw=;
        b=wjYXrWUOwHL8wymkG7K+DEPCF7JezsGZ5jvkC38cXK3iS7z9hGVrzs8BUF9fw5X+PR
         xi4Mtp+JkXi4FHvYe9bz62kzyNwCe4OBjSCOD6tNDkeN2YDiXONR3UChKEjPspNZv4ps
         uFcPY3Cvhwe6TPh3jdIqcFrPGbWrhF2Jh8OdgHNgdoEOhCyAU0VbzvoQmOkhdmJ2iHnF
         qxZ4Y+7yAqnWkOxc49I0JsQuXUQIZ6MRnD1hDlWmz3s+HsdkWXkt3/GO9AGr06yks+RH
         tMQUEkUX1xKndWu9PuPQOxdP9U6Z3G42xKDSWX/VPlbM6T3K0QT2QWf71bnlDTJmOPTs
         tWBg==
X-Forwarded-Encrypted: i=1; AJvYcCUxre27efVKhqcvxgUOeELCcWez3wg9jKlXTgISqEps13tjp0sic801cCalemjQ+vSGJD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tBKDpJiGTY9znD0nF2m1tmZRVFMfG/7HVdFgjsu4ZsQqyQgz
	dBa9j/yLeJ2cDin3K50rNO6byeKdk58N6E+WGwYtAMS5krGDAUSa3pyaS3xZwb1nwA6dHN7zukV
	ML5C6t3qj3qwwrHhiy79GYnCBPMY=
X-Google-Smtp-Source: AGHT+IGxS0hzaeTK+X+UhobFVRKf2tZ+Qngam2IxOO+KJEa2ZgcNrE1z+s3m6UTm7YIfjxJCXabEUbTfhXmVsxPHbY0=
X-Received: by 2002:a05:6402:358c:b0:5c4:23a4:ad5f with SMTP id
 4fb4d7f45d1cf-5c46484f30bmr4450032a12.6.1726901680427; Fri, 20 Sep 2024
 23:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
 <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com> <xmqqo74rxvw0.fsf@gitster.g>
 <4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
 <xmqq34ltbkah.fsf@gitster.g> <xmqqy13la5jb.fsf@gitster.g>
In-Reply-To: <xmqqy13la5jb.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 20 Sep 2024 23:54:28 -0700
Message-ID: <CAPx1GvdfE+v-wV=gbTZJi6GvwGhw8NZcZHnEwj0K+YSTfMs4Kw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 11:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> The reason why I am curious is because https://ss64.com/mac/sed.html
> claims that -E works.

It does for me, on my Mac, which is deliberately behind current: I am
still on Big Sur.

Chris
