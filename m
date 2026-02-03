Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233534C815
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113337; cv=pass; b=QANxoAz8wffL8P1BMUy32sjb3/ItxgmmMn4eJlrSH15K7UeVpUEJhZg04pSB5/4vSFuBzyl40KhkYC80/uETbwp/fttHIjxG2JImu245JWqBKJ1HaXsxpWiXIOSTQy6hZzhttF9jayO3gbr7AHPPi5e1E1P003vfZrUyfAFjlu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113337; c=relaxed/simple;
	bh=Rtbnr08xjvNnDhiVwrVYhs6KvxN/o3+ieoDzTFAwvQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx5n241v4QCAWOgxMWfXQ52aLFjWiRPGivGFkKk/+yUZlx09RwUv+AASnoxL43BV6mGPZdN1rKXNEQzhMWcGmAtTfwTGs/88ZUOJbMcNF3sayc9RGF1JV0AtUqevsSeE4bKyuh/fJSwVOPVxeFlCpmilBUVP9MTLYgb2VsM0GRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqkbwhaR; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqkbwhaR"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124afd03fd1so8033849c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770113335; cv=none;
        d=google.com; s=arc-20240605;
        b=lL6nUHYP5shPWQzhzu2z8Ugw0wZ68omemWKi4EWQR5vNJkDLblZcsY+Iwj2k2g2qip
         XLGwKN8kdipJCsSm13Gxxsrur+l7B9DpNHoJln3YT7R2llSwZMVveKTSgz+19GqwWgsO
         DVaf4kHAl0dtlJa4rq8RkmZO4EcGHDhGn+mnl30MZXQaKETWbnIK/zslSuZFpBnVaSBL
         zwYycEmiWN9ObNh4YEYyHEYAYKhk0PYjvd6lOwS0Sr2oTay6VhJLKgXcTxM//amRVVi4
         dHYXNCOY5QaPGrW+Qp4frLnOdBkSn3TLvVAh2WBd3p6jQT9E3XcwGFgaUH0to35rUXOD
         6JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rtbnr08xjvNnDhiVwrVYhs6KvxN/o3+ieoDzTFAwvQA=;
        fh=PDV3F6nQTWdTADIGVaiQ2XExtmkqO5nNGftqjraMlNk=;
        b=Bj+B8Mu8EEqSWI0T61Ban9WVhPJhakSxKEzbF3ct4nWRrHIY8ftvicWdehei4mBaa9
         5F+RgcsTZar90fn6HtRU6PzHUZn4a9G0ZNZDmiwPbdjlspSEk2Wqdn9jZsH3MS3p9ZaF
         hQzBulPcIPpHhhMnIE/ycL+IG36Ccg8e1hPopa1KL+kwg1QJlQso7GFhanD7BgkH+aU3
         x7ETzPM5pqSLy4RzUuJMhP1aE3RVM0DRjh687+32DF3elRT38g4irsP4tLkmSDaaJ7oH
         dsE9ao8qeVwkwxG3+k2coAgV3Uv7h7DJt3p9GOIVpXDIQA8GJSXfp0uUIIGcrDSSlTUu
         j6Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113335; x=1770718135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rtbnr08xjvNnDhiVwrVYhs6KvxN/o3+ieoDzTFAwvQA=;
        b=KqkbwhaRm9FNQCW4BbO7ezXq53v76uryqIdBKoiqixJbE0lT/hziNBQ4TppwT3i8KX
         v9vG7kH/yevK/cc+Q6GWB/M0dcYa2GFPO3APlzREc3IBB6qqbiU57G2cLtCphLgRQIOQ
         d5Bh/8VVyFh42JUmEp/I52ASywhaEqwFz1x6yToxqCVU5hne+uA97qk3c8rBZg71eMcA
         NDfTmaDeNTObnQ91pzJqR8JOtZtvjcz+ormKqUkR52CBJMR9ipy9/wPXv+4QiW8ro3G5
         AxdFNyiDAV7nz4VD/6VjH3hx2TUaH7SJnukrPncD7FXN0JSyuhODns6QxJyL8IqhZzA1
         Ntiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113335; x=1770718135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rtbnr08xjvNnDhiVwrVYhs6KvxN/o3+ieoDzTFAwvQA=;
        b=bRTLlHHO5KvUojKdB7P6zuSXeSzijM7g6ZtlnqIe7RoHzXD1GXYSdQCviQL7P6M5+1
         uMHhO9x7Ggl67aNCS17ywBPe8GkGYfjwqMEVotZi99lzqjBBKJkEdzYn14xGFT1kNLek
         h8/JMk+ErQQ7ITrCT56F/lALM3Ar3c5YGATYUYOHxZdAUHrefQpucf9ADjXMYr3rnOlY
         yH/Fvmjmx2cVbfHZRobTjDXHkzfI6qJis3YLS3IUpdXQeUbF2kuCs3YJ0TjMJxASw/t1
         Fv42xoUuAgb8JBQQ+aM3/fkpZ5UMSHAJDO8NgiQZa0wVcMVnQSG+Vm96GORc+olHTPZw
         gEDg==
