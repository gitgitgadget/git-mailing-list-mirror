Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EA3B3C1D
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322511; cv=pass; b=G0fJQOiTRE49KnDvkwvCG3+pBIm1u97gWwGp9v67ku6xYqOmPHRMFBtpuziB77PPRCg7FFPPpeL5KLVxBgOvwV/Lj1Wg3gAvjsmbvThSKZLH4wwasgOt7Y77FAjbCNpoHcjQlp2vCz8VMMTUgaqaC8marOM0KO9HCPF3WmDKTeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322511; c=relaxed/simple;
	bh=EaOqt+azPDKLQPff2fphfVznCaIJD856znb1mjSbcJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpmLvTMIJNzVF0n9gaA2VXD1AWiIoFBPCI3Mop4M54qc3eZW5rrR1D+SmniKiHJaGNpOCqZkLGrVEj6tejBF60HybpKIV51osbcWZSS8C35xsMeze0RUqQRJsIkGJ/7Dc5UGU4I3Mp7ldai8Em0Zmii0CfWrCbQhdaC3ducTSDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEJa47nH; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEJa47nH"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13721dfd471so9274768c88.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 07:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780322509; cv=none;
        d=google.com; s=arc-20240605;
        b=bkx7uH9OqEfEvQczpxAYlaUotaLmaK0rBYYec6gnGAFtcF6QP32HaNaDJ18VRAqHAv
         24oqf3/XG77irndrMW/EgEQArzXJxQOwZRLGW/Cuzqbsf5giGKVE42ijmkZiyHTepVX3
         CMKULYy5JOF86kGRQ0oR7J838nRn6Zaj71uz0dOpcanL4HfanmbtiVn+WQICSe25lD/a
         cfYXIbyoRi9yJAMQiyPiu2MeUdI0HZ4MADHGRN48Qac8oOJBLVH+JUx7Rv9WhYiJoXE9
         3S3I5mPjf5RsraZRA5f6g3lPA4Ep9F5QS+Wvxdz41Rq96zhAFPKBji3fkDFQVwJb/10a
         XFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5BvngHslubg2vj2rQQXNCFlzj/0/3cLOTNxDOX/4/qo=;
        fh=XnHTUH2yi1hzI6R3ZXeCezx2UG/B0bdvFY82pGSmZ9o=;
        b=F2RVku8dnh2HJEwOnd0dtkDUhCgf1ZizufQIaH4qmORMdfUjD5d92IiMYsxym5qqbk
         MuX9AeftpvMWEyChM8Kv3BQ1Yd4Og1aFFhF9GAkSreJ+uxi00QRx0TTf4DrdNbNhBkvG
         cQ9ZPr1FsgxjQIm/GzHUPUgGpDHerr/RkMUCavK3t6PfoliGzCNjkLwI/M2fKDKkG6SG
         e3WNMkMGLq7aDvLW/I3rF4BAIRFkz0+R75NmK9QpFKYP1O6Pvwa8j8Supq2Mm8s1dJB1
         8SiPtc/9wjchR1nIRAd6Io06fGtCaMbbuuUmWMqEnkkgV8yh5w2zUqg+a/mcQuDEBFiA
         CcHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780322509; x=1780927309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BvngHslubg2vj2rQQXNCFlzj/0/3cLOTNxDOX/4/qo=;
        b=JEJa47nH06KGEYdHDG4BIB9d8hpiZn7Kjk420jD4+ye0D4hu1MIZzdGeJf0gM0pL/S
         QAl2AfqzDp3djj7SEMf8gOycoFnsa7HVymFwf3+FnemPkg5h4s6GkcGG8Xl34006qBcK
         tnKVHJfqFu9Ga2Y8rnka9WWHfl6YHHMOzanVaYdzHfQwUAaG46kp3giI256ffmNXDxQE
         /MVew5/pG9Dnm9ANo13IwS5Q9Sp4ZxO2MjtHEg7xTwZJXH5xaMQEafrynkiu0LSpba7D
         4KUecdfwxN2RHtrj0/f0UENdpxH7TRjpVDvCjLgQQqvXyL9jP+mzfAgknqA9hVai1DO/
         zFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322509; x=1780927309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BvngHslubg2vj2rQQXNCFlzj/0/3cLOTNxDOX/4/qo=;
        b=Nt9VGN/quR5jGpa5PtenXBYefnHe/BibeK8MJmO7Ht9HRKsJFv+mi65zp8PMx0mXdR
         cPAnepLZVN3ukyrYOyHF3PE+vdp+eeYOOWa4Ji6D4TPCAc8gbi94vbMrrZ4lF6Wt3Mz9
         7Yo76Qrc97iY0FJPA3VziDWe1QYeniBbcHYc0eKxJXmpuGt0hRqem20ghM96J9b3ax3s
         bJxJAXWKp3mdqu2bL4iZTygjuWzCie5ljXRb9OYhs6yKY+moEmatflHrngNXwGkUgkeq
         Rolr7y2T262j1MshaisTR2s4uP1jE0QN564dH4HD3dr3wLA1NQMZ8VIceDEn48jZcn0e
         ehEw==
