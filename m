Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB73E5EE2
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176788; cv=pass; b=ItLtASN7g4UMITE+t6ZQ1l1MrimGsR5amj7rsbZk4PDvutrmKsWaj0G3rHAnfraMRlfORNJhBHbKsByVk/9zVXFCaQoYRdYG37f2Jtw7VcxNIRgEGLZPgyytWNV5GS2ru9ZFDw5YxInbSs/i5CY6/pa/AEalGsyCoJ87y9ljnjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176788; c=relaxed/simple;
	bh=EUF8lNMxazv/jM6Zi9FyARPPKTnbS8VPoaXPUg/xPag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+eXICDbjwTmCGPcYGvc4lktrKzmGreeLBu3i/g2UvY7FaOR8tsnLHbpB/vEGRdF87YwgVCArG8jAtD7uHbC4kw5s8H1+iQL08EA4oaIuSBSAiSU58kenDWa0U+3uIvPDNaRm8vVrK0d3uPp52baTvhnQcrI+Z0/ag9Yh/NDLWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2TcyqzS; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2TcyqzS"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c19d23b19so6342077c88.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776176785; cv=none;
        d=google.com; s=arc-20240605;
        b=RstmsvtNRJ5NKFiJESOp/LJXZZm3ZihNDvhyN8SrCBlB1xrsMA/skNPC6SnOsna4gd
         NHwrB93wqeG65Xzx+VBzXQ2YGjq5ANAu8PvqDNczGjSigTuCwBo+1dTkWJsZgklfIvjb
         6cn22PO72Z47HMKBd2q0JS+HK/FbpohEqAUDw4Wd97+Blu/oOKanhbgjSchqfkr7LVAI
         iFosmQh248nlSNu4/IddzghbZYSdGgMc9snhyHn12Liz+uTz9U8xZR79JouYbOhgPZR0
         JyZUGoy7W6ISiJ1fjhRP5Hr8DP/N9XhpO0k1KZn1SgXpryQYCtmOany0lDfSoscbBKWk
         Y9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHhEyHGGV0lVOHKSViiRTMviLtST0zqqz3j9kQVsuaU=;
        fh=lBPmdbGtIqLcrOfOHWor4SBa+dA9MPlYNnuFeiowut4=;
        b=Hgvvc72+cLJbHH/nnv9lVk5dWVD73HYSe1uo81ImHyQcKbM9yNpdZ18M+m3jrAvayj
         NzE/UI75ToxOr1BfXJaqsR/SAK4h6WYetvVhYf5BhRLogniuXzlzmndOZKuS4qNY4ffZ
         coGtwvyzgYUtDZsEtilAOYB1wa8OpeLiTbLwQXXpgSFkIfTv6ADavRs8nVGdUMfTJNmc
         Ni5HX2nTmqAgGfUqHTviZ9QRUtzMHwupOygqEbjRUcITEYEzzJ3GzCCKaP4a5Apfy5T4
         9+wUL10H7orUjw0284YobTVNKS4cMVyaEQsyrpf2JRCE9nV6n/MMhSr+GadzCNugjUvj
         /OkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176785; x=1776781585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHhEyHGGV0lVOHKSViiRTMviLtST0zqqz3j9kQVsuaU=;
        b=c2TcyqzSYZCqw9v/cXcAeR4F5Cx8lN5JShnV0UCKExdieTvsezvgaLQFOvgSh/hWaw
         b7Hj7RB7NXDNwDxSyzfa6IsVi3lYSoU+snAbYmcgYZUotP1+98ECI2WygC7xagJbKl9Y
         I3yv9z+p0C0k4gdkgl7bTAF8fkzHHSQowEmY6l5R9AsNcxK3RhMR1lu3tiYhqEYKbdHc
         JkrT5f/75TDUjSjMUQvnb/a/ZEESBXi0Lt88mt/JMYgmljjiFU1uhCAoNduKnRQUm1jm
         mSjC/Y7f5t5T1nVmd2CUBKgxyJG8G0kUc0L5nN4xIVzfadoDPkPb2ird5SV+G0GRJ69q
         I5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176785; x=1776781585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHhEyHGGV0lVOHKSViiRTMviLtST0zqqz3j9kQVsuaU=;
        b=nMKyYlIDLZgQkza1U8/5iIw2IijB4nrJUgwLsFU9/9+Dyc0kweB+C76yv9jZN6lEL7
         yAhjCYhZ5U9mSNYPECbNom65S+lgrAhfJEXUbsE7e2KJFLOqEOIGa+S3I9AuavkMFvSW
         zZMj5sqRrtu9Ot5wsUFhrGVRAHImQowiQyGW4oEP74XWI5yUpV3UUlc3hNmcA4IdSfHK
         PO6J3Zys4bxpFdm765BhPcfyaSWeEiX1D6/cJpkOTqXO+HxwxtTolyzz5p6aYYsoW7tz
         2Mw+ut5NmBckaRWDVGZVESPCOo4VHaTK1/JOUPFmQeSIweELXyTuZwiAcr70kUSpeD81
         TIVw==
