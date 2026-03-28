Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF078F59
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774702332; cv=pass; b=Z53bMex4XcUCVKEijhu3q0iCQpuQ2r4P87EcAhf60tGWkNKadyqs4V8s3HgLJlaHycTudfa1WVbafhmw23Ka5jPRFU/7mNLhiQ7v2r3MnjLx3fkX3K8xJqJecmFi7XZOGMXQxkCxJoyV2boAvay6F667vsVImlzlwlTUbYtaYc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774702332; c=relaxed/simple;
	bh=rT0ZsD/W1XHg3bKCzFv2BhprEDFCETtSAbmq1H5xBDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBw+a0q5t40ET4YqnbimeZpF7CMSEZHHKlZfy7sxTGlozW5VEFNCG/Kl09WtBuAzoicagixhefUHi0Ed0GhibEeOKl+OYcK61dMeLH5qglpCn1pLqNwjSBZvMX7Z1X7x9htipvFWNA6hHQt8sDoiR2SeKbBXM7U4fdZtnv7Plvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBIwnP69; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBIwnP69"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899a9f445cbso35160496d6.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 05:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774702330; cv=none;
        d=google.com; s=arc-20240605;
        b=hwdqEcBSdwh/7zkD5fn+Z+sD1OI7TJDRUCMq+u8ad7xKus8zQcgcewQPbbVuhfEzJI
         6U/Dxg46sIYTCl7H9jm6Yq4qMksT2XMhJvOkB0j3BdST4eEXnxvWvEkVryDeYKwE8064
         CIj4/T2zwV3tscDVr32yMzXKXrext4J8hazD1vkoxciX9IP3Xjj837mTdoEw9gd3jrda
         ns42c/05Miky++ivqzCnDjU2OdBuSW0GhsRBtY7tfPbSyJSWneS5ik/pWJUAeVrnst8O
         pDXO8uFB+du+0X2YfIYINhPwYUfN6mbkrVE6HHMmUW1wMEoiCkc7tSxYyoHGtaOgd8JK
         M1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aK1H3HXbI8d9cKZaDgYNwb25DqMRuMON5/oWFIpyzJ4=;
        fh=RvJwTIx8ErQQdgi+CMnWTpCZUJB8NJwo6Tu7jmWlYrI=;
        b=L/ptTGvLOejMG33Jc17rf1/5vJP2m2HaU8g00O+ShulkfiELBTIqKfmsJOFjRT9cve
         u2tWW8CtILYOJoGJSbpdQUXcrrnJ5CX1GPi/lalzSBF5HFqRSgEL72Av4XYf84i3pX4V
         1yJHCVHr5NetYgfMRT3I+4Q7X6D1vr9bSisI6yUltFcW9H3eC6p/3TOonI+5Bcd8SWrZ
         WMhNrtWKSBu0LpfUmZZu05WbjdmZUyFhSfq66zLGyewgef2Kwblgp91YYgPTTV6V7zZL
         10jfbrO0/s2Erek/zgXv1gkzKys7uvx3FTc8oNEFRDQhizpQ3t9Zr1NujoRrG2VFtytJ
         JmpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774702330; x=1775307130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK1H3HXbI8d9cKZaDgYNwb25DqMRuMON5/oWFIpyzJ4=;
        b=nBIwnP696XWTOxBOvVavwP6fHy6WDyjXs2HVDg6mWPCDhFPCPvroUZqa4zMmQKdGVW
         ms8j4dqI4yXFdvaJluMxHdfmBu0muabBWBtNX6YF+ruti9Kyw1KSDb1zfs8GZdSqx4La
         rw2gL0e6fG20Iddb16qe/fWMiOdrRTFu+rvo15l30JYhVMLhAc2sh0ZdvityugT1NugI
         NjRhHQo/lvbvHQP3dFTne1IQXiocxQ5MILe3r+cO9+QNnnOFaPsT4NaNTadq9T7Ia1lU
         teW3gfkised0G9t/yPOtXqFgmwdt3pd06paRuHVcjpAaQFmCXNOBGb1w0+K86ItMk1FN
         F4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774702330; x=1775307130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aK1H3HXbI8d9cKZaDgYNwb25DqMRuMON5/oWFIpyzJ4=;
        b=VSvRIwy9wDVGfgY6QAV82uZX5mm9NPtknJsKe2EgU3Zm7DhMqDhPQCGAJcxfNKMNCi
         L7zgGEe3KU6IHF+iM8GfyTrEbv0wQ1LryHi0GD97ZdxiS5vESX8NCkgI3YpO2TeIujh+
         nK7MxnSS0Ol25ZGirSNabcqmFArfeSToN0aevs7iGjLlYVgKz0swtqQPwFQouRRiu27Z
         h2E27wHyuB8dgRifnnu2f6Zrn1hxNz81cA6dfwcBIDmtQXjTfp2ZRbcrLLbNLiQ4Clki
         767SfVyqB8ruLexChmBIMSuXmsHv6ZPMjf814dyHSC/y4e0bdFlD2gHOzVYW4hbDFHH4
         PJDA==
