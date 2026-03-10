Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275213C0620
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165647; cv=pass; b=b29Cq1lGvSd8Jem0D5vhsoU2hD1EvQnDmaKl418gRejPS4v+HlVvXuKZXxyMXQ/HvobCgFVsTRIa51eGHMt4wN8+5XOxQqqo0lXQ0TR7dmhR5vMt3NlOM4Srj+oGmQG3mBVD5L78wOBdg5BinTA/57urr3PQbm3v82wDp6FoSZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165647; c=relaxed/simple;
	bh=8pGRL8bS4+drM1NQ+fK5taR8TeOxeRw6Mee+MqOWFQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAf482MkD1KD9MDBKSO4nlekjNhAJgzVVo+Z/zkFaeQfY/YfaTuvuhONJw05/6OK4atM0MApN06iu0eNJU/qZpgxXGqgq3gkxmUtnst1Xs15BGXXcJwk+VBUkmw+ZiH4c4xk8O0pCBlFOHemYFed9ffbOPjuuRt7ugd4cpjYe1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZkFPReY; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZkFPReY"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94e82e5b262so1004755241.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773165645; cv=none;
        d=google.com; s=arc-20240605;
        b=Qh9+550vpREkGuoHpI55myTpIb9ZPA6FH3ChRZWLWXwo2cVG6c39zRDJJrQNUjQX2t
         B0AQojR6pcWsDtp3tbHd6akykZCRO8lDZmuN+fb9x/kgyPWPKuJq06Gf29wmQ0IZFJjs
         ExhHL4cahGIgi1Zt51FejQzzZddmniAeaYBfGlN03G2Y4meyPkBMZifN7mMlFhmSCGOG
         FYftwtgNFkJ4SLYfmtRyk2ozgrRgPtSsUF7sEKXOyu2PldFq+76jco/nzPgxea2jHxzg
         XWcOyzYzkPs2HbtlCMv4BInYPBaSBoro/rxFa5DKmlim3KrtzGPZomNt4hPqA7oMAA6c
         uYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8pGRL8bS4+drM1NQ+fK5taR8TeOxeRw6Mee+MqOWFQw=;
        fh=kj60VLcDogCs4o4AGaY1j7fbPfj2eOA5xw2wndz0T0E=;
        b=YStAihQtjCp+LHHroFONdmK6qcZdjKLdaBAqwH+ZYckDHUaj2iJVSMVQVkKneTNH37
         zM+xo/QPYc5MUp4NJdK4ABN0xywNtoOgbdMnyUywyYIG/xoo3Nh8B+/GrGAuImyZCzrj
         XG8XL/6kef4b75ZXqKZOHP0dxdDPjEY7sbB+1ghHxajpkinqcnXFf7YWE1uf7lzEmgyT
         gmbWdqBgpd5Tm72QEdupDciRKXNQZB/E2hlGbymF8PV0lxswL+F99LLT7JGZMC5YH0je
         WFIKZ58lifoR89Sky4DmLAWsYtrfWrFBiuW8D7TL2AnWg4DGJqMNYaM242jQDdwb0VoJ
         7mFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165645; x=1773770445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8pGRL8bS4+drM1NQ+fK5taR8TeOxeRw6Mee+MqOWFQw=;
        b=ZZkFPReYcwRRGgarTAXQdL8dPhHgADDnr479UaTjMwTGZ70K1H/7UyIb7a56A2UtrA
         MQimYcVaajXnHZf/I6KqqGYcepm9WSarGlfvY8pVOcUE73TdfCBFvfkzwZw+zGAOupLF
         xIOwQsIgD+n6rqlyOx4FkmkeKlwD2gmF67JPW6h6RL32V7gt1ZnBnbfD/II4clzHF1sg
         QVmZB7gplD2FO3xjoGSqaXQI9o5pkd1EReDLx8UKcxbOXNZwT4uTjRbFLC7MEiXFoVrx
         pj9AxIQNpgIk2qhglIDxjn6N4BTFk2mrWiXRUZGafiRrwGXlYmFMoAemxSiY48mJjeMA
         3nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165645; x=1773770445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pGRL8bS4+drM1NQ+fK5taR8TeOxeRw6Mee+MqOWFQw=;
        b=Ywq6bg5VzV1bopwj5VtDOKhiFBydCmxSEbI3TVZYCl3VwjjhSCD9tB6Jqx5WT6rSCj
         YWaEq9rMcLzJu/4UaqnBKr9GTMDAZcgWSwIYYvrgNr87gKk5aNMfithyWXq5un9hqOxy
         sfM2ELra4KkUo9afdPxYl2mdgFRycR6LiR54C7YJabqMxUgZcqgdruyHHHxNUS7WdkYu
         enF5qaCw0Uv8VQY57gCrQFD+M+Dnb1Uj2nq6rGk7GaiMiEj7AtrUde73O3goJ9vWqEGy
         RwtPJaw0kjc/f5vR0wmFfeLh9NG6TkfRZawA8PvQic3qz5qwSrVcwwa4Au94+OBURDnd
         i1cw==
