Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F748CD63
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298478; cv=pass; b=fuwz+hyF5Vlf98v5kyh3OMs3Edtb+iid9JRlMGXEyululFm+KAzR0x9DA/IaI92fLhUpv9I5wpgSJjm2gimR3s6VCLNWnLk+SmAWlYk4+Cac2hxC0vFPLwIAn5F7CqVWRr5c15P33sMZcDZv/DCZJAa6zniT9Rmp0Agpjs//Uyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298478; c=relaxed/simple;
	bh=jwTUAjZRMxSyVHUOud6t6B7rmfAFI3AzdmuuE8HcZT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrzE7t2R8AaNqgBsG0O13OqqsRxo1YUSnMEnmI7c+kBS6rJHa74w0Q30E0WNAK6lduUgmWVofcTBaQjqX3ofPsyeDJ4y4ZV6QcwLrKKVEzlgYSIP1noW3W5qlMp+Qj3QCMy19HAXxE+4bsafZNLjcgcq+fV60IvHBWh2wkJoAR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/bhTRd1; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/bhTRd1"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-14394530ec6so632379c88.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 07:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791298477; cv=none;
        d=google.com; s=arc-20260327;
        b=Xj1x5XOXe7NSObV45Wn1O90DCwfDuMQ3CWpDhIOwt/SDRiIIoFbxUYWCNkykIp+LHk
         g/TO0uzHEHYyf9po7/Av86F8F2I/6g/T1hGcny3Zle227YINs7ai1XU3bSewo9EVPqAS
         EzjVdGdmqoFXLE2n5xA7tg6Q+KmfH//H6QWS9qHvsfxk7pklvQTB2f7fb15Fka2GoBA4
         EmpBloggpKxFaAvca1G/vSSFOCgp7GDOyZFNzogjJ8Vbgzm5FnQzKfDJkcPZbI8M50b0
         SqjwHHJJDuAZzpUuEe7QvGPEWbJHOP4NuoTMbuQ2ZAbyafS3beUt3bh4V/QHetHdPKu6
         ZFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sNCGX1JpHBB18yWqGRX8TKuCR1A3r+A497CQRsnFFRI=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=s7+qh+Bi9heR/jSAwAxvhfaYxTzYT8ZiN75rVmluYevx5E3MacpWkro8/3aeblTWL3
         MaWBpj067FrrNPOFkO0sAMeXkU2Y/L0KSBJDa+HIaIwXFjmHwE9n812Y3TkpLlTFutEL
         9FwOW4rYZi5kq1y3Z5RYSt8YkZsC5iFbsKUDGntmQNS3WbERBVh3wBsipmUQ+uCcZ/Is
         MaqocRcLABwztvVaDO8z6TLPs/+udEnNZ5jXOFhUlHeer58M9AAOzAJVqXrfBWcMDIZA
         LHqvzPYKQBmXbjAGxkLgUbF32Aq7oFJTQBk8MufRjWfHV8B45YnpLOq472gQpCZfFaCb
         mO7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791298477; x=1791903277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sNCGX1JpHBB18yWqGRX8TKuCR1A3r+A497CQRsnFFRI=;
        b=b/bhTRd1uqfWl6gN0UFLyLdATwydBCsBhtkBDGXwxnxWpfzzkMZREMnwL4mWkKAxy7
         ANzDzYjhohsb3Zje0H/nP//Z7UXUTS5C8YWSBpo9MGbwcDzkj4j7pLGjpUH27hi2XJkm
         71H3fwWEU6bRoQCo9XVWObpQ653Xr9qJ2NTGPMPI6vRYIalQgxt1JDl+0Srgd4wTa2hR
         Dls53lir3b893nWvtMopK18XhEmC+vU47yuA00S4C6FMCGQZ16ZJb0VhQUdJZjlckuhB
         dJnU6J2kvH2KoGcjlHZVAHJFYrqQ+UO+7C5ON8xBtPDTEgP8Cjk7zVz8Pf1nLHeb2lF/
         I2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298477; x=1791903277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNCGX1JpHBB18yWqGRX8TKuCR1A3r+A497CQRsnFFRI=;
        b=XuzXIsHJOswYdr6CmUBR0BkDo7R3pQPvgrBJ1bwR4RvWXvH6M96b5+WRGsFGLFz3Bb
         jz0YGJizGat+lMkoM4z49222XDy0J2glDl/xHem9sd3ZHJEpfVUJ7Ey2NL2Kq7QYWG7R
         w/NGa42gOU2w388BJUV4qiYlihW4wPKgt9r1wzRYwqBbzvyM4kIEPVCw78wzJaIkFIoj
         wSzhidfyK1OuO2PhxAZKWzEvRphQhWFP83TSA9rUe6I0n34QIDJd5aL+cd2lM/nSpouI
         vRxHlbErwFyULDmHHxaayxf/UyQBVqiodG8MdoqEERJm6+bvpwMG86MdxR8vW/XIhh+7
         UblQ==
