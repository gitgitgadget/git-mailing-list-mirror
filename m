Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37E3D4132
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672422; cv=pass; b=GBYRMVx55Nu97ShxzbrPN1ir7EUNDqZrpO8Ya8irc6PhR9iDKwlk5zRyKh0XETDqcSEbz+4kUxgwCGpY5/MX8zABNS5oBfTU/V+QVKDzg/0iqeL8Dcp4BUQeIKZUVdw/AP5CtmfGLOPAcKqG2LawywTG/CmxvHqnMTgGUrIZr5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672422; c=relaxed/simple;
	bh=2aJsaKxXyj2hGrWDsn0fPc6pBEN+pYeZMz375fH8+0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mebo01kn0+5v7Hf7I982lFVs0jyxAk0EaH+7eRaQOlctxMzR/NyVcyT8PuoWoNc0hVWQiv/Nt3LoYhfNACb/mUiE5ClYzMMr2Ob8CpUioNOC/zkYfNeDi8ZgDhF7bod4DRRJHpLT+g47xPbGE72Vp8G5HMZxog646JCTViTOOy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUQ3h/03; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUQ3h/03"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-49c38a4f110so282164b6e.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786672419; cv=none;
        d=google.com; s=arc-20260327;
        b=Zab31p/VK0wtyq2ADFFZjoYbWRQYC/432WffmaCzA4EdUYV+4kb0P+6+ew8PLMYa1A
         FkPsfL9nHmtLcG0T1Qc1r2GqHtCCQ388DPV17UwCvBzN1w5ELCo18wh1oiO6YYC/ru4C
         nLf/E4RCRgQ33uV8BRGsMQgKI8L+f6hooAstyGGLewXeP3b8q9004gNNF6j9ZsUyBGJf
         TLXUTqs337bWyCpNf6q1jCVINheA+IFH/NHnDYj4VcPc5BbQ5ZBJWjprYmooC3gjN14A
         DYWZ9nKdXFGpHVWGbZlGNyYJd89aFiALfXS9fwQqJZnTIdUETnrPF2bICzFhdHMJCi6C
         bAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gf2pndTxUAQhKRub9QORvrzGKvKBjuFNjVTqZpW9ES0=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=OaWQkrc/kB2rL1kA6gNhKndWnQMsNxlnLaLz9AuzbNdFtJNKxsDo1oMmV7H8htiZYS
         GfoKF31xxmZskVuMjO2w5wYzL98yPabBGzyE+iwG41MjVZiiTsXAPGTJIS/Nz/ZuJl8D
         e4vuFM9hTPCzXRAI2Wt29BzTA/YQ8XO9YlY2WpD0IDKkrbiY9AqZ9/JxguZSAD/+ispO
         Wun1gReH+PHcXVFiIQ4LogvGyv4COJfshMn6daPBeDZ/7eebe7NBwwiISI9NwTsJ9Xgb
         Qoto/sTymDdjxdJ5aiAqp7y4F3Loxdqd7ytszimWbxrd3xMMEpMXgINJp3raCUT8uqed
         OTgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786672419; x=1787277219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gf2pndTxUAQhKRub9QORvrzGKvKBjuFNjVTqZpW9ES0=;
        b=XUQ3h/035GodsER2o62e10UOS8IVtrZbC3AlVmIJlgfrSjH/y3JttTeVqqSmv4bL2t
         G0BX6wH/jOfbq+pUSA3eeS33doXvHISi71TJhIToPWPu1Bh6RQHcShmMPImMiBsyzhGY
         Y/8rmux0eumMYLpuhKy8IC+CJVphEzu44ukWwWFhOXTS9HAF0LZZL6B6CEf0xyVUDZnU
         zN4C72VfjRG812ESrkdcYVS4pI5KPkHnL1MuWI0nYlyQw/GbGM8SSlq4GLd9Q4hC0vkm
         cRI1e6DGHkOdr9PNiZj35h50hFOFrDcMArR82etc9SzzPpCSOXlpc+CnIqYxkj73VVWp
         1cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672419; x=1787277219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf2pndTxUAQhKRub9QORvrzGKvKBjuFNjVTqZpW9ES0=;
        b=k2xCc1j0w3M8AadEkRLpqBBn5gXqS+hi8Unl5qNeEOxOVIzRZtKaep1zi0kNyT8lRg
         95ZRD59gddR+AWYSGMrbXUkIu46yPZtIeRl2u50ZxlWKHdFbovXu2sNl91oVnl+VPVpi
         +fKYVXS+/B8tVTv+sPMpixQzPsU6wcf2ynZuq8enkBE4XmtaHrMPL4z+BwpeLkwYIzVC
         rJQtmtBhIzqobb4c8JVwbK/9PEgQJzQzArcqTtsfzgsAshw8DuQjmx0UMk/8h1uu9dH8
         lU9b16fvPBpsllLcCnt8GsGY6wWQGbCYk178T5MH8Bb1xXPWLcbBqW2x66SRUmz/U7Ct
         HN5g==
