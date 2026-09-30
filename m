Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com [74.125.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369E4CE681
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804357; cv=pass; b=RkLE4UDGUI/Dm0Kliljs96GWull8dZmzW/3sHrdsAKBcMziP35/qY4Xni2N/tJ68VuN9TIQ9C06KgSE3kqeBI9tblPqITx6DEx0jf4y83hE9U4+CiUuopSqER18SYDD34n6mNJuWug3IrZHcEU/JxRTMGO1X8NNQClI13MGgfmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804357; c=relaxed/simple;
	bh=4zOu20i6NsrWUp+M4YfSjPPUOdJd2TyMvS0gIupf+Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8dD8BdAhzNHUs6iVsM66XtrL95sxjQX2vvK7fB1obYBFJdpH4Eh6ud72YkA2mVV/+++tOZ+/S5XeQGZuy/yNqWNLPVG+GhlbLVchI4ozAfQSAbd1jlpdvKQcvuCpGPW+79Q9XFa7L+01vlweb8i2C4mh+XLJ17hXiDInF5OtS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNoTb+Vz; arc=pass smtp.client-ip=74.125.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNoTb+Vz"
Received: by mail-pz2-f30.google.com with SMTP id d2e1a72fcca58-880fcd3790bso2102085b3a.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790804355; cv=none;
        d=google.com; s=arc-20260327;
        b=TPTqaSMFEcj37EGzgfqumLbPsTtWaH3UpamYKF4qKrMt3I22sgDVpfkcLJHeAH80XK
         1WU9vFabtcPcWnW3JYX7+ZmVQXe05OZe+ugxnO0TEvhX+WutZJoJQfbPpvtSizLPE1hl
         NuthnYn4jAKsxbz29WNQYcLAgAs5dIN03tL9J1o9xtUfRMIKvRAXNv4NWbTh9rPDlFv7
         8rzixB2H/4KyQ57HqHn3iuWEg8uPLJNMAc0jN0GqrHMBg+IUjEqZRrwFXFTJFmf2LpCD
         X3UuRpv0YGA3H6w1uXjro61qaW9Uej7PsMHnqDD0CMlxWVITSKZc3ZhQLx8mif7ZwqIC
         B6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4zOu20i6NsrWUp+M4YfSjPPUOdJd2TyMvS0gIupf+Yg=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=GYG5oeVYXM9rJN2MAyG06p+0EMkfhnf/cIMFfL/oR18g93rjaxrlBtUK6KzduW6poV
         csYITlGk1tTtglpDHX35oPfh9kCa8gk10ABM7hcSBi2dmHMtABTd06zkk1EEbB6vpk89
         1gzU+oKxHCVVdcdBoIejVRAkcWXI56f3OH0eGd3sKU90+Jsg+yZqE8cNlSpXM7sihO4K
         Rqt4M8uE8htbtNbBfHwszHpuwujS4TVw9Lv5azsgeofPxTKTDt/cci+MzadUSGSmejGc
         a4ueFBVr2R2qpPm4ViGM9EG/LuPQKgZK+TxJn+NLyrtpew0J/VWhBvVYTveAGdvxnab/
         GPAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790804355; x=1791409155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zOu20i6NsrWUp+M4YfSjPPUOdJd2TyMvS0gIupf+Yg=;
        b=PNoTb+Vzw9fs3Z7i7ID8UaTcPmkKNTthiDR9XyFeXHrEMNdEFUD4vDj13xXN7Nw9XU
         q7m0s/m2T3VzQ7ELAlimfhZ2+xRswEElkJEnJLY/LITFia/bN9lqiCvGMtXyduwgW3sF
         9WVzN8+yQb74pDV3VoVSW+0qmldOluVXKHGKE9ZwlBJmNKwO0OiismYM181FdRX1LI+i
         kQXJOYGqX68nm3MjJRwDbxl21gz5TMLIPyy6qAXAJGO+kNYhMuY+oJ4NlWP55NhQxKwO
         OPS4hOfeW7PzBEQwYXNb71OLELilrmVdhge5madbyOsN3xMD88gpjSUwRxZSCu7ZpZct
         v6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804355; x=1791409155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zOu20i6NsrWUp+M4YfSjPPUOdJd2TyMvS0gIupf+Yg=;
        b=e6XqKEnI+auQJFWEAEoJWiaTUaUl0X2XL0qDlgfaohmaCW375smo2I1Zp1JGAz0i0q
         k/VQECPSZ1NdPzOmW3DKNjpgpYXdJJwrtaiuBAG94uMqv5TkylRntoR8ldJHbEgDrGcs
         yG578xAcBnWVgCM4Fav6+hGZNQ6u/QyVirGEejMaYrvA0UWA+zN0qt0UPej6/fwGCJNF
         wm/rzbpYPfusKSpN8RyZi3KEZq5Ojo6PVSy5qEPFZTCLhvyBcVQ0+XFe70mmZtpeMrGh
         LZv/mC2kvbWDk5JjLOS+xNuJUREhpH4qth1j4g1bsFGxvpXMowO5APuYOCtlHiBZO5dW
         fK2g==
X-Gm-Message-State: AFuF++kKaOwkLth9zRqEL3prCW7cVd5neYVmFG14erXTEjsqb2rpB351
	Q4qsZYMoNFmnPLpwNxN65rLamJSy5lHMSignWCwwcgegvPlU8TJNoTW/sPUYrQBJ+wSVwp31aiu
	xAexRQvqvrsnoPZWoXpLlBTsFsM7vaMc=
X-Gm-Gg: AYBFou24wIi/gnrNnh0TXmN8u9qWo9r3H9rNkfQ54ZnxnJlAqlTpZ4lxZjmVDlLXOBe
	Uosu2nIVhj9Cj0mX1gbdv93mMGLLb00SceaEDVWtdASqiGr0H5xZ56JxZtnvtSklS0jsZ+WLXJo
	i3D20NjHU598e5oZhZgJxSbxJijxz3iG+ooSzj1bYzPFIEY7Sh9ic1kf/CDQtxXyIPaQPBkWcky
	BaOaTJMU9Spk84ckavHdpeL5qrgxh33WKJLUHqfIr8JgbMUYs/l8QowO2vpk4knxuOX1eMW4S28
	ZLFHOzfffTY1GPsZ4/NnKXCKOlit8/AZbKQfswu6OFImWbr0r40cfHEVw7+c3wcXCJSyFVfOwb3
	VlL1AI/mJTZ+s11ZClBllS8huuXdf0H0oOjnpQlE5Q62OxdyRo0qISaUIlvHd/xxFrrhWGDQuwg
	==
X-Received: by 2002:a05:6a20:e290:b0:3dd:85a8:4c5a with SMTP id
 adf61e73a8af0-3de9e6ef037mr2661986637.33.1790804355058; Wed, 30 Sep 2026
 14:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
In-Reply-To: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 30 Sep 2026 17:39:03 -0400
X-Gm-Features: AclHuK_ED1VxwYK1YV5K8sn3Vx5udugCUZ4ljyrVb2QR5UhVZifrok5CfngeKig
Message-ID: <CALnO6CBR0XJUJR=2e5kUM8Fk9aV5uz+QxajRpnFFVTEkFfJQ3Q@mail.gmail.com>
Subject: Re: [PATCH] object-name: accept @{p} as short for @{push}
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:06=E2=80=AFPM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Typing "git log @{p}.." fails with "unknown revision", even though
> "@{u}" works as the short form of "@{upstream}". Users who reach for
> the one letter spelling of the push destination by analogy get an
> error.
>
> Accept "@{p}" wherever "@{push}" is accepted, in any case, just like
> "@{u}".

I've oft wanted this. Though, I don't have a `p =3D push` (or `p =3D
pull`) alias set, because it could be short for either!

There's no "@{pull}", though, so that reasoning doesn't apply here.

I have to wonder if there's an older discussion around these notations
that explains why one got shorthand and the other didn't?

--=20
D. Ben Knoble
