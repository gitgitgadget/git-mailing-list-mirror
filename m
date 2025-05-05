Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A51A5BAE
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436293; cv=none; b=ba0SK3icTqlgSFCPYS3bMtKH4D1BsfoAE+jOlspoBqOKQXFEwcs4voYudYwAXvFGu+T8Onsp2i4DkIsOhwTQjjcnVQNtIBvfmFT39NBoBIMViJdtU2ajHhkCSkaIxpEHLcItwq0moS5xo6OMusJHKtYpmgmeJnmnbxtd09wfCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436293; c=relaxed/simple;
	bh=XQ41KPxA8aC+xvH0hMm62yKvpIzbDj5nWxO6nwNc/UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tw0AYuPLfrt/AhW5guc2KpMO2qpO3Nw7krECLmfh7uOt7tUiyVUQ6s6dmirW6NcGNYjZRO19c4/PcLthOjaAdcgXn5lunz1MSq/U8xkmBKA2Np+uakicQjlXXoXaRMqMlYRmbC5yMMyWXXzTIO7OqOYt11PtPXjyoCsd2j0GN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7G29O1j; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7G29O1j"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e756416045bso2906933276.2
        for <git@vger.kernel.org>; Mon, 05 May 2025 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436291; x=1747041091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNvLmLWeXKkZmro4MVejMXPVBZsEJVrAgUExbGwAhKY=;
        b=T7G29O1jdT3/JUuOiLr06mkJjS224qiQixluqkk0yC+zWqVhDGpD5sARkeEHKfJ+gI
         9kGjF65SfS0dXqxsMqHfc9wPHM2TFZoYVpxT7P12YimDVJBdEgyNcxldyS//0+8ZnFlJ
         IXSHwoSjRMoLX6EuJrPSzbPPUzq93JRHsl9XntfMl2i/l9ZGdtAxTKr85fLLeGyH5tnS
         PySQBnXcEHGj3zU8QnTHXSuCBlCKIKEdH37us5IvTsjVEE7QAO9rHKF1B5HywiCV773Q
         pDBm5AvAZOzq97Npzcy21C0yqJjc3i6Fzg1YY9qaJbeXSQ4ntMZvTQBfdVSQxCHyO6Y9
         JLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436291; x=1747041091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNvLmLWeXKkZmro4MVejMXPVBZsEJVrAgUExbGwAhKY=;
        b=F1O01crOuuvbkY184tJgh/SHIuJanhkxPGF1gkSohzHPpBNM9DaBMsk7jHA4LQrCfW
         loisax342BQKSVkaB52PI0ZXjMIhaw5dyLd8edupA+9G7NQ94drd8U53qjBAKQKRH5lR
         FdPpYyLom3xCZ8OgNq3+l88gSUbQKe04mcuIg4vjGBCZIARlnL5Q85EaokfgGRWtoFsW
         7nWglXkQndICmMi3umGzd68rypOMcRJIjn9wxfabXNTzRAhKOZBuLOqSBCNQ3IJjiNxI
         4wuRmd4/ILMVlBeGv0JLjdpUITQ7OJ+TTWHaUWAJ80ddLxiMOGDxgpLWewz72662gUZE
         DjVg==
X-Gm-Message-State: AOJu0YyphPv8d9We2Ej2Zf937VZCgGNZI5hIgabrNDfQtqNHkOpRcckz
	+gr7DouoGC9I20NHFPC4Ew/74RcANQx9Fd+iLDFPzc40hK1EOi+MW+yVux/3vQPZkjTMiNqyzZc
	QHFmUtM4anJJYBVYSRiBkcJBUSBU=
X-Gm-Gg: ASbGnct+9SGcEJWVBreoMgQ4wC6Xb9m5lqQmL8UVIRUi3FZBvoCQ41kqg2pbnTbx/jF
	fZxcItMQvAaOCwdLMMpUGmg1CM0Y29sDW88hXENVtgCocRGuBC0NC7jTKdTP+FmVeQIvisaWlrG
	xttUF3hp4MY19Tr3VKy3br1Kc=
X-Google-Smtp-Source: AGHT+IFGWUPt8D0Ko0KnIK5fTziXbnbkodLOt0PWG8daTi0MXAKpev0ms1EzDNOW16gqbzlzYOWZ9laNJ1QRXRFCqxE=
X-Received: by 2002:a05:6902:1607:b0:e73:22c4:117b with SMTP id
 3f1490d57ef6-e756566218cmr15246740276.47.1746436290965; Mon, 05 May 2025
 02:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429175302.23724-1-kuforiji98@gmail.com> <20250429175302.23724-10-kuforiji98@gmail.com>
 <aBSXBv0oPOXpfC2i@pks.im>
In-Reply-To: <aBSXBv0oPOXpfC2i@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 5 May 2025 10:11:18 +0100
X-Gm-Features: ATxdqUG0orQyCJfoafy4OQGJ_DDC3vaeNqmuKM0TRjxSvbZ8MfLzbbLR_RrqytQ
Message-ID: <CAGedMtc49Mur-M77krEZ7NbomKn1bTW-q1MuweQa0=Vh4M-hvg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] t/unit-tests: convert reftable stack test to use clar
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 10:57, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Apr 29, 2025 at 06:53:01PM +0100, Seyi Kuforiji wrote:
> > diff --git a/t/meson.build b/t/meson.build
> > index 756cb2a2dd..8fa00fc9ef 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -1102,7 +1102,6 @@ integration_tests = [
> >  # sufficient to catch missing test suites in our CI though.
> >  foreach glob, tests : {
> >    't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
> > -  'unit-tests/t-*.c': unit_test_programs,
> >    'unit-tests/u-*.c': clar_test_suites,
> >  }
> >    actual_tests = run_command(shell, '-c', 'ls ' + glob,
>
> Okay. Ideally this would be moved into the next commit where we remove
> the infrastructure for our old-style unit tests, but we can't because
> the glob matches nothing anymore and thus causes an error.
>
> Also, we have a "check-meson" target in "t/Makefile". Don't we have to
> remove unit tests from there, too?
>
> Patrick

You are referring to this, yes?
`@# awk acts up when trying to match single quotes, so we use \047 instead.
    @mkdir -p mesontmp && \
    printf "%s\n" \
        "integration_tests t[0-9][0-9][0-9][0-9]-*.sh" \
        "unit_test_programs unit-tests/t-*.c" \
        "clar_test_suites unit-tests/u-*.c" | \
    while read -r variable pattern; do \`

I've hardly taken a look at the `t/Makefile`, given my very little
interaction with the file throughout the test conversions.

Best
Seyi
