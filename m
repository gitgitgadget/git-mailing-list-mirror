Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3215316193
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146582; cv=pass; b=qnP6pqMHKPo89Y4NmHl/5mfZqa6JwojYUfv7ugMRR7s0rWTWZGEakbfXw2cpti9m6/eTyvP31L+OAOUyFwM3ebk5Lu1hDTz00UxyhIKrNenkzbPX98WodkpRnBQCGccSurytr10RvXvAKVX3A/VLf8ETSx6RnTByAbKlAVd3ojw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146582; c=relaxed/simple;
	bh=A2K1RzIjTSWp78Gtlo3G0MVEfyxL482BsaYXUIDv2oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UY6gLxRHKRiL6OvoKDYLn+CXgY0CShtmh8itpL6L2x5JnEu4N6OtJtqC3LYVraqID1VJRKADTC7bMJsvmHu1KRUHAWG6Xqm6YNI9HCuC1k9LicLlIcDhKsvRLF6ND9PcR3K4XpkvKSV34sJEXdl6t4H6LJSoqmzIuPkm42wk/CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUsrrHlW; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUsrrHlW"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40423dbe98bso2671887fac.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 11:23:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770146579; cv=none;
        d=google.com; s=arc-20240605;
        b=gDK6BgkPC1YciKRDSE/8qXCtPDBesaXC1fhtYo/0x7YjW+S86cdY/qzVb4w4RRVBuc
         dnJ3w8jDAN9VRHzCXHYhbp9QdV1LLAJHaxWJUwEw4K67MNbf89kJM3KuRhs/I3TbT0kN
         UvD5tUkI7v/u+nvcAQrKtuGAF4MOJKWzJ1+QW+AUmlSjxyk6Vg6Mu7TCCseJhwkPWEpU
         TwWiL5GXh51nVD5EHpE+vhXM9mntyZU8hNGmF6v1A5Pq/K5Q5FnPpu00VweE3xXFFDIk
         S5jsr2nI/IiydkJPHL07Ecu4kPUPccGBOfLeYO4YJwmUgoqqR2OJWo0XgApMRwpFm2FZ
         CbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2a8+XYc5iKtgQuP4Qsy9WtjRJEu9G1ogDo3bsQZktc=;
        fh=epWJDPL5W/O17OQETcucKGZOPMkrHkOfUb6WPvdf4Ww=;
        b=ifDQtZ7QWeiapN2uiEl7bsDR6KWFMUS/NAeNh+awzA8u8Sa2AocRNaumkDWF1EOKPH
         dEKxEJ+HzOXIbH5secCfqDoT19owztCwC3Ug1sNkoKotHH85f0cmmd3xDIzWIJMKD30o
         qszSYwVqNsyw6a/pWjqp5SvNj6UkqDyg/kmwU0zc7VxcEAvWjd575lmDK4xXMrHCTLvm
         woKqOG/ELG8PcJ4IJpnFrS1rb8z/F7+Lx6XLMZIjpa2sLFVF27JeoQSASIrT2VmXptf9
         jhnh7N4PDTaVYMEHA0iD6of9QeFIut+FCMQZo/x+IYkbDo2gw0Dsj2ql0ynp3zp5s76b
         1Orw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770146579; x=1770751379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2a8+XYc5iKtgQuP4Qsy9WtjRJEu9G1ogDo3bsQZktc=;
        b=kUsrrHlWCPDuvVvy9thsg6o1qQse4m6ZDJ39gzpuZqZKDUqsrE9KdizaMsXfOrRBbh
         IYPiHFaH142W7DxVPDOSnkp4QFTn41JfXDiEOjd3siGvNmyu+rCLZmbVlo+hgUUAArzz
         NUdyILB3HcVL9cRMQmzPLTI4LwcIPvVdcVNhrCUDPHcwLtgavDk3TBZUZAwZwWRJupn6
         qdl6EfvG+iYxebZ6iUQa4wy17hwYz3/Cm8zhMLJeZUoKiYSlz25wNV74Y8KaCdIpckNS
         b3Tr4sjC/eyW3QK6IfkbUeGfE2t3fUYYwtf1YxKc+6dmt/jAeC5SM6C6BWexcKZ1RcP2
         MWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146579; x=1770751379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2a8+XYc5iKtgQuP4Qsy9WtjRJEu9G1ogDo3bsQZktc=;
        b=OIiU45b4DvEwyf4yd9hWykNMsXGZq+oaTs4bk+pYHo1Rj8oMiaXptP6mi18kE0ADvR
         8vQzDf72EixHYjuyicPqZZdfuPd0x1uqtTqJ6FJEPwH/gWseiHFa9XC5EX9bOX9ChhVJ
         wxSH9ag1hCCakcMMhRBoiJl8sw5tpghTt/0I8QbuRAy6zWH4KcyNGYftxl21we/Zetba
         DG6Jnj+Kgez23fDBAHvXowvDJWeUFziA7Fw8xpOaVnDUaaSX89z6Xxh+F97p+v037bFU
         XwSHGQ1K7fQv0s+Q0WS0Ou6FVGqTRAB8A6Duhu099Fqy96C1oZ5yXFWOc2wv8eABgI2k
         vFKw==
