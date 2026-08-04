Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BDA39DBCD
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876772; cv=pass; b=ui/1UVbccgj4MJzHAKhxqFjgl8iI72M5ltx+XKbV+zxQmkM9j87JMH8qFv9qtZrS8MiYHt8uGP80GXrzwY6lcqnqhtpVh4jO4yrQIABY6y3RU+5mviGoCqzE64C16w3h+5PHWmQSW7CUzjBp7YiMKfCuebIC4IVI6ryDc2Lkkdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876772; c=relaxed/simple;
	bh=cDupGA2TqFSuC6492TrWRmaF9uUlFfsB+Nbs5TSMGqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHQyQZ80ofTMJf2HFW0qyfC9SfJ33z6GpMt2F9xc1ZdSBTTX/dpcUI1vagM1nRYI1mSCkZXyGaFkdcO/wpiop4FaF7EqPGnmoYkRll9qNxt8sUXdyqmPZpvLVxhoDgYafyFO+xHpCHcQBwBApD9Bs5/VyOoEPDOOXPsc+9CiWr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK5Nlght; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK5Nlght"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ff017d420so23302157b3.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 13:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785876768; cv=none;
        d=google.com; s=arc-20260327;
        b=oIz/KwTr8oPiiRb2B0eq+wvqjFGyu2loUoPGw9OTNyONqn28AnEPiqerRljUk9RxwS
         MwXeYn4Qgh5Iq5GNYBKOzspSJ7BvRM7WOz7DHbWp+n0pxso37MotG+frsqz5SUWDjZGO
         CRHcesVL96i0vqXXUR6VXGl7oKRDo9bt4Jd5qrVfvszkmvQukc0N6j47xnLtS/ygQQ70
         UcCQWXJQyzm3q2z2eme/jXxp8EARPk8Ut49s11gND5xZu66BD6osnDxWDZzGJ4sWlecm
         CrVCmWfDZn1wBvkfQkV2+AuZounL4bEx8bKcbykH27617KurGA2Oqs7UbHCSWWyt3mVv
         L1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xZgcqWpqGgtR7GaERZD8M5BsBe3KTRMkAeTTbV3Uej8=;
        fh=uzP9eSBalcZxX8ofaryTbcw+rtkU9c0hMEsgQeuKVAU=;
        b=M5vOHM8on2pkSVvi1YfYG2049LEFKyUCXK53DEzhK7+Awnvfvaqzswv0EcbNQzAvOV
         ZoMt57szfxhCiGxcWm+N+StRkNdl+8KoQjh0QEsMN/XKDSe6clGGsjph0QLH1eDBuKJ6
         SIQ0Td0r8XDAGinz5TmyMTEPCINPhB1cShqBNlq6Zc/LCGbPJHv++0DRKJ4QSY7eKoXR
         WVmiorQPKGgbwPDMsvQNOpc7fjVJEiohJLLIeNSEIF2ufcn03kwZE9Q2Y445sdz01VA/
         rscUtDfoo2cBXgUqmOkXZvceCFdrXQlqpV855PlcJWXdS1pNNJ6S5fcl2faIpU00SAum
         iUjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876768; x=1786481568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZgcqWpqGgtR7GaERZD8M5BsBe3KTRMkAeTTbV3Uej8=;
        b=RK5NlghtlBVuSoLJeUOaOFzq5m0iOETxiOgdtjDGCAR5DV0EK62thA795mP9Si8zKd
         1zMoBPYAi1F61fOhw+NReq5cXVDa6lXvA9rBrRgse68UYiI2l7CYu+v4vqJoBmyQjHUM
         VgyEmovGcSUHEcBNcCAjYuBALzMt7Gy3P+AfTzCSVSijI6bJUH795g69n/Pc5/nDfrvm
         ua/YJVXfd6mIuRZeLV+M6UTZtJyQ8e/AS1B5AFZy+qJFk02GBzxqZlerOoCWu3Cx3IGS
         Xc8MjA1UDMAuUP3jqh3rEN+kmX6AN9yTKGkxzZrWp0X1khFwOBiwwtTtrffMEg8S6Zpp
         I/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876768; x=1786481568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZgcqWpqGgtR7GaERZD8M5BsBe3KTRMkAeTTbV3Uej8=;
        b=ZyW24qiKaF5+kRbRkl7+UVw2RtN1Pt4psMnzqTPFGwFxRE42Aq9dRlSyanAb04FulD
         5hMJtnlAQOQC0H9VlQ+BZLy4VCiZ0HrbSXcRImvg0xHVXKGcKKNQRWkh0p6M+TSFZ500
         MZvVdEqsCRQgQgw6+tyAPSzwiOJHymAb+EZJJCbvrWNHbAEeam332nWRpukSkNcFLMGj
         dTf0Q7MEjReqP5OCOP13BD4fw33KYCiUQau68owv6XvAoQ34vR0ELLFy8gY0Wpekm3Za
         LJz8NuGAWljplwfpUpxyW6TdSVKdYgcZ/XNjoq/73x8d7p46cx73Wj1i7su37FkYQUcy
         xY7g==
