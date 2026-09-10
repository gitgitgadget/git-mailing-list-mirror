Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967349B5A3
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078123; cv=pass; b=MoAygBa1K/YbzGVwHpeYfM7rY7xnnZcHRnTXM77TExJfxmK9k3qPdmxkYpC5ihM6a1cynK51+orgng2u5NtmfdJyD4GoCXo231DbJ/TcwRLbG0a84NQx/BOpwI+pZWKqlm7o78StxdQ6eKZBYwChFJzsv1UakU1kIo2Haf73j3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078123; c=relaxed/simple;
	bh=+Pl9YO3S/O2x69vshOV19waQ5vXwcnIvNCtyx7EA0nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqCWYHInOdSQlfqroOJnQhGRPFOI8epHcBIMrwzMZ5iU4bNY7WNJZorlW54ygvobTpvcGS/PeQeMBBk7k9QW+Mv1777D4w+XZJo6wnBCwG6tMedl87Thq3suvTkZwMAR62Mba8FvwOcJBfC4+yfrw3f2wQRPJZ6tXMPIASpHydc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=A2e2hrFR; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="A2e2hrFR"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b35cc0a8c3so346246eaf.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789078120; cv=none;
        d=google.com; s=arc-20260327;
        b=c6ZzcO71WQcD94krzUotB6ZLOwvrMyDlokEr2sJft3aNA8qhykySB0QpPoF16AMEjU
         w9dONddppwbLTnMblnPNeeOAL75JsK5RhoMMWOw5uACkqqPrzXBf9RVAiiAFk45CVmQ8
         B6BP73dGzq9KHSVdrcuvjVroYvVeVyIECtuOEDyxLno/KYeWIXzYzkBWjPe3ec6/DnfR
         CWJfELGIq6Ur5V0wS0JTAcNnZzpzQ1Hkvj+fltzSq6FQW+y1R6KbId4/INEMQriPQQVH
         LXtO0Qnfw5OVXv0K+5uwRCL59XqWov6TG5O2ud/PstEzH6jEWl/xL5EnThySsu1wl76l
         vLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XihY8WJBZvB3126XRVDccTEiZFfxXDa8SOwpqUfj/Gc=;
        fh=7on8cIw3NIZWw4JuZrn4//f1JrEE7LsGYupBvUWTs8g=;
        b=SB6AlGVJwBmMsl/Zy27LNzs+8dz4V5qfze89AtmjIYLtKepabRk0oPIKY2gyD576lX
         kfj92mV+WFxk1bzi5n6yH35oLmfxob5GL606EMoglGM50cmF/r35y5qiYUaUUskTidnY
         PoI+gmaPr8xvpDjX1bilVUV4SKveZleuM0jLZTPn573Kgq0xjduzT4n2rM9cVh3lNn4r
         KkmYTbL9MOPPfhG3Do93z1rew2lXuG55x/9yAym6BnlfSwRKQIhvJ6ZOm6NsT5osv7+/
         YLszk5twfK1HzjK+OJANnU/RHkTKmvpbDufQMEgmtUnXUtfUemWFZq7O8X4yHyVsbtfQ
         z1Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789078120; x=1789682920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XihY8WJBZvB3126XRVDccTEiZFfxXDa8SOwpqUfj/Gc=;
        b=A2e2hrFRyQtB5k5Gwumr59GY86sFCjpjjvEwBbCIW/eJb2bpWQnHfitw1GmAq2iOe0
         Y2uYHL4l3pt1rLmZWQ8OTqOJ2OdcULJULqh8yOir+S46n+5C9ss2I+jq83pk2nsm3UIb
         R4LaX2Er6dTZKjhiqXWQ2W4TopsxbRiFDQiG2vwV7Di1Z+blM8/tlO6Mr7Q0b6UD6SgX
         ovjjYYQOxbZUH/lIUvRW6jRMBRw5WzfY3HZDvh99MK7V2mssqgYJgncudMxnwL/Pzn9g
         H8OJlxmw+TR2ROEyZ0LzaelKL2hiwtN2CN9iaak8RsCbbte/TZ+oHxSiHKCDl6RGOm7y
         vH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789078120; x=1789682920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XihY8WJBZvB3126XRVDccTEiZFfxXDa8SOwpqUfj/Gc=;
        b=Ihc798A8BofpQ0kHXvo8hPWmWP4RcZzNB4hp81KYiFPgfj8gkTQB54B3RJzB8UD828
         dahFYP7qy/C0V6pH42y7pJq2I8tjU6ILb6pnCRZztw59EDkIHIkraZbOoao/BUhexWcs
         Cva3Cr3ulLzFYeXoyoB5D78bhGeaw0k8LbelzbtN3z/YEUJAFak8Eh6w9MgrwTI70iXw
         Mt4/n/iELmc0LhcUeR+1jAmwW0+TBvY+7rxlZ6pEDLW8rf/saHaDAybVIBGOHeSEzZvc
         vBsI/mJcLzo3yy594yHWi1GyRqkjSOm+xz7VpYm4/Ccqj11lTU1q8ORH7B8DuURQuj4b
         Xxbg==
