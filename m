Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36D3164D8
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256568; cv=pass; b=Os0DCJlQx3v+hBfmxtYGbcHwy+E4V27MMH/4nGNLftqgucPn+gCdBM3jKhSWeKRGiC0GsPBQo/xFF/+KQnDKIEozdUMbKiorCSPB9DG1SvIXwprJtV/1GyKQnSHLWaVhCq6kzy5hnvV6AKSZ0iiqtgzMRqn459t+BpUTmoPtv4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256568; c=relaxed/simple;
	bh=4pJxYFyIMOjA5cmJ0WusZPSlCdzGKjXqtqfKLOujh+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUZDHhSZMYccYCx3mUVvAaOmNh7PWH8bpEO9kYpfn/cM3YKCjKnfdRd6H5MJlkd5tsO4QP00dZDHjDElsd7FgehnQMWheURhXBGpSKwcwwnlZEb6OG8CEoCyYjVH+K5s1pDuJntZPE7patOZESaO7sYxCYhNkniEasOTlUnPlcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eozF1puh; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eozF1puh"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c19d23b19so12405796c88.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 19:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777256566; cv=none;
        d=google.com; s=arc-20240605;
        b=RAjLRL+Dhw6fzVLSnOuK7611bBsZTXm4LW9X1Q85tj3d1jlOKd90B8PqhOMypueVZw
         ghGnkGo9xfyjnfwwJ/2tgFaDO5QrMzJ74faEocF3hCqJcs3Egst4ovaRBMclHbzJIxM6
         AuxjnS67BHOV5q6biHJ+fufc7kNPixFHTElXhgSWCuhOu5VPut/swa1wN+VO6K7/oF84
         brCVPMDJZlIuybLLsymr+pVhxAM3cSTnF0adFUaUMyl55IZaIn6KmC5YCK0CW0JmXfpq
         iQDCbTx/xlpHKuxBd7QXpzHYXSOEU6k83BTblofxh65Py/XIT8tVzPStQuf7JJXqStf8
         06Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hSKbCwqR5PsQuxqlXNdjpJFb2sGCy6Eo7BuCvoOx7lY=;
        fh=oMVJYWzugNv3c1WGdTDfMb/8lCrZCnndc0+ysGiSELk=;
        b=MD6apm5qzT5ZE8IKawBxTWWDXguw/riCBSNubndyS09mj6NUweanuYQKgGDqjJAVhX
         ha6xpXwNcllhLt8zaapXI0BEjMjPQwIrdXlMmgvJq+yhf/V7ERBJzBpFCgW/WB1wQK8n
         1UmUHpABnP9ZmMSgqMahW+aNMuaDy23RdlIcSr/QbvogRKs/A8KSW2YhV+wUCmk1BLbf
         dTmLOgSYDm/fLx2QyNGzAPUgs3Tn/o9fmbrE+FGQsnRttPjwG71p9GgBssyXmqGmD7lm
         RlFLmAkPxa2s5oY6G3oZwj8tQsrtm6E2sQyM18cgsHblRSON/ODpZtc8f+IxDbXK1iS7
         ymVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777256566; x=1777861366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSKbCwqR5PsQuxqlXNdjpJFb2sGCy6Eo7BuCvoOx7lY=;
        b=eozF1puhtawo/kmdDTxQenQ4hCtRVVQLjkAN9ceIrH58sRtQD+WgkkEy7EMrKE5Wf/
         ToVhD3Islzw9Vt99Dcl7yT4FbF/UIG/z33eNGNFjag/sXPG812FkEu0bi+IR6KOQf3p7
         vFKv8RrRkQoPaY18OX9mF+Ft52uCanVER5iQOGGeXxloK7i53cV+3ioLzPSM9dvxtsak
         YEeVgSVS6ZlEYyXOfMIg8Etz17k+23CEQPKMX20L+UMKYanu5+eoThiXg/Mhqp6wmCgS
         Doh/bHiFUmBfZq4j/HIIu45nCdFzit+qUlrvquuU3KLNesMHyjs6TRBWHYuIA1lVtT0M
         zoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777256566; x=1777861366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSKbCwqR5PsQuxqlXNdjpJFb2sGCy6Eo7BuCvoOx7lY=;
        b=MfvvavLb0BQzVLit+n0YM+k9tUOf0j4hI7HKw15h6NAhkt8Isoy0eB8gF0QHTKBSz3
         UVgax66nJR5tx18mA82vcPSeWvAIFk5JQvly1ys8Npxqx+iiH+a33oajwdNyfSlcxuNA
         CxxBwMna8lFBzwmBzQHGFPbMZl6MDX08nyeBGqVnCslW/W2YLB/orokyRPM5mmO8k3GF
         h2cr+pkr+Utlmq9yxKct2XJSo+NTDYW7p0oypR0SSJbqgjfOQypKanDZywF89fYTMBgV
         l6mqU98ag0y+VAECkkRgrOANm80fMPSO9kmk+eY5CCnnlHeeW6ZKMuhAutS0gk7edrhj
         cy0g==