X-Gm-Message-State: AFuF++niKEsNJ6jbKuO/ElvpnTgyqPadyoZw3cygVYamnUz8xDntkF0A
	h5vZYhVVGTjWx9m8Lnro5seQtwaJq5kFvZqfBhtpJlGBqOpELTNbdBf21m2gMo7dJ1XzcaMtXSf
	eFd4A/9ZiyE4sXQZS1T0AlfwqlLmr3zw=
X-Gm-Gg: AYBFou095rIM1tFG9Fb+OOo9GZclOZDFGO9FjaR/ifVqTozqbLyq8iOzw+Z5xZENQL5
	DsLBNk4HWbmRWhbxmso/bmKN4konlXT1yYOyXqd+OY9jgLyi3ppKEcOjVfNEYJPC+e/ZlBhTAQa
	PwVn/UGWG0ml+VCbz2umm1zZrnMgeVW+VzR7TCvLbA0VeeFEZumITVsCkBB9gHEoyY/EZgP363c
	agkTShVYUEZ122/rsrWwEgpdYuUB7yxUU5nOBRfGdKTgPiFNuZE2LRzbNPWwq4eJWMz8X1a3/ND
	vst5ru0SkRUb8HQ4Mto69m07+vWJkRyCPfSgxiZoqDW4wJ0iKm/XJRWZnKDKWnAVc/n2FYtHhjb
	/fH41B96g25bIzpSht04lvRYk4mX/sJ4+tIMSCV5NB0CnGNHwS4i37ITonT85HK2MFqujp9Z2OD
	TwmcbEJG9mdzqlrEDn/2Xv6qC8W1PcuulAciZHzBw=
X-Received: by 2002:a05:7022:7f06:b0:14b:cf58:ce15 with SMTP id
 a92af1059eb24-15ecb1cd53cmr1627078c88.43.1791298476573; Tue, 06 Oct 2026
 07:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928133846.2094261-1-christian.couder@gmail.com>
 <20261002082322.2682869-1-christian.couder@gmail.com> <xmqqo6d8ma4l.fsf@gitster.g>
In-Reply-To: <xmqqo6d8ma4l.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 Oct 2026 16:54:25 +0200
X-Gm-Features: AclHuK-Fd1E0lr8Ch75HopSONUEPFymwuJi52BlakgAHlB_qTKNpYGBHfDVWXf8
Message-ID: <CAP8UFD08XuP-rKmcuLSxhX2xeM0k5G35sgX1TvuNmpe5Bpy7mw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Introduce 'uploadpack.lazyFetchTrusted'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 5:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Changes since v4
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Thanks to Junio for reviewing previous versions of this series.
> >
> > Rebased on top of a018953688 (Git 2.56, 2026-09-27) to be on a stable
> > base.
> >
> > There are no functional code changes compared to v4. Only code
> > comments, documentation, tests and commit messages have changed, and
> > those changes are relatively small.
> >
> >  - In patch 2/5, a NEEDSWORK code comment has been added to say that
> >    we may want to warn in case of a missing path unless that path is
> >    marked with an ":(optional)" prefix. Also the commit message
> >    now mentions that NEEDSWORK code comment.
>
>
> I was hoping to see more substantial reviews from others (compared
> to my rather nitpicky review on v4), but nobody has bitten yet.  Shall
> we declare that we have reached the point of diminishing returns and
> mark the topic for 'next'?

Yes, I think this series doesn't introduce a lot of new code or
features. It's mostly refactorings and a new protected configuration
variable (along with documentation and tests). So I don't think it's
worth waiting for more reviews.

Thanks for your reviews.
