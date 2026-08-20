Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F543A80A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226672; cv=pass; b=WVq+XPMReURapjdF8x/xPHiY31ocmBfnQwaWHUKlXlzjlAyUSZSZvPe8Ewfb7uwgCwFR9aj+c3MRQDUPm+lWFzzG8z7QXNgKLt9kjpETZciljazGiLJCl6gFB2BnbIbNU/P8epkOlV217YPnEGtCnRbNtTMYhiwo32XRg+NnQAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226672; c=relaxed/simple;
	bh=PnaoSM21ql+gVaTpBozIcPYBIF+XA56Kns16OapNvuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEz7VskhELfLeSBDXorp9DpAHcEjOMgxpEqBgdOdk4Bh2GaPLUoYu7jDtsVvw5xacU0sGhf+bd2BQU1t8sWy5z/BrOHehaZq0xguQslk37DvrGhe+tftgtigRALkM4xkOrP0nGya3tD++EwPgQBIskpovYAdesC5t2g6k4YfLnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxc2J/u4; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxc2J/u4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caed617615so22153615ad.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 04:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226670; cv=none;
        d=google.com; s=arc-20260327;
        b=j43cOQDnBWrlnmTJhJJDKt6bjNuyahz2Cor6nB8+u3q3IgnMOwyngaT7lzMdvgS71G
         0yY+kHaOamOSUpdUofsRKnbhTcdu2lN/a42Quc2BMc3bosS4YPbKhE7BWI+5APX/eB49
         +slInwmlaCg5VbQejk2xdZRh3PI4tCGoj7EYLmOwY3ZJfyBwB/utKwPYPu27UVLGnvl5
         TIbKrHJS5AsW8zjO2Lhh9pixEu5P8YsDHNDesrkDAODQIw1UZlhmsxb7HYuCucfLLySG
         xYzKDr3DRS/CTUKfggN3TCpB64Tlr8FvTiKstzL29R6K5cCxJCTgmbX9i0xq3Rw4/0xU
         0sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PnaoSM21ql+gVaTpBozIcPYBIF+XA56Kns16OapNvuI=;
        fh=uPjY8ueqdld3roU+rwxQvk+Ploi0wteBv041EUCijpk=;
        b=ddX7e8amRHuqk4N1W5h2nZtQcaB1Wv12/azMLiQgdXH5MxAjLCYR0hbFhfB1TdReK7
         aghgdZw9Gb0rwpjXr72e/Ft2u1F2g9dIEi3xNIvI1bEmvY/8BozSGg+lO2fwIiWS4t/z
         W2JZYRHdYewQkDmdhC3ByH7iDJSa2+EKaqzlBqAExjbsF8JDJbXTVcfGTtMlJyBx+v2m
         QwmJcwgVNbtkhEAK9ts0fWhb5u1HoRWE30YW0nbq8+WlrJ4fF7y8Hr/OJRInfERwXN7z
         KcV4SAMHKRhYkBncL3pe3QYKt5S89sRGiPR7STkFhMmDUAMInw/aIkPV3uzxIowXLHjr
         AZKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787226670; x=1787831470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PnaoSM21ql+gVaTpBozIcPYBIF+XA56Kns16OapNvuI=;
        b=Kxc2J/u44U2iF69SD0ogSIvOytnT3vxO9NdIe4dFt4eDZAfXjP/zXx5Makw+8NY1Jo
         0GmhCIdHDWEUbfc9cbOf9V88fWeuAcsNvn7oJiw71M8+OQ9IBqxeDq/UPUbbF7qgHZyE
         A7xMMGt1LJI0YFmcYCcw8TKJIPMVczDK5gW1Gtq6Y+RDgnigUGX45IRE7yJKMf4MjXWZ
         Xgx90Y2G+2gNW03kyWAvBtobI1FG2wfSW3JxgJnFdA6oIYptSKqIYgZIbytCmLPeO1ma
         ruoe/5GjwcOr3NEKrioSBBHgkWEZH8j+Wlhud+zXaoyNzzf53iZpHG6CmvZHqEOjo+R5
         TeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226670; x=1787831470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PnaoSM21ql+gVaTpBozIcPYBIF+XA56Kns16OapNvuI=;
        b=ATDjVICYQ8It5wmKiUK4CfGAyqXeYMAGURQrBQ4QJmcB4w+QTxul5hIZbgm1HGOiCN
         kDCAuxiLdcJeDD+ZM0qbXysPma5ODlsZqA0f3T4TSWphR8f2u5JDprRwe+xK/lqUG7D3
         Nl3P97m6imuCoEZJiEvvPOwDvasv6Vgx/2pdRgqdHGLHtNexqR4L3gwt+THAxcPSMpx9
         ihyq8aukWLckecQ0bqsFOW5SXOObpWiuHxY9Z2YkjMdsxYNF7vgaEqZKJXf1NMYrQz0V
         xWDu/yyJwcDaBRXuc2h7PK1anyrg/uwKuRaeq/bazq2FYUzjmt/xvY9hcf4zTHoGM62m
         w+qA==
