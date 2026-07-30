Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999E3E7631
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410606; cv=pass; b=Tn15HusB3ZvYkjWC5vIdPidBEPqaNvfOirDMCrf1mWp+JFD9GafzvQfC0UgI6ACNLv4PIdrUupCz/BtzzF7sJLFWn/urL/6JUhE4a7qafUgCUMlA5rnCqchT3ztbDnPWUswWXBn2+rcCccndVJR1HQoN0eUPV48qwguEkG02mHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410606; c=relaxed/simple;
	bh=t5wVGl5Gwx4jaEteCzDne+rvX++N+vABn6IFQxobNec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCQdUV/nH55vnfzakebLoqD3DsLxnQxc24oeQJDjfJuMU3WRJh/Czyz3fCSLHP9VK5mi5teCLrno2JmCQr2kNDj8DvMMDTjE9lNAnykcMULEqcDW77mNx4XE/+1FvYmWqGdPeIC4gFZ4iZ/Eaau/T6X3v5+yiB9EHdAKANkQlFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRsQ+Kzc; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRsQ+Kzc"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso2837188a12.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 04:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785410602; cv=none;
        d=google.com; s=arc-20260327;
        b=GbjknuYaix/4SS99LF0h8epGqnHGvWkLcJcjX2nmZyWdgj178yt7nc1+Ch6yR6YMP3
         GIwyEo+HqMibLdAwaOSySAxYfkP89dYgzhlpNMQREIg6Is5nmFnHM1bcG5LhweU0flKA
         v+57ELOl+Wes2FMYdwr+ESc4/e/c51baxGaqou1Ddu7xWqWFGs6qT96djQNzk1FkeXGl
         g5t7KStZo3zLIuQOA62M7OAK9oYvNXE3apEOBAY005eOzceFfyU+DPZm3cZ+32vR4p4p
         /4yfMw8Yr0sQV3ebb3YDH7PyVouiBt/LAeJOm16lLBM3sTOOxjrvPTS0DM144MeNK2OV
         eBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qpKvgKUsGhhlG6SaIjVx521IOaKzFx0U5/rjLTzsMfw=;
        fh=GH8XPYWGLCUPyFTOuWQfl0Qw6x4ukAetJr+kdoc2S9U=;
        b=WTv9BiiZOoodEO8yrhpZdjbmzKtIZiVAxREGcAcsPqs5P40tE/GEw0gI+flxYPdKeU
         xLsWKROtzbO2SyJZMiLYBldSAvuZzENob1dN0gq9MMmm0RGvGpmyVulWOnUvmQ4a3S1t
         J3NcOsiRDJvLO+Un4XrG+Y4wlJ3YkDTTzWxV0RLjp9bg2NSLRdFX+9jDp4xtkj2Ijj/6
         WOmU+OZs8sBrqxW0V6fFl8Knt4crPJ+TKpcWEmmNSX4JosA2+uCDjIZYRM2aU9b8OSoL
         Iikmr3Y5XnVT+uL6HyAKhCGuiAarKpy8/X5ThSUSYjH47MWndeyS2+pIXaov8s2vAZtn
         bXOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785410602; x=1786015402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qpKvgKUsGhhlG6SaIjVx521IOaKzFx0U5/rjLTzsMfw=;
        b=iRsQ+KzcqH6GMubiCs2G8HZYe2l/QrWYalYpNvSSJXOue7tv6O2UvWfR/1hDz/JG8G
         PBTgwVwksI0oC5IvgjOAfjrJHgPMNCyMAnUtV7+YAQ1LJWDw2tnywnvH8URaY5Jxz9C2
         CxEjBICfmSeHYBB+l89RTzBTaOJzO4Kzbpb+5Y7ZdGGD+fAfT9nGWaO7R9KLlGk5x9JL
         dSeeSTq/ZLkWUM9V5revQB20MvoSP1Br3gQNLc6cxkRGmhRvDyCzBfHNn/R5P067GRKD
         yNQn36LVS9Ln2Leix1AIgtxZj7v+ctEvH+KUHhZOQyAU+2zUjP1Cb6Ta2pPckURD2wEv
         3n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785410602; x=1786015402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qpKvgKUsGhhlG6SaIjVx521IOaKzFx0U5/rjLTzsMfw=;
        b=RktGH277B1dGA9Nw9o94DV48R0RF3paRVSnB892tMtuBp03Mr2Ym5ZAobGibIyX3G+
         PzS3FmqFnuJIxKWsksrGL3qxgPAa1JjpBRVMFnGJG5S71GeYrmjFm1zo24OsVdbNxsEG
         e1X4nUdX/j244yspvrSY19atQx8qGuEd9vO9ArcH7ezuO/9hi/K3mQRCSHDD2IAmATxd
         rSA86mW+ESQ+94Hj8Gbhop+jhJIL84GuytTQXcvJrlSNa7arT+HXdYH6jsvO0SSuij7j
         i0WoQe4MGHCWqBFSSqSsdOPgAt8LPlhbD9NFxnWlOXlKcDgOFHGT73sA6Hz5kn0dr2Py
         vmtg==