X-Gm-Message-State: AOJu0YyEQf2fcJWdShg0myuBmdza2ge+7SHGQ55p4zMblSN9IWggd4Zt
	8CrUUdLO1FVg6XmoTYd/4V0Zoq29Kw7GgPt6MdciNmjtTeh+a1hTPwfCR4OxRvML8dmWrMNIUpF
	dTBeJ1JGzTUFNz3FBzUT3edVEQS+fz4k=
X-Gm-Gg: AZuq6aJ6bxwRgaKnLCeZt3sgVCAsEj7U9ej0J0cz5XX/PkRDwWcD/olQTtiS5/QeISA
	p3CoYvL/vfGR+CH4Um+b/pGsD33v3+u/ZiBTdytFYK8jcVgfsrll8JPBX285Oc2x1HE5DQfMew7
	LNIOrIMLxNQ8XmIdQtHgSPeqva2+70B+8OXOTfBbkhoyNDt2JmTmMpLIirckwFGYOkAR7ZzwOC6
	yo4bY5FWuok2GfpQInQISwIaF22uIZwoGrq8/s/lO3D2Y6zCo3mbauQAG0smQZuQ7zLBCrrc0y/
	3TDYCsKppFT7rpkfo7QH5vUevn+U
X-Received: by 2002:a05:6820:4611:b0:662:ff03:c215 with SMTP id
 006d021491bc7-66a2342d728mr291401eaf.70.1770146579505; Tue, 03 Feb 2026
 11:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BEZkhYW+fWgtGn8yHuLfak+UYo9A_HwdiCkAf5A0H6hBA@mail.gmail.com>
 <20260203181845.602979-1-pushkarkumarsingh1970@gmail.com>
In-Reply-To: <20260203181845.602979-1-pushkarkumarsingh1970@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Feb 2026 11:22:47 -0800
X-Gm-Features: AZwV_QgESAjRF_YXl8nF2cY2aswD8eQ61Ljah9LSbKv4asNVvq4uqTLijLIUidw
Message-ID: <CABPp-BEP=KBKdF-hgMgF0ngJDsBHMehCJoRc=ww=-W=F3s5rcQ@mail.gmail.com>
Subject: Re: [PATCH v2] stash: honor --no-overwrite-ignore with --all
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthiknayak@gmail.com, kh@pks.im, 
	peff@peff.net, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pushkar,

On Tue, Feb 3, 2026 at 10:18=E2=80=AFAM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Hi Elijah,
>
> Thanks for the detailed feedback. Much appreciated.
>
> > What's the basis for this patch? I don't see any "overwrite-ignore"
> > anywhere in builtin/stash.c .
>
> The basis was the existing behavior where git stash push -a would remove
> ignored files even when --no-overwrite-ignore is provided.

By basis, I meant what commit was it based on.  The patch(es) you send
need to be applied by others, and if they are based on commits only
you have locally, others can't apply or try them and have to guess the
details of all your intermediate patches.  v2 should be what you would
have sent to the list if you had gotten everything right the first
time.  Same with v3, v4, etc.

You appear to have thought in terms of the purpose of the patch, but
your stated purpose doesn't make sense either.  There is no
--no-overwrite-ignore option, so complaining about how the command
behaved when that non-existent option is given doesn't help me
understand the purpose of the new option.

> The intent was
> to make stash honor --no-overwrite-ignore consistently with other callers
> of unpack_trees, limited specifically to the stash -a cleanup path.

Oh, so the point of the patch is an attempt to make command line
options more consistent along some axis?  If so, I think you picked a
place where it doesn't actually make sense.  We need to back up and
figure out what the user-side desired behavior is and what they cannot
achieve today, or what is confusing today, and find ways to improve
that and implement it.  Starting from the low-level details can work,
but only if at the end we can explain to users why our changes make
sense.

> In v3 I rebased onto current master and also removed the commit message
> claim about removing the stash FIXME, since this series only addresses
> the concrete stash behavior and does not attempt to solve the broader
> unpack_trees issues.
>
> > This suggests that --all and --no-overwrite-ignore are incompatible,
> > yes? Shouldn't they be reported as such rather than having one silently
> > override the other?
>
> I agree they are philosophically contradictory. I chose to downgrade
> INCLUDE_ALL_FILES to include-untracked when --no-overwrite-ignore is give=
n
> so that users explicitly requesting preservation of ignored files are not
> surprised by their removal.

You don't want people who pass "--no-overwrite-ignore" (a new option)
to be surprised when ignores are overwritten, but don't care about
people who pass "-a" ("--all") getting surprised that all files aren't
included in the stash?  I don't quite understand the logic.

> I am open to changing this to an explicit error instead if that is
> preferred. I went with downgrading to preserve backwards compatibility
> and to honor the more conservative option.

You added a new option and only changed behavior relative to when that
new option is invoked, so I don't understand the claim about
preserving backwards compatibility; how can backwards compatibility
even be relevant in this situation?

I'm not sure I understand the "honor the more conservative option"
either.  Is that a cyclical argument (you're introducing a new option
and deciding to honor it in order to honor it), or am I
misunderstanding?
