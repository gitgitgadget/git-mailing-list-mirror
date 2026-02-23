Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8034AAEA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834074; cv=pass; b=jbSyU24Xxek7nm9LOHBHeAOl7m1Ly0oVm1gTqF8t1Qs/MTWPI81hWd9nWvHQXRuNEwNQqrbcQgu8IqfvSfr1AqmUEhDdcI6eLzCgDg8PWwfFqxdIe/8qmq/OpF8zXfQ/QPVYS8J35qL3e670cIlSVeUCWqChJzCCnQUPgEINHm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834074; c=relaxed/simple;
	bh=Ei2wuSwLBIh3Q0wk0KoRNK8dncQ21daCKfNBT0wOEkY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gOgAtp+TxB7gfiJ1hc1j84YH2vPuC69pxoNNaG9WkUhK5zFAfKmKMuZsKJi5miV609JxBEoRgK6yAc7wKJ1/bAnzUv+BduIi/mFtv3mPnjBD9NITmCscptXiTkYCquKjHHNDZ4i7ZncwbfhBXbq9xosANDDPmFrIuzK0hKKJYBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRlBvENp; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRlBvENp"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56743b33c67so1746431e0c.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:07:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771834072; cv=none;
        d=google.com; s=arc-20240605;
        b=brlnEV/tVvZMb6FbtdVQT/UBcVucXjQJGWe648hsvApw5+bSErfUeyb885qVIj9IzU
         tBUBbSM96IQ4rdD9fgowu4+y0mqsjdofd2Ldoc0J8YNfkNso2jtZX2rLtijM+s4HaYdP
         jnHSCDpY1cO0/itvXVAxd+wkS5Z7BCHqdj0AYd78EC8s8q3H8KfCztsEBpdsMtFRXWVL
         Mon0xIWPftaUB9zF5hsRU/9AWtfZXFK8IJ4CV5lvpjjMNjPHfvjW8BNx/AehUXcF2D5O
         lgZ/pmrVZgLEUg/YcAfEHOgouzOjR6KSqYhxSyUg3NdVrZ1Y+McUDPl48GI1nXCqTDl+
         5o4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Ei2wuSwLBIh3Q0wk0KoRNK8dncQ21daCKfNBT0wOEkY=;
        fh=jj1OXnLxo+p0V9J+U2fVmi05lQfwssFOvqjOAcRMGmw=;
        b=iMnkHAnS9AvrnmG6VjaIMjnxcVkAXmtABDYgcSYpY0c121h8ybkf6gZzzd9e9SetrE
         3fw0qetyKOEZwFAU+2swx5xJQd9n0xNO+9b/Poek1da+6jjWrnVwJ/tw5rHvjJizHt5k
         LBb+XljWPqWiQQaYuzLc9+P0SU4SOy/15VecKbcXPT+1CP4cVg4OkohkWJrxauoxXf7m
         MlkcYIEg5kyi9MjUwGYXJZZ0KdxRZwIPHA5u30vEjREWbw7SmL6OBFIMgqNrBV5xKjK6
         sFjrnSFRFmEJth9NCnyMRoN7NEH34/nX05bejC06fFHgc+iQQrbp/SDXnClWZCXOQZhK
         67rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771834072; x=1772438872; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ei2wuSwLBIh3Q0wk0KoRNK8dncQ21daCKfNBT0wOEkY=;
        b=GRlBvENpOZ7GAP+NEY4gk02e8LmDGRIeM7UfpcItTuKtTCpjr43c6mZ7V7vwjcwwLh
         LksT/dSo0Mt0iXK9Onii7b29VpjPyMYcSvjEUJksV12pBY/C2NdrZLf2PJeAhgA6JhNl
         W7gJN1dbdrap44D8VI57yRdktKY28hvO1scn9UgUlqu6dEtB2LUIgRspyGfA+gcg5/Tk
         8wVXG6fsut8DfPPrAUKaADKueht2ujZLaKAbgjmVjuO7CGUzqdCHeUDLsIMudKnVM8LU
         BS0HSyqtUMOb/0WjKTGJ9LyqboTKjYBhsgwvDdmIMULOQHHb8/FhZM9CEDt3QhX2lXrI
         1GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771834072; x=1772438872;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ei2wuSwLBIh3Q0wk0KoRNK8dncQ21daCKfNBT0wOEkY=;
        b=qt5WEd3ErBkQ9g0DJh2xCnKwjI4eZEQzbHntUMz3pH0yydjdxOxuK5Te2Obh7pNHps
         Ad15j5Vaq6fkxuKCtGa7xm/6Qt3IxDU8+5rWma49VjTCC0UO+4iJLUjnkWLtnKDLgSzJ
         wERyzOVsJiqYY5/lEriLtZ0NDpi6NnS33JDwWZHgDHLEmsRpo8jmxVHXi2bHoAJXdxfa
         qxeyrkSgqkGd/Lzt7x1BOEcEoYP+kK2UmMk+H7uATHYAnO5v7WlRMy0dvXvr9Kf4re1+
         B+lB92OXaAjv4VXho7HXEeb9HzNuRZU0erwJKfAYCMQ2ea/0zqxn4w27rp6NSeTP4S3R
         wu6g==
