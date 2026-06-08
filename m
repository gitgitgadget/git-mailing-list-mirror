Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DA23395E
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915983; cv=pass; b=VD9laMVLWWcjprw3j/4vpgQAxt4GflgGoE7IAjRAE2pF0rhPIBiw62P7ZSrcvKsB32NVoKDj7v9uvEgrs0jev/wR2sNU8OwzDl8/GcCepTIYsBNV5geKyWLkrLmxU3gAaJQ2USEFHiYOnx9tYz/YTz/MjtGOXR2IhPBMmZ8wDrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915983; c=relaxed/simple;
	bh=sBXLRfcLUOF6XAxK/QsJGWKRCoMP/T8tt2OGsQ2kuF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdNE9m7fRBauIVkCr33PMAa2zdYEZp/3U6dBDWNQFokiT7LmkzXXldCL76L9x4nBooV1C/SQfmfLmLuJptqQjECKt0qvwCQh84h2jdYIdvzIHyOeRmFRrnwXZpSW+5bCrFPkSP76JWeU0Xu2CUaMkWUn4NKiyUBq9t0jquIPeo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/ZyWmcG; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/ZyWmcG"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66058b880e9so4059319d50.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780915981; cv=none;
        d=google.com; s=arc-20240605;
        b=Ct+rAa5tUVm7hxGhD2Nm4HPW1VP2j6QtZvEpXnDTpZNVV1zf6EZdHsw3XD1Hir/z05
         BcQ4eyyC7or7Ise8B4nvviC0mwJN3qz9dtpg+qI0L+sO8wXVbPSAgiOvhPc6wBaiVNJC
         QQWbjVMXBtfqw+rMwE6jTQQMmeF35EUOsIhRx7ZOIfEq6IcjpAka5l2E9oyovtTyw58D
         fG1aEK1ZlnCLrKMrk6a7/vhNgDv7gJYP4ECampTEO8nxNtzwDa3VCoxpQ1QZMFcFvo4V
         0cq35n7jKC19Kjp7b7KqLYbipISheHrHzor7uEmjPgSokKkE2ttWBG6Gaxzr/YBGgZ00
         gG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pw/gGCz3u1h/W5pKoXw0YfMenTC8ekuqZznVNQ6YM9g=;
        fh=VCjcCoJq7R8xNj3e1ntUBnKE45cB+lDpV06/bP9wycA=;
        b=GLPlKeyoFmDQuGS4YDShXBKWOkW70tiK+DnNXOsxNmja/liNF/iK6WME4kwIK/qb6+
         XKmfX2HRSda515NuNxwRABckgXvTakVAS7wILQ4ss+8kS88C0KTZ9qsjKHYBnPejFAFX
         gO77JU/2RXBv9mmWuW7e5wd7xRyfvRkT6UNquLXvaBx4p1rduL5fLKztPMTLSVMIPWAE
         miSCE4e46QkjBRyXt5rtsUdsPR30+fESnZ/QrbqobrXh5a7QWuLcdNHjavDNEuAi/3Vt
         oX5+3iBORrvT01xPu0qkblZ6vClGl2neTQaMJJSKwEcoTItg2BvNo9bSywskvs08Wk1P
         byZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780915981; x=1781520781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw/gGCz3u1h/W5pKoXw0YfMenTC8ekuqZznVNQ6YM9g=;
        b=r/ZyWmcGAFGgim9gBZsy6W5/46NZkiAE1rmhFPIcUAfbEau4J01OjTsZTvBQyCz0a5
         YLQeAUJPr58AEZlXrqFiB3M4oZJUtdqdPbAQ5d3Vxz/roL6zOV9C9x1T6QNvJFUoUOho
         QP8N5oVWKwU9QMqoILbOKQvfE/Y2q/dlNfxypkHstvke2eKsFKslJtE8y0g9vkojg2nF
         U27C2Yn3nhghG+1bkliOcJa1/wG5h2EDTyd6TdNzydWEvAzEnHtphCwrdhS3SW9oWwlM
         HgCvValcxPeDmEv1id6ArFYGj16cphS1nS+ZF9rg6FrmvkmaWD334FNNtwQXLV4FO1dj
         1uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915981; x=1781520781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pw/gGCz3u1h/W5pKoXw0YfMenTC8ekuqZznVNQ6YM9g=;
        b=WvbpfiU/57V4CeUVs0KZLo2D54mbxQKUWM2fYw1osl+WMbfLuN/BPLiisOjegoJZBI
         qRNvCG6YEtMmsjadgY+XOgMiJ+jY6UccPPNf5bRj/puxef0FnP0uLCKNp5PKql0/OZbQ
         gSq+W+hY4yot7fy4pUMb9nLdpSTfXeJ+dVlsdYemr3AeAQ4XUzEqQ+WOrGDxlK0RKByU
         EssyiV7Q5p9nIsTniTS5+ANnzJvI0J2T3R3hjvVY0Z3ID6w7M94Lqe4cBcRbIYoXCzcT
         a5ZpgrlgG0M8t0+3Fe2oQ7iHiSZnPfQFMikEMRYIWSOGu5ZDSYmZUenoM7RJGe2AP1HZ
         aNOA==
