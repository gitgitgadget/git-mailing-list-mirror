Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9B3CFF4A
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813659; cv=pass; b=fQKOddeRj7LhsePa+kd6OhcW9XaLTxH3jMD3BFR1Dc7lFG3fMDS/rH/DCo/E28DXh0AsHY2U9Hh28xk/6bqPzj86L901eoGqPYxOOF/5isynBookJ5stImrPx64CH3Jm8Y5Vm8tO7TkEIyjletl4zKibns17rvxOAEHM/7fDigg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813659; c=relaxed/simple;
	bh=ZEkRLw9//wlOJxvkSh1lgNLNRZ8LLDEdQ7Van0IQsFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcHMbheAG6LY5cggTeRfO/zGEL1+bkSnuWo0Zbsyet0RFP+xzQ+paTYX8K379rwUah7lenmVrwmYMIZX7LVEhluktCQQJfHPjec5dFbaQudv1UNXHRJFpZOWTlyAwelLapeVo+WJASEZh1FydLpCsRpomLGE4A70MjekM1FU+Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS+lPbmP; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS+lPbmP"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso29456991fa.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779813655; cv=none;
        d=google.com; s=arc-20240605;
        b=OAjznZ1PVQRKOafQhbQy6GlmLxu69Dkr27zVqsY0I6Auf1ztj8Y2782laCx7TyupUJ
         /PhVW3mnbZ4tFe9K+OXt5vu8qBZYpMIqIgjqi6uvsH5ta2lhaGHP19JaSGL1T8gHekUw
         BD394uedw6a9UHQsUE5ZM6OOchDEfoN1yyHMcUsqcimx/3IQAOIzSu+HhKP6FCheERVj
         bS9IL2N22Ko68nBbhdOfEGu/EqOf+zfExbVpgVDGrDlBxkoMjOauPBV5b60QXJAqgHxh
         2luiEgMzS4F/bEdOTUczfOJz5ZER98m1TacJ899olURvQZFD9S/CyUEc0WHwChfQ0E2C
         TT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEkRLw9//wlOJxvkSh1lgNLNRZ8LLDEdQ7Van0IQsFU=;
        fh=u9RykvxT2ItQdvEri/ONEGmMsjP6TH4HCaHOnuQfx3E=;
        b=j1rdN2CaTCA31/PsytLUmEIMPLtN3AaQz+qfjEbFjAX4qkdDOKglD2Q2QHxkTBsqbO
         fWBXb6/jI7s8ZI4Ry/xowm3Cm2hBY+qh2m6EWgEc9tqIjICpt9xxmFTQZ1GRt9FQt54Z
         aBijRAeL9t6jhbRZZxjGRoVwqEN8MwM/M60NReHA5ljSZ+VSkQUr0/D4I3pmMdqtSphf
         om7UODk8FOUNwnFX+LDMoxPDMRUKlAXPd3Uag6C0ihmwZonwMq/U/O2Eh9BX+6P5pGIy
         s+Inh2uyzOSsDbsVBvQoYCJCexTn3Elh9eGc8K2STocuNBN0qHWqCvFqTo1IKRDC4U3L
         qCSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779813655; x=1780418455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEkRLw9//wlOJxvkSh1lgNLNRZ8LLDEdQ7Van0IQsFU=;
        b=gS+lPbmPY+2C/4vuuC/pm6MnOJJUpFL5B+AhsZewrqm4+zFhg1HqY2xIFPZh14pKrP
         GMN5axLDD0V9ia6UnZULWJxyDq9L9GJklEZjC3UqQGK24lVZ2rbYbfmiJgeXp0Kq3PvD
         x6Qrn+7Q6QU4tOutARz9SRt027Okes2QJnJfCNy8e3nizfOZ7RBY9vLkI9TbChbipKBC
         qSJ+qmWAx75DK6aqh3OA+bMpj3zmLkvZZodDE7xxv1FS9+GiPap5oyBrJInItqWE8Muz
         cSGwZmSEIXpvE6TVGgJkux4HHViAcmQxrmqFPQK9aEA9T2o0fLlSwyLQBmbwtP6rRgry
         n3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813655; x=1780418455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEkRLw9//wlOJxvkSh1lgNLNRZ8LLDEdQ7Van0IQsFU=;
        b=N87icmqwm8qzHsP2MQvOaLpL91l1wWOG2DYvPIW5yPPG3TdRxDswOx1JVcjhaooYn/
         PQ81idw+DenVRGR5YiFi0p2dYvkbgraC2SOqa7ksLylpDGZZINKIZKSBfVe8N6Y6q8my
         eDF20vhvtfIO4ERNMM/vRGryXoyFb2F95Go3ax6VzHbL9lm/MIBh5k00PSs476Ha4f8Z
         6ijb1oFldS+eZdznTavvJirBI+PO8NjXaaETLMpaKytfGlR/ZMsLrK5ogxFCi9EWSXuQ
         oRr8iBfjB71YjZdyqugthaAL7/8R3pBYfst2Ad0M6Q6Uh92yLQEpAnQdbUtghvwWXUlK
         Ilxw==
X-Gm-Message-State: AOJu0YxSkn1GaucqmDDuKW4fnhnl8y/xGIv1rzYg2SLYQYO7XOQh8xqS
	V5UubJVP2ZpdKdAfic+X8fKIacDuP00STiwXqdrWaiwc+VIBqqy9bvPRSpJ3HufPO7p6laKDLPV
	svwCUVV5lsIwXgidTQ+Kh+SVx7enlMOw+yVUe
X-Gm-Gg: Acq92OEvstm77bEWH9n7UyzMNmWkfA2pVeGt4GiMSpIfyNduSxPbiqr0F7J7zF97awC
	uQZ2ycJuY0DLkMlcKFcEcK4AWpP0xqHH9kTpFUXJnesFuZqIg+mJYQ9mc1bTSjq6mF2j9kC9c4s
	qPBEbY4TB6+VN1wDsoDhbkV4YyaeO+/BBM3bawjYLzdNkdJMlSUbQijgQIR383XCqxfhn0VG9tt
	/zsgEO/9jl4aiL1wCY+qupTk+sE36wEzKA0S3oFsEO0ePqz1YmL2E9PkaD14SMcq05M5m82R6FZ
	+qkdfQnYOKnSfb+wH4U=
X-Received: by 2002:a2e:3307:0:b0:38e:49e6:a376 with SMTP id
 38308e7fff4ca-395d8d81755mr47925071fa.22.1779813655068; Tue, 26 May 2026
 09:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
In-Reply-To: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 26 May 2026 09:40:43 -0700
X-Gm-Features: AVHnY4Kx7sXv3g0xJ3Vsp95VMInOTH1Frv3VCBnclcEqUvZpolmc_oclPYCdUDc
Message-ID: <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
Subject: Re: git mv after the fact
To: Frieder Hannenheim <mail@fhannenheim.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:18=E2=80=AFAM Frieder Hannenheim <mail@fhannenhei=
m.net> wrote:
> I'd like to propose a new flag for git mv, that updates the index
> like git mv normally would but does not move the file. ...

You may already know this, but technically no flag is needed:
you can just "git add" the new name and "git rm" the old one,
with the same effect.

A flag for "git mv" would be convenient (and slightly more
efficient, not in terms of storage but in terms of CPU time
spent discovering that the contents under the new name
already exist in the object database). But Git will discover
the rename on its own in the usual way regardless of how
you get to that point.

Chris
