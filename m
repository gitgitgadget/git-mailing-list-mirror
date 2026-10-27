Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130128;
	b=D+/qim5Rt2GcGKUeGm/uOTYSE62vTPkRAGiY5HkPjlWccSTWnJmQXh0gchs5Wwb9Sv2a
	 GJryWXFX/PnvlVr2ksMcFnxs6cL9jLuQaqkQVZar60tuA+DCVPmmAsCvJK7phHi+N6b6r
	 /j4/PsiRjEhLYPrDR2ry332KU4Uw3PQG8Pmjzy0o3GzPWUNLkj78D3veLQ3RHciqKLrKx
	 0PSCF/AX3zVqMLMNq3TpC+9kHOgy7smwb1W90bkaV960ICOwrN48d1oY2dfu4Q+i2TBTo
	 eZ7/vqdAHIZ8X8WiX+A14cp7uycK95QMJeVzUc41qwtrQ1D5dXkcTjHzAOTt+5DIz4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+TF0zymFXk4wXEcskGsU+TdUCdPOZCQIsB2Z6LDf3xk=;
	b=ngVfqOWOE1PMIvxslyFbdvtZl2gLIrsWzKGszAAAS9LEKfxBOurKl7nK2WgjDMJM8vyW
	 INgZPZCSFTxrBJTntK4WdStNUsKLCjMOpggwKN1/82QO2RZ4T4ivcSiu2Ti2d0dnpZ1SB
	 nECaR3Ed3dc59MZyaO5cZq0TRh4YAR5JYWt2JTU3wLjUPK9Bm59okIRzhdXY4zMetJvTO
	 UGKz0kKTeKyZhkq0rJ7rbGpOwnWfqxRi2gjnZ1euqqGIXUyo2JsoBexMj/5Vv0xZqpD+P
	 4XyiJKZq6U6UMJGjq8p9KK67rGF94rrFmGiJ4kc/pke56RZRRaO7aiOVCuOX6IE6sJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+grr3Pr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CA606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 470CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+grr3Pr
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so147522b3a.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130128; cv=none;
        d=google.com; s=arc-20260327;
        b=HU1Z6aoDGSybRmN8sY7ibT5rsYSk3RNozUtIdELzWREw2vi11HVI7/n22ZCqOLQ0mU
         1uJetiNAdIQD4FNBuh8MZ8OrzdibHH54txTa+umrlHsgVkBSz9J0ci5XjdDxiNVLdftK
         kV9YZQngOckdYKur4guiTU2KGQ1wy2wNx1NKL4Cfr6XvHBa3h9htg/sjRHY0uLlBQCcm
         T3/vx9VSpiw94O/Uu+oUeXt0zQroPNzAs87rDviDWyB3zg32+oEHh+NwXt+JCGsJwIs1
         aFt9M1XM7ZftQ4OKw7MALaT96RtNlePXtbFS41eD6LNAJxlJDxbhdIqH04YtE9mbIXGi
         RxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+TF0zymFXk4wXEcskGsU+TdUCdPOZCQIsB2Z6LDf3xk=;
        fh=1N0JDWu4157h+WhruOrmu5yMf69TeXVYPqAnhT112No=;
        b=AWxZu+X08HjrwlBk6Hsj6uSToIDdp9Xm8jK8Bb6sVH/YFyzAeAJRnC70pX4OQUz91l
         hhixDnTgMgifg4Ek1MSWL+ybqjmTsIDh51XsWrjvPtOC6qdvvpgjgcH8PwPwtYzHGKBE
         WqPZuutIWnFeJjdBnCZ+L/xtyyBhCO4t+iVDaZlaayW2QBRAwWNzb6dySDzK/E9U7x37
         5kPQHxk2RzQLK5fi1Kqitc0+GqLxbEx4SO3fGVZNviiBAOgMJvPeDM59gmbdzzzZkvJm
         LvEWoXl8uS9UG7PeXIegmDGRABLTwqrXoi7EQBY638PegZWENWn9aPvcgWBG/kz3uGfv
         yctA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793130128; x=1793734928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+TF0zymFXk4wXEcskGsU+TdUCdPOZCQIsB2Z6LDf3xk=;
        b=Z+grr3PrNW9uPCeUXWWOz0GENutLbUZR4klfCnyYm7+Vz8Kb7lQHThbV21zhUjwG2y
         Lq2FRVMVuAkqJxA5AkoeHUNH6akOZoBirUUieab9SKbLjajNEBr+b2ZUthVHdcksBJ1q
         6LHfwmFffQoah9diQpTtMNp8aTaiKtHSNPEUKC0NrAd84B08+arG98Pdq7waH0r1qEzK
         CTN/2MpnSiG4UF1yMZq9SUOHvJbdjZS+czBZ4T8Fo2sTGvAi6qE3szpHrEoZymtJLTln
         LG8Lo3qZw5ofTugCCWr2yeaWCL3Kfn01K2zOtRqEYbUPfgKejmq7kl+8H1RomIO95jPH
         xJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130128; x=1793734928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TF0zymFXk4wXEcskGsU+TdUCdPOZCQIsB2Z6LDf3xk=;
        b=GDn6neoP+4xHyBM1jwHbYfEzhStFaXBtAt2sygx5q9fHKlypimI2aSftrA9q6K+TO/
         Rd/cu0Mt1vcuMBqNdmZ+nAZbVck2axB+L3PP8udelper01k0CZ/3IjUw6V2arkM14hW4
         7dElSC1s3faMhqotkhfxsqFSHuvpIuu5MxboGsZNEezwdWmGgYhJAa2PxWDAKYgysm3C
         vZR63yv8ioSEejZlLfiR2ra12UTc9eNNKCxI01t0zJ0Yhv5XbULk/kPzc8DcC+4OBdL1
         S7tATonQ4ROwkNDn7wovdU46GTiUuxsCUI1G10uD9GMBvTwF8KThTyanF6Hd7Sg+LZcb
         s0HQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWCBmJv1HZVN53GP+PGcAePm8WqCnnt3ziEV47tfAfpV1bnCbhYyE27tvlw/tQf79EXVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYInu+/9sk2swf5iynW5i0+PfI16PQC8GapVENgskGR1Xs6tCIcr
	cJrGJagRN8hCTABeifTNYizrndEm1HayhJblpUwL+5i2khRLW4KHxtq6FTxcemMlCgESs0zNDjI
	f2Dde76T/yoxeXuhR5zUpT1VAlfbZ6KI=