X-Forwarded-Encrypted: i=1; AJvYcCXr9kQEfyD3w0BaWBf4ZGUpltII0hwyv7Vc4noNFYWHlSYt6Xtz2dqeiBfOk4GPYGmYkGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfHCzWJ9BL+nEXVqfF5wUcNW9G2XXwIkcAobUC7MgIIcYI8qN
	3uyQNC4ZRob4RnJYAZUtNnUhg8tXyecBgq/VirAyp8HAHUwAIqTYfyPm/QN7IOlC42pKxzv6JL9
	ycyexNV7U/lDvCuNvss6B2SlBge0N5RPxANFB
X-Gm-Gg: AZuq6aJnIPJ9o1Qgj2mvzeSvW0TwBaOOfeDOeRJM61ijBZOZ3/8gYTAsdFT+szQ6tME
	3IcyUE0wcoIsk9vsi4esr7HQCQRlIDPDdKmPEyiYvR+0cADOQz0qJkioVhnHf4pRAnL5t8ZHFwT
	PVEewpjlgLUorsmBC05NRG1SEBqfBMMc2Vjo2W9BxDns7XreoO7qzek3Bp81Wh+Eq37H5ueNLyx
	jJZI4tL4HrbJ6i7TWl7ECZ6QGFEgLyWKGzrTaVZlXA79Y7Rp3PFZBReT1UEoISNOPdDwK+mJQd7
	LiyuwSZo35XvrjWM86doF9czsd3aJXPcv3XJil3ZUA==
X-Received: by 2002:a05:6102:3913:b0:5db:e909:aa0d with SMTP id
 ada2fe7eead31-5feb313fd23mr2367149137.37.1771834071846; Mon, 23 Feb 2026
 00:07:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 03:07:51 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 03:07:51 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-4-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-4-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 03:07:51 -0500
X-Gm-Features: AaiRm52bYwcmvSo71gU3x8oFQzlgkjjt-gPhcSqQARC7YCmpuCZdmQwD4PGo7TE
Message-ID: <CAOLa=ZQjTM+zdhRNELxAk8p9E4WJYUbrKQ7npRkQEjnvyAF2RA@mail.gmail.com>
Subject: Re: [PATCH 04/17] refs: rename `each_ref_fn`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000743c20064b7944ec"

--000000000000743c20064b7944ec
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Similar to the preceding commit, rename `each_ref_fn` to better match
> our current best practices around how we name things.
>

This and the previous commit are renames and make sense to me.

[snip]

--000000000000743c20064b7944ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2f10884fe6d39b5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0N0VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUlaQy85aWFrZmFldy83elFYV2pJNkdXS0lVcVEzSwpob3R5WmxLeC9k
WmVscDdKUTUrSjNkYmNWaWdnS0RrSjEra3F6T0VERjdHTlRBZUdnZ2FuRXduUjR5V2IzWFZ6CjVL
cVZmcXhKZ2VyelVvY1hOcUt1eklUekVTbE94bkRNQy9YUExWRk14NTdlNUNrMTdqQVJoMkhNWCsy
OXZqZkoKUWg5Vkg2Q3hQaXZDN2pGR2lyTWhGUFoyQjRhUFhrQ3ZRV0YzYkpyb0xNZFFybG5NZk95
cmpZYUREWUZCZEphcApLZGZoWkQwa2xDZlU4c1NqcFhKWUJCQzN2OEJNSEF1KzUzQVhqVFlTY04r
RjluSFVpNTZ1QW5qVjFxejMxWkFaCkJzSENjb0hQTTU4eHhra2EyT01OQmhJMk5CSnFMYmVXRkI3
ZjVlMDlIN0ZNNHFNQURLWEVhUW9oUUVEdGt2THMKQ2NWbzRicXVZZ3c1cXYwdWhiRXVJMWdLT2t5
N2MxcXBFSHkrajlOMmRIUmk3ckM0YzMrOUUzanZramo1a3VSegppWm5rRWV2bm1sSHVmeUNKTmZH
ZEJtVVhSRmpwOWJDNVN1c3gwTysrOVJGaWJOd3dGUVhCK3YxcitvdTZwYmJhCkZ0cFF0UkY3YXpV
alZuN0tzZGFyOTRGQjF2ZW0yNGRhVXpMMDVjRT0KPWFrbkEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000743c20064b7944ec--
