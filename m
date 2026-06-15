Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5627402B92
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537267; cv=pass; b=pYk2ZzWCv6bpKd9RXcDrjJ3nhy4CEF5vU1AXAm8ZQrMDG8kdtonG7ZBeBOkujYBHE07lut2uLAN+mo+oCXINR8k4JOPKw62wNdI8Ow6ZBAmwmKurH7ZlJkGBMAD1Ambvcovbl2OfiEVZ5EeIIMXtnDPxMVjdVLJ2jgS0u5gVhdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537267; c=relaxed/simple;
	bh=4nwDyMoH0oHvzh6ksuEITDRzvVmLsJyUww524py/0Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvO1BqPL3FRcJQ0+hkcAHqHZ8rZAfE1wxoymCoNTfaHoHdY0y96JPVj+odTcJ2j8EhhYgy7O8xDD67a0ucegbi9oD6+Yb0yrh52rnNx+lNM8GJ964WUTqeLmym4RE1+joFgO34RN0A5iP/xXjdbqzkoqBr84SNSV5puDAevPVHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAAHIT9Q; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAAHIT9Q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1946222a91.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537265; cv=none;
        d=google.com; s=arc-20240605;
        b=JAhMkUumWagtEOhsK3Y8poTTmerV+ICHxrs+yDtAI5XvQwOwd7NTnvhXPGPyU4ajl/
         DEyKgSGkBiqAq9U8lITW1wCV65BP463FpWc2EPtvB3qsArvQ9NHrOiV0H1NdQQoUgX6Z
         DTaUDJKJubXEJMiFOLSv5vqnC6zMqlv+JIVg1n0chJAe+QfVmRz7vaG9ZQwMwhxnmcYh
         gyQYLzvJwyZDQc8AsY6LuofpLlBLtk+n1G7q9TvH4IFa2u+WXTdhwTj3Q2JOuSFVGg2P
         e5EMfe7+JyZkoQLqHFycmLfeJmZnjGXVJnJRTj2poItmNxc/HTs6tIzS0refQjfQCUVC
         w2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=koNXwqWL7XFtlO33VPCZ24UFvH00QiGeaUgVIISeNZ8=;
        fh=/AuRq0Ekie0rf+HwAYA4OlWC9UNL1zEBhTiQLLUEZ78=;
        b=T8ab+8Q2n3rSqJDHbYgD5+DNCd2PgL5mKKdHiJOY3R/3M+I0+OEBPojxTnSKstv6ud
         X8oOCGpoxlfvhS2TeTiSvTM+q3KelW5m8dlNFZm6jDezTb3+9+7S3RMpiDGy+PB9dYvp
         vmrg3yh4Bk8rt8hCqGwsQ/bWNHdnlRYs/Ek/1CDdSvrPf1rbyQrQcCE3Q9+irS+JEV2I
         zxNglrFilPgmdWCyxwpHZREmIt/sG0vJmNr/8O735d5ylCe6PuXpu5W6QR0ylgoORwXC
         QykwwKHb9omslrQp33+Gd3rLgt/G1dmfFvhKyTU/fWlZafkjPab3rp65kNFfrGJRRC7S
         EcOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781537265; x=1782142065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koNXwqWL7XFtlO33VPCZ24UFvH00QiGeaUgVIISeNZ8=;
        b=pAAHIT9QQoezZVoRTEElt3rWXthZY9MShK+FhRYSxKjN/Mf2Ht6vdF4I6JMUyKpGCV
         kbb67y7W50rf4LHBDkxewu00uUTs/3OKtbLwTWGzhtPxRjc0HgEmRuYjxVG1TWtg47PO
         uf8KINgJMp+Lvsv7mHexZSQ3YPUkcTwF1DYD+v4OeoPam8YI+Kmw2PoAe8NchjgZBRnJ
         BkbKkq6RytOUo6NkKl7tpo8mAYVAzIQhya8chHyc3Qq365wg5tgs1HFh7tOehX6JTVW6
         IBcvC8YK3USXpJtudpYOaCRX3Y633KwMDKEgZV/W3ZaOvd3AMC8SV+JDG6NUSCVtq9AJ
         LNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537265; x=1782142065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koNXwqWL7XFtlO33VPCZ24UFvH00QiGeaUgVIISeNZ8=;
        b=LTAXxpgQP1WAzByRs540+4+BbGd6c4pQBjI/xYfdui5yjLEiURmSZiGB/c6MZp+OqR
         4oFAvjTb5iVmYDQ58yLO3GubNvIq7AIspFsijWyi1xvjlv5wzOz1KHGxivG2AFzgdkU1
         ZFhLpIzmjM1xxmZ/Q3HnVgyU+z0g0GLdrDStmyZieJfpEQq1HoQ+sA/ZbjIchw8Loy1c
         76apsoLxxdQsAeGs5KxC21LvHcdCRvILGd2enPGBqsb6etzNnm53S3xo7LFlDruw/6mr
         nja6JtNUWehz311NmzO8jRf+kPRmxDW1SgQh4hWYGcRVr5JcVApZ8UFyX2pbEVQ8hzn8
         JAeA==
