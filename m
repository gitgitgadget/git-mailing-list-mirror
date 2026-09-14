Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2D3DDDAA
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387709; cv=pass; b=G7aeeH8PwzoUqfwKyMUIfRHuyUKI6X0CANWZk2XFwfNpEouBh5kKOKIhsDmZG8RFYRALBRDaWzKxlcdWbodDfzjt4QGeQ0MZPquOKrRU7K5SXTiKoxkpd+uUXSjROUlu2CoO0HMiXORfOLofjsbxlEyZA832gk8PjNxk6guXV6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387709; c=relaxed/simple;
	bh=t4V1RrgANQrowHd1XJgyfn0SGdZzk+qr5iGsEgwhwfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLGge2SYhgifyQqtT7wwt5XTYKAp33vh98CxXRhCoTs2LLEpVVTNfoBqx9Y5iV1o/ORQYhB2KGNAFpe5jNAOReFjwwfDNefAJ+YSL717CppJ6fEpMrG0GVi2IZyWnWFdzHKQgLJGqUhWcsuhfoplXyIH4hlGPTPMY24IwEZ+eng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXIFUBez; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXIFUBez"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-779d18ef706so2415933137.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789387706; cv=none;
        d=google.com; s=arc-20260327;
        b=aQ7GIefIBNruN2jM0W4tY+LlDorUvlpZOagqKNWjYuRkty49Nm6Lf+CgnsQqjdliIy
         jxffyxYRft6YmdOAmu7JJH4UeO9FcZyIrx2rGqObOM3fgLezdtsjv+BBXvi91lyfeyxy
         kCilMe3l4zYZkNhn8wr3qw4Mjc6hk7zBg4EtIwRdizCznVJq3vq/cXzl0/F4hukb2ftx
         2zTWizx8AxiEEWcDQ8/5FzI/5Yw8CWrPZdvkJBxcphLES+yoT5IIyd7r9rfQdYeIjtbL
         Lq03zA5kGDrp/oppZqyNAcUTQUnh59r/sRQHWwaCuOaxf4Sipa7LGc3bhJzbipTJ4yvc
         gYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsyG0TSoA4B/C79nQvesqvLI08R0zYUdmfIIKGwhAeo=;
        fh=s4EacBjiek327frWMiVBFWRr5BoeLYnPjbgIwexBVBM=;
        b=b/Ov4wnqsLtt17Zhx5CybsGZV24KygSKGNDL/jBvh3Dj2wFrCuKA0FZprVOF5gtdcA
         Lhy3waFtZmvxk98arbKacUnLtn9xR4bBkIdTtOH2t6V4AwSefs6fTY6YoaeuyEwJa8gW
         mvOdZIsx0ioHUfi8Lczu6E1VOgWk6SE01KeOUYdCl1c68deClpHasP3IKhfwXiTdJK6n
         5M+J2nbKKSrpm3ZWFoDhnrPtEflUHbzd76BAG2UNNcRwZKhuFLqsdLjhlJr6M3CMeyOE
         bWqNLXirShls7senlwYWlYO26kUSn+o36MNTjboY3lyWC3wNuiHQQ9hR9s6dezpCSqP8
         eB0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789387706; x=1789992506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SsyG0TSoA4B/C79nQvesqvLI08R0zYUdmfIIKGwhAeo=;
        b=MXIFUBezm+zu6qyqdMIt0lZ7DmnWunL5KeccVtw84W8Xpo4T04wTGTm7XlhEHGDAdz
         dRtWsUma5rUFv2CVujPPG4W5937oX3tBPni+MbXYH26LXQcE2l8uh5T5Q4x/egZ58wBs
         tduilJvoQ6C0B4DatTHZsrPMucgKXmO3rTd16B1KgcFyXS3g2JHqBFijNV7kX0qsroY1
         JzVuwdoZZ4Qvydpa6mIjxJY+imReAYVmUACXR6nm6kaT9nxj3ghyzKznXNDvxA5Km3J/
         hU3Q7ROWp8vabQBIHUSDMOym36/lfqe8tNvbIJUhI8FvMIQYK0OK/QVYzGR+rjF4iHhC
         GIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387706; x=1789992506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsyG0TSoA4B/C79nQvesqvLI08R0zYUdmfIIKGwhAeo=;
        b=YJ40uiUoyiQWdsDPc6SPWeO/Wx4r9lbY8iz6SquXmwuLnS5ruX0vZTmk3NJDgozDIn
         QiyjOVOATLqcfV+0ZsYP5qdCnGLzRrjcs3cTNFb1xZHLDUPLh6JtRTVnv0dIFIEkrq37
         hsdYFGSazk/4yzfBKmsY8uYXWSYVKXzCkQxMjw8DgkNiPQbb3Jze4qXpGOYA7vtgeDe6
         TLu76gaAR8fxtw9g8DeNxblHIvCfDI0kxM3+idKrFatfNCrGJTShdz6Er0z4aeCGIP3E
         5UiQqJh75f/R//Utoy4hOioRETUlfnetZ7L6SLdC2D/wY8cR6NiTBMEmHrkjbtHqCRU3
         zbow==
