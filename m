Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4776326941
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817830; cv=pass; b=ELMy/ZqfKOvXMYniOx2vg50a1WpDZzhoEjfkCLevdk6O2BOEIbeP1BtpS1xrOLTIcnLAZiGX9TxSw11G1mpsWkHDM3kM+gV5ccBWnYToXbUbRkd/tZFbc0/WB5EBPQvqQycsxNVIpCfMBkwACyvgV2/702KXKo4eAgRlHfI+fkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817830; c=relaxed/simple;
	bh=s10StDCnUGeW1W3iqOIneOnXD5Y5804WRyI2G5Y4/po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VopFVt3cIOqETjYbAWvpFfKpyIYbz743PlVOdNUSFIeOISSsPKweEFNlUozZKa3uADBdMeZUQh6BdrQBsQRGdsjHxlJYUziHDd83Ukif9I9TSrkey5fC5oANP0aZQq34ukpJtAWPMRtSEXgiOAMtP5YbzsQa55Blj3JCtTDymgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StdExmNW; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StdExmNW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b900f350fso1605570a91.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781817829; cv=none;
        d=google.com; s=arc-20240605;
        b=XYPbAgokJoOQN7MN90g+/X2Xnax6u4/nGlx7pk63C2cWy0TqzaenWd/W7f09mUCwVJ
         dH4U8cQF5fwGQZ37oz6rBCx5jeaOTRFwYtUY2pq4tQICVEM1uty8X5heClqn+vyicaV/
         LjKfBp613Sw8ds8g7M8vXzT5PF+MkmRKh3IcUm/IjwIbmwA/MuPhNuvSazlHAXBtbLAj
         f+/J7X5mnJPDb9Pw16VBXEJCy8M4AqiUR9MuZfknNnU2CvIfoiJzwT/UhtN2fHdrYGLc
         3ghbSY2bmQ46q96wX+dpPKQc4HblEBXDsaE8F443mL67RxdlBKM9itsp37+E7rw6BLpd
         pmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XrRJHIPv+dyQelRla+/JODt7Sce1Ivv183LERLA9Vwc=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=Q8rmhaetekPuiUTwiaAuuE3SPvN/Ve6+PpfiNEzi/pSAfmlzj3dcbff4hVd+hhTGo8
         ncgWxZK9aGkqKN5UZlLDb9bfGaHFou90mVjpIzI7MbdM7RWviegL4dBFJBpTlbjZkZnJ
         whebX2z8rVKA11srKS2TUq+Fn6ST4rCoT/4nLCBplfAdeV7s7zJ501RhZ3gsRc341GCh
         4wBJDjgkrTG49tW3oxBykdJskJRWR+y71cXlH8QALeA3RdAHwncRpQtlg/Rot2KmXLK9
         Y+X/3EtXPpI9Zms/cN3cQdc0x9ul4wPa5hYDNLnxxTauoVP19al48ZB+F3ptjgtnq11b
         k9Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781817829; x=1782422629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrRJHIPv+dyQelRla+/JODt7Sce1Ivv183LERLA9Vwc=;
        b=StdExmNWXoZFUJ0Dlicb8v61L+dW+BME1jUZhZw74/c+d5t6QXUz1tsU7ovjOWHUEj
         mmZ3+Y25toBdbF/3rykqlaVUBjeRrlFFzjRm9Fnf8LHPvfmsiZpQ9KFZuDfAyWPVKCYe
         PL5JLJ1Djq0r+hkr4BgFqTF5KWHmc1kgvjL6AN0DBn+bqYkg7OfNfgr4qGPqtFeP4qfO
         7Mi6eQwuof3eVJQ/OvNLfMNJYefqEdFMqH1GSz0FLMBOgxDY96rZFINAH+b5jKX1nz8d
         uKkG3SWRxqMMH+JnN9p7Gar0gsHOmXsC9N7kmuVrAtkFweDNnGAejPp1r2D1e4FtbmBD
         agZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781817829; x=1782422629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrRJHIPv+dyQelRla+/JODt7Sce1Ivv183LERLA9Vwc=;
        b=Yd9mGDuAVnPJVVhbVkYFkXKw4I8SMknFs+0QzFGx5obpDnFz8/UwYD+38S+RvgPX9k
         OOSOk+jzivFNWfH3XChvr9vTtqG+Y2Fp9MkZn8p4yR01h/KqI72OVYNc77T1OrODnkje
         6Q4mh/HsVJdtax8XkzRAAsj3LsoB4MqRK4rU/3omGow8hzxv1Au2kHcWQzho8IbyiR5y
         P+mXyMzCb4UIERvTHfp/6vOfIRETk38frYXbo61SBb9MdfnVlklFSkzfREFOAZkd/H5g
         pAs15A+U4d6Z/74S48joUzKnAOexMM3XTYx6HBAcsuWetirPUyiT6BdIusCDTyJ2S9Mc
         EjvA==