X-Gm-Message-State: AOJu0Yx5Izto8UXu6WE1MHtRMuUhmUPKdueck2fcIc8JRkM//EmX4tRt
	06fyM4jqttlYikJ3j+5592pxJKnr94krt4kl3oI3kEUW4we7YgnBmRt20rVM3Q7JNAhWBGrO7Hz
	o3Mr+gbZYjhYpL3dpyJVSSn28jRmEfDAsHQ==
X-Gm-Gg: ATEYQzxNr5+iqMKR2z/lQ+YAtihXYmBqbzXuoKeLu9HGebP4yKuYs+jFfifTfNJkpp/
	DsWieAczAUiSraFEVENAiUnwN2j+ExKgus7N2F5866t4eQYMDEuqeEIOmC6yIaAmwMlvTp6tMWE
	zAE9EMxsFkT53HBDx1NblLLswkMM9sRjzseu35VQ2YCgqT5lDh2xqePUrMZP4FyNYmrazGaB//l
	7mEIJf5/BYPIUL8Kg2QWw1keLAnz2U91YI5c23P58kF/vsbuHt6xig9MwNnr2EWKM74Awl8kA6a
	BK07L2D9sklW0QNTg3c32KAbb/ug7ecMVOf0fRuLBR+p5W/aszw=
X-Received: by 2002:a05:6214:4292:b0:89e:a170:6b13 with SMTP id
 6a1803df08f44-89ea1707210mr45556996d6.20.1774702329844; Sat, 28 Mar 2026
 05:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260325164833.1216577-3-shreyanshpaliwalcmsmn@gmail.com> <DHDGF1CL2QHP.101BB8D2101N8@gmail.com>
In-Reply-To: <DHDGF1CL2QHP.101BB8D2101N8@gmail.com>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 28 Mar 2026 18:21:58 +0530
X-Gm-Features: AQROBzCBGBe6OtU9irIB7sNTbZtvbdLAhGhFGHk3qZO0wVrD5JMBUv3fCp8X99s
Message-ID: <CAPYXD67BV5-FjvGVv1gcV2Fp8H3d815EZO0PVDWPfq=hJYP=Mg@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs: make get_files_ref_lock_timeout_ms() repostory aware
To: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:54=E2=80=AFPM Burak Kaan Kara=C3=A7ay <bkkaracay@=
gmail.com> wrote:
>
> On Wed Mar 25, 2026 at 7:44 PM +03, Shreyansh Paliwal wrote:
> > -long get_files_ref_lock_timeout_ms(void)
> > +long get_files_ref_lock_timeout_ms(struct repository *repo)
> >  {
> >       static int configured =3D 0;
> >
> > @@ -998,7 +998,7 @@ long get_files_ref_lock_timeout_ms(void)
> >       static int timeout_ms =3D 100;
> >
> >       if (!configured) {
> > -             repo_config_get_int(the_repository, "core.filesreflocktim=
eout", &timeout_ms);
> > +             repo_config_get_int(repo, "core.filesreflocktimeout", &ti=
meout_ms);
> >               configured =3D 1;
> >       }
> >
>
> Looks like the existing code uses static local variables for
> performance. They can behave unexpectedly in multi-repo cases.
>
> I think moving the config into 'repo-settings' should be considered. The
> config is already lazy-parsed, migrating it shouldn't be a problem.

Yup, I agree that would be a logical change.
We can take that up in a follow-up patch to this. Thanks.
