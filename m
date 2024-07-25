Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F319AD8B
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927434; cv=none; b=URDzna35GdcU1I4s40dW9LbS0NAAwarQlERADsiA4ielj5BToCbKmH1g87XXO/APie8Vg0sqDX9bY06wz+SdRP5UDRrAF34ajeI9sZjVYBNauFbnbzr7sDUY3Pkh8nsL4UO+AU3K2jkeSjB6CvTeurn1Lac/i2gprq4LvcwdusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927434; c=relaxed/simple;
	bh=M0VJ+nxpJouQdiz4/1dmBVvqQuAt77Kv+NrppHQPGp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+f3S4y0HBSQbmrTv9H3Y6oSomdVneQfF0wvJrxKm1KTU+TsFKXXSVh/C9fa84JeqUcJP5NafeZhxZQAaBIbUIORWNG1VKi308LU4Xa/aLL5ShEjuEIK9aJtLIqs9BgJQTnG1GFcnUW9J6Hz4SMw0duOBMlJSUfMDCL4LLrtBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feMR6NAi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feMR6NAi"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so4100440a12.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721927431; x=1722532231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jdUaKcr6pG2k4TMdzv/hT2ZL/k2xYsT4NFLIRvDS+M=;
        b=feMR6NAiBwa83ZkMak+fAHt441B0zE1ZSTyH6NMazYtNUV6TsvdeHJfUAQWx0UNoSw
         yhlEX3RGKegmn9hGAYxTJewoAE5XVvpZFMkU+nIFykh1KYEtlHfMq0TVy+gFii5GGilS
         e3s3aEJSm52nMgT0nrMFzKJAMjhaI+dslKGy37brglzi/MhQJmaT/BqxbinVexJ+TZKU
         oqKKHvsoVu+y5/KSZdgfwch+yJOS2RcsozkysvTSoJcEt+zjcRgTiaDtOI6VqrI2XMNv
         5A/XPYPCXHQZYsuFMY6QmSa8T3c0ezY6VKxORoIPo0A6cPgsCQGkYklL9XAVou4Ssyg9
         nD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927431; x=1722532231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jdUaKcr6pG2k4TMdzv/hT2ZL/k2xYsT4NFLIRvDS+M=;
        b=RqhxLFkOpInwQA+kyaZDiyus08If7emVUrky/mfMSlQNcROWxjcTPaW/EkKnVB4sTG
         yQI1QKOoQNcy0vdtMXTTpL1i9e3tlKSYVmJh8gpwgDqq196h5/Jug0gbjLLk7mgMMrak
         FlyHTuBqmIgMbRtyPWDir2R3PlWE5VXNQFfKp1F3T9SnIPiLYTG7T+9HueOv6LQ35DO3
         TzHtaGHp78Zqs6ikao2qoN8L+J5VRh8eJeT+YnfAYDGicPE/9Cy4MTZ0/5XDWMCmohwb
         1aEYguUMszxhL1lNTeKtGPdJIqhGelznqcy8Mw+BkVif2aRjuC5gexKCmUbFc+JR++VB
         hgfg==
X-Forwarded-Encrypted: i=1; AJvYcCVFZt+/a9L36ER5/9dOd4vhrRsBk6dlX+yFFbOvIPF+wxdHzI5mm0nt7F6K/bPAjuYgQPMtX0l0UuYEBlQWup+hw+8g
X-Gm-Message-State: AOJu0YxPvQg0n7MCcSRM7mCWTf88oXhduc40Nb726BKkP8F+7CocW45p
	une7I+Nhg7ctVigrMFWwBtDJzjs66vX7o2zhTLNbIX8xSQCVQQsPIdC9cAi9qkplIe+4bt2l5b3
	bTfsSt+xqa+fAwgZ9J5zEOq5WkL8=
