Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793612BDC03
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766218996; cv=none; b=PPmZvmmsm7XYlPaU4auwkbdQiYUSbA5Y4QzGKP+pCNU0pfwR/syPAnAGPsRPa4fL1ZDdfM4Z/AAX4gWC53k/HTISG68Y5NRNztkmWo0ge0OmkUuXoMyOiQYYfCvp8W+yKZ/NvWxxsSn+Kv9dDRPL8V5uPgJ6B/BMby1/NPGKYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766218996; c=relaxed/simple;
	bh=qkXUxod3tSLy2GeGp05FqIDdMDEq5j0JYodeIFRtax8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdrdYFhsVSSCosmn+wH1Xm3sh2JUFeKkVcl4fVvjZHzAv68iAhodYaMU2rFxfOPwkGZkQRKKTm0aT1uMGyyVMdN4XImoU+EVyT+a3AxZnEnYOt171oM6N57uQFcBfpnQdmguo/7FtXAxTuc21jx4htv4SBAcObbTNGxQkgAdtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8887d6d237fso2917036d6.3
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 00:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766218993; x=1766823793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPw4arG7wRIOwjTZTOc/N2qKACBYjEz2WRbimXXEo80=;
        b=cyH4sZiyMI/IMYgGTQ2ELkqt7Amkf+wTB1GMjBMWSvx2KrAOIVuHeIF9NaEK1Y3Vtr
         EYRIKzMbaWpgShkw5KQiV1iYNmaSYS7vir2skOcMukYJn+AibPfUFrZJ7dFB5QXJtHsa
         vUmdlFO6fvrXuntHvnoiUKUdT0rY6ZzbfxtQDFgnwjhHn6i2THu1NOlEk4RxRJYP88qU
         AoyU+2nSWm2W2+r0RL5MNODtGQaq1qRy1hOmVGHUHx1lqoyyA2W3Q91q4Y49zHMeRyTx
         1hapX99IzRChjA+e0Jy6oveReRTvs7qm+CPSVZgxrOXtNMylNrHl2VJq9VyHAq5Suj+V
         awIA==
X-Forwarded-Encrypted: i=1; AJvYcCVXwHKrwZeiFi9gLOyeoBGs+LQ5xICmExCeenbL6vlfTsaOfZkdvjv6tO8eZk5vWfVtqSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYy/2rTsHwBhJQ4fkbH1VpeOMQTpUlOK8Vq+vCJ2YCETlU9IV4
	jyDmkImbb/dVS9MbzekIcn/uHDPp8xQ1aep9JaViAxB5DdS1pcW840Y/UndhUUk/+3tm8GhPnLQ
	jT3/z2R7r/AeeVKwkozoEIbAgt8sZln8=
X-Gm-Gg: AY/fxX671z11EPcxIU6JYB93fKS93+V98+vvG2dlCu5kO/ihPSCCfPZ3ahKM1+S5Akh
	++5Eg376PnWt95vkjdsBinzR6y6mPkG+c6DAgz+JBOGgLp8VRZZuxkf2Jw/LowOvh7Mt4xm8vFA
	twNxspdyHDV/XYWEuyYxaqBRzSfgbSaQa5/skIg/7deE455UzNt6RsZ5eJ5nTIMPc41iEn1OvIo
	nR4/uRKpCXoaZylF1Z8X0Zy/UBWNVpxE/1DgOqsnZcbTsZn0Kn8YZpRtFIYEsSklKNo5HOtBuL5
	eEMl1bmAk+ne15usPQqT5sL2/JEd
X-Google-Smtp-Source: AGHT+IEBQ5QRhSmAyhDNvvXZsNzbMBUyG656I3+eTcftGtfFp2kJbJHxqBtTJVLXTEy+l9zW0MWMgZVtfUj2tGB7hvU=
X-Received: by 2002:ad4:5b89:0:b0:888:3237:6fce with SMTP id
 6a1803df08f44-88d83f5543cmr68121516d6.4.1766218993284; Sat, 20 Dec 2025
 00:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
 <CAPig+cTC8ROsf-cOhUcxovUOcQ47As496SAm7FcEFnzGChhLww@mail.gmail.com>
 <xmqq4iplvhao.fsf@gitster.g> <CAPig+cTsKgzLvz_BJxTLqRfc5A7CK_FNo_L6TDOGPVGG9eXDCw@mail.gmail.com>
 <xmqqfr95txrz.fsf@gitster.g>
In-Reply-To: <xmqqfr95txrz.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 20 Dec 2025 03:23:01 -0500
X-Gm-Features: AQt7F2pOvgvKpRYFj1tcsMIqgkjQLX2NsWqg5NayunisHKDK5p_B7pnAXMC_cHg
Message-ID: <CAPig+cRa5EsN-=WcjEhSPpTLu=R=7uLwHL9OKLdAhwuxmsA6Og@mail.gmail.com>
Subject: Re: [PATCH] worktree: clarify --expire applies to missing worktrees
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Sam Bostock <sam.bostock@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 2:31=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Sat, Dec 20, 2025 at 12:44=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> >> I wonder if this would work better.
> >>         `prune`::
> >>                 Remove worktree information in `$GIT_DIR/worktrees`
> >>                 only, without touching the working tree.  This is
> >>                 often needed when the working tree is lost (e.g.,
> >>                 the user manually removed it) and the worktree
> >>                 information has become dangling.
> >
> > Yes, this is a useful improvement, although one part confuses me (and
> > I would omit it). In particular, if the working tree is lost, thus the
> > `$GIT_DIR/worktrees` is dangling ought to be removed, then I'm not
> > sure why you would say "without touching the working tree" (which is
> > already lost).
>
> Ahh, I somehow thought you can say "git worktree prune <worktree>"
> to remove only the control information while the working tree is
> still there, sort of "orphaning" the working tree from the main
> repository.  But things do not work that way.
>
> You're right that "without touching the working tree" part is
> misleading and redundant.  And it is not "this is often needed"; it
> is the _only_ scenario the operation makes sense.
>
>         `prune`::
>                 Remove worktree information in `$GIT_DIR/worktrees`
>                 for worktrees whose working trees are missing.
>                 Useful after manually removing a working tree that
>                 is no longer needed (but use "git worktree remove"
>                 next time you want to do so).  Also if you _moved_ a
>                 working tree elsewhere to cause the worktree
>                 information dangling, see "git worktree repair" to
>                 reconnect the worktree to the new working tree
>                 location.
>
> perhaps?

Yes, this sounds fine. This information is discussed in the
DESCRIPTION section of the document, but it doesn't hurt to flesh it
out here, as well.
