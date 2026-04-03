Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB15C1BF33
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239667; cv=pass; b=f+JrT4/r9kZS1mEJpDgOGIAFNYUcPJlnFg8ZNZTG38V0DVPD7t+cDy0wVg3wclkGTJwYLpGtuqbOqpSyBQiuTpQcl7cVQRZnBITxuLuCXJEf561GiAqi625SM0SzHveCNl5R3iYRjwpI2lq8S/txw0uBDCiZ5HNSA7SIz6MFKiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239667; c=relaxed/simple;
	bh=gD58ZVjUj2BSgosXRrqJ636jrFZnXqj4LuTM2Au2PT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/v/R8oLkEpP+emnRkD+IoZwdOZuvDznwrQFIb+GJqdvzxSCDtfGbP7BSq8xWV65lMffDMiQC5ZN1lLHmAZ3zVvC0A+ZYv73iTtoLpoM6ioHKNx3E6XainwZPJhTRGCtoNN6mnk4HcMuLOhcQ6JzMm0Mx+51rRWSTrPUTpT/rls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfRStVk7; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfRStVk7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79c20063a32so22246367b3.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 11:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775239666; cv=none;
        d=google.com; s=arc-20240605;
        b=jGzFL3Zth1qDOrrVy4SDAx/R8umi2RkLyziguENMHXcBm1oM+ArkMxmCPm8vAWOwQ+
         BEf302EgecItz3v9ca+4ar72dYnl8PidRn1b5IBBqb6bVdmnKliL/n88rIyhemNPf324
         Vb263rHJxvAyC4fvTj0FKMItS2qBnEzguVU36gpzHbYYiFQOw1SwQQYzoyZoFTKTnUfb
         yZMWzTiKPX6l/QuKg0QHpRE3Iq8wcNemGLyflk0NDbYeTxXHSO1rkluDgaQlguclqCwj
         NLig2lDwnyYs0Rj1EqijOmeenOMSBoruWTRHJvhAblHCc63XiSMOTzpHn+JmNNNBAZQU
         qX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lVHZuXSsk33SyiHmxrbd66UQPRFwtzDxeMz8X43AyY=;
        fh=hdYj/kDeiNxc0CV9ANV1htcOog43EMyhQ9sUUeD7EVE=;
        b=LyNzkjuBsXD1az92cgA/Z9J54fbv9MjQoyIvD1KJo49qukT3K3NPExQ9zRfa7iNMUF
         v71vEnh2+OK8v85RCLqDgprzmiDKjdj+ycKrNObgtwrmZHgnaj9Rf/TjrE5bJGO2rP94
         vSzstEbaY2tUFX3sahbnResyZ93ZwNoCK9sCQXd8EzL839do4dAxhWOl1PUsu0KSVfxR
         91DCDyljZny7X5QuZP0c81cytczylQNw+Hheb47dTc/pqntol2zRtPT8szEmEaX/rndf
         J237I4e5rvWKQeKE+HZiEcq6jfF1jaNA5mhUkK1Oc09IPIQG033svswqp/cYTyw1KkFP
         Dz3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775239666; x=1775844466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lVHZuXSsk33SyiHmxrbd66UQPRFwtzDxeMz8X43AyY=;
        b=QfRStVk77iucNueOZyJb5aTis8dLzCXeU7nRnUKghzoxiy+t6bzW54cC5g1+wr8Udm
         cW6ZOgQ7L4IKvdgUtoKpD7MdISMLMyrfggmHBYIZcRFtay4rZEN13V0va6ak5IKFoTsl
         onMh/BwnT4d5+A2XpgCBUHfLqxbOcBs4IxQr2QRLWzJWMgQSVahCV9PNYLOwMFx3GWzj
         zPTuIQ8cpT5DjSrCdHS7qN4/5CwqLXFAQ5zj5aV1BVcU3oZLC1ZFnBPppfe9+ZgD5Bua
         1ITLhfBvkn4ZoMz4AAF/pEUqkmIYN23TlT7sFd1+lrAbXsMWjCF2r+fizC52wCTirlST
         4Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239666; x=1775844466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6lVHZuXSsk33SyiHmxrbd66UQPRFwtzDxeMz8X43AyY=;
        b=mqoAKmGmN/b+PUVpblAw9fSLc6V9jhvVV4CoYOsMt0jzRSEeaFEDlA38aDDl0yz0W7
         bH19sd1gecmIE82n0ShteAFMKw9Aq8+TL0MeuL2rWlerow53f6MQ/xemSw3j4yWBxmtc
         ic90IZFdqaT4tbCIqSUAQuVhD55fn6ihR/NZWqVPMYlLn0OafDvUeF2LH4vMVjIAhL5/
         xqsKlCw9OVV2tPnv1uwNNndEeWPYjutldPFgWqLzokmhPl3thGs1881a27hZHwDkrIvc
         Mk+5pVJJFKbfMM4XP2JbTeVjCTp+n9Ec055wxYZjAc/A3UZGAmyw/Y6oVSGNfRTDk7dp
         xpgg==