X-Gm-Message-State: AOJu0YyTsbndhfeB/m1/OanXWaCGpTXLfaINKS+k33lN+7vGAFcrVB7/
	2swskMzHpV69JD0d18uJ2KXSfTMOo+vxd3O2bkBUS9Ubvvc4Yru0rmMp8h60iNCzj8g6KXl58Pl
	YF6fGTx4bHrMod6XSdXHdS5ubQSGuGiZf8XguDEM=
X-Gm-Gg: Acq92OHOpFCVXNKG+27nYLptOFNotrGXtzid3ZvkzWy9hm5VCmyIKVslDvp2sL2a7SC
	gpKSIOVjuOH1D1JvPwYJYZaHCwtlpyNrZ5A830tdP1fuHTbfUwI92tfEvqPdgTgFWVTTnF3TqB7
	cYCjjMYFpzjU+TUSaPWzcwb8sg19mJu6zYwlL6xHYxxp01ZCewIANXI4wGCzq0TpVZfm3BHRuzW
	lqd5XRMdEmzLAhkc93Ud3v2OdXFd4kuddeyeLz28ctCWZ0W/rIi53bp4HpyUU1wpNgMvx/8wukH
	5Kht6esNl/eB7LbQKKiaO0luY2jfNgIN0CoMQGY92dF9xP5KF7hhVF7xcyhSlWNSbIa+e5hsbBk
	vEbySXRUIm3PKhbY=
X-Received: by 2002:a17:90b:5205:b0:36b:769c:c037 with SMTP id
 98e67ed59e1d1-37a1e0084cdmr9902759a91.5.1781537264904; Mon, 15 Jun 2026
 08:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>
 <xmqq1pe8eqmj.fsf@gitster.g>
In-Reply-To: <xmqq1pe8eqmj.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 15 Jun 2026 11:27:33 -0400
X-Gm-Features: AVVi8Cdh31XsD5sKqb_MKCnCkQlHaWPnTHEBzEkUR3VWOhCUqJqkOQEGB313Hs8
Message-ID: <CALnO6CAzS818J4TRTNAa5s74RzvxJJ5=HXb24UnTxQzVPH9Khg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix a small, old release notes typo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resending for list]

On Sun, Jun 14, 2026 at 5:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> > No harm done if you choose not to keep this, I think. Stumbled upon it =
when
> > trying to understand Elijah's message [1] about timestamp_t overflowing=
 in 2106
> > (I though 32-bit time_t overflowed in 2038, but timestamp_t is somethin=
g
> > different=E2=80=A6 except maybe when it's not? Anyway=E2=80=A6)

=F0=9F=91=8D

> Unless it fixes a glaring factual error that would harm end-users if
> left unfixed, I would not very much be enthused to see fixes to
> these ancient documents, quite honestly.
>
> >     separate and dedicated timestamp_t (so that we can distinguish
> > -   timestamps and a vanilla ulongs, which along is already a good
> > +   timestamps and a vanilla ulongs, which alone is already a good
>
> "timestamps and vanilla ulongs", as both are plural?

Indeed
