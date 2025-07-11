Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56371DC994
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261863; cv=none; b=K5a/z69NioU83WYqvVW/sAOWTSJapvXnN9M4FqeQk9pHxvY5nwqGBnCEfHqFOnG1oI+oX6iS5isCq5kRi9VUTmMmWrKVEdW8QkMEGZIOCkmP/qFmQ4aQfDL4dkJRHFzHBdyQQHCfduNmyF7SjBKxMo614kbO+B3m0ds+Aqxt1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261863; c=relaxed/simple;
	bh=ptFU/abQs85p+u+vF2QH+B0fHdAdzjbsqsHZclFeiD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adUoSBWst1dOnRMqhlqXazLc54To6MgA5sfMZvrQSVjEjC2iSmNua82TPMJAm0t+nRE2Gsj8vSTQNdqLYl5YsGTT6yZG0UUZmmKzfhR/5wRNTRv/pyu/RLmJUjpM0qnlRBZsOHZ90we2lF325RmC1NqaI5o86eEUzJUjW47F1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1JPUNNa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1JPUNNa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234d3261631so20530465ad.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752261861; x=1752866661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYLTRS/70WrrqJNj4PwtdjrMJOK2FBtIx1M1YtbjHQI=;
        b=K1JPUNNaUgJ1heSQMuFByD4GP206p19PUpWeih82jZ1MYWKXWqhy7NC9Rkh6nojSWk
         F9nphP5c4y6SU17zx9Jnlwy6A63SDE3jqrAFcmMAvkduBd1FrmsQoOFDYQ+NbO13a81o
         V6JHFg4CUnxQY4Bx2HNGyAlwcA9gqs0OZTOYmuFz/4oH3cEYbfleyxJ1NUvuF7ILjyt3
         gxZSFnB7JJ7zYcM0a9O/My4MWcYpaefezhFqyXRqvcJhnjIMMD3aii4aL/lnM6j86dd5
         CCOzCxM0PM5DNV35V1eqnh8CJsq4ZPxsLT90/7BMUD9KWa53OMP64sVpVbK3HM+A0CG+
         G3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261861; x=1752866661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYLTRS/70WrrqJNj4PwtdjrMJOK2FBtIx1M1YtbjHQI=;
        b=MzHbPNanpMK9U/XaW2C5YdsV5p1OR3SRCFNLWfrJ8PBI1tiiGo9jis9OIdVX+cWf/f
         kOnLrASNwkFmltPIoEoz0mnWd4y2OqQbYzXzYDf2tAik60dk4jsalnGGcNdp0mytAPIP
         fMmZeueOBC2eXK8nShQiFdBXD6El2Jc1EA/zIoplIea4SCA3/VgQQEAlOF2oEeKXHMej
         6i8WDJDfhlOzpyEMIZj4PbzuBzxLKivGJ2pEUQ5ksRVNwIJcYRZ+a+PPtJSC8O8Yzmn1
         jxGTldjlIaQu+dZ0FDpY+3RKtfxY69/cZgaHxfLT4IBlLS5tF9zLOBlqFcb4piQSVQw6
         qSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaTqlUz8kqePR70CLHnd+G2HtEmXUhQZlMrRBiDN7xBCrUDya6EMrd5bAEMcyyhKFmhzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR4MNJXDNITULCyA0BiEioFk+wbHkCTheOOxIU/emOdvIUc/o
	/xWUgJ0pd7xdrCkXBm9mrN1IlqTLIkiYrBSSVwyi/QIJ7AS67Y8D12eKfFtZM2L7jELf69pkoqU
	vyFuolVJGfQ9gMNCEUPWu2j8/RJI/BD4=
X-Gm-Gg: ASbGncsJ4BgXEQzvYAQOEXIP8p8576qWRWGvdGaNt1XR0hnOW91RVAOPPZHz4iraoT7
	TwCmkUskNGQK7BHsr9IEfRgLWR1Q8M7GdqTcaFTPrOYddIbsfHSj73gf166EfMzb9nOX0w9uJIA
	lGluHq78V4RBxiSXwS1PRGzNiodGADTnRp6vWYuZNbJWy8sNmnNPwmfWq7eL2WQ+GyH8Y4s++z8
	S3RlYyPEulWKIHFql9c5OnYzKujFhSPn2EwQhDL8WXi2u+l6e2W
