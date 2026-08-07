Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B4431A57
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100767; cv=pass; b=WdWWBWs8uh6qWyYCti59UnNtXP2snmEeejtGNBUc7eFo3f/8qyGQscYl/TzuK7QQG/nPyMooR0movtyyRFWkx+6daMJnz3ILxYCP6GOBMEqRell1gYVIecrwEG6uvvITqe7NtCDSqed1fc1M/MIpWzwg/zjhPA5hQLiBuI3lscY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100767; c=relaxed/simple;
	bh=E9dDvsN06IPD5zB64/SeQaRs6z9PY+n0vUutwRiLj0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e114eDscLS9MZSzC7Yy7gZIZ2WgveqDCMscLqizvSNCWRBifAN3elmb+kXwfBqqJFzBE7TyL9yIbkxYihDfOEnI9Hnmni+xEh5oDreo6nHpd+7nomDTWWI92q18f7FJIwpfqfQ/u3ewHZanCwWUn+wayGv9HNo5R2eHu44QDH+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUQlOpMS; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUQlOpMS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so37618455ad.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 04:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786100765; cv=none;
        d=google.com; s=arc-20260327;
        b=AOkPwiYXZ+BjuoNZ0ChJwZzrSkn38WpToLnFDFNOZGEAgbeXHyrzdjniAc2LRTO1qc
         Nt9CEVNVKF7RQWsTKmvHAbYHIaXq4Zyd1KUSPJNHhgItjP1Hvz+VZ4gl/0md7ji3C3mw
         F5SZvszTcNFTNmB7dowZ3fWaZ8RNGxDG/JWR4KGgLAYFGc5YhOlyXuNc8i0q7h0m5AhM
         dka4PCBaDkyaHffJMBHEWLiO27UhlATionISIPrH0hFHMx8DDjsolfCHQN5wGsQ2fEaP
         ZQZEle4D/4MbxRL61iletwv82/vRvuubwV+IjEOhEIU/cj1LO03nF5TugGw6H+qDvKOY
         QLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0IKI3GDNTIWby+838J7zZZ/+ejmsR/q5VkA8tj8HABI=;
        fh=YwmPq8PsobiLvtC74wuvScxlJSWQOsxp3w2WzSpzgwA=;
        b=ZROnPWXziWEW168UwQcx/Uljy1Ldtv/KKjch/uxFEGN7IZSbZZQx9AU+fDc+Q1VnHO
         /9h+xIDbi4LsxXv98CgBHPuTvP62S4G0Ywf3nAvGEIGYZjim9xNjKTM/rE451jLjMTf8
         LyzIo8QRkGXkzA6mLcYKRjYNGeogtSJWgqhWFFmw1S4jHqvsc1fymknkXx6OgUoSsJ3C
         nOgZch7sTuBqrXtPjhJkaEK4hu70tsLGA67H/ZBF/3rIv3hk3CYuCQeHscdb9UUQoj3s
         6f1fZV2L2c5GVlbsGW575qCdXSi5vH88Ea7GMNUlSYMchOe8xtIUrWllfYeSRApcAtI0
         ABwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786100765; x=1786705565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IKI3GDNTIWby+838J7zZZ/+ejmsR/q5VkA8tj8HABI=;
        b=MUQlOpMST7kk8ZdLvF/UWgubO3Fz4K5eFEBmjvUDx807hRZOMVdKp8TWrVYejcFxJZ
         IXfAH3wdxKv7DxewQTQdvdahN2aoQjEzGBrtu8GtxDu30TM9fbaSUYxUfrs0p890NJMe
         iEZ/ay8tmTKcG/L1FBMvDjDtu3774chlCgwPQzXy8zTnkHTmlQ3czFVNqUYG9dy21Ekh
         gJECdaqOFnPl1+PIzTO6EWo3Ynf/lbuinjJ+sdeKD96jztL3i4wqcniQLdNyQHJfnggN
         aEqdKh2XHlpqqeSH15mlH8aYCkNjWyRWrkUC4scH7/m7WIR6p7Rry29MdcMhRcyEo1vF
         H3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786100765; x=1786705565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IKI3GDNTIWby+838J7zZZ/+ejmsR/q5VkA8tj8HABI=;
        b=WOHsZhziOfnF3YxihN3iD7+69jDF74dCFfSdQuhvc75y1C2wdEPouVV69Nv6ZSUWBx
         pRDp0CEHXcauuH16Y86WleXFkafAJeqfFNg/IB0B+wufYj5PvJ+NUpSpc4EFycvlPaHO
         kkTeGGqhml5B4FzuoUs8U8fTiDMws5YlHpn+atXUkckm1YwXKnKZyk7DM9D/yVzMnaPY
         ScoovPuMr+YH63Qym/PKU7GLgHAEFrXesymvXZVPCVO6dFjiMxMh6G78uzkCFmz/++qS
         MHkUCoKTJq9RT9Q2z3t7nQS5kqT4S2CR+XxzXwu0OAyetLOH8nc9InQNT9+loMf4yFA3
         hEag==