X-Forwarded-Encrypted: i=1; AHgh+RrXOiWDYQEnlZ9SXut9sTAyO+8TjRHKdw0uhjthsSRol33ND3xXPq4hYSEcWmm0g9EXipA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0Ha2Wh3PbOuJAXJHCfiQMCqZFmJxSdF5yKer8g7+Fnwq27Re
	ILhX8aAniELj8yYvfgjWPSY3JmDiZioDaFrQjjpO4ZwMgEYJ2uCu0AGJV3NJGjC8Ry4dHw0rNhU
	Tz3ox9XnJsSvBQETbYNbDY+efWOKpomSLJ5twFsI=
X-Gm-Gg: AR+sD11CPp02+n1mf8T2NZrS60nTeinvA78q6SGTUSp80s6Lz1VZQUp/s50NjRb3lzf
	+z2wUPhk0pfqRVBHkwzZHxKrzt0u6070tTHs/Weq2EiyyTwlcbseDOI6tgTCGt2etbi87cmYLYE
	AXBGSNm+2P+3Ztsze9ZBRTABWW8qNF1hB9RA081UXa/duRrnEwCzDoPMpP5xN1EnMlMDW4nU6Tg
	BhNXhrCRVsul6coDCT2XrYVyj+IzHvrwpenFzNieCA2T/lqrHrAXzc8CT6mbYLlt3QngNxrK7MT
	pADYiRlfHPrMV9HHLfTpXSLKnt1PYSUiplLresjdzH6gYxrPPOU8AsK8YHWv1FqdGvndkzFum8B
	imw==
X-Received: by 2002:a05:6402:26c1:b0:69c:7697:e8e6 with SMTP id
 4fb4d7f45d1cf-6a07b892dfcmr1102690a12.37.1785410602195; Thu, 30 Jul 2026
 04:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
 <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com> <6b72efb4130d96947c7f90026042fa09a440d091.1785097071.git.gitgitgadget@gmail.com>
 <xmqqbjbsgjfu.fsf@gitster.g>
In-Reply-To: <xmqqbjbsgjfu.fsf@gitster.g>
From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Date: Thu, 30 Jul 2026 08:23:10 -0300
X-Gm-Features: AUfX_mz5C7ejL9eTqh-20tpuLNiiJ5yIFKniMYq7ezUq-GB6znVK78eOYzXYUok
Message-ID: <CAH01Q--Jeip3VvrYCOfM69ktvcR1gdeA6gVsQynd_xQ+cjsN8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mv: reject a destination whose leading path is
 missing or a symlink
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>, Pablo Sabater <pabloosabaterr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 27 de jul. de 2026 =C3=A0s 19:24, Junio C Hamano
<gitster@pobox.com> escreveu:

> I cannot quite parse this.  Do you mean to say something like this?
>
>     When moving a file, if any leading directory in the destination
>     path is missing or is not a real directory, the problem is detected
>     only later when rename() is called.  Furthermore, if a leading
>     directory component is a symbolic link, the issue is not detected
>     at all.
>

Yes, that's what I mean. Your wording is clearer, so I'll use it for
the opening of the commit message.

> This small piece of logic is a duplicate of the next block that
> actually performs the move.  I wonder if we can have a small helper
> function that takes mode and dst_mode as parameters and returns this
> value?

Done. I added a helper:

+ static int needs_worktree_rename(enum update_mode mode,
+                                  enum update_mode dst_mode)
+ {
+         return !(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+                !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE));
+ }

I'm not attached to the name; happy to take a better one if the list
has a preference.

> Are the elements of the destinations.v[] array normalized so that
> they are all full final pathnames?

Yes. When the destination is an existing directory, the setup phase
builds the destinations with DUP_BASENAME against dst_w_slash, which
appends the source's basename, so "git mv file dir"  yields "dir/file"
in destinations.v[] by the time this check runs. I added a test for
that case which succeeds.

> What do we do to elements in destinations.v[] that lacks a slash?

A slash-less destination is a bare filename in the current directory
("git mv file_a file_b"), which has no leading directory to check, it lands=
 in
the cwd, which always exists, so skipping the check when there is no
slash is correct. I added a test for that too, moving into a bare
filename in the cwd, which succeeds.

> then you need to allocate only if you need a copy.  I do not know if
> it matters, though.

Applied, the xstrdup() now happens inside the "if (slash_)" arm, so a
slash-less destination does not allocate.

Thanks for the review.
