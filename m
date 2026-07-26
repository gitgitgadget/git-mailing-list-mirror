Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038513C13FB
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088798; cv=pass; b=k5J5EMOIzoHJ5hg7veqX2Y+huQF+0i7ONeHFuAVRACI1d9zuCC/NsvnnrKTsQR/xC7eZKu4PxJcmxWSFjPrYICcj1DxOJiEpYO/MEAhXreXHEt1ld0V1RuIOwL1Zyt/0htw2DqEUaQihqR3+GSl+V3ZvTJxuC+HrDpLgJjCTWSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088798; c=relaxed/simple;
	bh=oScZxzD5wbk5GKpZ+RHcH83mMUBAuhlJz2zeJGLnYCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HssBQWoBK9mhb/KXG44oHK1m9G0VasFUW1CYrN67bEI/1cErtQw+i4oelEdrTTNW4IF/cWWysFsLv8tnmIPDFkZAWRDhLuotDSeQtjuPKaTIPqDKuH9G/+rMJO49JcO+ZIFxxjmuyykFBmzVy9rTe5qb/k10nKaS1usLwtam5Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5uRRXPr; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5uRRXPr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso3123328a12.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785088795; cv=none;
        d=google.com; s=arc-20260327;
        b=ojL3JI6zXg8d3bO9k96PdvM1bkKDjdsFH6IOxG9NtdJd2axmuhj6g1dA/Wk3OrJmtC
         luYonhf2/ALHP6GDcwPEhuofTEHIK6GYVBvhEO9DPUyWXRpeQJHSDWMN7sQ8IC3timiu
         dejriyFMLmPzLQ5wtcOjZx2X6CD3Y3rPXNV5TLuEeuqXAxweAwrocA/8XzADNVfNc5ua
         DJQwy89eWF0smS9GRicCTcjWmGgXfCdMN1XSFXK0/HR6SktYDxyqd00n3Xc3IILhBOGd
         n4NEGV9Y2kWL77gdGcfX2oXRLgi3eZuB9KEYa0TzFlg/4yk8pfen30XFk7nxyypac9L7
         Z3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7GvnEEppQ/s1FGLgIdW19vmGzL2ANouEtnB+sf4s0M=;
        fh=yalKYYanIEb5jv9++9i5BrL5Bp5foLKdI8QhdBQ/xhM=;
        b=EbMvLigYi5L4qIdBFtLH9qKIp1oH3R6l3Yw5HPJ4wMIOiSaflaY/0xfYPyl9sgNUsL
         aecn9siVoKrCXBRL/YIMOBT6JE3fLXPk2oqkn/QjVERQNEdO/VO9pzyxjq1u1neTGqrv
         nWs9bpzEhp+sn77JIkXUYazDP//jIDVI5VAMEMVidsnT4mfP6oLeDD4JFjXA01ml6SXH
         KjmyNRs7SrEhxzsRLBcX+PcMFXKf9c7lIp3YqwH3BrLHbVXIzLErjIldEXLcdEl+Q8Ge
         IcvNcbq2+Vg73XiMRW6bBjFBwtluCAMksNVx1KdOJtOt2In4QtKs8RYFr2yi9EC1KzC8
         FTlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785088795; x=1785693595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7GvnEEppQ/s1FGLgIdW19vmGzL2ANouEtnB+sf4s0M=;
        b=C5uRRXPrmGmc2ZeZxD6VH77/DYux/jVo99z46E2bgmdDTtXl5WyLkXKGoSTHZ9TEfP
         IZKCq+ZWCcnhLqPafVi2N6o066/L/M5Uy4AkRpHykSah9lEsO3xMGxtnKojEMgiIc5f4
         P6ZBiIrgC3A/YIiU/ksMLj2/OaHsMtzGgbnh705eoOWvgtUAK7MquZtuL1k+q75u2Idg
         rwz1KULz1PdGcGOhwesudskES9b7X489XHFAWWphQP/6StS7p+uXaR76kwjIIn0J15v4
         R7KTPtP0ORMBvPzdlJlVRjczhEcHbqGXyGAWmv+60NQcp3n6ijNYt9JKi5AusrNYMhh3
         1fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785088795; x=1785693595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7GvnEEppQ/s1FGLgIdW19vmGzL2ANouEtnB+sf4s0M=;
        b=h2YrF9TfjoC/Qs2X06Ot4hOHbkEOKuFcAY/HhxT9a4+Yi4gcjSk9gxKUjcRycD8GAm
         E9WBCaWL0k3vMqvR7AlsoNH3BAIGwB7JIBHCVdmHyx32IRifRD6yhDn456BIH6oKCF5n
         BI/WUmSzxE/iSS2k4HlTLfzhnLO1TS7rhc4grKG8q/+YfpcdnF7xkowHJbkmBoPA4JzO
         HJUxo//RDRleYqn4/ezOOltv0F4uD5JTSj5KQ00VIL/dDSXr7oqFOxsIJl+g67CG8kcs
         2K/0v8hGCl8Xg6qRa41OP54+CctiFXa2Y4Dw1CVP6NLxDIMmEbZ8xtOhizEhNb86cPB/
         mFvg==
