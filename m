Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566511;
	b=hqpp9PQ7cuDwZUPArdLpnJrRnZLnTkiSrpAHPmXUi9XKTE2HWzj8Zd0rVSoRlOqsANju
	 CZjUPXBuapFc0RXnhZxtTG24/jiBwTsgVAw+Vj4VvgZnvZrveaeemfEsQ+89pL9XU8vsq
	 2HoKaDeb5SnnNvwdorkw6UiQVtVkDlRagiq9Xp89ZdsVgpcYrhdMkZMNrEoFTkUdIlq0r
	 2s4ZhBR2NbL0g/MrYLxH0HSH6+pj/5C7ZIGeeKrgmAlGSVSK2o9dmbojgGwVlgXMCigJG
	 LCRkrjznGsN4nYsUzkSI5LkEEmTriPE2+2XAVs2xVHh9Nje4/S4VJr+URCFSltIWGhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566511;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=NALixbDZ40y5cxAu6rVNFINnGD+3KOSu++sU4kuPoOo=;
	b=SIbFU5X+d6Pt289h5TuMbN6dXsCfYn3bgK0heapEkXuQ8/oOkLkinlrPeh3aNsMHmJYA
	 hXnVruUoApH9xsnzQzmqJz1z06vGyWXNZ3VWDVOVzx+wLN8Vs4u1Q+l0AciUUojHhYE9C
	 M9H7kx6GBE+vvr9GBy1uFO20EEZEMMnL70AIqcRHIXC5lvXn9SkIjBLAOR3UF/W7d8YCw
	 Jjf9ucKj31JYmcJGGXzr81OTVgxtK/idZ8JE4muZpMrCpP2aucCPLxsw6//EinY314LS1
	 c72Bnhxf7Sna3g5y4gDksvF+hNVKuQAxQ6dwePg6Il70ivFcaW2dY8MtFppUeriMqCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=sunshineco.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC778606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC778606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e83d2cc8a2so932435ad.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792566510; cv=none;
        d=google.com; s=arc-20260327;
        b=X0DiymJzSimroWVd/RJcgl/da+CduBn4ChZO5kg19AsNPWXCcB1jx0wfEZR5IuyW8T
         0ES6AHlb6APwvrl0wzon7HpOVO/S6DiIpavdcXkeVJoORM4b+2aHoYu9WRgx8Nu0wqMB
         Ix25GsdxT2i/ma5mt5QZIDjOwcrgMhxwbv0VfuWnSvpfRhnltdRc1Hma8S5OU3QsZhmI
         LTI1Tc1fs7e4KsO6lrZ9NF4R42LxO2JLvv7TwgzNJPUQedtmtpqfujT6fi+TpehFXsNj
         rRvAXZGeGg+72xqi79wCVVfFQwofC57AKa1Dg19FmlDrsIw3hvN8dsFqO13Nb6kQtqav
         S+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=NALixbDZ40y5cxAu6rVNFINnGD+3KOSu++sU4kuPoOo=;
        fh=0hnH2vYDv6vpcFd43UT7oWMkEdVCy5eROOyZeipDsQk=;
        b=pGrZYu8iACxPOkjWIfpp8MXWu4YUFTQpSo9pAOA/WKmvfRnDdNpPAMh4/uGaVf8wmw
         6LG1jWWPiprVDnVTeusqD1WDeq+jVNGkB3cchgohHimOytIgjly+aN4Ij2WElFJCMdF/
         2Vmu69BeO7QF2IVUImra2+XavM96B9gEKgoTnIAPCrFfRsMSJck26j5CYWyqjm64APGa
         fetmrkYARwx/AtOrWBWGGOVr/qGZOiO5jHUwphA2xBuvXqoNY6NbRkDqspMob+NWlQIK
         JU4xlsUz90EgX8zVa+OPcbcRF34ig1kXHURqf4Rn3Y6KJYo27aD3HnbndTO05ktqAzQg
         52OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566510; x=1793171310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NALixbDZ40y5cxAu6rVNFINnGD+3KOSu++sU4kuPoOo=;
        b=K2QkiUhIAhNXAOgpgsWRieRKEcWr7hLloq8yic3JuEZoY9OGIumQYmfURWyfqiZuLr
         VOfp+JAQobAyerdsIHpIaZuSkLatkFjj4gHdO+wFm8FlSygdTmgXoP7lFdAgyhTeH7rs
         JKS4fBcjReiaOGFr45aOiWImZH857Z+FqU4c83YyUIRZNaqYArF0tXpnwxavAKgMbyBc
         lzd4VitcFVx8LzRajoPc0gVuMT0XoiyLO2e59Fps59h8jtkcc1Zg2gNbYpxWEO+CK5Mq
         z86IvO1kPK51B8rx99jOYQC/uavRkjTOfzSAjcUA0GAS9rS1iQ/HBM1uN9a4/2TVj3fD
         8qUg==
