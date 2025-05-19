Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34375275117
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663846; cv=none; b=eMDX5macOTPf0O9GMq//X/hPPKh1Y3p+yZfTV4NRx8oe5UxWqRQxLxn8cwiGYabNxRhpnZof4tFchlD/F6JUqJ7+4GA+azPvmyqtM29uLEEH61eP8GIybItG0NJT0rENyM5fP/UneFCFJtSQE6924T9lXlKDKlkR/BgnBrx7mDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663846; c=relaxed/simple;
	bh=zADauhWcxt33uyBrFkLPwKsPc/E1KhnJeGDmitK+aQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFsrKXCcTKzLcDljPKjpbGBwUbl/Q9faiNOWzVDv6yhB8+NTr/vEgx0dxg3IvhSnqb8fa3fR9xjIEoJwDJJgoDVCMtY9CGHbIWPSRyGirLqn+AQyxQopQYQJbi870b+hMwJSmfgbkPK0kuCvT/b0kJw9ieaIelKzX6wdDqe0kTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akXua2BE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akXua2BE"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad5574b59c0so322877666b.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663842; x=1748268642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zADauhWcxt33uyBrFkLPwKsPc/E1KhnJeGDmitK+aQw=;
        b=akXua2BEROdinUWH/IhwqoKIAVb59bgkItOJrFiExfiURLcf6PdbsUZcdQjHglbru8
         4PsHeLSrYo8PK0geqRPpcj4ErK8d8sRL5qc+E9Ku5v3Wc1dbu+yDcQhAVP+GYpBgTRpb
         7+YXxwSij9BbB2vW7lcqhrkbWC7FY2931WextzUfckqDmizZudeNyx2RJvT6vs5rV9Bg
         m2blhSGUj0WTNGCPOvL95LzkiPAojr3XZIqJtCJkeiFM1OeslkhnbN926ezb2fMoBuhs
         1u8KTrSGhmUV+KE8JRDVTBk4iP0QNHMgTZQ89altZ45CzM8HsAKrv8PyTbAR2GkfA2/i
         3dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663842; x=1748268642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zADauhWcxt33uyBrFkLPwKsPc/E1KhnJeGDmitK+aQw=;
        b=BZ+sHIxh5dik4CUc6paknunP9pCb9iZ9/hanlseD2mViTJKRc3CVqHGNdJ1+WpNOaY
         inkApESXHTp2/MgK1qvptwMkYM/Cw0XBTkvRcqg4WboKp4iZe+Id+L4apc6EZTCHh+yj
         FRTIzJfM8qrKgoZQNDy2rV3YUAtzz9cL6v+eSNyLcTSkgJDDyK1AHwOKxJmewyQ26Cmq
         YZCfZuVx9392Gbcf7fEcx7UAmmGaBQ4nOSRDl4KKeGNdo4yvTGiaSBcPafUikCV5BqUh
         TsGedold66Q/hdCRC2fgFE+FTwBShNvsZLXi7RiX4zNbJ2AUtIqnny9DZgzCK2uUgFWU
         FYUA==
X-Gm-Message-State: AOJu0YyzJtTxfUj/SLIbb3OIur51kfnWz8j35e73HZef25WBGvaNWNbS
	BIaFyck972QaRpHLTS3mj9ovpx54LvumQr4ZTSGMRWjHILKatZ96fg3WgGEz39aqd8bwPO4CeV+
	iijGlAtwvc3Lkj9SYax2sjsbGiKxEg2Y=
X-Gm-Gg: ASbGncuA7S/RjzoOrhx9DK6gtI0Xup0VLxsYj1LtxsLVcXNzoBFDDR8A4EzLaGruF6A
	WZKLPOUxsz1YX4WzQ63irGjxSeDGcyJTnb1j7g/yOapz2kbCn6DeOIMfq1XLTsMbpRx+3W6+IHP
	7bA8wsTGI/FB4yOYLGWm/BS/eGpl/OHrtfXg7zBaWwoMjCsg==
X-Google-Smtp-Source: AGHT+IEuca4J/4GvfbEM2y+v5zG73uJ3lGoVSy8Agaj4CqVOjXrE4LP2SVQ1h3gQVObb2qBnMYarq4pYa3kPA1p9wAA=
X-Received: by 2002:a17:907:3d4e:b0:ad5:e0f:7850 with SMTP id
 a640c23a62f3a-ad536bde688mr1068559866b.23.1747663842195; Mon, 19 May 2025
 07:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-2-christian.couder@gmail.com>
 <CAOLa=ZRL6nRb0+Bf1u9b45UZGnsB1yPVJ81Mt884onEYhZ7JtA@mail.gmail.com>
In-Reply-To: <CAOLa=ZRL6nRb0+Bf1u9b45UZGnsB1yPVJ81Mt884onEYhZ7JtA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 May 2025 16:10:28 +0200
X-Gm-Features: AX0GCFsgWLHYclVqhockACRY7e9_VsbUeGPM3NS6VU-55xlYMmod26Kygk6jb2U
Message-ID: <CAP8UFD1xrtyv1hJhB2mvbgJb4bWeV3K1GZGdGbF+ptcp7T1Dew@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] promisor-remote: refactor to get rid of 'struct strvec'
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:27=E2=80=AFPM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> [snip]
>
> > +/*
> > + * Linked list for promisor remotes involved in the "promisor-remote"
> > + * protocol capability.
> > + *
> > + * 'fields' contains a defined set of field name/value pairs for
> > + * each promisor remote. Field names are stored in the 'string'
> > + * member, and values in the 'util' member.
> > + *
> > + * Currently supported field names:
> > + * - "name": The name of the promisor remote.
> > + * - "url": The URL of the promisor remote.
> > + *
> > + * Except for "name", each "<field_name>/<field_value>" pair should
> > + * correspond to a "remote.<name>.<field_name>" config variable set to
> > + * <field_value> where "<name>" is a promisor remote name.
> > + *
> > + * 'fields' should not be sorted, as we will rely on the order we put
> > + * things into it. So, for example, 'string_list_append()' should be
> > + * used instead of 'string_list_insert()'.
> > + */
> >
>
> Dumb question: As I read through the patch, I realized we really care
> about the order of the fields and it is mentioned here too. Why is the
> order important? Shouldn't the client be satisfied as long as the
> required fields are present? Or is this merely an implementation issue
> where we simply parse the information in a specific order?

We used to only care about the order for the first 2 mandatory fields
("name" and "url"), but this is relaxed in the v3.

Anyway I think it's better if the 2 mandatory fields appear first as
in many cases it might theoretically enable the client to reject an
advertised remote as soon as it has parsed the first 2 fields. So the
client could stop parsing the rest of the remote information in some
cases which might reduce its workload a bit and speed things up.

Yeah, I don't think it matters now, and we can take care of this if it
ever matters in the future. But if it ever matters, we might be happy
to have specified for a long time that "name" and "url" should appear
first.
