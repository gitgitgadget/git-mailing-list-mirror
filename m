Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39230FF1E
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111443; cv=pass; b=dLPISsA9Axm8Fvjh7gBxpqdPVtRqtrJztvN6uPsdLTTOdRe/0snAgyqF0v8YqqR519EPsT7u6z3ExLD8CKoDOcReoIIESe2TP/PCpcYoh27XOZ3Pff4DED/6bq2SMiJUgfAhbZMBObEND/e/d3EeDB3BjiCqrGw99GbGX0olhR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111443; c=relaxed/simple;
	bh=ZBk4zMh+C9VYUxIs8Up0P3+A4cbjKbd552nB6BcX8QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kX8obHrM+VrjtCCNnvz7prnd+X+ktFrEhXCTzvFz1Gi0If2HkneA6Yul30UcbOaDEsv5KKm14MskiiA9nYRWa/9WTt4QFV0tJHinWJATRiQ89oAal73r6eWne5vPkStYXomTBhMSe+RaaJq3ds9HjjDBueUBqDllL6l7CrlkG6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ/6B/tf; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ/6B/tf"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-124899ee9d3so488921c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 01:37:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770111441; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZFRU0CjRsnVxV/8Ccvxt2A9z68fOgOwMlcvh/xDUiY4V3pPeiKH7DYKmdl8Oa3uwZ
         cCEzh428zKyBVXJ2uewaT/rhWE4ySesap4tVr//c7CpGn7CYccR6ezVxlahFV+Bm0cEO
         6882lvKLtBSCzA/qzOc4ZAbwMOVO+2i+HRUVlCqpo00RQhCsCkiduXpIf/XOIvZYIWO3
         qoUK0fhGOULuEwurJLmiTTmDi48Sr4tEzDXaycaaqgtEoRY09d9ITs2sS580CfvC6SLt
         X374VGyGfNHFeY0LLkc7YnqLUvUIiJWxAdE1AwLswWc7m0/UvHLfo/4ONpTfwQxWHWTJ
         Uf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XdewbiGDLYq8+KAcP//kAmaqzIvaT7Km6lsS3uNRj1c=;
        fh=5luRCYZo9Tk//EtMuqnEP9CeOYryDsQqOUuiTEu3UtU=;
        b=Q+5wtLz9D3XqDNLwJZSAYv3xIY8p2QgktnoTaQqA9s7yvtNiklDjOI5HOvWaOuUVv5
         pQw2r2iG7zZmoY1OOd8XSB9PG+0TwCJiLwGbC8gRsND08+zTR+RsmgYwbv4UYmAS0OMA
         5S5qBhNXYAl5hbobyegBNnoyf8smg2aDnaygiTtn8xNHkfTF2qpJwmXZuQnZtzaefK8B
         h67uLuYN8g88MgUkqhjf4nCBgL2SKVxnGBy7dhdT1RFv2aQj+1QsxRtrjoUx6dFzCDWP
         fcVuP2X9+v/MMmBg/pzO9W0tN/7QieV3x3h2/Dgr/IsnjE66bZvYxq3ws3rH223WkFqF
         WW+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770111441; x=1770716241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdewbiGDLYq8+KAcP//kAmaqzIvaT7Km6lsS3uNRj1c=;
        b=AZ/6B/tfZNNYN/KWxU4ypkcKVKWFdkSLAlphapkEyhULXhhfXg+jvZ63Jo/4Wg0OYt
         jkXG+10BpFl9okTM3/W/OYpBMiyRF+nk9+Ej182gXUZahGml9Emn3PuReGCHwgdcPc9r
         bKkrMTNOQ+zshrQ7kzElZpLNRF6VuIVxpBQritmhjSCRKio5be3PFj/2EMd4q9cBHCgy
         DJoyeJ3U76KPK2/sGINczzUl3enLxJoJONEvCJLE4x8x/mITawDzUGb3CWK2DZlEZExp
         dF3HWC0abzygc1mdoHm1LST3bnhy9WshnkOQQnD+4l2a/STycNrg0/3mb3B0Auf4PX1C
         mG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770111441; x=1770716241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdewbiGDLYq8+KAcP//kAmaqzIvaT7Km6lsS3uNRj1c=;
        b=r5kI9Q3WwYIfRWBErhMGhRtW++gCjQ6LO5ZC7s2JLe3YYAcFBOqxovhGlJrl8RnmqS
         ruUenv6/p5yn05kH2WiySC9efwPqefYRiDEd9qwa6ocEJlRLl4chwPKmJbzpMBfUD2wL
         YSOcy9i7tjeDaf8GUiiiTnVpUQK2u3fxjW9dulem2JoNsUisxzrr06GVztWg5K6vPjum
         Myvdx/WqJtF8ehDXDQD2uhxZcwm1OeyBlTVcrIFZq+S3XtuKRaGtoWIuJyLlgWerP6x/
         /LkoJval2FUX9uIjxsP2wRl8ZNY26F6FHns9wmpU7QFz+dVQCxxPe5zFBz9vAhjhmcH2
         ddqw==