X-Forwarded-Encrypted: i=1; AJvYcCXTXEYfbPD4/Zlf3Q8IiaIRlplZd7FG2QbR7tichbzrU+mqwCrZphw1WVO3eGS+iNFb3xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcpxBe/0P4K7xyfhgSD4jNIxW0XMD22kg98jv7q+y1UOgbxYii
	hMEEqIvxe23InUtPs/2vN6a5FknKk6OkaMAzD7C/h/73O8U8r/LL09Z9c17eO20H6bxkjYfUGk+
	7AX2A92EziT1SPEkvNC9fu4gwn9aCLj4=
X-Gm-Gg: ATEYQzzpGa8ep++4GSvoZD6LM+5z+U242AkMHrOo8WOB+ZSO1z5Ap3d94ISFFPv9Biu
	xQD00TwNpkiGkgx18kSoF5znLBhaa0YmI8CzfxIQENLltFOQM+zxoVFGVGr/NYVYj/oJFOeopQP
	XC20DJLszPukfO/uE4ZrsQkxiI1Fsu73EJS3rr6mBW/QcbxuuLVJwxUkFyUQSHcU7ruiG/9+yBI
	NdtCMlx3rrf/CRG6oA4b1TKTIDy3O0PXOJW63Je2STOhcL+W1whT/m2OX19v6LvukBrY8OnlP3E
	lB/aGkISV00ienesN4RAwZTXX2z8H9XotvZsiIVzncbX09BlNRoKf1HOQfYIOlNBEAKNapezwUB
	2zwKE1DiLv1ZaMFp3cDw=
X-Received: by 2002:a05:6102:161f:b0:5f9:35a4:f5e3 with SMTP id
 ada2fe7eead31-5ffe5f55071mr5772940137.12.1773165644693; Tue, 10 Mar 2026
 11:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
 <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
 <CAOAgETOcivRUskCi4PCLnXzn1qGs9jx39JzgBA0jE=CirSkZJQ@mail.gmail.com> <CAOLa=ZRRFWyvX7fSar8R1WYOQOz+mz_c_S9ZM7CDe9v7bbQeQQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZRRFWyvX7fSar8R1WYOQOz+mz_c_S9ZM7CDe9v7bbQeQQ@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 23:30:32 +0530
X-Gm-Features: AaiRm51f5Zk8xnMKPVwi9DvPboUIWr8qsIWpHtxEKi1PU1TG8cs7N5wHdVeeRhE
Message-ID: <CAOAgETPfXxjo-Ltw=4q7rG_AV4VpGzRCwLDBTvdxtbWbh22GYA@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes

> Use of Ai in patches and messages
> Suggest the documentation for the same

After reading the document carefully again , I understood my mistakes
and I promise to not repeat it again while submitting future PR and
commits.
I am deeply sorry for the mistakes I made and promise to never repeat
them again including in submission of version 4 of my current PR

On Tue, 10 Mar 2026 at 22:45, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
> > branch switches
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> It is used in "add.c", but not magically so. The function that you have
> >> introduced is the only site that uses the new advice, but the function
> >> is never called as far as I can see. So ultimately, the proposed change
> >> does not have any effect on the user-observable behaviour.
> >
> > Thank you for the correction and for the bottom-posting reminder.
> >
> > You are right. The function advise_on_checkout_dirty_files() is defined
> > but never called anywhere, so the patch has no user-observable effect.
> > I also looked into the existing behaviour more carefully and found that
> > unpack-trees.c already handles this case and prints a message telling
> > the user to commit or stash their changes before switching branches.
> >
> > So the patch as written is both incomplete and duplicates existing
> > behaviour. I will rework it in v3 to instead enhance the existing
> > message in unpack-trees.c to also mention 'git checkout -m' for users
> > who want to carry their local changes over to the new branch.
> >
>
> I must say that the patch itself and the responses seem like they're
> generated with LLMs. Our guidelines for AI usage within the Git project
> are laid out in 'Documentation/SubmittingPatches'.
>
> For GSoC specifically, we have laid out our expectations here [1].
> Please go through them.
>
> [1]: https://git.github.io/General-Application-Information/
>
> [snip]