X-Gm-Message-State: AOJu0Ywwz/F84DvtUWdiD+6qtUZI0Y3omUklhcgNyknoDh3LDcDL9+YF
	2ffXnTva8CkSzx28k44S74VHaCtOlUB4oG+90SfYz5VC/38yHGlAn+Rw5490EOmaJfLRcdw/bwp
	nNMyF/3l1vPdxAS4fQZBfbhiBBkd382g=
X-Gm-Gg: AZuq6aLCsut4OtL+CL7IAfQRfuxD/yVtMHDJ/UafNKMC2p/qfed0pV+y8eITRFpCx9M
	l6hZQAYpqXem41Xm0uyJMhNu4zIZNAq3C5TSWlc/fzG+x1LENAw8D9ag8MhjNsCXwGsZhEpSJ7V
	O+zptRPj5HjRktlOirS+Ziq6L/3AgT10PojQsPHcj8Z7nfVr4wjM+srISXBLRitlt+V0oSODK5Y
	BvxAFt4n0C5/mFpclPsUH2nOmsxV6VJD3DkFCdSewN+pAfweyYeKDH1B2lBeE9fhrdq9qZcfSJI
	3ErkT8zcE+qqQzcpyF3S6CkrOi8ctcYu5ycL6yZbh6P6Io1jqHBVXcLd
X-Received: by 2002:a05:7022:628b:b0:11b:923d:7753 with SMTP id
 a92af1059eb24-125c0f7e618mr6373347c88.3.1770113335271; Tue, 03 Feb 2026
 02:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com> <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
 <21D9FA76-F382-483E-817F-C3947C939D16@gmail.com> <CAP8UFD0qtn_1VAA1SiAMjGVF7Qv9qC1GdDmsbkK1xvq=SFxTaQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0qtn_1VAA1SiAMjGVF7Qv9qC1GdDmsbkK1xvq=SFxTaQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Feb 2026 11:08:43 +0100
X-Gm-Features: AZwV_QgpG9kchhVSBzPj3XQ34ip7iRnNCeS6Y8Qmlme1rPt3T4eSLSLSXFhgM7c
Message-ID: <CAP8UFD07yEVibYL-DwmRj4AQtdbE600LwQDR3Nf5j9FxnQ+mnQ@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>
Cc: git <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Eric Ju <eric.peijian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 10:37=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> Otherwise everyone who said they were interested in (co-)mentoring
> should be listed as a potential mentor of each of these projects.

Lucas, Justin, Siddharth, Ayush and Chandra,

I have also invited you as "Mentor" into the Git org on the GSoC
website. Let me know if you haven't received the invite or if you have
issues with it.

Kaartic, and Karthik,

You should still be Org Admin and Mentor respectively for the Git org
on the GSoC website.

I have removed everyone else, but please let me know if you still want
to participate.
