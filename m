Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA204182BB
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906553; cv=none; b=l3Ca69BHXzc57OZVVFYTzlwy7Hsgz6y6oTE1i0fY+CRV+uDF5fNkenjyDC0UH7wbW4SZKSifaEg2VuBtjcWfqVqucj4QxEkx9+cWVnCrXyZ+RUFBQjgVgCtFLiovRfMOHsiH+ZK0F4oSivjlprnj3xuXD7L3dIrR4cc7no7lDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906553; c=relaxed/simple;
	bh=HaUy+P6640w9uxBrNfp6FSmsODaGhwn2J3KbEpyhCWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB7+G+6dvCsvBenzeikYeDrwmtmHM8ZmKIOLtBEvBwXJ589Bx+NbIRRITY9f7A2H03F9RRXsOKRPXWVPOkrC8zbezS3Vn/9VXeCfJS6dLoRf+K66Fz8RQkN0FBPesi5YbgYlPbyrp/ln3Ku9T/GHv6BChyqb3DlYXmIsJyVBI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo9/dNL5; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo9/dNL5"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21922481a2fso3709812fac.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707906551; x=1708511351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fasvEnqHRq7BMVF5cxURa2Zl9w8sC4IgOadk4K+slow=;
        b=jo9/dNL5Fr4VClb7T1c0mDhqMH0Wj2khpMWV66nGLTKPjLqBtFLaP8k7UM5OTXgPZr
         UD3reEdUnzpvk3PhoUwUOswTJYrYp0yu64/RPwVlMY8jU3BZcA2xW7BDXEyhva5L/YBy
         /OjUP9Mk+IRCJQ+Y6NJQMkxMJmLayqmSoyuakuffQes9GHulY7wZxD17T0fd38o3YPlB
         206ZQngZ7ss0ByvoO+HdjmB57w+xX/RdaGEFMa2So0HPSniFGFtmWjK3olfk0EQiquFU
         u9WnGd2ARg0OVdW3oQ6Z2fKBIw6jD3CTYC0p31n+dhzDZM6frQIV24GGjFqIS5rdK/Rn
         O9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707906551; x=1708511351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fasvEnqHRq7BMVF5cxURa2Zl9w8sC4IgOadk4K+slow=;
        b=UoTdM5GjQB/g9dozsmpMmlyQd/GvNK4mppIQHeRzIpq9Mfhp5SM6GIaqmckaWGT7gt
         APJNryICVvYpUqliOk+bhXThsHEKv9LLyc1iMpLLZnfZtO3dj79XpF/iiXYXyDc5UTEE
         7/b/Cn7fK03AcXjCjFJlXOrzkPyy2T18zfP+Ge3fJJFiqlx2GX+0PMvRjMn1bnsruCzV
         doiuxhYpagC2BY8qb16oPseTh8WeQ0oBxqEEgJmMmDpgW0XDFzEH9iOKQOUfsze61wu0
         iRS1n0y1ddmAWmX9ddukoMd8Lhv5h9YnaBeqU+EhU9VCe/bgfa7uNuA84F4gHa2T4vPP
         titg==
X-Forwarded-Encrypted: i=1; AJvYcCXefN8WlchL9wifmCaCFQxZeV9RYRg0yCNXH1jkmbYuQVbvVTQwSKhauBX3qXXeH+Af1VmJNcLKGtbKASGVozmnLIxc
X-Gm-Message-State: AOJu0YyDN6E4lTwO/t9SdffwRFGMkBcHJ/q+bQR0ORCc5/BuTdJC0boj
	kY37Xokp9Yew+Atm4qbZpNhwybGy2Qbbl0A0d9EiH+u/Qvtxg7hE0cRWZm/WzW7m3t+Q7NiXEj7
	xA4I6VosCkVfHADvGbneBz9YzD00=
X-Google-Smtp-Source: AGHT+IH+82bz8RJuiDlG1xk0XC20GQ9+4UtzUDY+fJ4uRxU+r5SxfRU+/5qNUh9VXLEWDqnHFWfSD4lt5NlJ+sekeBw=
X-Received: by 2002:a05:6871:3230:b0:219:69df:67fd with SMTP id
 mo48-20020a056871323000b0021969df67fdmr1593949oac.46.1707906550661; Wed, 14
 Feb 2024 02:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com> <20240211183923.131278-2-karthik.188@gmail.com>
 <ZcoTbRxIaGmTd4fJ@tanuki> <xmqqh6ic5ex3.fsf@gitster.g>
In-Reply-To: <xmqqh6ic5ex3.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Feb 2024 11:28:44 +0100
Message-ID: <CAOLa=ZQN17Nyxo-uv7CytO1RkaPu9TPfeVHANvV=tycCGpy+Ng@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, phillip.wood123@gmail.com, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 13, 2024 at 8:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I wonder whether we can maybe consolidate the interface into one or
> > maybe even two functions where the behaviour can be tweaked with a flag
> > field. Something like `refname_is_valid()` with a bunch of flags:
> >
> >   - REFNAME_ACCEPT_HEAD to accept "HEAD"
> >   - REFNAME_ACCEPT_PSEUDOREF to accept all of the refs ending with
> >     "_HEAD" or being one of the irregular pseudorefs.
> >   - REFNAME_ACCEPT_INVALID_BUT_SAFE to accept refnames which aren't
> >     valid, but which would pass `refname_is_safe()`.
>
> I am certain we _can_, but it will take an actual patch to see if
> such a refactoring makes the callers easier to follow, which is the
> real test.  FWIW, I am much less skeptical than hopeful in this
> particular case.

I was trying to implement this and realized that the changes sprawl
multiple files and
and have a fair bit of complexity since `check_refname_format()`
implements its own
flags. Overall, adding it to this patch series would overshadow what
we're trying to do here.

I think it would be best to tackle this problem after this series has lande=
d.

Junio, let me know if you want me to reroll for the whitespace issues.
Otherwise, I'll wait
for reviews here.
