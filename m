Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7D4A0EEF
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437546; cv=pass; b=MRqtufEGPJDU7HyQQryvoYbLt7/MScjSh7T92Ve/Q7+aSLyZlGXufvp62wC/dqnWFPl/NPcyRseeSi3Vx3Nw8udm0NbPn8A1M4hwxqnCuhG9MlLvhNENLPNLjcBfNCq5tYv0V0C0rG0J03uNRwpv1nHL63O84rPgRxtLccQpJq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437546; c=relaxed/simple;
	bh=vBvKlThonxyH6RqrlqTqT1sSlbWb9Z8ExXvHzlI9klo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYmBcdrUDkSmpZUfn6Yw59J6KpmliU49Aj4Dc00WfSiyBrNv+Q2/6+jRd9k0h3iH7F4g340cE50PR960NIbAy/dMaUz9DaHjr8Z1d5xCLJ49sokaCi4IrklwX6pzZEchfvl+K2IqLf9EVqaLh49D08EkICqiA0E3HF75aB1V6bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=qtvOnqH5; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="qtvOnqH5"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-86d43cdee51so20987027b3.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 05:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788437543; cv=none;
        d=google.com; s=arc-20260327;
        b=OD1mgVgHQ+5dTyYz4fQqyJ9zqsDjqwEERbr+pmQEB7Z2UbaUyCz2I0wH5eZRfehDT4
         CZa9ecxc5JWd9yb9ZC1SglVy8ZrqFJDKbuGcWrSEaUsE4pn29ZOi/uNIJvoM9UpxeUn5
         ZgC0aI5siheW3TdhHJRQeuliuiL6GQB4MLr+ev7EiQ/W0h+UvQvHMIzPBYpzsztVMvJm
         8LcdWbi9mudS/d9Zss8cKtDmSWzg2VP6U9TokgKZ70ly3bXys0lHmjglT6D4Wr0UCqhj
         QINNGtHbwCZMstGoOSo6XwLvurUpVS/ahgjL47mR8f4XhxioTjhkqOcYyBQ5/1U6wLdH
         yc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vBvKlThonxyH6RqrlqTqT1sSlbWb9Z8ExXvHzlI9klo=;
        fh=ezSqOIm+jGYL5zev7YWtoj+HJD49ADJAzck6fRI4XZU=;
        b=dveW8M7I6q4wLYyBHBGNYprXTODYN4b0C/nlURNNxpaVy4mr6rCDl/8DFSlZGaKSKw
         xh4rq7PfBq4LZayOBfaVjbPi/Saoj1epqXsV95mXsFYmjoxBdwxniGl8E6pQOmCgfrUA
         S6BXyoOxFP8RZORzrASuyOiaa9/RisESbm1lDPCGlsXlwOe9Yfj/2XzE9kwtEr/sZK9W
         cWAf338XmYc+dT752S1SUP+mY5gksVgJC0LvIE+69PSD9mLhBlxiFHG3sq2fAy6nOfii
         n9nFuVv7tGPiVnj5qf1yj0eacou6SmbvWQpSABo66blbUYt2+7+9C3Q+t2IxpWsJuVfD
         mKFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788437543; x=1789042343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vBvKlThonxyH6RqrlqTqT1sSlbWb9Z8ExXvHzlI9klo=;
        b=qtvOnqH5OM3RFCIOyfDkhgq6rvyNKLod+XIkhq/rdsTN3JHex1YbcCam7hW2phRTN5
         +9yNKwkpPYXhoVWj0BcQOgEzXHhBE9uBX4y12569YUWrXHMrxbGR/RQYmmkyAtcgzVqn
         CCVcOqsGWhNDJAc7aoj861Txyv8xkES75MG6pg4FaVlybBzbmVeWvTpS3kDiCud0AlDO
         w+rb09SMpRcSYIi80Vdsbxg65khCcgK7RNGvcKIGyM3qliLtz/r8TzVPZfkaFMrhr/UQ
         /+VMqQCYN0OY8wquhxwm1n8UaanQUKm1oRrljppX2ZFGVAGZGgv4LIuakkjyCOlB2dRL
         AK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437543; x=1789042343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vBvKlThonxyH6RqrlqTqT1sSlbWb9Z8ExXvHzlI9klo=;
        b=BX+Vy4oN3lVxfyecqPjYd5q/tM06MwZ6FbyI1jY5uae4/JoSGvRu5QJInZ/ho4Lc9j
         xkpGqSJglxHBOn2cruNJsaFdQis2iCEMNPJN+vLx0rOtVgUf4QR2GJ7PFWihnHXUg63H
         I4nvT/qWRDEDGe5at9DJ7XNXkXHNA12gHoNxw+acX3CV85TqSpXB7X8yTwOQ8eKWJ4d4
         GVaLZaWmHX37IWb13XDL/BjDQ298VO4o5To/n/sr9vXcU9WtZL4V4GLOnjGJzY3UTGGn
         rBht3KfW3FCmzIMUIe7d2Yvx9C2LOI+SHD5cd1B96RvsEez1S90jSFFF1u2EKGcZLzLO
         rFyg==
