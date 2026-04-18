Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8A33987
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776475004; cv=pass; b=Wow6m7qvjbfwH4sPDbBySS18i6mQtBMxKzQSZlNl6mHNWckULaWSUenPQqoqPLT7xQ8rHffsFAVux8sjlmov5i32gJHgDnkTivsmhoCuUNhJMetaxMYqp/UvHbIW6REzn+R7nCfp7SH20I5R6zvI/dDNdegj/ms6BTqJFXst2tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776475004; c=relaxed/simple;
	bh=5/5nrFNrJsTmH/M/q4CMYJOUdRpVLhOqRgpDoTgbmRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP1eufyRspzGywfSS2toaHWtyXqPYfLiS+x+DyvhjPbOAA5qM70sEIbkIz+VigzybHznOm5VD42ikW1jpZwfeugYplVsoMbz2tPMFWIP+DgLwOnXzXJRbL0NOOxXWmDXPzu2gtuWWhFh5exfnsJHmziiNTQdaU1YOkMlPdvXBDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4pcpiNq; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4pcpiNq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so582585a91.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 18:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776475003; cv=none;
        d=google.com; s=arc-20240605;
        b=B7I/RRlFfOfTojbOV5O+rH5TZLVyEZToixIyFearhFSBIXJwvncNkmkLiaRCZrKEOz
         jfSOz18QmR+z5wWxk7S4QuZH7X0S4ApLdcRaVaGooFg72t343OxyUoO+N5DIgmGcT+Sg
         HBof8eBdRH5AfLu6oZbx9Mznoi6bGaTSinR5F91n0FHoxKUwAHH+2YjuX5JElzDORBU4
         XV9LYfg4Px37RuZG/qlfFWZ84oQmIW+i56JSHpNmgVJ7fqER6l5c0FJWksO02t8RYGtM
         lvAKHaTee2zU4fcXxW+wd8MThDlDqS0px2gL4oovh062MBjEV9h8RFLoCo/lTSjfz8dX
         rpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a75XBNZygoTPvZ0TkqRKinimhM/ei4ak07xxYsmW1NQ=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=efHwKE2H5657/6MuixjdxNt/fqdA6MzOjqKUv03giCSohBjetGGzX6eQ8e3jHF/VEC
         ERXFIgShr90q41cXDr1sr/XnQDIGdkfblfLZ1GwOG9eW5cQkdOLxSGg1KjlAOGYRViPw
         lh9/wpEeL/cGZglQZV944XYhH8stPw1zDkpK5hpU9G8y8BYQpaYdh7w3bPcs72iKVszd
         gB+QcH1031BwW4m57gyBvX/oc1FTdIQsVF8fvxp+NhzToAdADtPwh/jEtW7SQ9YQFK7L
         lBvKW+m5eeaXodus8KGIVH5Lkpucl0tegxwe0LC3y+sY6fJ2Cq5r5lQyn2t4GhkRkkwV
         8jSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776475003; x=1777079803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a75XBNZygoTPvZ0TkqRKinimhM/ei4ak07xxYsmW1NQ=;
        b=H4pcpiNqAX+XZSQ7QKIF6kEiPGv5TbOKpG+V4zQWbtuMoOrynaQt0oUQAW8gQwcXuW
         e3xkXQbmh6PKhjX/p6LWH+eSLFRXzmIkpVWePKiAsOl8tOem7l61iUpL5VscHWsrGXno
         4uED2o9qIOiSveY3iJ8QTlbOqUyCw3aLEuUmWfu3wPyGtpDQUdUrWQpduuoe/ka6cdrR
         si52Jb6Y+RAfqDqkP68Q3rXBqWwlFinWF5lfK/4XdBkv81Kb+KSWzuNFgjZIONQXZ8M8
         bU3LrzFYQKNAs2jrsXZY/gdi5TUdYK2CDTdRqA0QFioWXtQwraSA3yz5lu8QjWkaCBf7
         /JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776475003; x=1777079803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a75XBNZygoTPvZ0TkqRKinimhM/ei4ak07xxYsmW1NQ=;
        b=ot2zMBPKlm2esHS+5U6oD0Rg2w0qJvpfmoQo3xmQaWtyNpI1OViXQkF4goj27yMC6b
         fj6+d4IR84gwxsS9Er5lw7SRIxENXq7bkvaCZlDupHXUEToyaD52i3G3Cu3ZdcQgbqm8
         1XDCi70LKzSrUHLcTtI5qK70HiprfP/pjtXMVBXoTmUO/s2bWTGthursQ2eK11Bh8f3r
         0IDH6gVJeWD42FQUtfvc66sbxDqdw2qyY7aQcl81ex4gbvZ0KRQJziquy02shTou7HEg
         WqlCfXi1DAm9goa3ASHGPNp3ZM63an23YR0LyGJQB9BexaxqbHDcvH4ARZiGAFJaBk+i
         oZXw==