X-Gm-Gg: AYBFou067zI4xrPO2sdNDgWHoVRf4G0YyqNAch8Up8/xiNWiLOx4R1cSz/tV3DTevO9
	qcVIWbJ20HBFDboCW6V8eqTg7eFIJSLm6nW4zctRaSb9I+UKje4uFISvPwIBh6UcAyAog0bvvgk
	I5b9nwduIMc8fKJl09zXMG2DMaL7jF4ho2iHZg4hCx9Rmn1zXskA4t2fWuQ1Fbt2SVgqsBJHN69
	OlOxB6DPLCF/H/82YF5uGbAYhjvZ4rWph0UGSfmuZhZNdrVEIv6j+P3N7fJ5mWfn8oOG4QsfpAJ
	e2qOkqpUXM+ZLus/b8vrqXLLjS3aOe4TrAid3T7vmQqcqopi0CWW/M8Ny9HRnekwdAD2XWuPL6x
	giHCQC4Bt3S+WysOPF4tNd1cuh0TBpfz+6mWcwAoEooNHRJI/wBGnk9oxOo46Q70NEIZhFsZykP
	606KCXRlIMSIC9rw326lBp9X2Z/bfCb8C/zP6mKiv+ruptg+8/dp9qxfKOjIj1Y8hvtYVFVKnQf
	KH/qXD4JXXewkA=
X-Received: by 2002:a05:6a00:4105:b0:880:5fe5:a818 with SMTP id
 d2e1a72fcca58-8a6e869d235mr176860b3a.59.1793130127671; Tue, 27 Oct 2026
 12:42:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <aa20604144efdcc5ada00d65d538fdb42c2e31d3.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAgS3=ne1RkT-DioLmY6SqhnOZ8NH5kxxCZA_1QFx-dBg@mail.gmail.com> <CAHwyqnVELh2ZyCy5W8+jHHWN=UvcgMJP0k0i1PJKU5bU_AhUrw@mail.gmail.com>
In-Reply-To: <CAHwyqnVELh2ZyCy5W8+jHHWN=UvcgMJP0k0i1PJKU5bU_AhUrw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 27 Oct 2026 15:41:52 -0400
X-Gm-Features: AclHuK-yu6rPInVA2vlWHz8cRPzXy_8f1vvjctyk_vczMefI1YxnavOqcWBKhwk
Message-ID: <CALnO6CBEPcPeTmZj2_O6WMXdjo4e6YiQCctN3Bs-o9LSN2rsrw@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] fetch: extract collect_upstream_from_remote() helper
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 1:20=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > > The latter is independent of the former on purpose: a narrow
> > > refspec (for example from "git remote add -t") can leave the current
> > > branch's own upstream uncovered, and we still need to be able to fetc=
h
> > > it.
> >
> > I don't really understand the meaning here. I can guess that you mean
> > something like "A remote with a narrow refspec, like what you get from
> > 'git remote add -t', can omit a branch's upstream from the remote's
> > fetch refspec, and we still want to fetch that upstream." But it's
> > taken me a while to put that together (after puzzling out the above)
> > after first not knowing what "uncovered" meant.
> >
> > I think the whole thing would be clearer with an example:
> >
> > """
> > Imagine a remote with a narrow refspec:
> >
> >     git remote add -t main colleague <remote>
> >
> > and a branch whose upstream points at that remote, but isn't part of
> > the remote's refspec:
> >
> >     git fetch colleague work:refs/remotes/colleague/work
> >     git switch -c work colleague/work
> >
> > When we "git fetch colleague" without a refspec, we decide what to
> > fetch by combining the remote's refspec (main -> remote-tracking
> > branch, in this case) and the current branch's upstream, if it was
> > based on that remote (work -> remote-tracking branch, in this case).
> > """
> >
> > Note: we aren't "guessing" what to fetch!
>
> Thanks! Maybe this should be the example instead?
>
>         git clone --single-branch <url>
>         git switch -c work
>         git push -u origin work
>

I'm not sure if that captures the same "narrow refspec" remote or not,
to be honest, though it might be simpler? I'm not sure what the push
has to do with it, though, and I don't know what you think about the
rest of the proposed wording ;)

[later]

Reading the new version, I think I see what you're after. I personally
would love to see an example adding a remote, since I tend to want
"big" fetches from my primary remotes, but that's fine.