X-Gm-Message-State: AOJu0Yyhq0dUqJqBHSFrcvTXpPiN2Y8MhUdBDj3YeutKOPrMzYl/ae6v
	oOQbPHLP3r/NDFTL8MgHekGqQ3BBS1hBuxsVQABBoWlA/fw+m6U7CG2iQ4Hmjc0rDHEzVhnIEQa
	LWJB49e6BeMskWJzYs17Z2V76K2UyBnVoCw==
X-Gm-Gg: AR+sD11yY5DMdOVtN7B1Pk6bs7dICxSbsQU3gpV37fPP6LbhZ5w5NJBg226gPQgkyZT
	R5a8lS/HyE410xF3x9buKcecQZgvVIHcUfy/pOwGfF2HKHuDmkwfcXQ3fBPJEzTPuSQGLvqkga2
	7lo/hbZ6juKBde1fpjLwzRDG/9ZfO7x7t/LqeKzIfIffCgmx580T//KuKuQXrwouRFohRDGzuHh
	EpJi82xeLxX/83NaAoX/5LzYXZRCiH2/P6+41MUTNEDfbFT1AcrlK1gsf8D7t3tKkWTSyPzP/tt
	GlKdWgcAbTQNWVY3aDkCbPJ5JCvmJ8FeTm5iQdhdrXqbtqFE2CLjixMDA+hTamuA+FgyOubp/zK
	GtbDu8inZr44Zk40HWblqE5hwWrocRGIvvMiG9D363bnOToRygt1hi5QuQ9V2DmpVyUuSTCG/xE
	U0u1witjY3GENhRc06IAU=
X-Received: by 2002:a05:690c:d8e:b0:81e:f57f:1f8f with SMTP id
 00721157ae682-8201a9d3565mr12123417b3.6.1785876768010; Tue, 04 Aug 2026
 13:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <017e01dd2441$476839f0$d638add0$@nexbridge.com>
In-Reply-To: <017e01dd2441$476839f0$d638add0$@nexbridge.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 4 Aug 2026 16:52:35 -0400
X-Gm-Features: AUfX_mzcV2lbwf0lnIZe6FUo94uwAawlx359TQr3Kpob_vEQExCqFCvyWO1BxDE
Message-ID: <CALnO6CD+LmWNffptqp4bsoJQaq7Ah8VaKHjTTu6m-Zfm2uN+9w@mail.gmail.com>
Subject: Re: Question on textconv
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Tue, Aug 4, 2026 at 2:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> I experienced a change in how textconv works since about 2.50 and it is h=
ard
> to get past. I would appreciate advice:
>
> When I define an external binary textconv, roughly like:
>
> .gitattributes:
> simple binary diff=3Denscr
>
> .gitconfig
> [diff "enscr"]
>         textconv =3D run -debug ../../enscribe-conv --verbose
>         binary =3D true
>
> The supplied file going to the textconv program looks like
> /tmp/git-blob-GFtIhK/simple
> and is always empty regardless of the file contents.

That's strange. Over here (2.53.0), I get the temp file, but it has
the expected contents.

(For example, I can debug a bit by using the shell form 'textconv =3D
"f() { echo $@; cat $@; <stuff>; }; f"'. NB those $@ need quoted in
production, but for my little test case that was more hassle than it
was worth. We can also see the invocation using GIT_TRACE2=3D1.)

This was true for me even after setting "binary =3D true" in the diff
driver block, which I thought was a bit unusual.

> When there is only one file named simple in the repository I can find it,
> but otherwise
> any ambiguity in the name makes textconv processing impractical. Somewher=
e
> prior to this
> I was supplied with the actual file in the working index instead of a tem=
p
> file.
>
> Am I missing something?
>
> Thanks,
> Randall

I'm not sure :/

--=20
D. Ben Knoble
