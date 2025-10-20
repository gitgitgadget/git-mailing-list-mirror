Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02613DDAE
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982013; cv=none; b=HJBRRBBfP47nmoTEJ0qM6IqtIPgrRmzgsg1c8sYDShh9Cx4eZmBeC800DYt+hNUniubnY2mkqpnoNoUWNzRuutyayudPNLg+qBh8OiBZ5RFbV4xcpkA+GDNW3ndEmeyoGcEYbUyDOWWu3f5y8OIz6cFNx4brZF/1V+G2HYFspIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982013; c=relaxed/simple;
	bh=xz+Fe86mOJsKmpgMrDstInlGTViNLZWSGn5G7nxiquo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE25g+9rVRcIFPL7F1ZvYlFYIQ0P80VVqL8T91MLxWlZRHSa702Gdyi/uqLbVOpwPAybQWCa26Sin9ggCcYHkUwSxqYOBG4EYRb6YuDg0Z8TgkPFRDItwTlhfzyoQW5HkimjIB14+mCRp/7bog9ADlbSWe+LqTAigLM8dRpIaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87c25d43d9bso2197846d6.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 10:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982010; x=1761586810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wx3zJXA0H2Tdn4cDGGsbifvU2nY8GMBRYi4QjrV6Kw=;
        b=pdTKUDTbbrOWkC2op4UK1MsajxmZEk5Ks+JFbHiXaBC3QcqbaCQdzwVsqQ13nKPPDc
         RdLxijc0p4bmvHkAXibMtym6tNCLQG42SgCi91vgcJyFhV3H+PB0i7Pdutau5xsBfdVM
         IukCaDuVm635EapRC7AaxnK4iW5wjQWGsNykXg7mpVS2sYv1IpxEymxiA/NVvR257ugj
         6OEsDhA4l1+dOLPFybmTaK/bffegGts0buMCfuSRuOpQ3gXpiWy+tWXO9g384mcZsPzD
         AcKY1FTeWwR9Y1wzydMQGPcJeTHOeGGXRNUOdgk5biC2xbFKynZoL5HSMISr9Kdh49Am
         +m1g==
X-Forwarded-Encrypted: i=1; AJvYcCXgGdp2jwpwWddAfuH+uwIwGGGDb3Yy666rwvOvJyQHlF2nB3Rr1QOrLUbrvo70bO8ih6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMb6TsKI3WqD/4W5sFHH3OxI4dR066oa3QFtZvnhjRLgvN08hZ
	U2IOrqe1BdwE+JSiL6Stt6X6O3miazctfa/c7VDOUTxLT9tO5olSrrcV8IsU0teIkSNE2PFQGbe
	MaGaUnK2oL1ETYiMtTKqq8jVF0pM3v9g=
X-Gm-Gg: ASbGncudriIH0Ij3P4lfgZPrDecEvf7laLgnYugaJT+zwMm3vXtPjiwShpPW51CnXiv
	lL3owKT0+11YUZrg2Lsyc3/O6o9A7fv+qVbUqE1mjttEyGKkOwkcneMRdISQc/xOv+AAY9+LP/v
	tAELOUEGe/sY3vnjMzLDsge2MX/XEdQG8VfmFWNri2j/zRrR9XCJDMocflp0fxQlGJ8k3HAIG0l
	L2KOV+RR3cLmJYpOxSAxKhUIT0RK/2iOGOd34Vq4lYZLl36myOZWkfrMpc8vJeFISwkavkXNls+
	v82jYHPtWc8JKDMTYKiTnumD1N6k
X-Google-Smtp-Source: AGHT+IGsceu2bl8ujnoAoeP8uSjSIBA5Py+k4hKJakFc8jteCIFLeYjBquxDvSelH0FX8QMTpgtXxSUmKD9Thgihs0Q=
X-Received: by 2002:a05:6214:d04:b0:87d:ad10:215b with SMTP id
 6a1803df08f44-87de70b4540mr3888306d6.1.1760982010150; Mon, 20 Oct 2025
 10:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org> <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com>
In-Reply-To: <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 Oct 2025 13:39:59 -0400
X-Gm-Features: AS18NWBaZH_T9yOBhBmn-lDVWhvGoEyrWGa9kZmcWQVvzeggGdc2aUAWoH0eOEs
Message-ID: <CAPig+cTP1ARNMQmxZh9_YO0pDOsFZ1Z2HTa+Bo=58O-voL9hXA@mail.gmail.com>
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, "D. Ben Knoble" <ben.knoble+github@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Noah Pendleton <noah.pendleton@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:44=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> > Le 20 oct. 2025 =C3=A0 05:40, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit=
 :
> > =EF=BB=BFOn Windows, the MSYS layer translates absolute path names gene=
rated by
> > a shell script from the POSIX style /c/dir/file to the Windows style
> > C:/dir/file form that is understood by git.exe. This happens only when
> > the absolute path stands on its own as a program argument or a value of
> > an environment variable.
> > [...]
>
> Going forward I will probably stick with using pwd, given the difference =
in platform behavior.
>
> Is there a doc or test lint for that? If not, might be useful.

The use of $PWD versus $(pwd) is documented in t/README:

    When a test checks for an absolute path that a git command
    generated, construct the expected value using $(pwd) rather than
    $PWD, $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference
    on Windows, where the shell (MSYS bash) mangles absolute path
    names.  For details, see the commit message of 4114156ae9.

(Though, it might have been nicer if it described the behavior in more
detail rather than referring the reader elsewhere.)
