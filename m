Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8F4A5EA5
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820153; cv=pass; b=TIhu5P3wVbEkrjWT3e9/SSgw+/1MeohKE//ZcD7Z34v3+ytWDriZlIJRRy63PkTxaehd/lM/TVXkxDxHEwTCvyRSRbRKLYJBCz3eG+m/GzZLoiUDkJp0/eLGhTq7pQNgxpwqw5TrFsIOSBSyga5q86i4V/d53UjLZbfuaCmc8kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820153; c=relaxed/simple;
	bh=np8K2/mxT3qH0z/2v4radxXMigwgZFTQ3D25BtgLI6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TN2ak3yPdjKIpwnteSzPN9qdraSk/kQO4Bardz1Xz0tI+JlqF6vgHw3rxpJ4biC9I9XuA0w+Jr0I0M+9cR+EslxcLW3wnn8F08IMBtYawkK5gdIKm3H8D+ZW86Kr7JP98wrgtyn48qe0qXKOtipzp3lElPfTbAGVIa9miWmgpHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYQAQWds; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYQAQWds"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398a5aad413so975681a91.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 08:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791820152; cv=none;
        d=google.com; s=arc-20260327;
        b=gV4rMB9K2rISh5t1fxXQwn+4DRqkG4RJppgRlS2TKDV9tKq0KLBx8KhfknPF9Ma3pD
         iUsIuuLjt0XMdGRbEds5m0JdhWzu+vJo73+IDkwKnljf3lJUYZy5gAwb1mb51WPA3hnT
         M33lFAbcU/wUscMBTqbs9su+v56kZaMHIdpjYNi9aAwBojGM6U1OXI6+5PfMfy2KrFYa
         oHnDVROOiHXPpccK+hG3rS0xehUj8VxqgfZ0eucMvYTa4/WUy4vcf7LuaPlG+4ROn6V4
         UA2yY7WbmrbAJPpUux+LsEG0efWeBz+22RjkLtwpkv9IZ1UWe3xznUO9O1lxHTw5Bm2I
         FnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7dtdkgpBwHriMRBfE2JlbLPVLAMgy36E+Pq+KQuxy0=;
        fh=E9y2fewsh3vIviLIkvA9JPzAWiNt/TEtUyL2XdzRY7A=;
        b=dUup740pfF1/L++EvbSUgHsTkHAvrTbV1jFwoz1bCSOpFjV7lnyp5lanYi5mRI3Yhz
         nD7yPkeCNj3vNGt6TDwc8WnQFrzJLSkXcMJBWzDR6CaKUc97SQw1hxQ9JrEH7YTcyS1Z
         uZtPBPKnHiz6iN5VJsO71pvPraHl/xufBHseLbUUF4+FVCfn2ditlG3/SOl3BcbM6mHE
         A264XhaUo7x9k/hM5n5tdAZp5708Ggx5FQijEo+wyfKE4bXN3SCPTNTVRcprJUPeGRLo
         /yhzem7Td4KYnkZfhdaDfa1RQT16YSzYpNmrGQbdCbrE+tPXuVYYIhRnPaPynXe7twcE
         H7DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791820152; x=1792424952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7dtdkgpBwHriMRBfE2JlbLPVLAMgy36E+Pq+KQuxy0=;
        b=rYQAQWdstZpn2jfaQxSbaUIs6u60uKFj0BvIwuguTccV3oUz4WmLI3NYPQbHanPyfN
         X4TvaBZ7zx+tCG/v1iXhVf5J0MWrc3VU1+3QTujxXnqt2XGkw0eqOyeoMkY5QlazU1g0
         b+/LSTtms10rkRk2lf4O7WnPEao63EIHSEGNUs+X7Gbk6oYy+hEVPiDrv2LhWhOJSWTb
         XlfvnVgWD4w7KRw/pu4RJj7MXDaxUcqqHrhGs3EEqn1v2fkgAvyLa8t4JVSOJsEY39Go
         Lx9dtx+v+uOGGxNEN4dYoCxFb1JKm6dMW191q31y9yRIdyPB/PLda7gUgYMzmjEpefS6
         Cshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820152; x=1792424952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7dtdkgpBwHriMRBfE2JlbLPVLAMgy36E+Pq+KQuxy0=;
        b=xG5YNq8w5djwEZRiYBQL60U7xIq2vCzDL9S9WNpOGi0lZS3R01Bh7e+3MI8g2Nxd/B
         HQXXdmN3u88ejjOASE18c7rAOQvByHJZAJqOQI793qhaRxCX8GDMq3Ok7QnBsTeHIyjR
         81No+3F5vvZ2qpdNAyfBIagLGirBDGO3dnjxmV/WvUvN5FEup0642NXhSsIkTnE5gAxX
         PXxiXKSWfc/JDV1+QW/JuBjbRaCVUNFJ1VsuPyiAuKO3X9GLSmo9zWD1MvYAgFXCqhJJ
         4+hShHvggO6XLkumXucdg6BQ1VnCCqIDJR4o6UWxwqir4wdwdSN+yFFfxqVZ5HLhr9VF
         Y8Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxsFZsDfc4TQRtJdfWqSqvWK3LJO83f2G/RClACqu/TnOkxF6FhafLF5nUtcTumTgB3jZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeD/mTJIuMsfLfaHmtkmwsk8NXjHuyEPz75hX5mJGvTsOjXEz/
	+l0S2TLJcCWXDRfpKLmWbRA0tTYHsbE2I4LBm6Jip5MW7/8fAaGE9n7VS81Ra20/HYdd+3qV005
	wekawaZjzWejGdwikolmisSnUaL3UCvA=