X-Gm-Message-State: AFuF++kRKHjy5np1sUa7vXZvz1e95K5r9imQHvrBJHxNAAcDoZfB1bZE
	+0u5divSX7owPwqFqKPbsNLitxtI2g9+yBySln7d0KdIOg6awQyJx2R/EwdZ+BNFJLKrbKHCfIU
	xVRA5V/EVww+9j70BjI5FM6mUefGGnWblUKyFevqXnQ==
X-Gm-Gg: AYBFou32c5F/yINgk9vVA8WJkrixL7WlgsO3T8D2LWV08YuO5mwPlUFY/aHvvEOFLRH
	0jrsUiM2V5mjaHUM2Vrr5+uPqDQvcJ/tGaknFv3qyZNNvoagarH7owHyVww1s8rDxS2LGIuNqKz
	qRQMRxg0ZiYaejnTjRwZbt1oXwz7Bq4WtMPr5O8x+YcGom2pb6FZFcl0R6cH/N4PDFWsRRTAht4
	dkXWj994VGtFr9IIocS7lfBwqYDA8fyypHJhWjQbrGeOHxbsIqJ8SkNiN7QuZkw+TnFKYwIWwsE
	zeB5yLRiJgyJPAAqC/TfR9upSE0telClHbrr8Eza1bZ5TdWMsSluaeE=
X-Received: by 2002:a05:6820:491a:b0:6b7:46fc:1d3 with SMTP id
 006d021491bc7-6c0bd587be9mr588422eaf.50.1789078120618; Thu, 10 Sep 2026
 15:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260908222056.1150748-2-tyler@tylercipriani.com> <xmqqld99dk20.fsf@gitster.g>
In-Reply-To: <xmqqld99dk20.fsf@gitster.g>
From: Tyler Cipriani <tyler@tylercipriani.com>
Date: Thu, 10 Sep 2026 16:08:29 -0600
X-Gm-Features: AcwNN1VYRPye2Ly6mAWI9_gMY1ZEfvgFmlop4ojo5yJ-bAXzHUQjHUyhCs4mV4s
Message-ID: <CAHLx=Ok_0RntxYo5GsEQTmvxWy7B7S8KDHq=G+G5jWorPz3-3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] push: check pushed ref for --force-if-includes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, "D . Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Tyler Cipriani <tyler@tylercipriani.com> writes:
>
> > Message-ID: <20260908222056.1150748-2-tyler@tylercipriani.com>
> > References: <20260904210122.431757-1-tyler@tylercipriani.com>
>
> This is incorrectly threaded.  It is not made as a reply to the
> cover letter of v2; it is a reply to the cover letter of the initial
> iteration, and breaks automation.
>
> The same problem exists for [v2 2/2] as well.

Sorry for that. I had --in-reply-to on format-patch vs. send-email.
I'll send a v3 with correct shallow threading.
