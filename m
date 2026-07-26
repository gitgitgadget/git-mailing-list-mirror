Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA53374A1D
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049184; cv=pass; b=EiGG8JSon3K6BnOSBuPto/5Zj3wIrXjsg5U19aAACNlisXuK107jL/KjHc2xj1e5rqa+jfmOdyGf+toxeENSaEGyYcDateD/QjxCBD9D27Kz/AajbO6nO+2imr4Ww+csJV10JsEwXjaYwUIm5TmSvpcLyzbLDHrvbdc7R71xo54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049184; c=relaxed/simple;
	bh=d2Ww6GH0/tEw7lWZmhV0x2nHjx0QyRJ5fmyPmnY84Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJjL1+b/KBnQmrsEs25ctba1T0wLOmd8plm7zYVVm8bSn4jUnsXl/cSa23ZqixiIBvhbdpRmdt83gQOROYBHFEWNa2tLwGGpeWGN0Yzx7LZdQfmP95/xMP4gZdfcrK1Vrp/3ug05x0szPIV1lPph9jb0LUIxSSvStoEzyIrF5Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEdVeGqc; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEdVeGqc"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ebd88be784so1257948a34.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 23:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785049182; cv=none;
        d=google.com; s=arc-20260327;
        b=UZUE/RpPZ+D0MJcn/H7QlXA5Kk/km3YBAB/jriv6WuQuB6YgON+5IYvVFn/vQEq9cR
         DB5riwILJqkFpsiMdvTKRJ5s1MSuCKdnT4LXhB+6WbNz2WEbKAe3Qb+FiJ/8dJpkNN+5
         u/Oq4ii6GyPtMVn6oyfgbbcZtPEkV7LxzZ6YP/gZPYdVgNcngTRSbUQkJuAmYmWsqCJc
         RnSTwmZ/RJiwyiGGDESfizqr3LGJV0jUs4UAA4c4vAib9p0BOqX4uElvgr/J6OavQqGM
         MWSx0a98DPGX4wDnOlX0AVKlW/MKXuT8rjrYSsoe9p3nUQ+DN4N++84x/xzfSEgwIjkp
         78nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=botCUwsBYsEBwV0fNYFNTWSzfNhUh8gERiBlU3v5ZNc=;
        fh=NLE3wSUrauHg9vAbx1PwZCGM+OQEDSIdoBfAht2rzTA=;
        b=feSTUJtwQtcBz+/YyLP/+M0rPgWFamaMPsVx2q/pnpOZyWtYIPPpXIVreFwVLHP1AM
         U3RfE5rIjh4G9HzzF5c+AIc/LwtRoqXYr03TXZ4600RjoPb226a0RGZotslE7MqbdSul
         sApKx84nR7JXRLfOHixP/8c+EQkAvlFHIpq9kPQwROhYZDdKuWLgDjyHxhPIZEV6KoDj
         lWLO3kvfs61+rmJu11UCwuG7Qwx4Z5RzMuggw/+l4EJeWpRoWanTyEUKDf9iTAyKj4LL
         859BFZntltzv5ugsDPPHVG1whh1RMO+1dak3Vfih+BYvuJ3dzllnGEcQJKW/l1XGiR+Y
         aW2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785049182; x=1785653982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=botCUwsBYsEBwV0fNYFNTWSzfNhUh8gERiBlU3v5ZNc=;
        b=SEdVeGqclfVZ9u86t158gtePfNdMD8AsT/Mp51b6a9K+x8ywDjaxyKsBF95I0KtyHF
         8bcv/ehK/kFcVyNNqifCAfqYSK83+ehOzkbBv9qScb+qBxbF1Abiwnzd/j331ifoFfb/
         TftE53iEyL6707jPIYIDoW+p+RpXcQvvCvC/W6zI7aHQWVGDKYXKYyQ5AuvMKKF7L1Of
         3Z2fTd5k3dJ9BnR5a7JN7EPvv/gZKIzlyr/Sy51u6jyhte/1C38dnXbkUOcOBBW43XLU
         w9Z3d4GJVh9gOhJNaLcjQryJBH0iP8VrSR3nZRBX2WCYJeHtbI75rIfCoY+VhQoT3HV+
         +seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785049182; x=1785653982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=botCUwsBYsEBwV0fNYFNTWSzfNhUh8gERiBlU3v5ZNc=;
        b=FCEydcaeWjdxABCSS8UIW+3p5R9dPHFFUiVKzCD0RISb9GOT8B1YQA2uNP6UJJ1d87
         jLyjUMuOStE3VZW8oN8Dn55q7NSslH7R0HO/NLG+zmFXlRdvbzsgyQSuArBuLtV5p4Io
         hj2/AsjmyeWjc8yba4SRShXgAZqlK/k6JyBQPUuoJCw62ZPAdIy+ThgiTYw06NBgmbbb
         COqCoMqbNpbvkJHsoPW+90cOzKxCyT7Vn4dBH20YWREGrVfXjhrFi71p76dbnUFxEups
         XbWkMF+NLT5wq9XB2XHNfeSR1EvhZ89ug/vbWpCOn6zYa5UPZbW/oslnY3QS901yary2
         ixvg==