X-Gm-Message-State: AOJu0YxkDLXztjMext0pgMZL51FTmUo5sjvrB2HX3mUjuiJIHzU9uiFA
	T6YYCCavnveHDkeabYZWhmk3R0A+8n5S34f2P0BTfHptdVYDdXjY0T65LHLDBL5t87ulFuJOABf
	ZrH5ydCLeZvlO3UAwcLVDBCXMgCTAotE=
X-Gm-Gg: Acq92OHltW3z/Bgv6nzlsEbA9APBuLqBe5Hy7GCw6t3xlzFlwxD4FeTdV5O1QwlGPEs
	QEYXMboWmGRVLu8Iq4qbwY0//4k9PkXeju0G1sQdduEsu0ZL5b1dspStg5tVo+5pYPt+TXiE7ox
	t2In/pNbemmeylw70BuzrDSIK0Gnhea2cbaHB24or+80KqCDKfHrIc7hlEuleUbNdTmVGp4YkEZ
	oWwEjyJaRNAU6P9atzqNDZ+1GOTv+YwEJrMD1wfrJtZoO6H2aUaxNw/fLtR21PvWlK8p6L5A8pi
	HbVG7AVn8t+yyy6UJe3VRxID2Bu0l+fs3cPXUxNiVdvFsDpBQVBhskYePvDkGOGLof0NbiiZG7z
	hDsa9wRM=
X-Received: by 2002:a05:7022:429:b0:132:fac:2fb2 with SMTP id
 a92af1059eb24-137d3d09902mr4449652c88.8.1780322507029; Mon, 01 Jun 2026
 07:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com> <20260423165432.143598-2-belkid98@gmail.com>
 <08efcc49-0db8-49f6-8971-633aa55eb66c@malon.dev>
In-Reply-To: <08efcc49-0db8-49f6-8971-633aa55eb66c@malon.dev>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 1 Jun 2026 15:01:35 +0100
X-Gm-Features: AVHnY4LihRcoXgBWT-QjK8Uw4YXM4IFXCPSkOOc0DOwtwqmtOF9Cem0u0lGyCNI
Message-ID: <CAD=f0L_zoZebG039APOcgYysjXnJF0TXCMJXT9YE2XT5LwBwTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] environment: move "trust_ctime" into `struct repo_config_values`
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Christain Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, 5:37=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:
>
> Hi Bello!
>
> On 4/24/26 00:54, Olamide Caleb Bello wrote:
>
> The code itself looks great to me, but I have some reservations about
> the description here (in terms of why trust_ctime is eagerly parsed):
>
>  > `core.trustctime` is parsed eagerly
>  > because it is used in low=E2=80=91level stat=E2=80=91matching function=
s
>  > (`match_stat_data()`), where a lazy parse could cause unexpected
>  > fatal errors and complicate libification efforts.
>
> It's true that if we use repo_config_get_bool() to parse trust_ctime,
> following the call stack downwards, there is a die() call. The terminate
> condition is that the configuration does not exist or contains invalid
> characters.
>
> But I think there is another factor: match_stat_data() is called on a
> hot path. The following code is implemented in read-cache.c,
> refresh_index() function:
>
>         for (i =3D 0; i < istate->cache_nr; i++) {
>                 ...
>                 new_entry =3D refresh_cache_ent(istate, ce, options,
>                                               &cache_errno, &changed,
>                                               &t2_did_lstat, &t2_did_scan=
);
>                 t2_sum_lstat +=3D t2_did_lstat;
>                 t2_sum_scan +=3D t2_did_scan;
>                 if (new_entry =3D=3D ce)
>                 ...
>
> The call chain: refresh_index() -> refresh_cache_ent() ->
> ie_match_stat() -> ce_match_stat_basic() -> *match_stat_data()*
>
> Therefore, if the variable is lazily parsed, this means there will be a
> performance regression whenever the index status needs to be checked,
> e.g. 'git status'.
>
> So, I guess it would be better to extend a bit:
>
> '...where a lazy parse could cause unexpected fatal, and result in a
> performance regression...'
noted...
>
> Thanks, yuchen

Thank you, Yuchen.