X-Gm-Gg: AYBFou3B89XRViuU+JnKPi/CXZWs+mpllcq3l7fUlz2GohD2w/OeEin2NxX3TRIKrk8
	F+X5mPhF/thOvJHnL90LwzNvnxNCRoYEOMbugiIdL0mZWnwfMpen5y+MZ75vEo66E4MwVPaFb7M
	CvjCg+BtWCMKsDEPaURF5jbSUjJLmNEEl+bA+15owfMyX5T7EiyJCu685kwsm+66TKQXjlfEjUM
	HIyjcQAAJHy8T1bSPH8B64Vo3vcFsKWThiV9oyNOIznTW+UXlilli9BxFFere9zr0sDlrGvGh1u
	63d2UYBmtRD/hZxy7We1aEHDbjwexpb8wPDEZpvSknY+s6p42FtTMuu2hxNhSURObMRbCqDJofC
	pYTGacl/WA6t5vGVVt5ySUsxVqHmiTyU5j+iAbSPEPyRo7VRxflUDp6esyItKiU+btuLF5G1HY6
	xZeGrM7o8=
X-Received: by 2002:a17:90b:2b50:b0:3a8:609c:7a6 with SMTP id
 98e67ed59e1d1-3ab3a8e9100mr7659526a91.44.1791820151863; Mon, 12 Oct 2026
 08:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> <xmqq1p9vdalz.fsf@gitster.g>
 <CAHwyqnV=SBMwTzC74YN7585u_pd525E=tRArL_5z_uLb-FGnhg@mail.gmail.com>
In-Reply-To: <CAHwyqnV=SBMwTzC74YN7585u_pd525E=tRArL_5z_uLb-FGnhg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 12 Oct 2026 11:49:00 -0400
X-Gm-Features: AclHuK_Xb_0LrBL0y_a0WZLibZnzU1Ow7Q2XMWc1JgHuMBrIohfJUwHlZXsA5Ac
Message-ID: <CALnO6CDTaXcfDArqT3tj3fY5hReEcAaMmCbTD9fpMJdbCMc-bA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:42=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > After rebasing, you probably can (re)use the same algorithm as used
> > in range-diff to match the commits and their rewritten counterparts,
> > but I wonder how "squash" would go.  Presumably you can locally make
> > a trial squash merge and probe for a similar commit on the upstream
> > commit.
> >
> > On the other hand, unlike deliberate rebasing done during a patch
> > iteration, rebase done on the upstream to integrate your changes
> > would not rewrite the log messages, so matching the commits based on
> > the log message may work better than a range-diff between iteration
> > vN and v(N+1) in the submitted patches.
>
> Matching on commit messages sounds very brittle to me (GitHub mangles
> them on squash), and also unnecessary when we can compare the files
> themselves.

Well, I think Junio was talking about the rebase cases for log
messages, but I have been known to cherry-pick and edit the log
message of small contributions that aren't up to my personal standards
to help contributors land their changes, in which cases you *would*
care more about patch ID than log message.

--=20
D. Ben Knoble