X-Gm-Message-State: AFq9FYI25E39bSFETGvtxX6AxMwi87BRW/z78WApWeqtZ+1qP9/J2Yld
	4zwGYqIL+5ziWIWCSX2uLxGyxr4BKpEyTKSmII06k+vudVUgmY3AjwYCvbkel5RXZuuq0CpIQVF
	mGgNF94A/05mRpuO9lH2N4r7tD45dq31Ax3as
X-Gm-Gg: AYBFou0OQW9pCYeO5rcpA6U4u3M82o5rxughhwHjvM8IqBoFGQsU8LIYGZrOB/WGhzl
	pZAY9LD3HxMdm3JH9Z5M0wSZ7DeFYX9FAJeky+KWemyKwfFkgw0XCv3bSn38Bkj3Hg1nVyXvb1k
	TPmp6Ww7QLtwApAKWQtx16KZWDNgiCnVa1TSrI7LPQznJ59guuvpgjf4LXeJpu06lGSXVYwyQKJ
	Ol2yREl/2/39culDddBFkJlYt7n1BzVsVi4fiXUIlXotsJmHRakKaTpr7oDVAjgnE4ob39jWP1I
	kAhHfs3T+kNd2h7aSUu15ncmUivEtA9FQTtcqTDNViVoeCVfA271usGxzRlQCpFPNIEhCOgEugO
	yBRkGyITg6JxQwCe+qbYA10Wv0XWyq44aOJjQzSUmnLxcUgdCgJNcKNgZjvw89pLm90AGzA==
X-Received: by 2002:a17:903:a8f:b0:2e9:5714:607a with SMTP id
 d9443c01a7336-2ea43a1a01amr17390355ad.2.1792566510294; Wed, 21 Oct 2026
 00:08:30 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com> <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Oct 2026 03:08:18 -0400
X-Gm-Features: AclHuK8ORWXFJtQ2NiyNHW_GF7YJV0hwNtSSJGfihYXsO-w21WC4MWUmE-gHitY
Message-ID: <CAPig+cRtMkJb6Y-b9M8JP5pmZXuHZf7Y+3-0mFVP2N4Zd+KpjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] worktree: copy-on-write creation and ephemeral branches
To: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Jason Newton <nevion@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:08=E2=80=AFPM Jason Newton via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When many worktrees share one repository -- for example a fleet of agents
> each needing an isolated checkout -- "git worktree add" is costly at scal=
e.
> Objects are shared via the common directory, but the working tree is not:
> each add rewrites every tracked file, so N worktrees cost N full checkout=
s
> of disk and I/O. A branch created only to back one of those worktrees is
> also left behind when the worktree is removed.
>
> Patch 1 adds "git worktree add --reflink". On a copy-on-write filesystem =
it
> populates the new worktree by reflinking the current worktree's files and
> index, then "git reset --hard" rewrites only the paths that differ from .
> reflink_file() in copy.c uses FICLONE (Linux), clonefile() (macOS), and R=
eFS
> block cloning (FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does). Elsewhe=
re
> it is probed up front and falls back to a normal checkout. worktree.refli=
nk
> (true/false/auto) sets the default; --no-reflink overrides.
>
> Changes since v1:
> [...]
>  * Kept --reflink opt-in. A whole-tree reflink is not invisible: it carri=
es
>    untracked files, and cloning every file can be slower than checkout wh=
en
>    the files are small (Junio; qub1n on the ReFS work).

I may be missing something, but it's still not clear from this
explanation why --reflink must be opt-in rather than default behavior.
The above only seems to be touching on Junio's superficial "cp treeA
treeB" example[*], but doesn't answer the deeper question he asked
about why this can't be the default behavior for individual tracked
resources in the worktree (his "a_hash at a_path" example).

[*]: https://lore.kernel.org/git/xmqq8q8pxfny.fsf@gitster.g/