X-Forwarded-Encrypted: i=1; AFNElJ+imqTvi6pwcfQLGeOwGLduuwQQZ8KSiVf/36qzC4+jJd8zpwCbGEy9hT17L3hSCJvec6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lK3Hon/iFB1FiJuK9b0VhpBeXxu3X3kgKLQfPktDrJiBjik3
	7nVg7tCQ1/mVVzy41MLrQXAQzLx9CFKKsIFrck0bFXEzBsVXA+p8aQqx3w/qWr68700W4rMNM/M
	U/q5Ktk04nbQuc6t7BqyU01iA0ugZnmIHAhYCqy8=
X-Gm-Gg: AeBDietT6oSpYZhutMV4xInSd8IiUO9gtdc69URP1l3Dlzp5ig24YwSDfLGIIlTJrJ0
	Sx2AucqsuOCTzkUIIj1N4V/sRS1nb/wf7igsnXRwCZuvVEZwbDkb1MGiz9kQIN/ARFlpGcziqGt
	MgfIMl5jeOudm9c8n7eYBqOQCFzpoiu1Dv8JfvaC1MVazVcgmckRWlDnYpDWYa8e6BVAybSMLMq
	/vBc61a1FOH3JYzBOld7IyGY9HjotNtEPBPlq3yGgeV0c7C/OIIIUljb59Mt8E5DiW/gWANTEv0
	97RRyL+n60n+UxY4wnfZ5Qo67gPdAasDYu9ObgpH0Wn2dmLlwXIw4R8S7hRqapHcvgzXM9yMoV6
	RhUmybeCKw+e6Uxj2GCTtAO4uMZ/M
X-Received: by 2002:a05:7022:eac8:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-12c73f75981mr22498187c88.11.1777256565764; Sun, 26 Apr 2026
 19:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422182516.26667-1-beniamino@beniamino.eu>
 <20260422182516.26667-2-beniamino@beniamino.eu> <CANYiYbE1qTFYLEyhAR3SEyXozFnEMPxyj=3dAh-vmHkpXZnMpw@mail.gmail.com>
 <d7ec16d9-2707-4c1c-ac64-ac3dde3e0946@beniamino.eu>
In-Reply-To: <d7ec16d9-2707-4c1c-ac64-ac3dde3e0946@beniamino.eu>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 27 Apr 2026 10:22:32 +0800
X-Gm-Features: AQROBzBPGVTLfEbFBcyV54q80oHu3av9D3TbboLni-O7D-3RXxZOrmWKoeLazco
Message-ID: <CANYiYbECkApqhLvFuh6EcjA+-QFo0ySDJ0w2g51RaK4mLpcF+A@mail.gmail.com>
Subject: Re: [PATCH] l10n: it.po: fix italian usage messages alignment
To: Matteo Beniamino <m.beniamino@beniamino.eu>
Cc: Matteo Beniamino <beniamino@beniamino.eu>, git@vger.kernel.org, 
	Alessandro Menti <alessandro.menti@alessandromenti.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 2:47=E2=80=AFPM Matteo Beniamino
<m.beniamino@beniamino.eu> wrote:
>
> Thanks for your answer. The italian repository found in the TEAMS files
> hasn't received an update for more than 5 years. I've opened a PR on the
> git-l10n repo, but it doesn't pass all the checks due to many obsolete
> entries.

Your fix is unrelated to the CI issues reported in PR #918 [1]; feel
free to ignore the errors reported. I will merge your PR in the next
localization window.

[1]: https://github.com/git-l10n/git-po/pull/918

> Maybe Alessandro can shed some light on the current status of
> the italian translation.
>
> Also, notice that when creating a PR the default PR
> message tells the user that the correct way to post a patch is via the
> mailing list: I assume this behaviour is inherited by the main git repo,
> but still can be a bit misleading.

The Git l10n coordinator repository ("git-po/git-l10n") inherits the
pull request template file [2], and there is no way to disable it
without changing the default branch name. I have updated the
repository description as below to clarify:

    Git l10n coordinator repository (We use the GitHub pull request
    workflow. Please ignore the pull request template inherited from
    the upstream git/git repository.)

[2]: https://github.com/git-l10n/git-po/blob/master/.github/PULL_REQUEST_TE=
MPLATE.md

--
Jiang Xin