X-Gm-Message-State: AOJu0Yz5uG4vjYGMyvbKePEjUHl4l3CayrwrnTvMdB//24u5YmsqNANN
	Utv9ZjbrpEHYrD8TeC+q+xrk5w7uyukIqibGcRiMPjROWVxoytLKDMSccoWNdSqfozISO6xln9j
	p7wanLKIkI2alOoufBHYKrZxcd+fd6otOL0B9Nes=
X-Gm-Gg: AeBDiesaGXhAusA6mm41WR33QUwknjguF3OB7FT/jr59agBtosNlS8fLgOYSqDEJNMw
	G+HRxmRa8Rm3+3NfMBKS9MMEoJ4ClXuxpeWE4wQ1fncSNWvm1iVNK86BQenh08rK1Mz0qQsus+e
	QzTiXtwCIHPuYhwa1WI4XUVAR4rHewu3I595Cj1SjHZFqEMMc2MBQZGP/W1XOVltn6VBB6WJ3+4
	DfKJhWlqNtdSyRSuaqg52wRVSwkJK6kRdXN6uPM45dmGheb0dfszmfKqqtFW6r3pfq5VLxX1jT6
	BKfPVlthHyzfkqY/sJuvEdXvCKxqoZkQ8B3gMrIFVnn0a5+ahcICmcrqzv4RHWNtJC7VsmV+w3m
	GB0ehHUZfjCnDjk29oLrg1A==
X-Received: by 2002:a05:690c:4903:b0:7a2:46b8:3858 with SMTP id
 00721157ae682-7a3be360aaamr56363197b3.24.1775239665801; Fri, 03 Apr 2026
 11:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <20260402211717.3604688-2-pabloosabaterr@gmail.com> <xmqqv7e8lyhf.fsf@gitster.g>
In-Reply-To: <xmqqv7e8lyhf.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 3 Apr 2026 20:07:33 +0200
X-Gm-Features: AQROBzDAlzq06Wh-YYwRkKFz5z3MBSF-ip_Bg8kFJpGkKoYldpdBFsJVoTP0B5g
Message-ID: <CAN5EUNRA-AAh2sKEV6Gff6tHpv=MANgZ4MdmH7kdXhUJh_sRVw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 1/1] graph: add indentation for commits preceded
 by a root
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 3 abr 2026 a las 19:55, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.s=
h
> > index 28d0779a8c..0333fea95a 100755
> > --- a/t/t4215-log-skewed-merges.sh
> > +++ b/t/t4215-log-skewed-merges.sh
> > @@ -370,4 +370,140 @@ test_expect_success 'log --graph with multiple ti=
ps' '
> >       EOF
> >  '
> >
> > +test_expect_success 'log --graph with root commit' '
> > +     git checkout --orphan 8_a &&
> > +     test_commit 8_A &&
> > +     test_commit 8_A1 &&
> > +     git checkout --orphan 8_b &&
> > +     test_commit 8_B &&
>
> On case challenged filesystems, you cannot have a commit "8_a" and
> "8_A" without being ambiguous.  The CI failures from last night are
> all from Windows and macOS X.
>
>
>

Okay I'll send a v2 with the "seems_root" change and fix the names,
hadn't thought about it , I'll make sure that CI passes, sorry.