X-Google-Smtp-Source: AGHT+IEgtDN4MJoovpZ7Qv+E8kml3T3SG/VO6wz68RE+zx9H/Fm0gpn+IyLNzQyR4+VcB0zWQbKICAXLtd+hkqU2/Ok=
X-Received: by 2002:a17:903:46cd:b0:235:655:11aa with SMTP id
 d9443c01a7336-23dede92f44mr61841285ad.39.1752261860858; Fri, 11 Jul 2025
 12:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751309770.git.ayu.chandekar@gmail.com> <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
 <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com> <CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
 <70a10ec5-9fb7-4b7e-b4e3-3d04fb44c23e@gmail.com>
In-Reply-To: <70a10ec5-9fb7-4b7e-b4e3-3d04fb44c23e@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 12 Jul 2025 00:54:08 +0530
X-Gm-Features: Ac12FXzazpDMwvt_QlBwh96Twnv9tCW5N_vCb7Ds30_C-SeRVmO_Re-WT411f48
Message-ID: <CAE7as+YFRk_ZsOUQrnMivHhaG9s55Mmh4qGrJ6B0sOLWZQh-9w@mail.gmail.com>
Subject: Re: [GSOC PATCH v5 3/3] environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	gitster@pobox.com, ps@pks.im, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, Jul 2, 2025 at 2:31=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ayush
>
> On 02/07/2025 00:53, Ayush Chandekar wrote:
> > On Tue, Jul 1, 2025 at 6:48=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >> On 30/06/2025 20:27, Ayush Chandekar wrote:
> >>>
> >>>    void clear_skip_worktree_from_present_files(struct index_state *is=
tate)
> >>>    {
> >>> +     int sparse_expect_files_outside_of_patterns =3D 0;
> >>> +     repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideof=
patterns",
> >>> +             &sparse_expect_files_outside_of_patterns);
> >>
> >> This changes the user facing behavior if
> >> sparse.expectfilesoutsideofpatterns is not a valid boolean value.
> >> Currently git will error out when it first starts because that config
> >> value is parsed by git_default_config() which is called by almost all
> >> git commands. This means that if someone sets an invalid value they ge=
t
> >> timely feedback that the value is invalid and git dies before doing
> >> anything. Now, if the value is invalid, git will only die if this
> >> function is called and it is likely to die in the middle of a command.
> >
> > Yes, I get your point. However, if we look at settings which are
> > shifted to `struct repo_settings`, the behaviour is to set a
> > fallback/default value in case of an invalid input, instead of
> > throwing an error. This is done inside the `prepare_repo_settings()`
> > function, which is often called in the middle of a process.
>
> I'm a bit confused by this and I'm not quite sure what you're saying for
> a couple of reasons. Firstly this patch is not adding a new member to
> struct repo_settings, it is parsing the config directly and will die()
> in git_config_bool() if the config value is invalid. Secondly
> prepare_repo_settings() ends up calling git_config_bool() and so will
> also die if the config value is invalid rather than setting a default
> value. In the case of prepare_repo_settings() commands that do not want
> to die in the middle of an operation can call that function early on
> before they start doing any real work. Looking at the output of "git
> grep prepare_repo_settings()" many do exactly that. Here there is no
> option for a command to die() early on invalid config values if it wants =
to.
>
> Thanks
>
> Phillip
>

Yeah, you're right about the `prepare_repo_settings()` which throws
error and since they're called early on, we are notified about it
before any heavy operation takes place. I had it confused as it also
stores a default value if there isn't a config setting set. I can move
this setting into `struct repo_settings`, and since
`prepare_repo_settings()` is already called just before the function
that uses this variable, I don't have to add any extra call to it.

Thanks!
Ayush
