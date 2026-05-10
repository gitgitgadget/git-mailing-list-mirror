Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AC335066
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778457118; cv=pass; b=uG+vcgGN2PBEK+bJJ8vKAzpsySP2RHeKpwjQhJOjKtPpq6AVSdSdNyh9lCLkg+HqBg9WPGB5jznjp0jDjVgPdrnDWlM/UUf5/pTgOo/lDLw8Mn3XmrvTDhWeDeGMLQjfuumyoeutIGp5ISvbP/FfS3f6Dx2HQa0YFj4moXu/FW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778457118; c=relaxed/simple;
	bh=tBFR9P3yQ1lbf5KIB9uu4X5R/dq2SCbuA/p596fI6e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oorKr3isLU4uUObT1G0PFoJTY9pVXO+XQ3yc28/PCodpUHZttk4E5mqK5zgLuBIC0caA44S8CSoKuJNBftLddPYqwfb1GgJC2EERP1ItHJqrUU2CwQfHwX3eP023KU8QAP6wzYp7B1JL2+fkEelxlXTMW9+9UOhv0l3gLgSWCfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7VkhtM3; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7VkhtM3"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393a44854d2so28551561fa.3
        for <git@vger.kernel.org>; Sun, 10 May 2026 16:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778457115; cv=none;
        d=google.com; s=arc-20240605;
        b=j7m1xQi4sPV0ELgkOwoR+OdtLbA/1N5udZu2hoj2fJH/fmwtORaW/XICh7P8BEF9fD
         flPdB7timvnIIXV3hNpFJxd7aoDajkeWm/gQmaLolP3tgWrDW3Lj+9Ar/185DrU2K9Wz
         O32zYjUp0qOnMxl2wnVvjAf3Z2n/WYGk8o26E7kbovbwVrPqFuQ21DW7Ne1+6RBRIe3o
         kW9TtWszh1rExIcvNE+IKpT8Cy2ptNz5r3wm9XwmFVkYjUKpJPLyLbzhgBPgORnthyhM
         TcnaPFUk0Z7Y3i/kcyexdoWQSCa+5z62nxNMv3OejSakbWfPBoLPTFu9rhXxVpWavbuW
         0FKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBFR9P3yQ1lbf5KIB9uu4X5R/dq2SCbuA/p596fI6e0=;
        fh=DOj4aov6QCZNHIut7J9bRSVLpYXeERrLPgwttad+t8s=;
        b=gxiJ3wFmiOwm3/etMDcz3LCugcmWmzY3FkaK2ihsdnUqO8yu2dy/oZ+HCvmCayvl5W
         Fs1OajzeVd7W4nPXg46hixg52gLHlI72MmyeODX/ZVI2wJfVM/1SdF13xaU9kbfievdc
         R6/SeI98ENR4cD+R7ub+cRwBsJqQU2FrDc7PfBTtnEo6O2ZVizcbphfRT8PV1D81Wllr
         k+Dyby8ncB2oXsYSGVHN/Dc40v0x523FWcdrS8JOs/MctLxvZg1Je4cPYHZ4qD2Ctiwf
         Bc0FY/KHflai7bYkd48WkiWkJiHYWm1T4YvU1YXaicqgYrerZa3+EJRJKHB2i0muifcB
         OHdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778457115; x=1779061915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBFR9P3yQ1lbf5KIB9uu4X5R/dq2SCbuA/p596fI6e0=;
        b=U7VkhtM3flxaDrTy+CuPbsngQL4UtfxKT2drae13v65aAA34Ty8xZWlApdGWhv0uZ8
         3xmz3lfKsGysrCw2vSyjZYcP5DPNGHuZZ1Zq08jOO0Rm5d0f7CDno7JFfWdEefgJ2M7t
         2hd8xbbtk8CpYNYdcK8AZjxHoI0SwThj22T7knn2nJU1+WCN2SydFkVAqhRoF2ba3EQy
         W4tiaFsy33/dOpEyklLapJFfmw0AoJNFesUAhSO0F70b2jepa0uX7ISq4nv+NBqHUp9f
         9CE2ZzUvDbwHEg808yeUY6K8TGdHwf3I6DJckz/wztSk36JoHlou1Rl10UcGNleqEV3d
         BR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778457115; x=1779061915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBFR9P3yQ1lbf5KIB9uu4X5R/dq2SCbuA/p596fI6e0=;
        b=r1v02Z21O1YMZwwEUHKNoAqxs5UsV+66sfsTpo1AnYJsu0dvdzIAVwEyW+eHwc7b9+
         SnUYDLT7iZy+NMVlx1+8Fo0fsZDMTZeJ691QG4exl5hD9xWP4LgKMhy++7v2qKf3q/X6
         unKJXSQCMi4d6Tl1zAV2YSwsLCCcuzlsl5f+acrC4TguTsY/+Oek9TEX+Ez4xej449a7
         GfjLnCuTEEkyemYBt/oaFeuaLJMbqPnfNgShngodRi9crOYV+sybwgq/RDrS802J9sms
         B0yyEX2YOHQW/jkIWsrou+F+5DSWVVELDnr6sRPDReBvWa5LxKYFO8t5T/u6jU0VMU7k
         96oA==
