Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E62502B9
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899660; cv=none; b=Oik0uixDXkcvSapx0T/upuE8Szkj4lLc2ddxBG8VB8LU++pxvjLAiK/gSSLLKr/Y+JpJIjk7xQDHPJ2fYjOemc3u6DxgCduhUFpVDfeAhfrWLETnAvXl4aVsHWRO/uTA5qDBGnUBbNYqMfe1o2Uw99Rnq97fx3ugxiuUXBsDkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899660; c=relaxed/simple;
	bh=vWSP2CxFVhW8+kCGp6lCP4XmdWIXNYxm/A5a4g+yMfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAQk5e9Ax7O+Ji95mx+T9MpkWbQIjjgR/G3GfRe7GBe9vfQzbFsrY5CdwxFm3XtUdy05cSfib6uRmRmoUmxkQv7iPuibXQ+bvFB5ICA+vsZWApMr9x6nFaD3iyyps84EALjA84L9v1MW3C2Z14dimELg8LRhycmdcBFMUryFlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFq5B6UN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFq5B6UN"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaacaso95677966b.1
        for <git@vger.kernel.org>; Tue, 28 May 2024 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899657; x=1717504457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWSP2CxFVhW8+kCGp6lCP4XmdWIXNYxm/A5a4g+yMfA=;
        b=nFq5B6UNjqHge22+wCOzBlDFFEdyr21A+zk/f3HWfjd6jZkXVpwoEOj2nTbxK0kYU3
         x2OY0rnnwn6jNatJ4OAQiKvVG7KwG15spfRK4e6RAPVHtMOB7dwMvAjGr3mwfYBizjBG
         JJaRwoLohNOieN8+SF3maCLO4WT+DwubaTXj5Ky4TQHsuD8P7aCyG0X+Jr3z3OnZArRE
         x8DIOaOKxIEGRDArne/wX2lI5D3c+4EeXbznNPjUl2eplPGrjwPia5T0uTSxfqWKFRFm
         LmGsAqePDKWNPNpiSVfKsqdR1mjpSu1HyClyeJHz8/LEH4xo1Y3wyjXiPpVOuv/rRrOl
         3QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899657; x=1717504457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWSP2CxFVhW8+kCGp6lCP4XmdWIXNYxm/A5a4g+yMfA=;
        b=vzFvol4QMPgJ4fAUhn27FTuBbpiBoi0Hccx5Jy/ONiej5O/vnceoa4wjyyD5DI7r9E
         ROr0Hg7aPczNheWwwjMVyZdVGxqodLidM3BW/yl7IT89Wl4PZZPG+opfkF2ZrXdRPBpl
         GrtAzXZhHmRg747ClbEDtT0yA7xhxRE8hh8z4HhZY7ry238dUnKEHFtAYctxlOu9cjD4
         0imXBQ4ZabLuRJivW/J8me9wHMOPlkDMTZMukTrhgJqtMyIHIMj71izQlkc8UTmBXUj+
         pK6tJHeFBsTL7q2zD7GTLR01FTN9LoQIXrHUlM0m5Tq5Vx6WezmR3Mttb7cZO7oaNNzN
         b3pw==
X-Gm-Message-State: AOJu0YwCMN2Vm9Bq4ZQVByd2jfDmYL5glFseubVmTdFx6S8ZFK/5tLzA
	YMoQIsevqHv8/SxvyYNelS2tBlaa3vG+0Uj9i1AehhBz13p/5/iRyuYcGc012bPxFnN/YRRhxOw
	43TrzrQtbmkBGZaYQ0AvaH5ZqKOE=
X-Google-Smtp-Source: AGHT+IFm3FTnhtB6Vl0SNf4WbrbhRv7IpgVoccEBUAF5SNtQiVkopkiIHLXYr068lS4EMpuNjtvNz8/aZKt+r0On4vs=
X-Received: by 2002:a17:906:874c:b0:a5a:27c7:af4a with SMTP id
 a640c23a62f3a-a62641b3b0cmr765620066b.6.1716899657029; Tue, 28 May 2024
 05:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528113856.8348-1-chandrapratap3519@gmail.com> <20240528113856.8348-2-chandrapratap3519@gmail.com>
In-Reply-To: <20240528113856.8348-2-chandrapratap3519@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 28 May 2024 14:34:05 +0200
Message-ID: <CAP8UFD2ObwdQVE9Ta+th6O-FC9cTR8sNxsrSQWBXosjP4ccqSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t: move reftable/basics_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 1:45=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:

> diff --git a/reftable/basics_test.c b/t/unit-tests/t-reftable-basics.c
> similarity index 60%
> rename from reftable/basics_test.c
> rename to t/unit-tests/t-reftable-basics.c
> index 997c4d9e01..b6088e1ddd 100644
> --- a/reftable/basics_test.c
> +++ b/t/unit-tests/t-reftable-basics.c
> @@ -1,16 +1,6 @@
> -/*
> -Copyright 2020 Google LLC
> -
> -Use of this source code is governed by a BSD-style
> -license that can be found in the LICENSE file or at
> -https://developers.google.com/open-source/licenses/bsd
> -*/

Are we sure it's Ok to remove the above Copyright? Or is it safer to
just move it over (and perhaps add our own)?