X-Gm-Message-State: AOJu0YzX/l/tpoBjOEmjwF27gB1RIomYVCDHY703V7F9W0hsfxlsBjxZ
	IvmDuYOMRGkCRFmXoj38pfmBES9Z0UpAki5hwBtYKuTBjCiYehxVV2JYkMNnWwIP8XyjrUtjvA8
	7sjD3NquBKNzcsJqD1aUVmI1+FKauIAtoVQ==
X-Gm-Gg: AR+sD12ETKj0wOQ/BBNb9y/YNEb2t7HBiA9yAXg2mLknVnRu0wpua2X3Uco9SJmU3y3
	DX4M0+cndjwuvUM31q17o8SG+orobzIHRPFcWAJkeeR4Qbi6bsj4ayIsd4KFNHPW7vO4ET0L7R0
	WByks6HP5m+RlDIaEDXPopGSJ6QxJXuxbTQQVEFscf3oOOnQ+U4iLYy9qAnpS2VbB45wmxxFAdg
	DZjCWBOQsumdPqhhPXQUujNXjUJ9L6inLI+x5FHIgenSfXp5e+wmv8h4TS4mF1ffaaUGJDrc3O1
	NWQXuhIY/IDPGP3bXTRil15/K7vnfCZe4qtb8irh+UCGhOyMmtay/CHNaseD7Ct+bGoICT8OnyX
	LtdMivKou3QuVvUW6PyGoW54y2DFuiSukDyJLtu9KmvsyRWSBlnkMW9Wqvgn6JIk=
X-Received: by 2002:a05:6808:238b:b0:48b:1e49:24a8 with SMTP id
 5614622812f47-4b241cbe2e6mr2164154b6e.11.1786672419165; Thu, 13 Aug 2026
 18:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7blx5oor.fsf@gitster.g> <20260813191234.1066662-1-gitster@pobox.com>
In-Reply-To: <20260813191234.1066662-1-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Aug 2026 18:53:27 -0700
X-Gm-Features: AUfX_mwJ_q5ZBY0U43Z88g2CRLFw4TOwBK2pihng95CcID89I6q6OGBZQG5Lpyk
Message-ID: <CABPp-BFeLStBR3OeTCJoBmC7cn_VXrn4RcvBg-WWGyz4LpJxsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] completion of 'git [-C <dir>] checkout'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Continuing from the previous 'git [-C <dir>] diff' series, these
> patches correct completion for 'git checkout [-C <dir>] path<TAB>',
> with a fallback to complete untracked paths of somewhat dubious
> value, primarily as a reminder for future work.
>
> Hopefully this will be the small and final update to the series.
>
>  1/3: completion: no-op refactoring of checkout completion
>  2/3: completion: complete tracked paths for "git checkout"
>  3/3: completion: 'git checkout' completes untracked paths as a last
>         resort
>
>  contrib/completion/git-completion.bash | 88 ++++++++++++++------------
>  t/t9902-completion.sh                  | 56 ++++++++++++++++
>  2 files changed, 105 insertions(+), 39 deletions(-)
>
> Range-diff against v2:
> 1:  33d136ffde =3D 1:  33d136ffde completion: no-op refactoring of checko=
ut completion
> 2:  a28754cfd9 =3D 2:  a28754cfd9 completion: complete tracked paths for =
"git checkout"
> 3:  90aec6539c ! 3:  17880068c0 completion: 'git checkout' completes untr=
acked paths as a last resort
>     @@ contrib/completion/git-completion.bash: _git_checkout ()
>         fi
>      +
>      +  if [ ${#COMPREPLY[@]} -eq 0 ]; then
>     -+          __git_complete_index_file "--others"
>     ++          __git_complete_index_file "--others --directory"
>      +  fi
>       }
>
> --
> 2.55.0-759-g9dcc51a0fd

This version looks good to me; thanks!