X-Forwarded-Encrypted: i=1; AKwUvBwHVvkIo9RoYvZxFwxhfGXeLXdUcq4sta4viErxtO1xqpShX0uMZA3XHCPTI1wL+veNybU=@vger.kernel.org
X-Gm-Message-State: AFuF++lEDH34NV/HG/gqwMcu0CnotiySt66t7oFYqEchnrOY6UGk++EO
	u9LVrLv0zUQbnesk2lXfh5OSKGoioemIx5N750hQG7n3h7Nivl2SlRsIZ6kksxFl1kT4T2gNFHJ
	I5wexOj5zB8IyfYy/yVvDRYXjCL051z+TlPIP
X-Gm-Gg: AYBFou27Mq80EwgZhjAQ/x2BlA8Eu8bqKHdLPbw05PrdtjFKz+M2MlnGd0HgjYHN9Pk
	lPJCVXDO6UCxyBN0TgSd1xiA2TEF5XHnkF/xYTJXp0HGO1bIgXQCUaNrE1+jsOq+wK/wj2+oNZ+
	PgSjOWErFp5QZqWurjIRnolcYMHqOev7JtxsXMFcC9VrcOUKTCME3vxhPUAhW7LfHE0ST9/+6h8
	ZHN0Bpblld3wC+RAvIm0I45yfkMwMv1mtvaoaLZ4Eq/v67+GNUa0CkEp2Hv7So0drxAVYqvVmMd
	558hSeDjaBWwnpzMjYnTsKzo2ldgSTyiokjszmcOYg25TStIT37Ou4+1JYH8TMyjEfW1x30UulB
	GggUITOYke29zu7+Ww0FmE26zh/oE2HW8R/sgVwSEVHE=
X-Received: by 2002:a05:6102:3712:b0:79b:f106:4eca with SMTP id
 ada2fe7eead31-79bf115925amr857594137.13.1789387706573; Mon, 14 Sep 2026
 05:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2218.git.1789171955370.gitgitgadget@gmail.com> <aqeUWrx7pbzDVbVt@pks.im>
In-Reply-To: <aqeUWrx7pbzDVbVt@pks.im>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Mon, 14 Sep 2026 21:08:15 +0900
X-Gm-Features: AcwNN1UwASnmTmN9Np6KfK-ZHCTDoAkIdTdnVoR3iRIT8SUAIRVKiHfvqBNkbKg
Message-ID: <CAF5D8-v2FSJX_dHFmNzaudAtPu76pVX0n5GhMnGjjnT2f3g3Ng@mail.gmail.com>
Subject: Re: [PATCH] completion: complete 'git worktree repair'
To: Patrick Steinhardt <ps@pks.im>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:29=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sat, Sep 12, 2026 at 12:12:35AM +0000, Yoichi NAKAYAMA via GitGitGadge=
t wrote:
> > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> >
> > Added completion support for the 'repair' subcommand of worktree. It
> > optionally receives a list of paths to linked worktrees or paths to
> > worktrees with broken links.
>
> We typically write commit messages in imperative mood, as if instructing
> the code to change. We also briefly describe the status quo, even though
> it's not as important in this particular case. An example could be:
>
>   Our Bash completion does not know to complete the "repair" subcommand
>   for git-worktree(1). Add support for it.
>
> One could also try to add in your bit about worktree paths, but that's
> something that's quite obviously visible from the diff anyway. So this
> may or may not be valuable.

Thank you for your comment.
Since this is not limited to bash, it also adds completion support
for zsh and tcsh via git-completion.{zsh,tcsh}.
So I'd like to modify the body of the commit message as follows:

  The completion scripts do not complete the "repair" subcommand for
  git-worktree(1). Add support for it.

Thanks

> Other than that the patch looks good to me.
>
> Thanks!
>
> Patrick



--=20
Yoichi NAKAYAMA