X-Gm-Message-State: AOJu0YyGk+VjnQxHoKMisD69OOX3UBQ0lThLSVD+VBgFAI+mZZ61dYfm
	hwUEpYzwbo9NvBSv6C3KjewaL7kgyd/7o5VbXih6Nv/Z8AD2solc0spkr1qMUQsIycUesIXDRmr
	me3ddFOXeqWzANYfxdzZKk+k77GP7xBDH3Q==
X-Gm-Gg: AeBDiesBXD62tcTDBox9B2S6yduGN5od1Wp4Sfb2M0OgNxLJnitJA5gO8h71FE4Pk+e
	ypZTLISI/llQzi3InkMm2sRSK49Wgp8fKLGLlyoDXmzWRYwEw8EStv7Cw9uV+fpX5ZteDJlUSZF
	NeSPbyouGtSZ5+QCRsBPgZFWeCGYQAQp9OLpSpSPXYqL5h+d/buH/dy14y2+EbD27418FGZoVg8
	njHXLkWrnP6pTcuySoEG51y0lXECHnIh62TFAOVMakvtVA0NyXnwNSCiZeZIMYdJ8QnUehTGUUl
	I2PNbBzUyvx8pMy668kQ2fWNVlQ137KC8HErheI1LmceTlAr2weBCeIo2kWVouORJKu+kbuDiT4
	Gd3o0m4En1psH8EZLwcrAbS50emQrDCxguSqD
X-Received: by 2002:a17:90b:54cc:b0:35b:9d3b:34cb with SMTP id
 98e67ed59e1d1-361403e0ff3mr5202737a91.8.1776475002882; Fri, 17 Apr 2026
 18:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im> <20260330-pks-setup-wo-the-repository-v1-10-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-10-0d2e822837aa@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 18:16:30 -0700
X-Gm-Features: AQROBzB51b4mO4iPZiZkxLv44zfj7gE6AImBDsq7Qk1hz7C24vvwHbeaavMnZ-w
Message-ID: <CABPp-BEe0oN3ZfV6ZhFSADWWj_zEAx0_JUhc=Qc76-aqpSOxTw@mail.gmail.com>
Subject: Re: [PATCH 10/18] setup: stop using `the_repository` in `set_git_work_tree()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:19=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Stop using `the_repository` in `set_git_work_tree()` and instead accept
> the repository as a parameter. The injection of `the_repository` is thus
> bumped one level higher, where callers now pass it in explicitly.
>
> Similar as with the preceding commit, we track whether the worktree has
> been initialized already via a global variable so that we can die in
> case the repository is re-initialized with a different worktree path.
> Store this info in the `struct repository` instead so that we correctly
> handle this per repository.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c   |  2 +-
>  builtin/init-db.c |  6 +++---
>  repository.h      |  1 +
>  setup.c           | 24 +++++++++++-------------
>  setup.h           |  2 +-
>  5 files changed, 17 insertions(+), 18 deletions(-)
>

> diff --git a/repository.h b/repository.h
> index abeef3129e..7ae3d34484 100644
> --- a/repository.h
> +++ b/repository.h
[...]
> +       bool worktree_initialized;
> diff --git a/setup.c b/setup.c
[...]
>
> -static int git_work_tree_initialized;

Okay, so we replaced the global git_work_tree_intialized with a
repository field named worktree_initialized, _and_ changed its type
from int to bool...

> -       git_work_tree_initialized =3D 1;
> -       repo_set_worktree(the_repository, new_work_tree);
> +       repo->worktree_initialized =3D 1;
> +       repo_set_worktree(repo, new_work_tree);

...yet we still set it to "1".  Shouldn't we initialize it to "true"
given the typechange?