X-Gm-Message-State: AOJu0YxZdjUN8+6xV15oRyZKlqRaxqxEtObL/AW0oD74dKm9Ok2WLH9s
	dnzXx4dEy/Dte5VH8Gx034p8whssSZC7ZKXqXV5US/AOKSmIqlQmplBJP1nYsKv8XlAcJFINZ0r
	BvXpLoTZ6DrF6dozU+Mz7+NS5Ko1TLXg=
X-Gm-Gg: AeBDietXwxPPLdlbKO7WSQVbYkZgY/N/6XWaOxKZNgHo/wErsDeCWd0YA5P3FKgLO3W
	35wtMW0gYoefXlT6Ho7HMhrbw1hBd3qhDsxxOwIwzAeDo6syCiIMrAVuTCN2Mk/6hr0Fk6zXzad
	VxBm0cpbSMufitWRI7gA+EfvFG1+17eheCy8fhs8tEZKe4hs+5cesqdURTqDmxiIAW4hpTzmOhF
	B+lZmuWbGtRk5mJctlgfMaTxaUSSRJ+fW5pkzjX6ktGht/7H85SR7UAvCxT9QVE7GDBthExbHoc
	9dgeoM1jZ1vcxXCjARFeX854Qzm/GoZs/DFXG7p4xqrUS/WDp17vs3CRPejiplqcKbflpnzbRf9
	X
X-Received: by 2002:a05:7022:6b8d:b0:129:fe5:117e with SMTP id
 a92af1059eb24-12c34edd87dmr9726073c88.26.1776176785074; Tue, 14 Apr 2026
 07:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324123750.157143-1-belkid98@gmail.com> <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
In-Reply-To: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 14 Apr 2026 15:26:12 +0100
X-Gm-Features: AQROBzCskDTn3v13i1LcOwnsY3PiattBzRv8ei7cfU1Lbzv0nDv32rq1xpRwlJc
Message-ID: <CAD=f0L8UM=6vZR24_7Lz9g+yMDDPbcizzcs+DcqQW05PsTOzDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] repo_config_values: migrate more globals
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, gitster@pobox.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2026 at 10:10, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > This series continues the effort to migrate repository-specific global
> > variables into struct repo_config_values, further reducing global
> > state and improving repository isolation.
> >
> > The previous series introduced the infrastructure for storing
> > repository-dependent configuration in repo_config_values. This series
> > extends that work by moving additional environment-related globals into
> > that struct and updating their call sites accordingly.
> >
> > This helps avoid cross-repository interference when multiple
> > repositories are used within the same process, and continues preparing
> > Git for improved library usage and better encapsulation of repository
> > state.
> >
> > Changes since v1:
> > - Dropped "Base series" section as the dependency has been merged.
> > - Fixed handling of pack_compression_level: removed use of a local copy=
 and
> >   updated code to operate directly on cfg->pack_compression_level to av=
oid
> >   inconsistencies with option parsing.
> >
>
> I had a look at the series, the changes look good. I do think this is a
> nice opportunity to set some of the variables to be of type bool as
> needed. Apart from that, I'd like to see some more comments about each
> of the variables and improved commit messages talking about why this
> change is done this way.
>
> Thanks,
> Karthik

Hi Karthik,

Thanks for taking a look.

I=E2=80=99ll review the series and update variables to use bools where appr=
opriate.

I=E2=80=99ll also improve the commit messages to explain better why each va=
riable is
moved into `repo_config_values`, and add comments describing their purpose
and why they are safe to scope per-repository.

I=E2=80=99ll send a v3 with these updates.

Thanks,
Olamide