X-Forwarded-Encrypted: i=1; AHgh+RpK8Q2b3boWDPK2di4Xelaa46Ay2MpgfzJAS/myTzv/mZzX0gLbmdwqgFeHKgIkcFm8FFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjBX6zMaZLmNJU3mn7RSeqsRDWCAv+yLwsqYfrLR9l+2W7841
	8UMggx7nb77wQ81Fr1EuTSiA9MV6nCObu1cF5M5Up4NplL0WGKgQn68bnxSBuDkNPZXQpUMeto8
	dmndVfVEKU5PBnvSIb6UZ+smYYXSlAYo=
X-Gm-Gg: AR+sD11hLv/EMsfaILnEIgDTvQ3NHD4IaOGVPn9Uc2KDG2fffgOyVMPBVgTNpb7/7Aq
	KrWVpZxhA5dpvEnPIDSxSLgAqYgKPok3hilqUr3Vrgdvc3LfRKoPNm9SGg60Js3Wq/UC44VxrPi
	44QPOiC895P9Wa9Lr61lVxZkpyQJUSMndMnO+du8ejUi4ztJ0IiiPx5qFqilynfyT3aYwNtxnxh
	7bvtP2r4IylHuarrs5XvFv3n7sFe3Gf4uJNorgtniR4Kn9euMFeqxmPJ3ij5oofZAHzOWX/sNZ7
	xsZvRLa2tuiLX8D4+abu
X-Received: by 2002:a05:6402:354a:b0:698:d6e:bea7 with SMTP id
 4fb4d7f45d1cf-69fc100538dmr2190719a12.14.1785088795005; Sun, 26 Jul 2026
 10:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
 <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com> <1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
 <xmqqo6fximn2.fsf@gitster.g> <CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
 <xmqqcxwdcmln.fsf@gitster.g> <xmqqik61yeyn.fsf@gitster.g>
In-Reply-To: <xmqqik61yeyn.fsf@gitster.g>
From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Date: Sun, 26 Jul 2026 14:59:42 -0300
X-Gm-Features: AUfX_mwbLDQe8h-RRn3na0hXH0Q6XJluHP8z5zTe7Lzi95Po9FV9Jnx1abRsKDw
Message-ID: <CAH01Q-_k1QEcTLTMygBceUWjGNFLNewixf80bYOD2_s20jajrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory before renaming
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em dom., 26 de jul. de 2026 =C3=A0s 11:59, Junio C Hamano
<gitster@pobox.com> escreveu:
> Think carefully about cases where 'a' is a directory and 'a/b' is a
> symlink, or where 'a' and 'a/b' are directories and 'a/b/c' is a
> symlink, and so on.  We do not want to craft an arbitrary rule that
> says we allow or refuse to operate depending on the link target.

Thanks for pushing on this, chasing the symlink case down turned up
more than a bad message. With a tracked symlink in the leading path,
"git mv" leaves the index inconsistent with the worktree:

    mkdir repo && cd repo
    git init
    echo content >a
    mkdir real-dir
    echo content >real-dir/b
    ln -s . c
    git add .
    git commit -m "initial"
    git mv a c/real-dir/a
    git status

'c' is a tracked symlink to '.'. The move follows it, so on disk the
file lands at the resolved path 'real-dir/a', but the index records
the literal 'c/real-dir/a'. "git status" then reports a staged rename
to 'c/real-dir/a', an unstaged deletion of that same path (nothing is
there on disk), and the real file untracked at 'real-dir/a', with the
symlink 'c' also shown untracked. A later "git add" did reconcile it
by finding the file at its real location, but "git mv" on its own has
already produced an index that describes a worktree that doesn't
exist, it got there precisely by traversing a tracked symlink.

So this is the "not careful enough" case you suspected, and the fix is
the behavior you described: refuse to operate when any component of the
destination's leading path is a symlink, independent of where it
points. I'm thinking of using has_symlink_leading_path() (symlinks.c) for
that check, which is what "git apply" already uses to avoid following in-tr=
ee
symlinks, so the behavior stays consistent with the rest of the tree.

For v3 I'll fold this into the series: the leading-directory check will
reject a missing directory or a non-directory/symlink component up
front, which covers both the original misleading-error case and this
symlink traversal. Tests will cover a symlink as the final component
and as an intermediate one ('a/b/c' with 'a' a symlink), plus the
existing missing-directory and dry-run cases.