X-Gm-Message-State: AFuF++nBrw6PMUYTYee4XbxYUGlf7fTsF6CDByODyfNjySlLQ1WxphVe
	tCfJVtgpjZC23/MFzg4saoHH5uOrWjzDbb0YmHrR4/rxxvl27OWnfZh4ORrEZA2O5Ju6Tjk/+W/
	+jFC6j9lGL1INprE+NXXk6EAE8U/YEeKUppGht8QQVLozvfRmBAvdj6lzQvK7
X-Gm-Gg: AYBFou1wZ1c7gwXmPTG7cet9FupVIgGBlAsF+2lTnAp72+QZpRV+Pihmpyg1M16t2TS
	DjZjiHMOtAbOTUDcj7ziHWg547brve63QFxtrrJqkbbITukjaOAnDT3p/WKluIR2+rFK8zsHUsh
	9R3QPyHDULp1q3n+s1Rs6tB+lfu1yPONGfkX5jigUbfSetWYu6GwQ9fmtrKwt0A718mpgIip54K
	PebwHCR5Ok9ux4ZFMA7vZKuJVpYpvVlWNfo1pnEArv3O+s9Rkb3AaZ9XLzLVxx7bNWd4z3ht/RS
	+jchHX8qePa336gExpCSomoRf2N9qqHGhQqXyiF0ykNlF3JpoyvTPEOJ6AHJQ5a5N3YD7EY/+zV
	YxxI=
X-Received: by 2002:a05:690c:1a:b0:862:2e2b:8639 with SMTP id
 00721157ae682-86c558be269mr70257617b3.33.1788437543024; Thu, 03 Sep 2026
 05:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
In-Reply-To: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Thu, 3 Sep 2026 14:12:11 +0200
X-Gm-Features: AcwNN1WxPMm59Ije4v8Jn2J6K3V-xAz4DUBlOem9goXc5f2dnvHs-SsBxbsjSaA
Message-ID: <CAA0xjtoUzHf0bGzydZ9PR=sgz=mdA=4pDDkHr5uJhv9fT9ShsA@mail.gmail.com>
Subject: Re: [PATCH 0/2] builtin/maintenance: improve heuristic for "rerere gc"
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Thu, Sep 03, 2026 at 11:04:56AM +0200, Patrick Steinhardt wrote:
> as reported and discussed in [1]. Thanks!

Thanks for the quick turnaround. I built the series on 3cb9185f65,
t4200 and t7900 pass, and it does what the commit message says: with
the default of 512, a single stale entry in the sample is not enough
and two are, and fresh entries never trigger it however many there
are.

That takes the gc out of my repro, for two reasons: its 20000 entries
are fresh, and their names come from a counter rather than a hash, so
none starts with 17 and the sampler never sees them. With 5000 real
hashes as names, all older than the cutoff, "git maintenance
is-needed --auto --task=rerere-gc" reports it as needed again, so the
repro in v2 will look like that.

Tested-by: Thomas Bachem <mail@thomasbachem.com>

Thanks,
Tom
