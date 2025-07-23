Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4DE221DB4
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258301; cv=none; b=XnQChgCJfel2FC5Yk6rsG0awsaPLCFIttrT7sAQoT6yRqUWQ4Xutx/NhX4kE1QZ/mJ9CIv9t2jBpoSyUWF4neJlP30VzAp5ulhkLTMpSYFFzzrDLvsIrygwV/YJXiHORDTi1hHRVVdBc0TFZVbS4f+vJOzXZYA3EYMvIe5pb2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258301; c=relaxed/simple;
	bh=o61AVqJ0b2u5KCAkPia0odKYBAQhCWEdg5Z+MZJTR9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN6spf5G3eTtMVV2ZCFv+k0LOVSpg0FZF0SYoNK5sDSgzyeLXurIyPWQYomr3AejdP70s5CP3gADGaW0EyJJy9zvOxWCovKBDqJqZy3pDjUzMAYshnzD/sTxd/b63nWtlkRVxyD7V436zPidQgkQBBF/wkaLm3JV+gi0pR7omY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70707bafbe0so248926d6.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 01:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753258298; x=1753863098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o61AVqJ0b2u5KCAkPia0odKYBAQhCWEdg5Z+MZJTR9w=;
        b=NEgOn3SEJGaEyKdgTJO2+RK7+73Pit4mL1hPBcfVQwiMxI7d6ubBDSkU1RXAX1Fhb7
         H+mywLldJRrp53RTts2nZMsSbkD1twoO9cMXSKEUYSRth8W8NFm2lfnYnsxUH6Q82JeK
         IC58iyvEYFaJvzYnXMa+AI5Ck1hTdx+UE8eHEVkWcH/lRJnvliESuGzW8C6xrXkei285
         yRUP5BNC34Nyvu9Q0v47knZ5XWI7wcypQlP84Uy36CbopMOBybKuBZ68B49xR/rNTb/j
         9TyOUsxvXIOiBflwYwM/yhoNqmXKWb9UY2A8AkCDu3VL0GZQFyUgrE8nBCcJxAuoffZc
         dH7w==
X-Forwarded-Encrypted: i=1; AJvYcCVCa+DrzEnClPA6JJV0cfPoF6UzNrcHv3RFoHvwaslQLbh+IF0+TrhKybLoArdb/vrFL5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxP4C8SxOdM3FOEGFKNX7X+fj0yA3Nen1J/6rZiOHoOycz4+l
	aDM3BwhoJWG7mZAmIPcCaGVMVtlBloFzkYPvcZVFxgwg6tVzdsWvfC+cort+iS780mhBHpdaAVK
	ym22Ef4bjLau/Mkz6VjlEcVq8ZpVXd7w=
X-Gm-Gg: ASbGncvCZTykLtKoxWBWIBW4n+kqLEyFI+YvVoyltt1zYn+zT1mlgvsLO6T1Wo0fski
	TlGe6GsV/RpGDzs4UU+t7o5ubjLjJW0jEjtMHZ/LifpIFJMZNluIeNTGv05Da6+djWD1xyCZ8ZU
	Rpjft66EWYVAYs7CORj51n1/+sTOeNVV5iq+/Ia6pTJFOScSCHHUJ3qWOXhJxpM/lz46+HX73ZU
	hgEzus8VnIeKV9Csdw2Re579VbpYSoGfxkvYfCn
X-Google-Smtp-Source: AGHT+IEXyEDjEaTN3LjzKPI5WEBDjcmcfI/w0gpSiBgkFSNyUHdiQxXg2Nd3EPxzrWJRoxJB92j0TnADTsYyANPc0zk=
X-Received: by 2002:a05:6214:1c46:b0:702:c2b5:67e9 with SMTP id
 6a1803df08f44-70700212da2mr11194356d6.0.1753258298075; Wed, 23 Jul 2025
 01:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722174102.1876197-1-lhywkd22@gmail.com> <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com> <20250723075513.GA570540@coredump.intra.peff.net>
In-Reply-To: <20250723075513.GA570540@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 23 Jul 2025 04:11:26 -0400
X-Gm-Features: Ac12FXz33H0hEj6z4GZOzqMXmreBwDRG0r_Q6x8LpuCSer7FZhuuDHzFkOGh5Y0
Message-ID: <CAPig+cQ2p3muA0-8O_u-rOW0uVGQ_ZE7hcz-7qq8M1U+PdvtpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
To: Jeff King <peff@peff.net>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 3:55=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Wed, Jul 23, 2025 at 03:28:05AM -0400, Eric Sunshine wrote:
> > The descriptor is closed manually (again) because a subsequent open()
> > call is going to reuse the variable. However...
> > ...although `fd` was closed, it still holds the previously-open
> > non-negative file descriptor, which means that this `goto cleanup`...
>
> Oof, good catch. This iteration of the patch was based on my suggestion,
> but I didn't notice the jump to cleanup between that close/open pair.
>
> I dunno. We are reaching diminishing returns spending brainpower on a
> function that is meant to be somewhat quick-and-dirty.

Aside from preferring that the patch not make the code worse or more
confusing, I don't have a strong opinion. Superficially, the existing
code presents itself as being careful by cleaning up after itself, but
as Hoyoung Lee discovered, there are holes in the cleanup
implementation. So, I do like that the intention of the patch is to
plug those holes, but we don't necessarily need to be particularly
clever about it. For such simple test-related code, even a pure
brute-force fix should be acceptable.

For completeness, I'll mention that I even had the thought that
another "fix" would be to tear out all the cleanup code entirely since
we _know_ that this function will be exiting immediately and the OS
will clean up any dangling resources.