X-Forwarded-Encrypted: i=1; AJvYcCUn9S4cNxUjZe6yAKyDDM+ndMrkdQ/tK1GSXAZzM9DlZuDSnwf1ow9MbU86bQFS8FFwPMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbVBFA7CrDl2TVEzRjkdvUfrjiSDHZAJ2hVgrEXWUtUCITpqk
	olvKKuQjmMShBCHgfZOX2IT2IvlmbbA5nz+Ymt1VK8DkWkaroIPlnAiOUDax25RfnJyPlXs4myK
	HbFuXULidZlpbCZzWlfzzUoEoGy4UhBM=
X-Gm-Gg: AZuq6aIiiGL9H70/VzUhkl+6yh9gBAI+pfPDlsFrILnVJtaKEYctr/BEMZQ56lsdUI6
	5AWmX4BK+ZGkXuI6HANbmEY50Q2bZBlReR6ifZrxwVHY0XO/mA7xQgTUt8LJhxL5edEYoO92e7r
	s6E2/zlblTYXnPuigcVN+F5wW4VqtYq0oactDY09V63m/li9cOGi/m17QWynJgKd5y8uAW92ytv
	JyH6NYDw+dCpRvmEnGIvAVIB8j43/smnSM3upXk1uFZ0yIZE91i5nDU6L6qC9/KNrSNZ5JrZfwT
	ktkR2w+KD/PyrnG1O9FWVP1EIzZ/1i+L/9GZD6IVns/JSGvDXYCnBYxZR3snWMwA49U=
X-Received: by 2002:a05:7022:a83:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-126ea90e286mr970012c88.20.1770111440678; Tue, 03 Feb 2026
 01:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com> <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
 <21D9FA76-F382-483E-817F-C3947C939D16@gmail.com>
In-Reply-To: <21D9FA76-F382-483E-817F-C3947C939D16@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Feb 2026 10:37:09 +0100
X-Gm-Features: AZwV_QhGSdYO3euQNYD0RnIIw7BJPrt-Zr8U4MtNRGzfuhVN42V6qkdSihuHzDs
Message-ID: <CAP8UFD0qtn_1VAA1SiAMjGVF7Qv9qC1GdDmsbkK1xvq=SFxTaQ@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git <git@vger.kernel.org>, 
	karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Eric Ju <eric.peijian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas and everyone,

On Thu, Jan 29, 2026 at 9:41=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > 6) Improve `git repo info` so it can show more information than now.
>
> From my side, I have these features in my local backlog:
>
> - remove the dependency on `the_repository`
> - use the category as key
> - add the path-related values (copied from git-rev-parse "Options for
>   Files"):
>   - git-dir
>   - common-dir
>   - toplevel
>   - superproject-working-tree
> - add more values currently obtained through
> `git rev-parse --git-path`:
>   - grafts file
>   - index file
>   - objects directory
>   - hooks directory
>   - git-prefix
>   - other paths that are adjusted by update_common_dir()
>
> I already started to add those path-related values [1], but I think
> that the major problem is deciding whether we should use relative or
> absolute paths.
>
> I also think that we have room for other information that we retrieve
> through commands other than git-rev-parse.

Thanks a lot for this. I have used it in the new SoC-2026-Ideas page I
just added:

https://git.github.io/SoC-2026-Ideas/

It contains the 3 following projects:

1) Refactoring in order to reduce Git's global state

2) Improve the new `git repo` command

3) Complete and extend the `remote-object-info` command for `git cat-file`

I have removed myself from the potential mentors of project 2), where
I used material from your email.

Otherwise everyone who said they were interested in (co-)mentoring
should be listed as a potential mentor of each of these projects. Feel
free to send MRs or just email requests and I will remove you.

We can still add more projects (and potential (co-)mentors) or maybe
split project 2) into 2 separate projects (one for `git repo info` and
the other one for `git repo structure`). We can also refine the
projects.

Feel free to send PRs or patches!

> > I would be willing to mentor any of them, but I don't have much
> > knowledge on `git repo`, so I think it makes more sense for me to
> > avoid 6) and 7).
>
> If you want, I can share with you some information about
> git-repo-info.

Thanks but I prefer to plan to mentor another project for now.

> I really appreciate initiatives like git-repo-structure and
> git-history that bring features from other tools that make Git
> easier to use. This week, I was talked independently with two
> friends about how git-blame can be misleading sometimes since it
> only shows the last change in a line. One of them really likes
> `git log -S` for "blaming" strings and thinks that it's a too
> powerful feature that is hidden inside git-log. The other one
> showed me Cregit [3], a tool for blaming based on tokens
> instead of lines. A "string blame" or a "token blame" could be
> a nice GSoC project (but maybe for future editions).

I think it's too much work and too risky at this point for a SGoC. It
could require a lot of discussions on the mailing list before there is
some consensus on the command and the way it should be implemented.

If there was already some kind of consensus about a new command and
how it should work my opinion could be different, but for this year,
yeah, let's just pass on this one.

Thanks.