X-Gm-Message-State: AOJu0YyjLWubvDRziXnlbHrUvybA/4HAeY7449JlAMVlVqb4IUJUHItP
	Q09ll0I/Fvt2e/ZLrpyu7m0K6FsAST0l7EO+9sN3O3oV7oS2MCOF3XUl+vnaTfJ08jRnjslM1+u
	8SXI+TW42oPvqjIBDqSwTW6hB6uxgc3U=
X-Gm-Gg: Acq92OG5mVrhEeTqLeJMOrxKIUUj2gFYMEd6Y6Ewt/ufAnesc/8nQCwIvCIalTWcVwe
	it31omxnfUOvWR0uAzYlpL15WUoYQTwioESiR4kbgN/koOHjo9RhgB4j/g23vMdCF9RkjOqBF0A
	pogrsOC/06XJORDDgTodyN+3wNzb6HOpTMz7f8fi65A/zscX7z6JfLHL32KfZfXe+3pEdAaT3cR
	eAj3Mj+O6SSLF7VxZ2sIoHPJc6ig86oVgtEuF1KBSN5nbD5AWa1B3U+/kqGXB6nhAN+9ivL4nSu
	TdG3zcZ6A1rS9q5kYRFx0DddCaLWLF6nLisQI2fpz4SzT7YAHJtYycU/94IkmeBtCy2s5JERhzV
	MmXTYjWfaLIIXY2LqM7zL10CCT3f+/gj1EE9amdfh8v1XIR1nFpA/
X-Received: by 2002:a05:651c:41d8:b0:393:d1d4:9d9e with SMTP id
 38308e7fff4ca-39407e53a62mr22524621fa.0.1778457115154; Sun, 10 May 2026
 16:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
 <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
 <xmqqecjj9ckc.fsf@gitster.g> <CAJ-ks9nb1pebMLqZ+GunkXLSMYRb_RmpDuBDrDsgJ+6m7nbzMg@mail.gmail.com>
 <xmqqqzni967o.fsf@gitster.g>
In-Reply-To: <xmqqqzni967o.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 May 2026 19:51:19 -0400
X-Gm-Features: AVHnY4K5k1Z8TRkX3QXgcUPVDgswkjqyAH0cCRavSog2CEMePWf8gdfhlo6Qvs8
Message-ID: <CAJ-ks9nVaq-hMC1MoiiUTxnP6_TZLteL+Ri4x-OKsx4FXkq4hA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: git-log: clarify --follow options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 7:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > I will reroll to say that `--follow` follows a single file beyond renam=
es, works
> > only with exactly one pathspec, and that directory pathspecs do not fol=
low
> > directory renames even though they still use the same traversal mode an=
d can
> > therefore show a different set of commits. I will also fix the subject =
and
> > option ordering as suggested.
>
> To be quite honest, the "--follow" option being what it is (i.e., a
> checkbox option to claim we do support such an operation, without a
> serious design and implementation), I'd rather see our documentation
> being more honest and do not claim it works with pathspec at all.
> When you use "--follow", you have to give a single filename, and
> that file is followed across commits that renames it from some other
> name, and then that file with the old name is followed.

I certainly agree that being honest is the right thing to do - but the
honest truth is that `--follow` changes the behavior when used with
*any* pathspec, not just when given a single file. I attempted to
capture that nuance in v3.

>
> If multiple histories are merged and if the file being followed
> turns out to have come from different files on these different
> histories, the "old name" the traversal is currently following is
> not kept track of per traversal path, so we cannot expect the
> feature to work with anything but a linear history, either.

I'm not sure how to reply to this. The ground truth today is that the
option does have an effect when used with not-just-a-single-file, yet
the documentation does not mention this at all.
