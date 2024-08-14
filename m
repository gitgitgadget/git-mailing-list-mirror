Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4241B86D5
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657534; cv=none; b=Qd10bbBPg2tb1fY5lKMr+0ynpZjqnxUR63FPyfGnZuh7Jh0E5GZ4Bug3SRZR1tIoyHg2h3PIeNjfcjhPsaLD8H+6Ssx4QnQ2bzu7rodKvPMhdjmJ2qftjrOmLgEfjnAe9jvjQZikUary+bI7e2MC6HtpbnM8NGqHiPX08ArgZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657534; c=relaxed/simple;
	bh=ZgF93NktunkJmezEU2Oh4Yb6Qk/Tmt6zut2PlByVBS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ2VjwnCsUAH5xJRSfOJMc5ajlB7SYMuDl2ejvZzyhWgThvRY/lhDl663kM6O2xC2mI+yzkMv658A+ghBeibwz8y7NUiP1YxR2Q8plFIN5+Hyq25L+KjyodlkeDyApy6XlmTUqX/ax3/XZ1TwEt5qw9TgHOsypr3418GVLYEkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnP5Bi24; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnP5Bi24"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260e12aac26so95549fac.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657532; x=1724262332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU0SGWYGiXl5n77cb2p15cMEUvoozePAaIHgKVFSKxA=;
        b=JnP5Bi24vBSxKSby7N3rXEdAXtapSKHNiPiwTNt4k+UpNPHwwyrzanukF4nR8nOU6j
         3kbfmX+U114FdrNWFGab7dFlaLqpS24PtEsXlEU0YEQf/i48u0MfP+Fmk13dR1q4JvWI
         L/0aqoWR6ANv0iOwv3KFDi+MEmfneAf6GXnQ0U6H59+FAwSbTuzi4tFP0yroG86MG0F7
         Ml1l8z5WAG9d+OO/eV8pnCWNbLHC2dRPOquM4RcQMWMltVAG7RHLsgxM2ShWXqybPLQj
         2qKKwX55qx4/N6ClFwJuGj9C7NzZbEN3VifG1IVwR9+l/+g0Pw3uflY2II0K7J9XiNJc
         XDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657532; x=1724262332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eU0SGWYGiXl5n77cb2p15cMEUvoozePAaIHgKVFSKxA=;
        b=uDc5fWXyv2bGNbJZ6/l3pth2L18jRbp3o4JHIHpMO/peRyhl9W2c7+ujr1iuOoe7/R
         A5PNoLZrHDvCJYLgFZ9u4N6GC5+L8zZLhGj24ksJHu3yafOVaofo2nM6H/fGRhSLra9X
         SSGWGjf7ILEbSChZRxlh8A5Pp21eIxdyT72lvursTqxGhPM9Ei/Zxk0jSx0lUIoecUaE
         Nef8NjCVBIfMx0dsZiDm1VgcUdknFbqG2pMlYOUsVSDVz4ruGIOa7MPiuW/dIbPqio7Z
         IWyFvfKEFl4G15L3oOvN18iuEuLKDtHMDqqi25IoZhuvSOV8thxXkpIMppxVWNs4Ndnq
         NXAw==
X-Forwarded-Encrypted: i=1; AJvYcCW/E//nV46h12zebqrwyFj3aCnvyOyrSLMSR2u/gtwTn9/Q+la4EiEuVauo66xXYXR4WIWD4Wk3Ze32sjg8qd42f67F
X-Gm-Message-State: AOJu0YzTz/T6gVLuae4tgwLMaAkzrMwTnVz7N3UA9rUSfZc2exJVK/m/
	tikZ8JgkOB9zWgUvcCiXuNlT9H75fnFgNDm3caAOYjtzGQbn1PHPMv2IUSrq2j7kAEx81F4BzG6
	3RPXz5akfTX87JR9XdldPLzqJ6X1OoQ==
X-Google-Smtp-Source: AGHT+IGFgJwtJA2P+TRFQAasxYeU2KHBBLs6bgdVCEoOI5b2czdmfMk84wPCZd5fEYZAHgrbPv2AoFw9mXSz2BvKzWY=
X-Received: by 2002:a05:6870:709b:b0:25e:29e7:14c8 with SMTP id
 586e51a60fabf-26fe5c7ad48mr4016612fac.42.1723657531936; Wed, 14 Aug 2024
 10:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
 <xmqq34n711uy.fsf@gitster.g>
In-Reply-To: <xmqq34n711uy.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 14 Aug 2024 10:45:21 -0700
Message-ID: <CA+P7+xrKBqWVwkFH=WrGoLJbqVtE3AO=CBb0=UTw=E8AA+xv4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] send-email: teach git send-email mode to translate aliases
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 9:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> > ---
> > Jacob Keller (3):
> >       t90001-send-email.sh: fix quoting for mailrc --dump-aliases test
>
> Nobody noticed the typo in the filename since the previous iteration
> was posted?
>

I certainly did not :D Woops. If you had pointed this out in the
initial review, I apologize as I missed that comment.
