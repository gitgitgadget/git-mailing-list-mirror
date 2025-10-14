Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325D18A956
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467651; cv=none; b=Q7Xm2vbHNnAI7cIT9O2oJPEBUzkUOJKSyNbhZ7O29w7FIo0caJl5VuWhxho6ojVbczbOVZYwdwtY7hgCK2rsKiuRxpjXwGni3bZDTGDfC5TJRA/7c1A0amYfaSDosDzvg/oidjyjYN5mq7ddT6SSWw/7wR55+kUURFGwwwuDceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467651; c=relaxed/simple;
	bh=16aIyG4kTnBJ8JG/NjBia1xAemaCujykdgmt4RJyzGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNKpKpMxo3PiERwFS/zpSMnxM05PzrtTw15Klosb0xw+Cl0osm7AoQt6FS3AAzYT24UkU4FcJL3IrwC64tPLAmgHy940by2cAwcG/dJN8TEYZOtxTtyMpIkH9c3Q78Avm0NEQwLZt0m7nfSUoOuETgaHTQv5vCbI37RAnS5nyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85e6c623ebaso113797885a.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 11:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760467648; x=1761072448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16aIyG4kTnBJ8JG/NjBia1xAemaCujykdgmt4RJyzGw=;
        b=LJvx5wiHes50v0ffF2bAmHa17TFgIOcHUCF65MzDnEHJWtV0vU9/3Sbq3UmYNpQdtB
         vNkZV0QbaSfjY6cYE4Ubc3ZnYQx2Z0ghoE4kP+ST5YMCQUG4dfbXKTIyll2wt6vQRN6g
         dYoB4PszkZ7Mhzq0LxvqSX9x39RrFKebQsqz8JsYrmALDYLd3VXIqYaAp7EY2op7S00l
         3S16A0s8ID88h9S+4sNj2PAkFYQqjhTCTgaSQQ8DzxDdV2anp+Ik0UCj7ZAz5/4WY6my
         HgkSufi/ofPwaH91K2O6FVkvUofk5xIUbsv5uccZ942R1qybW5YmvETdPnGAfg7hwJkm
         QPYg==
X-Forwarded-Encrypted: i=1; AJvYcCXBSu0yH0nD9F188XpxaFqPBjf80Ub+WzZo4rdzxsZYeNxKwxbjCD6+5ugMmNmRMgvUpsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9NX2rXWb09DvOmifGna+sz+nYIlGd8DG663iVZ2vH/+EDga2
	6RUiRilH/o7pXKIXQfv9F/kpRtRvLaxjjjw2L2TltKZemyw5wBYyykir7J8ROunIqdjQRI4Aou7
	lQcwgJXrp5M/z3OMHjB0vymcvVVgyJxcjPFAzOrg=
X-Gm-Gg: ASbGnctFTe9D4Y44Tudj7PNUdQSgoHHX5Hhfd0TDwFwthnzzZNW6gg67nr2Y9qc1te6
	qPtKdU4cTZMwfEH5+eT44ShVtqyKlNiQDXSDB6vXnkJL2DJO3AVwteFQ0jb2KxSb8TpLMksSXnP
	gMMdQ5cQks22BkL1wSsgMiNn6ZwcGFD72INa3cY8xXdi7NduAM+N5F00wac/RJ7gVaTZ7jePrX0
	Kzntv+Eul6W3deAKEjAzuhzbhuITDLFBEUbeFqyGy3uf8KOsGBAwk/WMduxJOAEvQIiZg==
X-Google-Smtp-Source: AGHT+IFHuOVHY77+skx2DT3eJMV45MysGdYUMCw66JF5FsjzvbbjZOMxhEtoqfoy81L+4tGEby9yOekpu4TKKO/X0U4=
X-Received: by 2002:ad4:59ce:0:b0:87b:b662:ea9e with SMTP id
 6a1803df08f44-87bb662ecdbmr135126386d6.1.1760467647863; Tue, 14 Oct 2025
 11:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014161446.6135-1-solobarine@gmail.com> <xmqqa51txs66.fsf@gitster.g>
 <CAPSxiM9Ovkoa18gY=0+5cCHukz6Ah56Q6wLwV-7Hbs0MeWjVng@mail.gmail.com>
In-Reply-To: <CAPSxiM9Ovkoa18gY=0+5cCHukz6Ah56Q6wLwV-7Hbs0MeWjVng@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 14 Oct 2025 14:47:16 -0400
X-Gm-Features: AS18NWDdLL7FMn-F75zCWi0ss1sjHoM68tI4d6p_p8b7TRD6dNL6CKKCN_9CsAs
Message-ID: <CAPig+cRKf9r3UFh9ib19wMe2gF0=0Lhjb6WqCsZ0KMjV2Co0cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] t: update path checks using test_path helpers
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Solly <solobarine@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:27=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> Thanks Junio for the review.
>
> I was on this before the email entered.
>
> Solomon, in addition to this you might also
> want to check similar review done by Junio and Eric in [1]
>
> [1]: https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ=3D=3DhU=
83AFZ38b-2zsXDjQ@mail.gmail.com/

Thanks Junio for saying what I was going to say. And thanks Usman for
digging up the link to this previous review, thus saving me the effort
of doing so.

For what it's worth, these days, I think we usually point people at
the lore.kernel.org archive rather than public-inbox.org, so the two
reviews in questions can be found at [1] and [2].

[1]: https://lore.kernel.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ=3D=3DhU83A=
FZ38b-2zsXDjQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqwmqm8rmr.fsf@gitster.g/
