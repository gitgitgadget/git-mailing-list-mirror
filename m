Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933202F0695
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782040; cv=none; b=NzZibR8cXbNbSXRkRkTPMdQ4bPK2waNTcFHuLXFDYiZZry2xhBxpXGAfK/XKQONb5xeS5Wm8/3fpvMHHId/FEFDfx2REjbNvNwf1M/uTyJ3fz3t/W/xOMB4Y5p/C+I5rJ8J3howHZKv+Cp4o8he/TAaNl1iC35JORXlMAs4cLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782040; c=relaxed/simple;
	bh=4N6E4eUyzi67N3XVGfSG5YMVuUafAeCm6v9LujSGCAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMcQTYVG9PazmUuhjuQTywcQV7NTNdX0DlQtKXZX3jt4oWp+5xAxiR3O4/Aslr/akwLzLYrR8yVIjIoautTdM0E6MpsHa85Cbj9NZgR1KzE+gAvx8XDNnWqDZ2Jbs5ybFf55h3DnIXWRXn1OTrPpmbTLzxSVjhCQQsH+LS6Iifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWwSijHv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWwSijHv"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so1079730a12.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758782037; x=1759386837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N6E4eUyzi67N3XVGfSG5YMVuUafAeCm6v9LujSGCAE=;
        b=QWwSijHvgJIqbhfZLTV27CoTSx/X4lEL1RG4e7wXaC7RgkLRVC2uOiVdZDsDbdmGpV
         jNc9abiBsJ507Lqlw0xxsbUoBNM8i8YSHCGb2SWGLXz8dCT49L/q25FNGV//y3DN+WOC
         jumyCZrzfnT54jIrnmJnGNlWMR3/pZSPYv2sg8tboiZKxN66qMpCr12bLg6ojpK+w4Jo
         Bmd/rf5pc7NTOugJEvep06h3NJ+oVGj1UoTvC2wevTYs5ZyB8HLGNzcXw4HA52qHWeK5
         zlgWVTz3lR6M3BMJdpUoHO11noKA2tkA0WiBmtcj8AVIwiNVzem104r18+KpyZDp3N35
         H2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782037; x=1759386837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N6E4eUyzi67N3XVGfSG5YMVuUafAeCm6v9LujSGCAE=;
        b=f0vWI4I0YUMe5PiKnLnaO/SFktH46ywgSGTr+Z4uTZvh8XZDIBjd8UKJ9NyzVs7DsU
         /5q0qp3DGaUuEKLMFVvAFl965hPe2/ghRVFueQLgZ0E/ODMNzs3q4M0m6aHxupSOZrsg
         eH0yqjr3J7mpWDZeeV7ULV66eFf187f6lnL4UX1/ut4n9rbTj2W/TOpzjnzeOADTxSQi
         wE4vY/7Kf1MnMOPIZtksXkThFC6nfw6eW/fg3LKXwX0hHOC8ZlFUSRP/IKmD7l9EgSQx
         Kv72/54TorJnSi0O7OsHtncYFbrl6ngL5vMsd6lp63EcM9WbTFkT2tjl2Ncrh6RKPk+9
         7ciA==
X-Gm-Message-State: AOJu0Yyt2+meQS5GZ4n2hbXs4aBvWZuTle2pH6u38NCNPZZMX9I560de
	c5Crkmf9qxS5u6gwh6AclcUwctUkHIlNkeJnLMKeSjsn0/enjz3IkaS1A9DO19RSjaBDJbRGi9I
	oI0CzmR/5u3RWO7jLBqrDznYJghH5+oid+x7lSZk=
X-Gm-Gg: ASbGnct+IISaZWFkxBSSKRPSkcloFqiWPeZeybZQdwEl1iYwp4cDQM4czWbFyPBUCoQ
	1ttzs7h8kpAyhTbVRk6CTT9aVe9/v6YKtDbpXP/RJA8oxqzO7YN51VdjWzqG7BoA/Gncxsyw+Vu
	fFqpMIFv2PcolN/R68M6sOi2w5/mZVlbzpbHyLrNP1uQsFd05mpckrM0zjnZNcoQXiiX5G8EsNa
	4MKtnLDQ0VraVWtC6nZJtpOjrqwCGtdWmK8IJ4Ee5D69J4TBw==
X-Google-Smtp-Source: AGHT+IGBcl9UuZs+lCwXzyNB4fJUEJ/OnrNMI0LFW0S4hNue0niMedu5zWiW7L///2mugWh/oKxgHsHFRSIwwtDC5+Q=
X-Received: by 2002:a05:6402:388:b0:631:fe26:a661 with SMTP id
 4fb4d7f45d1cf-6349f9cb779mr1428141a12.3.1758782036508; Wed, 24 Sep 2025
 23:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
 <7CB0088E-B6D9-4104-A632-CBE0895D7AA8@gmail.com>
In-Reply-To: <7CB0088E-B6D9-4104-A632-CBE0895D7AA8@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Sep 2025 08:33:44 +0200
X-Gm-Features: AS18NWD8DW86XKJytl5HUZjDgaoQg60pcFl1WuCCzs-HimvrGZhLQvnUjiii2fM
Message-ID: <CAP8UFD088gzuexZMiqnxeFpYV4ZWkcTL31Cs0d46ePCo9jS=wg@mail.gmail.com>
Subject: Re: Participating in the Outreachy December 2025 cohort
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Wed, Sep 17, 2025 at 8:22=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> I would be glad to act as a backup mentor in case any of the existing men=
tors / co-mentors have sudden change of availability during the program.

Thanks, you are very welcome!

> If you need help with organising, I would be glad to help there too.

Yes please, I am moving to a new house these days so I took some days
off, but I am still very busy with a lot of things. Anyway I think you
can make a request to be a coordinator for Git on the Outreachy
website, and I am going to approve it.

The main issue is that we have until September 26 at 4pm UTC (so
tomorrow) to submit Outreachy projects. I am going to submit one
related to removing global state similar to Ayush's GSoC 2025 project,
but maybe we need a few more in case we find more mentors and
co-mentors later?

Thanks again!