X-Google-Smtp-Source: AGHT+IEszeAoJpsFsLma6hIpbiyJ+xeF/229SI/hiwDpmqyS9MdF8k1gD+UJykhwq85kRfteziGQjX/Y/lJw7NqvE10=
X-Received: by 2002:a50:d4cf:0:b0:582:7394:a83d with SMTP id
 4fb4d7f45d1cf-5ab1b762219mr6922065a12.12.1721927430805; Thu, 25 Jul 2024
 10:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
 <07d801daccb3$c1de13e0$459a3ba0$@nexbridge.com> <CAJ_CbHX5nyvMy3ZO+YYCWnPhUmS2QZJjTzsePqXT2TEy-LBQfQ@mail.gmail.com>
 <082a01dacd52$056ddf70$10499e50$@nexbridge.com>
In-Reply-To: <082a01dacd52$056ddf70$10499e50$@nexbridge.com>
From: Bruce Perry <bruce.a.perry@gmail.com>
Date: Thu, 25 Jul 2024 11:10:02 -0600
Message-ID: <CAJ_CbHWMiU0+6kB7mxE+n3x7N4A6GugMkmEQwHLzZiF-_GrxbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] clone: shallow-submodules should be single-branch by default
To: rsbecker@nexbridge.com
Cc: Bruce Perry via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Stefan Beller <stefanbeller@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Any further comments on this or changes I should make so it can be merged?

The current code behavior does not match the documentation, so
something should be changed. If these changes are not desired, I could
submit an alternative patch that changes the documentation to clarify
what currently happens instead.


On Wed, Jul 3, 2024 at 8:05=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On Wednesday, July 3, 2024 1:00 AM, Bruce Perry wrote:
> >Perhaps I was using imprecise terminology. This change should not impact=
 whether
> >submodule clones land in a detached head state, so it should not impact =
anything
> >that assumes submodule clones are detached head.
> >
> >The change being made is this: "git clone --recurse-submodules --shallow=
-
> >submodules" currently gives you a submodule with a detached head at the =
desired
> >state, but also downloads data for the tips of all branches in the remot=
e being
> >cloned (potentially a lot of unneeded data as in my use case). The modif=
ication
> >means the same command would give you a detached head at the desired sta=
te,
> >plus the tip of only the default branch in the remote. The modified beha=
vior
> >matches the current behavior for a simple "git clone" followed by "git s=
ubmodule
> >update --init --recurse--submodules --depth=3D1".
> >
> >Thanks,
> >Bruce
> >
> >(Resent due to a formatting failure)
> >
> >On Tue, Jul 2, 2024, 1:12=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >>
> >> On Tuesday, July 2, 2024 3:08 PM, Bruce Perry wrote:
> >> >I noticed a couple places where the behavior of recursive clones for
> >> >shallow submodules does not match what is implied by the
> >> >documentation. Shallow submodules should be, but aren't, single
> >> >branch by default. It would also be useful to allow users to override
> >> >the shallow specification in gitmodules on the command line for
> >> >clones as they can for submodule update. The modification here for th=
e former is
> >a bit ugly, but hopefully at least gets the point across to start a disc=
ussion.
> >> >First time submitting a patch here, hopefully I'm getting the process=
 right.
> >> >
> >> >Bruce Perry (2):
> >> >  clone: shallow-submodules should be single-branch by default
> >> >  clone: no-shallow-submodules clone overrides option in gitmodules
> >> >
> >> > Documentation/git-clone.txt         |  3 ++
> >> > Documentation/gitmodules.txt        |  4 +--
> >> > builtin/clone.c                     | 10 ++++--
> >> > t/t5614-clone-submodules-shallow.sh | 52
> >> > +++++++++++++++++++++++------
> >> > 4 files changed, 53 insertions(+), 16 deletions(-)
> >> >
> >> >
> >> >base-commit: daed0c68e94967bfbb3f87e15f7c9090dc1aa1e1
> >> >Published-As:
> >> >https://github.com/gitgitgadget/git/releases/tag/pr-git-
> >> >1740%2Fbaperry2%2Fsubmods-clone-bug-v1
> >> >Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-
> >> >1740/baperry2/submods-clone-bug-v1
> >> >Pull-Request: https://github.com/git/git/pull/1740
> >>
> >> I am concerned about this one. Many CI systems (including Jenkins GitS=
CM)
> >assume a detached head for submodule clone/checkout. Adding a branch to =
the mix
> >will change the expected semantics. Am I missing something?
>
> Thanks for clearing that up. Fine with me.
> Regards
> Randall
>
