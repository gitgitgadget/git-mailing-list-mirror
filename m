Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9E70813
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819608; cv=none; b=drYGq0UdZpeB+8vPOruv5PNCeE4mc9zD7ByUoX55JwJTt3oFTyFayA9rVFXxaN9ou6s7kycggiJXzdNPPyBUIdy842PHu4uzk3d0jhOJiriaDNrBuQoH1TgkMcCTHZc46FYwNcsMyJjDUZfpiS6BQkVDjXbDvr91Fa+/8Dx/ACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819608; c=relaxed/simple;
	bh=y6nQwYSBndJ1ck0+6qeeNco2LbtLFrn9muccO+ZYqFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJV5lLBGsKwxwXZYMarHpiZA01ASCoFs1JUIbRQ1yAxXK+nzmtObbFL7J04ss9XnO4FWurm2hK18gHgA4vgzYaA9bY8N8klRiD+c2JkdhepOOBPp5o91gEibs/T0/emfnw8Fjal/kERcqaTIHmBT/qnxLiJIu5Ay6OYMQUiOa44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIaYHwVG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIaYHwVG"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adf34d5e698so55919366b.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749819605; x=1750424405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6nQwYSBndJ1ck0+6qeeNco2LbtLFrn9muccO+ZYqFQ=;
        b=ZIaYHwVGZvFcipxFtmgjLv8W9hthAivUSLEWG4iaLWjzMxyeEDZgMgBP3cZLcEVJJQ
         cPGO0I8Rjl+l9kmoKyu0b1ovTPHYR6f4F9I/KH5Rfq4V/UET+5ipNw3/4Kv+3JrPONhi
         wAYyEW/4NOFrmPs0DWSPDpJCU8k5TfbsJCmBP8Kn8uKpp7q+UCMI5YPFI0mgLCN8z4op
         w3CqMmF9EUDVfeZ7z1SNf3gZzFSgRk2FmXXaLhiLLVR4kXl9mKryk4VzJPUCSFvRbHoC
         6ekxJUQh862lzHuaAqEz4qAIZgQ4PXZRr+E9bw2vmdkzeKfkkbYnIG7L6lKcV3lEHrV2
         xBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749819605; x=1750424405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6nQwYSBndJ1ck0+6qeeNco2LbtLFrn9muccO+ZYqFQ=;
        b=T4R2rsDhHOs5PHLEYj7clVbhUYGHObzqQQNsrhJS6/QbQ8Tgd6bqrrGQZmVoHHVVPn
         enpWCMh6QckaopJH0HXgaxl1SIjqhfnsbi2iYyk6CRWB3jfQCAdL0XxLHJYxZi9uF6FH
         r/Zm6iX7PDkbyPBdB3edoqDH6E0pHPVpiYnkZEvlXR2jcnKv/CwW9zl6+OKiDFDr2GWE
         biBWms4W4rBIfBXBGX1JK6o9fNT06x51wlHdKMsQ4kISnw+PvYbnR/YpZK9WEdCjAw+8
         uFiLxQ615Htn/vKYiRqCQT+/d8Aduo5rpmG/y9wMLBemzh+B6eeE7bofQM3zsjilnSrZ
         AzeA==
X-Gm-Message-State: AOJu0YzxmIxxqJrX3HvPuZGpdIqB3HOj2T+de+nyxAGfeb6vH0k4HPCS
	/HbS3Ol31XnyBrN7iWpxLyON6SGZ4+UP2JI3WtFysZeTk3L0YvM9qsuo0LFpNT9n9y42c2fn/xY
	X7QRsZyuKO/8vGHEedHPrztOxGNMp7z4=
X-Gm-Gg: ASbGnctIgflJMcDrkDsJsRtFzxi1qy3SnyHU8mQ/1mzFoedAGDz/nqFBbiTJWLFdb6t
	Nh8fARj4MKLaadi5KqmUHbtUjnC1BJhGQp7Wicmkysi5M+a9VNglIjJ8Tsg9vaMlaJUlqdazbh9
	dgHQUy914aycuyYGPAIBTAjQgup9OaidHytwPgZ3f2mXln59V+6m4buA4t
X-Google-Smtp-Source: AGHT+IEXAORKwMq7Awf7YvyDH6hAcHCkxVMDmDtGbcrVK47NFQeUUw8E4HSWV7XdMXTZOzVobpGefWFDAX8zI/BCDYc=
X-Received: by 2002:a17:906:478b:b0:add:ee2c:7307 with SMTP id
 a640c23a62f3a-adf4c6f7f4emr72021366b.6.1749819605154; Fri, 13 Jun 2025
 06:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611062643.8639-1-siddharthasthana31@gmail.com> <20250613115750.41205-1-siddharthasthana31@gmail.com>
In-Reply-To: <20250613115750.41205-1-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 13 Jun 2025 14:59:52 +0200
X-Gm-Features: AX0GCFup420r3V_B_TTU_apQ3hrTvHF828wZ0B6sd68ptszmirUL4FrXa_O9MLc
Message-ID: <CAP8UFD37rFvhO_XLhSjZNoOQ_ePwrrALYBcqKHfhMKcpqhkP8Q@mail.gmail.com>
Subject: Re: [PATCH v2] cat-file: fix mailmap application for different author
 and committer
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git <git@vger.kernel.org>, viakliushin@gitlab.com, 
	John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:58=E2=80=AFPM <siddharthasthana31@gmail.com> wrot=
e:

[...]

> This bug was introduced in e9c1b0e3 (revision: improve
> commit_rewrite_person(), 2022-07-19) when the much simpler version of
> commit_rewrite_person() that worked on one "person header" at a time
> was rewritten to use the current apply_mailmap_to_header() function.
> The original implementation processed author and committer separately,
> but the rewrite introduced this loop-based approach that failed to
> properly handle the transition between identity lines.

Thanks for adding this context and improving the `sed` invocation in
the tests! Happy to stand behind this change too :-)
