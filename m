Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB673DCDB3
	for <git@vger.kernel.org>; Tue, 19 May 2026 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177194; cv=pass; b=TJfr15EQvSHCdt7QtGlvBCGgGb1uFRrHMi78aE/xwC9nvoFed3P+3yKKeB35ckE7PW9CuVAlUtVWNULEwsPl5q1PFQ5k/KDxD40vZwl2aRH3F/3q4EPBt4myQ4/9sfqaOdOpfIy+JfpBkqJPhwB/2Aj37QOQtgBmaf/lQgqiCSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177194; c=relaxed/simple;
	bh=T9psKVm3ucv2mJPEQnTETQ8bjC7yYKoDQz1gWOhEHWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHmaLrGgb+NvaImrWxgDuk//c2fRhGFZsfCzON72nZAZn0sDDvRlEYBwoz17M4dT/FjgKi3LjfHHi/Tkh63Og83SbpVrLPn9ec+npBkYD2HrvRZlpvRJwOlniqlnXnlaDvYp1wni3Rn39rPfbeWLWgcFdcMJDOJ1iPd26aRfKZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY/eYzbX; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY/eYzbX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so650988666b.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 00:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779177191; cv=none;
        d=google.com; s=arc-20240605;
        b=MFZtAeLFoQJ2zZsIjG8rUMD+syjNbLq+0escFDxvefHZITwaVqcJ9+8gzfUkblPK8V
         QEJcu91lyj9ckLGqpKZhH8cRXzIh6YuYiua6JzARJ56jkkZy4nmRWb0EOKd0zaxz5+Am
         Wj9v9YWqimJfZnyi+ERAXwc8ADpI1Fyl8FSSwV30ASga2RGeq5Srgy4LF/hk5o8vLj3K
         JgeN0UhCPWw3FdiaFjrfIHqsw7iQyr2z389YhlgOsm8zbHUNh7+UX9iYYQ1+TKnszmDu
         EwFCSW8e+zppAjQ2A+GBtRNija5m8Qx+W6DanJh8bJQefZXe9rICh0YWrkhpka5sx5x2
         DrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+W15FuNzqLL/MIaPImVeHaP9ocLzgAhnSdnkghPXCt8=;
        fh=c7nUBzOdd2EAf+G9aESRr2CM4Nx/BoMhjFGr1wX2QOE=;
        b=FdBKxptBcR1CYeL5WXHwL/wG4FcwjAIjGRb7wi92PMI2iNC/rYPuYMnbF4UdB+Glvj
         Cd9nxlENIe5t27xLIfz9x2LWukTXl2ISOg+RIzUal1b/1EOHi6M1nQsEO9uM+spOQI9x
         2UW0zuMeziRkbnSd+Hi17Tzzi6Ggi4LHlE5hLce4BcKhDgc/4I1GzHuWPsb+hLYzl2D+
         eODODRa1AmRjSd0PXTom+HbqIgB+1oE4oZXrO8uC10tlg8mbGZBntgiEQr4IifNLWaFw
         Reci/k8sji3fbiPIaEeFZBc4TEKmr3ZpPPK6vILBAz6TeVI9P3LWDAlu4M/WYFTlHWqV
         kCJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177191; x=1779781991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+W15FuNzqLL/MIaPImVeHaP9ocLzgAhnSdnkghPXCt8=;
        b=DY/eYzbXkkK2THip+h9FvHPYVw02zQ6UqD8rrhnzXIfuMBHdsNbk2/xo1/AA4KcdWr
         pH72ECj/bcGY21eZwNOFzb0G3SPXntP9MksgpzXNYx4MAYUnNkJXD+MnzCR+7ZGNjpAv
         JlvgVPF4CYp0l+zLivd84ETHCG31RWnYc90Fwf76NYL9e7v4+rkq0OrjskIz61PfOGt9
         UWT1Wdz6csqF59i7qJEjSqfHlonKvmh9IIdCsG1VVWyhWHIuk+f8UWSDN8y+haGWSShN
         718oGnCf2+Rr569XeVFCoMF2pcH74RvyMfcSrI9xjpnNJ6eImp8fcp1BsTgEIqLtoTBX
         RzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177191; x=1779781991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W15FuNzqLL/MIaPImVeHaP9ocLzgAhnSdnkghPXCt8=;
        b=G0kfc6kDBPfekwyOiEFdzjE8OWPY9GTXcN4Vt/e9Y/N6BZ0QHlPs5lKCNEv+eeRbT6
         mEf729x3RtdrtL9eULa0Lt5w42vT6VidCiJlnh0QU0TniQWflJ+OQTafHxKLfcSba4xd
         CIetmZ7U2LliqNTHpVR6qLNARZdyZbJrIu4Aha+z+VS46h36QMnNrlzDbp/2sTI41fhq
         KodPEZROofNWI7uEzXumMq2GlI/aUklw/oLhkCCWVb0YtIk4SnGOYayNU+K0S6l0qA4M
         jxZjvUad1wVBVq3KNxfk+fEss5590gK2ymeoUeXS/XrC6GjdMP1PAcfMkPQzSI380fFk
         k39g==