X-Forwarded-Encrypted: i=1; AHgh+RpPm2ecjGEE6NNg/MS6vRIwFMvG/bVx9+lWTKRkOPwF8XmS8myK11JJVlvx2sl0ftUxq9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy624xmLCgMK6HkdPdyvk+dm1vBSfnGhf9ZVi4vqAIVGoElVk35
	o3z7SUyGu6OZxH2fteMsT1tr7Wyaqp7igPtayg5UtGatcKYDR0zLb9tRbqBNHu/tmpzjxQHs9tR
	GcQ2HcL4G0yUsAaT3EDe7pnCNz3JZJEY=
X-Gm-Gg: AR+sD10TJemdMaoWyOZkiglN5L6BpI8fbKtcteOZVURj4Ee+fRLOcc7qgN2drUU6/Ih
	fKbw6NWWer8h6tgLxcZhJDeuNM0UkH0kiqNZXzWnXIRcg6BYdYQL+Vzl1Wws4q9EPYbqkr29k6W
	tvTf3R8E/q21rug4Nrh9xPXrec+aFgtX6gCwARlYJRI0QhYhXqNyhCnbZYuel0L+7qY4XrrZmZZ
	pJfBVqE5nA4M3Zm6aB+OD/dVz4PkZwNUp07i3tc0zvyhYsD6SmwJ5uG/Qy8ZHqsXzDZNvnb/vaV
	HddXEzsUfCR5d9beRWo6B6i9EFAfrGu08aFG3d4y9P8oIRFtgU7fuUnceyEg9D1htw2vqZ5o6gr
	kIELlB5mqZcXfYEZK+1Bu6E9ioa+f60+nq8cVRQKNDhwKjrs71s1C0SSHsGRl61tUibjuiP2wg4
	EDZ+WFo4nC9xMaMsVG5w==
X-Received: by 2002:a17:902:d48b:b0:2c9:cf62:6f61 with SMTP id
 d9443c01a7336-2d0ca78de48mr222688065ad.17.1786100765219; Fri, 07 Aug 2026
 04:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807013830.698340-1-gitster@pobox.com>
 <CABPp-BE0WOD1jRT-fVqxP0uaVuV0-Qu4rqCyL63vaRCEiAUmAA@mail.gmail.com>
In-Reply-To: <CABPp-BE0WOD1jRT-fVqxP0uaVuV0-Qu4rqCyL63vaRCEiAUmAA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 7 Aug 2026 07:05:53 -0400
X-Gm-Features: AUfX_myS6nLbE1DCi8oy1SKyVKN4hnCXkdpeDRsR1NdkXpiIFbKrkoS33lLrcrM
Message-ID: <CALnO6CBDqCnYX4ph-BsDEr+TEs+oRbbXKb6rjYmbAaV_6H=HiQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] completion of 'git [-C <dir>] diff'
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Britton Leo Kerin <britton.kerin@gmail.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:32=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Thu, Aug 6, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > The primary motivation for this topic is that the command-line
> > completion of 'git diff' does not handle paths (unlike 'git status'
> > and 'git add') and instead relies on the default behavior of Bash
> > command-line completion, which completes files in $PWD; this does
> > not work at all with the '-C <directory>' option.
> >
> > This series teaches the completion machinery to complete revisions
> > (unless '--' exists), then tracked paths, and then untracked paths,
> > before letting the Bash default kick in.  This way, we correctly
> > complete 'git diff' command line even when '-C <directory>' is in
> > effect.
>
> Nice.  :-)
>
> > The tests are the only changes relative to v2.  In the step where
> > tracked paths are completed, v2 did not demonstrate that untracked
> > ones are *not* completed at the same time.  Now we do by having
> > untracked 'file3' next to 'file1' and 'file2' that are tracked.  In
> > the last step, we demonstrate untracked paths that do not share
> > prefix with refs or tracked paths are completed, with or without the
> > "-C <dir>" option.
>
> I found this paragraph slightly hard to parse.  I think this means the sa=
me as:
>
> Only the tests changed since v2.  The tracked-paths step now also
> shows that untracked paths are not mixed in: an untracked 'file3'
> next to tracked 'file1'/'file2' means "git diff f" completes only the
> latter two.  The untracked-paths step shows that an untracked path
> which shares no prefix with a ref or tracked path still completes,
> with or without "-C ".
>
> (Not that it matters, since this is just the cover letter, but...)
>
> >  1/3: completion: no-op refactoring of diff completion
> >  2/3: completion: complete tracked paths for 'git diff'
> >  3/3: completion: 'git diff' completes untracked paths as a last
> >         resort
>
> I found two minor nits in the first two patches, and didn't spot any
> issues with the third patch.

Yep, modulo Elijah's comments (many eyes, thanks!) I'm happy with this roun=
d.

--=20
D. Ben Knoble
