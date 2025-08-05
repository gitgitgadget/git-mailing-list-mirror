Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026BA41
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358088; cv=none; b=bUgt8L8z6eYZ9tBHaxeMXBWGAiA5MipoRdBccfCufwWJdpVZWOAc/Q2uwudmQ1C3XyM8A+fhyyaeERrAwpdt84Cn1Iq5VZNIYc5b1VEEB2XkhEtiYb8paAFNzq/GUySFbQal6V3JKl3yYkgTXMLu6iXLU6Jb5DVmgBMqZZqCS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358088; c=relaxed/simple;
	bh=8OJ5esmMYAJB45CsysuTelZ2tF3I7LRg/GcPY+n3tJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWO4TRmVNI/8gnnc0tW/T8W5UQlDvO6WDRKqKH6tfoDh/8e/9/To58uiOSMD1f76twXoHswbnbj3xUig/sWpaXSm2ZQHW5hNhYq6qJf6ZsYdL0N+TKoCMuSoHBcrv72579gjVQK3dFVLZejR9LPqL7NSquopFZ5mRMHC2hJihi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It16Hvmz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It16Hvmz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af9180a11bcso1055951866b.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 18:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754358085; x=1754962885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAGOTP3LI43S5mUYixoKSgWua/xMyjLwM2EuVwCzlxY=;
        b=It16HvmzrbSpjt8CVo93oNSmh920qXV6jIlaugxKQnoqtZUJLZs0peL9qOLL77m757
         LJOxTNZrnzOnpZlScyROiSmTPXt7tE7mj5Tn40GGlk66TceOQORgazf1c6ARwv+vv8I6
         wSuJaxkJ39V9qG0pz7GQ/oiWl6HEPNk79V3SZdinGKkjKgDi/yPsQWq88Q3OLm1k+DHN
         gOkNIX7UvLJIsmGOd0PuullwluGTgo10E1AG9t0KAD03Yox9h8/Gy4lmtdOYJoqixDZf
         3WMW2s0KJLJ2RLDTtNQIfEx2D82Ik/s+mym4erHFU/4wcOz5OcCUSDKa7cdKDDFm5Hzu
         xaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754358085; x=1754962885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAGOTP3LI43S5mUYixoKSgWua/xMyjLwM2EuVwCzlxY=;
        b=RsfcnvDLD9cowdNXsXQoRJjh+5m2BcM/IvhJUndDQJpYs/yJoPQkjkoR5llmqOaAj2
         uk1PZ4bfnUMBc9mBhuE2BhFx6a00HzfXj4lluxtNbQh+VRSN+ExMosEdGnLLpDTxs13R
         FxIETlGCCx6VQwpeqcEplgCn5M5Z1iaPAp7vVWCcKsQqI3rTE3GK5S2iif+WsefBxe6E
         wiWVa2CFX2nMpZiS+HIrn/x6wYB8HmBdt+IXOukQfmniJSmCg3MBl3mqzBvgPs6VV3ge
         f0sEP+HMuBrANMZkee7ZkI6fbATBXXCRZ91vouTpPDvCX2O0HyaJ30byiX7x4PzTvSpL
         vEZA==
X-Gm-Message-State: AOJu0Yzf9mZ+Dj93yubrWMfbeEu4uphUT98z1HImtC3T+qJFV5v6YGJ5
	YAt6V9Zvp3ZbUIqBH3954NcuukxZnQ6bmuc46Sg6GPFx/GUidUNfuYrSAlPdkXvwbUe7KrZKVed
	YS9yScJIXPDlzwgHmbFTNghJB7uwUOt8=
X-Gm-Gg: ASbGnctotzKpmg7OjxKeCjfZT8KqP6o2BaddAPG4X7zwuefspeGPbDj8XFr36vG+G9m
	WkWsJXOBlzUQInMHShzhH1OAIughSXBn1cXnlHrSRMG6hPw8xQdw6Z8Zar+ZtbALowk4GcC/7Fn
	1JelApVJjw6dU1DfZrgQ0cODVpMYJDw1h8SA529E0yPMfbZ8DRp1cjTQt8b9vvXSgAcYdEiRGP4
	0WoLYO5OHvDLkgcVaPoKOF+xu63XjPNulBEabsBMA==
X-Google-Smtp-Source: AGHT+IGnF+CgZHinU6L6AHLPqQC0w9Bx+7RPuXNmQrzzq/dDHu1oRmoaJwE/57T5WDS/d/tGUlPUhOrq+YB6YFd73dU=
X-Received: by 2002:a17:907:2da6:b0:ade:4f2:9077 with SMTP id
 a640c23a62f3a-af97d2454d2mr185028066b.5.1754358085034; Mon, 04 Aug 2025
 18:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com> <aa1f960a-e7a5-4ada-84c0-fbf86a6c873f@gmail.com>
In-Reply-To: <aa1f960a-e7a5-4ada-84c0-fbf86a6c873f@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 4 Aug 2025 21:41:14 -0400
X-Gm-Features: Ac12FXz5tgVp0POrAmXSve9QCfeRFHUnXR47PkN_7Xcqy3nBdq0Y69Txs2AF2ao
Message-ID: <CALnO6CA5LwY__chY7Di7qkZK16VhFR8MUSRbUV4C+29owsup0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Drop git-exec-path from non-Git child programs
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 9:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 20/05/2025 20:34, D. Ben Knoble wrote:
> > This has caused trouble in the past [1] [2];
>
> Another way of looking at this is that the trouble is caused by a script
> that makes incorrect assumptions about git.

I've come around on this idea since fixing my setup to not assume
contrib scripts are installed relative to Git (rather, I've hardcoded
assumptions about where they get installed by my package manager).

>
> The assumption that the scripts from contrib as installed at a fixed
> location relative to the git binary is false. Where they are installed
> and whether they are installed at all is down to the discretion of the
> distribution that you're using. Looking for "git jump" at a fixed offset
> from the git binary is no more portable than looking for it in a fixed
> location.
>
> I think that the assumption that git should not change the environment
> when it runs the editor is unrealistic. "git commit file" will use a
> temporary index to create the commit and sets GIT_INDEX_FILE when
> running the editor. This means that if the editor wants to display the
> staged changes by running "git diff --cached HEAD" the diff will
> accurately represent the changes being committed. Adding GIT_EXEC_PATH
> to the beginning of PATH ensures that the diff will be created by the
> same version of git the the user ran which avoids subtle bugs where a
> sub-process of git runs a git command using an incompatible version of
> git. There are several other environment variables that may be set when
> running the editor such as GIT_DIR if the command is run from a linked
> wortree.
>
> To create a clean environment when opening a terminal from your editor
> you can add
>
>      PATH=3D"${PATH#$GIT_EXEC_PATH:}"
>      unset $(git rev-parse --local-env-vars)
>
> to your shell setup script.
>
> I think the first two patches are very welcome cleanups but I'm not
> convinced by the rationale for patches 3 & 4.

So I'll resend the first 2 cleanups and drop the rest.
