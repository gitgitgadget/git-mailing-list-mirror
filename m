Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C260285CBA
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770777095; cv=pass; b=G3ehzJjz61a27Bav8Vy/uytJBvaI7MHioekF6LkQNp+DeZ2sYHmY+PozPBCsehvx7gmm9mMHxVrRzStNfbF29Zw63O/SeK29i0sKMGuidjSAMtKvHVg6WpU65jqLerX8EigMzi2HI/z7Jbu2r4mtp/vj40hqjkY5KbfzpEpoQ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770777095; c=relaxed/simple;
	bh=s662P4pld/XqWnVhmmOvMtttHs4XKWrnGrsph1Qel/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci2D2t2LSbSpe7nYRYKO00Fnf0/BcuYI4Fx57SQkQmp5xW7nCKjG7wDUXtVIQWJPWMauYV7moVIe/z//YzsG3AmzJRwP9ubq25uxJ/yUC3HR3ih8Z//NIh4Wn6EA/gNWfSruZVGLw/HN6+8fFJzHIgfx7CEASOmSGj2M2jIjI7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jouF38Gu; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jouF38Gu"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662fc35291eso817242eaf.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770777093; cv=none;
        d=google.com; s=arc-20240605;
        b=RUedSFAQmDofu93XQfQxTnG+w5+GTgguyiUTOM3SD6UM/lmTL+eyrfpAkAl3mKVO2q
         EBcMUKb3Kx4rezorfYGut9tjdVHAFCQsGTNNZHFwBAciUlnV3hHb6m9V+ity4dGwD6I1
         uh7Lru/7WoiHB+fVWmLTUQ2e6a4t1j2g06paocuKBDnLLBigHKfhgQf28E/K8qyvrKI9
         8e9FvxrsK9IlUmPeOf54XQ4qCx+Nsund6p7U4MxMPwZnUmcgL/slMf+v1JUV2qzvicfj
         /nBpCWsOQBGKTB+h+DtGmX5ThWUjJqnQD5zEPJuyK0QdzhS27GUpBK1Qrhat0/P66m87
         hQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R29C4ukn/al962po2tL1eBphuKxt1kDg3vYVmgu85pw=;
        fh=n4lx1vkGKfetBYEkHNvKnWT41T+2Ff2boUNv5fJ6CUY=;
        b=AZlrHzefLAGiIrhWedgMmjrUN8iuIhsnTg1Wk5FRgNLUHe4W784uQlzEXM3pavIYAQ
         K3mtF6/OB6Uk836C1mbgS2SivIB9EkqCrkGvfYBdDMXTd9I4peqnNQfrHBef6XHQkXoS
         QWWjg0QWRh42tzdlqdmXXQiLhTYWcFkjAJYDayGV7DHNdMUzdnL/pGO3UsBROBwRG2lf
         VMX8I02ch66NRbK4pRBpd2sIx2L1fBcNaQyI9ZDwAtrEdIWeFzsDzkq6rc7cY1zCLtZs
         /lip98xu55Xf3UpSFiK4xBcGKonNhqCIo3FHnScUsBaqwgNuIGUatAFw/JH1t/UIopHP
         A/JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770777093; x=1771381893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R29C4ukn/al962po2tL1eBphuKxt1kDg3vYVmgu85pw=;
        b=jouF38Guhxg2NpNVieQhU+dKsyvgwOmG7RVM3nC9Vd8f01kq1bvd6AsgajML6tBhMY
         U9nAYH3gRhSIaJEcgVaJ5H69FM+B0d379dnLiDPRnB73dg0Yf3T3jjyp02O20rAPbXnI
         WrTVgYVFW6kwo5SOjOmUkFnSQOM+DzAt9jwT09xzJiVd0NU0TosTd67VJZ7WoZLGwT5p
         Zu3YBJeZUG/Cn/Pm/LTrX8MjJOAK+qTOUqLfRigc5TX0RctGccGrfajklHnBFKT6MvuU
         USKudUhSsgHnku/jQSuSh1Wy9BBoLzQOGnyu6Q8uDyRg4AGWHHUFjlHJA+qanIvhnmpu
         iu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770777093; x=1771381893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R29C4ukn/al962po2tL1eBphuKxt1kDg3vYVmgu85pw=;
        b=eaJIHCJO04aObdS75Tsq7AzLUqcEWSFeNDXnGcz2TvogckelN5sQmvI5N90WnuXEG2
         FmdtE4x2c4VUnZjRnl3xSaYDBHqtwXKSjHvVV9NRiEVKKGzXJs4WPtVvEi2oFZmVzeiY
         ZcSG0xxYQ/D+Fc37v5oerUP3OlvWSXI9P4sKUvVOaysXaZ8GpJAnlMtOA8WjO12VFXfE
         saVoW2a1A+eL+R/VZqJW8r5fB8Db4qxc3SXSUUwXVY50tVL+P0jiwBrLvNlWqAHD1Gbe
         HscMj41cxwjVqO0DufRtv2RxHUegNDPobS8gEnycLhnM3VVmEOC/J70vGrGDAKEhdtTg
         DkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTogIfqgSRQ1GvsxbF9qWoJvU2fryYLEgpT77ZAiRHp4Xc+JVQneaLUrbqJtlvkvTWwJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5Qgl/lUEuDq8f9vuFvdGPeumyXwDT+2E6QSgvRcZPsxZL/yA
	Mft8m3jR+zAXLLXTQqu05wExusrB8CJr6+DRplrfSmyFThxlCySvp+C8P7AhDooDAtVbd6Psm97
	Qw+odI0fre3rjTNHU2Sfr8+yRWgBFODSLm0bo