X-Forwarded-Encrypted: i=1; AFNElJ+/HonUVssnPYVxpFckiXeorEpV0mfNTc81wDsl8TWMCZLVdAcy803alXa8NkXLqjn08jI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry5Xhal/LwPrPVJiG46g+OETMBcZcUs3939+ybnDTOzUO9ZyK
	lYQIgtN3mWO5zzTUpjrXRUb5Zqtid17ZhU/It+/Zsk7tZRPS4cQjVX2zrTbvR2mQtCxlspqR4XZ
	X/5XRv4ryKD1psOyXtYjP58GDwjqTAqQ=
X-Gm-Gg: Acq92OG/5eDz1ixpq3QEJWsaxttKSUbGruaau+GNxK3qCPOlcDrofUPSaOGr2mWXsLZ
	j5ve2QSr6knLzbdWec4/Wai/r946RQmBjd9xEGUB5LWT6bJJOVPT5M3xOlvHF12hYvWHWFY66Ip
	NS8XokisSG2SJ6bFa6BcJVmkGTfb8ibQ6znKXu7JRERS8IEGC1VjFfxbXpG7KqKa+0NSRoCg3X0
	4XtkaRi7KQWyH0oG6N9u8tIV65QGWBmyNNrBU+wTzM2pGeFUi24wsq1c7skbx57sggGWZgneCg8
	W2JK7+4=
X-Received: by 2002:a17:907:6185:b0:bd3:c952:9b2f with SMTP id
 a640c23a62f3a-bd51792c271mr643346866b.37.1779177190564; Tue, 19 May 2026
 00:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
 <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com> <xmqq8q9f9b5w.fsf@gitster.g>
In-Reply-To: <xmqq8q9f9b5w.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 19 May 2026 09:52:34 +0200
X-Gm-Features: AVHnY4KCQKtfoP66rjQn17iEPtur1msNX9jm5pWfkJS2k_uzHxzgY1_g7-l_ebU
Message-ID: <CAHwyqnUx=59MK5zKL0uuFXKrZ6PEc1j_2WT-_xtsGewVH3gBKQ@mail.gmail.com>
Subject: Re: [PATCH v10] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > +     strbuf_release(&dst);
> > +     *remote_out = remote_name;
> > +     return 0;
> > +}
> > +
> > +static void fetch_remote_for_start_point(const char *arg)
> > +{
> > +     char *remote_name = NULL;
> > +     char *src_ref = NULL;
> > +     char *existing_ref = NULL;
> > +     struct child_process cmd = CHILD_PROCESS_INIT;
> > +
> > +     if (resolve_fetch_target(arg, &remote_name, &src_ref, &existing_ref))
> > +             return;
> > +
> > +     strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
> > +     if (src_ref)
> > +             strvec_push(&cmd.args, src_ref);
>
> What should happen with this configuration
>
>     [remote "origin"]
>         fetch = refs/heads/*:refs/upstream/*
>
> and the user says either of these two:
>
>     $ git checkout --track=fetch upstream
>     $ git checkout --track=fetch upstream/master
>
> We fail to find in "where does the remote name ends and branch name
> start?" loop that this request is about remote "origin" at all, no?
> We may see in the former case that there is
> refs/remotes/upstream/HEAD >that points at "master" in the same
> hierarchy, but the code thinks "upstream" is the remote name, which
> would mean you would "git fetch upstream", when the remote you need
> to fetch from is "origin".
>
> > +     cmd.git_cmd = 1;
> > +     if (run_command(&cmd)) {
> > +             if (existing_ref)
> > +                     warning(_("failed to fetch start-point '%s'; "
> > +                               "using existing '%s'"),
> > +                             arg, existing_ref);
> > +             else
> > +                     die(_("failed to fetch start-point '%s'"), arg);
>
> If we failed to set *existing_ref_out, shouldn't we fail without
> even attempting to call run_command() here, as we will have to die()
> anyway even if "git fetch" succeeds.  For that matter, it may be
> simpler and more correct for resolve_fetch_target() to fail (return
> -1) when it happens, by making the lat "if (rest) {...}" to have a
> corresponding "else { return -1 }" after it.

Yeah, good point. I will try to address this and send a new patch.


Harald