X-Forwarded-Encrypted: i=1; AHgh+Rpbz31gxFsVY9VMcexEVq8DPofm9p6Ox1ZNP3HYjqzkTk5xGbDZF8QXzHZdOFehRHKwpI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYXvhTXGKjJCFINYRdTVo03yx1hul7uxcM6itPdre2BnMpWj9
	jWuDlN7K+3zLen5ePTZvRW3og67AweoQ3RzfndKD5i13Y3V9LZKe3TJNuZTRyqX38+KY+SKkjOD
	OWKCNxBz6AwkLY4cfvL6e/wBqIKA8S1k=
X-Gm-Gg: AR+sD10G+45/sbRCEeoNRwSkQWjQ/F9Kv8ZfHH806eI+gRltRswVOGazeq6dmU8fTpk
	8yJR5fIloi4Ny1lJqdlx8IRGP+MHRuQ1nJh2jsoEqt3AgsLYf6UCI/h8iZj3mSxOxNOqbmMVrye
	s9lq3CWZMILLieWJec0ENOF6/Hyd5Xrn6DIP8dHh/5otPFsYxeT9FXruzjC4HkNVczQoxxEU8bK
	+8xHkZalo5Lho0tQ1lEMVBzGDO9/A47KquvtFQ8TcjAOpIG4JUrZ2NVDXWGnmG1HbTnLA1xwJOY
	o1xGyaEfrtcyG/qJIuJobdWVQ5PcPn0RoKxfjLEdnv1D+TxSNQYRjNftiU7CYyNLvWh8qm0P/GK
	yiyj0yqfbKDSVwYE=
X-Received: by 2002:a05:6808:c3ea:b0:495:faa4:a742 with SMTP id
 5614622812f47-4ab6a28c20emr4080392b6e.41.1785049182063; Sat, 25 Jul 2026
 23:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> <xmqqv7al9rbj.fsf@gitster.g>
 <CAL71e4O5=ZJoPD4dnPmh8mjsTKtugx05-8d83VeQdBNOjp=bFw@mail.gmail.com> <xmqqse5en8wz.fsf@gitster.g>
In-Reply-To: <xmqqse5en8wz.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 25 Jul 2026 23:59:30 -0700
X-Gm-Features: AUfX_mwa1T2Yov2vARLdSU9hUNBsOv-bUFzLTcLQ65u6klIpBmUy1LppCJ1v4aU
Message-ID: <CABPp-BGATrNJyT7trzUzAMB_v-1ssVe_SRqp+281X5GzU=2eow@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson <krka@spotify.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 11:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Kristofer Karlsson <krka@spotify.com> writes:
>
> > ...
> > After that, all ten patches apply cleanly with git am -3.
> >
> > I should have stated this more clearly in the cover letter
> > instead of mentioning next at all.
>
> Well that is how I wiggled the series in my tree after all ;-)
>
> In any case, we really need to get somebody take a look at these
> patches to move them forward.  Any takers?

I started looking at the series and left a couple comments.  I'll
continue looking at it on Monday.