X-Gm-Gg: AZuq6aJ4Nz6bCoJWNW4pMpwLFhOPVZT62kNpY87XEk0MZXQeRmKZKIZlWZAIsxXBuyL
	wVEmnFX7bTwJQtW95AGhD1fVqwI4VhmpmDgXoz09HjjDLkYM+LC7E8MsdMzrevIS7zZV3AdYDXx
	f8h/avfm4g8X/KGthh+W1vkU7WjPI4rGpPAOs7Emp7bTyLmp8CVkRqsFaDiTRFENFFkW/Gy42og
	9DCjAIakboxbwci1MiUbWTM/H3BNOuHVbkTA13AytelnIglnTzlQSEbgC2M73hz4vgvLAQ7M4SG
	kJvVfA==
X-Received: by 2002:a05:6820:1c03:b0:66e:20fb:748b with SMTP id
 006d021491bc7-66e20fb7791mr5625665eaf.11.1770777093329; Tue, 10 Feb 2026
 18:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net> <aYoEO0CcVt2Qjgnb@pks.im>
 <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
 <aYs_P8QujA6mL81-@pks.im> <xmqq34381tze.fsf@gitster.g>
In-Reply-To: <xmqq34381tze.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Tue, 10 Feb 2026 18:31:23 -0800
X-Gm-Features: AZwV_Qi-UCulX2Lf9NDVE7r7fM4q-5IoJBmDiRsYL5Q0ktNS8QcMAmL0INcJ76o
Message-ID: <CA+P7+xo0-9h_V8xGQaEdgBEaxjrbrNOdPfmFmhKup+Z-7w0zUw@mail.gmail.com>
Subject: Re: git-am applies commit message diffs
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, Matthias Beyer <mail@beyermatthias.de>, 
	git@vger.kernel.org, pyokagan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 7:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > That is worth a thought indeed. I guess one of the biggest questions
> > here is whether we can introduce such an unambiguous mode in such a way
> > that old Git clients/patch(1) would continue to understand them. I
> > wouldn't mind much if they would still misinterpret the ambiguous parts=
.
> > But if so, we could make this unambiguous mode the default without a
> > breaking change.
>
> Yup, if the old versions misinterpret exactly the same way as
> before, then it does not even have to be called "unambiguous mode"
> that is on by default.  I doubt it is possible, though.
>

Hmm. If we add a new unambiguous marker after the ---, old versions
would see '...' and know to cut the description. New versions would
wait for <NEW MARKER> and properly ignore any diff/etc prior to this.

Since <NEW MARKER> is after a ---, it would be ignored and not
inserted as part of the commit message, and because all versions
universally accept cruft between --- and the diff start, this should
be acceptable right?