X-Gm-Message-State: AFuF++nYADrG+kuof9TtEjYM8tV5jq3ZsqCofPcToEl1JwunoSIXTJ7L
	Y15D6vvwuwKT45xh+GkLefw2eKHdm8UFZAPtiaFTrK+2FulpsFh+Aw0WwUUXtMSVejR6YwKjAFg
	pzMiSszsIQnFoKFDvGmu7RbKsZigmNDCp7Z47aGg/RQ==
X-Gm-Gg: AR+sD11l9m/1i7GB0JYORTm2GW1eJdYphHOEWe9Zhwhu8mwFpk9yP9S59gJ2eZ6ZO+l
	YFz3rmxXVELaVJ5yMsBEjzH/SSDShyLGSj1uGpsDOU3EYhgsqI3ldC8Y2Y0Opucdeoen2BmYXOL
	b84zxvc/HzxIjA21EDjU682gPty2iTQYZsQ4c3ryWQZ7AJ0qeYbfK/tCIlwpeMIIxbREDr5mjFX
	YBqf7FIjbhB6c1srQCfXDlLb4SdlSzZio8Pvqq74Bhds/ZVqI2ruj+t/rh7fXnL2Xu75eqK55j5
	VF1tINpYLQLtwWaJpGxUK9jCaodzWH2lQsxVan7mYJT9K7lBG06W5smWJpKAS4rPy1DlwZQA7wk
	VYS5Rc03KR+jIPyyPpvo2CV4Ub4oVgMfC6nW8Jyv+Ddb1qeTxVKO8kLyW4qf3XnwtHg4qmSOXzl
	p3YTJTgVHM+QSFW0bCfQc=
X-Received: by 2002:a17:902:fda6:b0:2cf:a108:7605 with SMTP id
 d9443c01a7336-2d60186263bmr239935175ad.11.1787226670233; Thu, 20 Aug 2026
 04:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
 <aoVoJ3Ijoaj3u64e@pks.im> <CALnO6CDgfT+VXaBqSmStB8vNOwBpr5XMjvmxhMdc7v-ma-YwXg@mail.gmail.com>
 <aoaPn0gaHIa9Utwu@pks.im>
In-Reply-To: <aoaPn0gaHIa9Utwu@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Aug 2026 07:50:58 -0400
X-Gm-Features: AcwNN1VDmhVZlYEbAPvy0lRIjU4hhD_BcvxUr4vViNioa5mguZIIFVfa_8ZuHkg
Message-ID: <CALnO6CAa0HKsKoytzfXvEmps4NLtx5qFkP9B4PZzW_Rfun+CNQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>, 
	Tian Yuchen <cat@malon.dev>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> That'd be quite welcome indeed. The less ifdeffery the bettery. :)

Agreed!

> On Wed, Aug 19, 2026 at 09:09:59AM -0400, D. Ben Knoble wrote:
> > On Wed, Aug 19, 2026 at 4:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > There's one more site in "builtin/update-index.c" where we mention
> > > USE_NSEC that wasn't updated as part of this patch.
> >
> > Oh, did I miss one? The only spot I saw in builtin/update-index.c that
> > mentions USE_NSEC is a comment that I'm sure patch 3 updated. Maybe
> > you were thinking of that, or maybe you know of something I left out?
> > (That is, locally on this branch, "git grep USE_NSEC" returns one hit
> > in Documentation/RelNotes/2.5.0.adoc.)
>
> Oh, I guess I just missed it because I already trimmed context of this
> mail. Never mind then.
>
> Patrick

No worries, I appreciate the careful read!

--=20
D. Ben Knoble