X-Gm-Message-State: AOJu0YzCsvxKR4SDSWqCLNte8E+loHeWEFtbVrczYAwsHn6Fue4RQWpO
	+xGCCW8TH9Mpg07puFObHt9SOgiYJnQW4v2+MGCrqYFiqji9z6rJToHuewtudXwRFVPPgyqYluK
	wDhlfDl0FZjHEtymLmgnyGw45dfD5c4o=
X-Gm-Gg: Acq92OHgpqkyv+IdY7ou6l2xY3eyCFDCn8MPVCDQ7IZe9MZ/0v4Nri/RiXpitIL/fq6
	SEPyHa6hpVCLd0dS+4QHDwpN8ggPU4cJC/NPBw8hAW+kzw2wYAvciRMGnRQ2dAyYuf7ZcaHS3w3
	phZ8dUWMKLoR3xPxYl0flZYYiGOBPAK7Cjm8fawkwlRNQ4LRNnmjI/159urALKx9XSHcbEjYf4p
	pPYIAaenvypbd+JzbARjs8a7NWML6V9Mr4GinFL3zzJoz9qtwUMlDQV0689frwZazjaZclsFpA1
	1q7FDIWLUxBtQcaRqxVU1L4la+baas8fRcoMNzec5T0wYjXaXtwL+wueKdHuvaZCkBRI6ACeil3
	CSjNSpFyqoo/eG8PgN8R/x94uVaj7gDmWhWZfk+3iYTj8n8fwRd5Od/X6o2q3FfefUX4hC3rdrK
	pcc2H5up6V6E29
X-Received: by 2002:a53:a68f:0:b0:65d:b6dd:69f3 with SMTP id
 956f58d0204a3-66107026651mr9736120d50.36.1780915980934; Mon, 08 Jun 2026
 03:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com> <aiaLxNwGPko5HS2G@pks.im>
In-Reply-To: <aiaLxNwGPko5HS2G@pks.im>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 8 Jun 2026 12:52:49 +0200
X-Gm-Features: AVVi8Ce-L_UYsvMb7sNySyS9_8g6MHLsgqjdAzv1CwAUP1bDVtPcAx7LdyZibLI
Message-ID: <CAN5EUNSAOMRvmLGVfzQiwWoOn9VGNVU5rVMZizOryn_q2fbCNA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 11:30, Patrick Steinhardt (<ps@pks.im>) escribi=C3=
=B3:
>
> On Sun, Jun 07, 2026 at 10:07:20PM +0200, Pablo Sabater wrote:
> > When using `git history reword` if the new message is the same as the
> > original it continues anyway creating a new commit with the same
> > message and updates its descendants, modifying the history after this
> > 'reworded' commit even though there was no actual change.
> >
> > `git commit --amend` and `git rebase -i` + reword share this behavior,
> > however `git history reword` is different:
> > 1. Works in-memory without touching the index or the worktree [1], so
> >    there are no side effects like staged files that could justify
> >    rewriting the history when the commit message is the same.
> > 2. `git history` by default updates all the branches [2] that contain t=
he
> >    original commit making it more costly than `git rebase -i` that only
> >    updates the current branch.
> >
> > Add a check if the original commit message is the same as the new one
> > and abort if so.
> >
> > [1]: https://lore.kernel.org/git/20260113-b4-pks-history-builtin-v11-8-=
e74ebfa2652d@pks.im/
> > [2]: https://git-scm.com/docs/git-history#_description
>
> Nit: I feel like both of the links don't really add much value.

I'll just drop em.

>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  builtin/history.c         | 10 ++++++++++
> >  t/t3451-history-reword.sh | 20 ++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/builtin/history.c b/builtin/history.c
> > index 0fc06fb204..51a22a9a1c 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -135,6 +135,13 @@ static int commit_tree_ext(struct repository *repo=
,
> >                                         original_body, action, &commit_=
message);
> >               if (ret < 0)
> >                       goto out;
> > +
> > +             if (!strcmp(original_body, commit_message.buf)) {
> > +                     fprintf(stderr, _("Message unchanged,"
> > +                                       " aborting reword.\n"));
> > +                     ret =3D 1;
> > +                     goto out;
> > +             }
> >       } else {
> >               strbuf_addstr(&commit_message, original_body);
> >       }
>
> We also execute this logic via "git history fixup --reedit-message", and
> here it wouldn't make sense to abort the commit in case the message is
> unchanged.

True I hadn't thought that, I made it here because we have both the
original and new message before creating the new commit. We could let
ret =3D 1 mean that the commit message is the same and then
cmd_history_fixup ignores ret =3D 1 and for cmd_history_reword handle
the abort.
What do you think?

>
> Patrick

--
Pablo
