Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA314601C
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610999; cv=none; b=mjq6DuuyeXT5GK0CZ9JQt9UKUugbvilkeYiCUVwzLWQKiQn9WsbOVGUC9652Pd4YoyUcvv5/x7HqP3tAmH+YmwRGdyCdb7fktZoFNDMDFdszAEALf6fe75q72TByLanuf2er1lr6vGsIEZoJ6ES+yr9Awq25/LmcM7ZHP5TDhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610999; c=relaxed/simple;
	bh=M+OnOk225r+/d+VswOBwuDFsO+kdBF/T+W3HorCf/go=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kiSJ7KudV/dXNfxRWm0khtInRU7iGUoVoLopEXtMq2+4zDDsdJUtnQrRTYydcWeA/EWO7JPBT80CX5PTO0mjdnVLL0zb1JEqvs0VNw/8eNvMouMgrq2dEfHtm2qK2zhn6r7eLQZWwnKR6fWUncTh/KAxotMdaSdrdosFEn+l/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=W/BhUMBT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="W/BhUMBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708610990; x=1709215790; i=johannes.schindelin@gmx.de;
	bh=M+OnOk225r+/d+VswOBwuDFsO+kdBF/T+W3HorCf/go=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=W/BhUMBT1NEauBgLcbK7ON42YsTBCxhd40uLgUQteHKYObxUFt9IHWrtb+2cfgGz
	 zAnDL0/50iUkZXc0lKsWhtg87XEBIUbTtCm1xAvMTsiYe3R9e/seqwfqiNzOBPlfF
	 +EbToMOHXSDsqFKViG5dkSKWeqxXUynYRRUi/PEPonrAymLZGlh/BLYsmYQp0/7Po
	 NIwZw7NF3vuhXhIiM7N/e6ypjb5GKnzh2e9VPnXpxxhXr4Ck28IdlUOEMTE+voL4w
	 Ep79gU/5cGwpILZJosYHyiydoPGcL8xcr/+E2RZMiY5XerYhmjER8WlaZRYH/6aGh
	 C6V4FJwV04mvEdFztw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.133]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1qiI9x2po7-00zTPh; Thu, 22
 Feb 2024 15:09:50 +0100
Date: Thu, 22 Feb 2024 15:09:49 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/5] merge-tree: fail with a non-zero exit code on
 missing tree objects
In-Reply-To: <CAPig+cSs8MFkLasTULh7tybrFm7SwaT+JeR7HnXjh+-agCHYMw@mail.gmail.com>
Message-ID: <ea0ad9f6-b3c1-5047-bf1f-c6134bc6218c@gmx.de>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com> <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <01dfd66568c1818819e81e001cc189f9066d0cf0.1707324462.git.gitgitgadget@gmail.com>
 <CAPig+cSs8MFkLasTULh7tybrFm7SwaT+JeR7HnXjh+-agCHYMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1773888088-1708610990=:518"
X-Provags-ID: V03:K1:aG86SnbmtdQnP1WFhUPZ1vEOzPw2dfCarXNQX16FZ9vqSn75eDI
 uzpcNCZmKYeHtc/QPQlMokrBk3y7u78EznvnIDdQ3wBgy/rx4xh12sqjtfRqO4TW6s7jiXV
 0Pjr7V+igfrSIsj70zUFAmRicDmrSgPWxCvVOcAhpXMI0e9Jxj9NI4wo9k6UzqRwqw0TOLU
 CGOwvPe+hFrAYxK3xZpNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sKw4mWiLCQA=;XSK3e9MzvnCJAT72nxlGeshrjm3
 k2r0hYr8Vtb2bpx0yTUxfhQXRwjTV+LB07W1s3ib5yDU3bSLxPJcVpQ6qR0gnHlAFX8Lql4nm
 l1f3kuBm9wGo5XNzWJxwlOLcJkkc3CbvciDAEB+YEW92Qjyeu4f2M5UiSrFonMHht5hdYhMvV
 OhHw3XhxfvgjxZV234wwjUl7U8FgHYMgyk3AP4TGTk2M1PQWTp2lrKx5OP/B4QQRZry0fgzg4
 HpI3vJgrOO6dw61i00S4xrnuaPVxd1+eu40BRHSZrg9dqVPldpZjpGhvGszH2mfwLbJF/uAFq
 lCrZ8c2f/NNrcU0iJeGGhcm8oxszVJLyJ7n+h9rUKsiL1yB1koPfNIIWEPcKKHucyIVLLa+zm
 lrTPHl0P8xZxaZPJ/YzHdzFuiGPBC3theC42OVs4dGlmsZP1luhmw/Os+OtVB1M6JRf+USOjn
 DYBmA5t2h6vkel7hRabNKH3qhg/pYSQkLqDkGVTIqpmKwekZeiOdnRNol0cYO/Bavo18sFPze
 q2xUeCMVpDoW9ABEnQHiX3Rn7GfwW0Y7SlQnUtD4xzCHHHV4LRUIn3jX2ukVSvFxlpWp2bRxM
 eYD64Q8hPy5EF+DNtA+F1YVhkFcPdto0lmxh+J+hccCYq80QdIhK1BBLntc+8S93TrklhaP2W
 E+gg80FYEp3CB6ztAzaSYZ9CWoEiIjkkfEWBSskCaR8Us2F7BZYTYGS+oWcukHS5/S0blYemc
 IeKb6ii036OZVJrveJyHg0O1uJMkBNzYFHFr5no4r8SaOQ/JByHS2KutMiwjgXenEYkeHExeC
 1CPUCsjY+EBvchmvNLnIuB/UrbcFsi+B7Q4ImB6uv9+OE=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1773888088-1708610990=:518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Wed, 7 Feb 2024, Eric Sunshine wrote:

> On Wed, Feb 7, 2024 at 11:48=E2=80=AFAM Johannes Schindelin via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > When `git merge-tree` encounters a missing tree object, it should erro=
r
> > out and not continue quietly as if nothing had happened.
> >
> > However, as of time of writing, `git merge-tree` _does_ continue, and
> > then offers the empty tree as result.
> >
> > Let's fix this.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-wri=
te-tree.sh
> > @@ -951,4 +951,14 @@ test_expect_success '--merge-base with tree OIDs'=
 '
> > +test_expect_success 'error out on missing tree objects' '
> > +       git init --bare missing-tree.git &&
> > +       git rev-list side3 >list &&
> > +       git rev-parse side3^: >list &&
>
> Isn't the git-rev-parse invocation simply overwriting "list" rather
> than appending to it? Did you mean:
>
>     git rev-list side3 >list &&
>     git rev-parse side3^: >>list &&

Yes. And the fact that this test case still passed was for the _wrong_
reason! I adjusted the test case by writing the correct contents to `list`
and by verifying that the expected error message is shown.

>
> An alternative would be:
>
>     {
>         git rev-list side3 &&
>         git rev-parse side3^:
>     } >list &&

I find that uglier and longer, so I'll stay with the first option ;-)

Thank you for your review!
Johannes

>
> > +       git pack-objects missing-tree.git/objects/pack/side3-tree-is-m=
issing <list &&
> > +       side3=3D$(git rev-parse side3) &&
> > +       test_must_fail git --git-dir=3Dmissing-tree.git merge-tree $si=
de3^ $side3 >actual &&
> > +       test_must_be_empty actual
> > +'
>

--8323328-1773888088-1708610990=:518--