X-Gm-Message-State: AOJu0YxacODTD7vJRShCv1NOqgjnBfGHKMRHntD/W7/FwcbrgygW7p2O
	Gi5mHAP3Mq7TzCKOJNs3wCkNr/xVeghEHIZXd28FrTypdgOvOMJj3jLbD6Q+KBM9ZQAOLvs/egJ
	iAUO6Hjok3SES/knJHwVkvMB6GPcZMJw=
X-Gm-Gg: AfdE7cnXazW7TarvRYgVYXwaoY38WM1VMhOoKByRMK4TSPadPZgkYoCkFaKqqY5AKl+
	3LbPMidUTqffh+vbTvorQtQwdXEreL2G9kBekGSYIl7xYsW+oOoBKpPtwtf7licQXojiZ6ZsY7e
	BkZmOtI5FtMYc7vHRq5/ugjRKRVoGDmW6JnVZcF9PHBlrj878JwgcZ4JFrmJYbLe6EkVUx+joCo
	lps6gBNNNqpSsWIZR2IN57+tzHLH0uvUHhA+VkNPsrEfmpq/wh6j7wD/pJFHtetXtgc7CzpqPDR
	3tSEu143vN9gDjy/OR1fJLDiqpqF1bzcq+ObiwRo4na7zW+iZOXKsehJMj+Z1uRcZqFE04lLDfT
	Ksj+z
X-Received: by 2002:a17:90a:dfc3:b0:36d:b9c5:e8f6 with SMTP id
 98e67ed59e1d1-37d15e8fc41mr1301668a91.19.1781817828880; Thu, 18 Jun 2026
 14:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com> <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 18 Jun 2026 17:23:37 -0400
X-Gm-Features: AVVi8Ce8s_WIlgIy2ohBsx_jvbsGcBz50IzgE_dfhfgplp5HZVSUYqUF8DK4zSA
Message-ID: <CALnO6CAeSbjJs9Cb+C7hukBBy2KW0x3cjLTz5WMnG-BuaA0DGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] history: add squash subcommand to fold a range
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 3:17=E2=80=AFPM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Adds git history squash <revision-range> to fold a range of commits into =
its
> oldest one, reusing that commit's message and replaying any descendants o=
n
> top.
>
> Changes in v3:
>
>  * Moved the feature out of git rebase and into a new git history squash
>    <revision-range> subcommand, per the list discussion. git rebase --squ=
ash
>    is dropped.
>  * Takes an arbitrary range (git history squash @~3.., git history squash
>    @~5..@~2), folding it into the oldest commit and replaying any
>    descendants on top.
>  * Implemented as a single tree operation rather than picking each commit=
,
>    so there are no repeated conflict stops (addresses Phillip's efficienc=
y
>    point).

I think I mentioned this, too, albeit indirectly. I'm not concerned
about credit, though. Just excited to have this.

Thanks!

>  * A merge inside the range is folded fine, only a range with more than o=
ne
>    base is rejected.
>  * --reedit-message seeds the editor with every folded-in message, not ju=
st
>    the oldest.
>
> Harald Nordgren (4):
>   history: extract helper for a commit's parent tree
>   history: give commit_tree_ext a message template
>   history: add squash subcommand to fold a range
>   history: re-edit a squash with every message
