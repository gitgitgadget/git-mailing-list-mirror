Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7B16D30B
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742878; cv=none; b=lf6o+XGkTvj9DOdxuMrJYjgxZM/u4dzkMSeui3ZkuIkyvKVPQQIhMBUSsgNuE/l8cL9RjEH28fMsXfTyTXH2jdg+DLJio5mWnfPlyy7LRh0nza7BFbOIuc7IeOv1b4CnRZFNS4KFNZ9C9fkBtl03JQvzz2+hXnm2Xs0BC5ks7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742878; c=relaxed/simple;
	bh=1qJhChv+1iBMHbkjiTLko9pP/adJS1nD82MRclRlXJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raZP86Iq0SZDVOi1dkpRrsx0ytBciZCWrVx9eyeA6o2ymgYsVun/T23fz1NksWrdetqANeY+iGL0JB0zku4IKAqYL5qKNSSzV2Sx6kppECn+2mrN+6PbtC5F+QAH3oMcfeI9S2ECh7AUv491JH5Wh8CKjoKFVaPmp+01+wJ3+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c35e1e1182so513526d6.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 03:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726742874; x=1727347674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qJhChv+1iBMHbkjiTLko9pP/adJS1nD82MRclRlXJA=;
        b=rvGBMzPLQUXW2TVr1lpumK6uU9dcAHDX9MokwxY+lIcllSajxk7ODjAKXxIatj87nI
         1Oic7er9Tj8NSjoXt+MPl3IRpJzSHtWYjKfD8Inyy4VLma4v2g3NYLxL1XvRJVzfqaQL
         2UyoJKNmFXKPIH5jOBCJXeigtruY5d/p6nh+O0/v2PosbjpLGIOnNO2UH0ZN+L16FuFQ
         vmVxPClnpVR4y3znO6spI5xSTE+lct+AxCvOcjiO+wq+2/720ZDh/loZKkGQ3eGzPTeA
         Fpzdqoz8mwLrVCWkL/wIcJoADFaCpxdCh3KKjyyPZw6qngAvfEL0SthjVzh+ifmH0wfh
         DFgA==
X-Gm-Message-State: AOJu0YxMjShRnXwZ2ZYNcurCFMAwlRVIClEnUBAYpLIJ6PTlIcwiWmPx
	NiILr0hLje/BX0hzMSlWYoSJSaMlcJMjf5ULIhwDyUVY2CZzFaw1trx3cxllXeKEDsg2fDb+c6l
	Je2TVPupeK2Tv2E1Ff+b8tO1UotxaYg5s
X-Google-Smtp-Source: AGHT+IGrJ91Bobr6+JvX9JixqDlaLJQbIz5p0coUa/0yxxvo/XIAe4C4IZislUg5gMJrFI4ppr+Ld1PEE48zckWPmfs=
X-Received: by 2002:a05:6214:27ce:b0:6c3:589b:7ab4 with SMTP id
 6a1803df08f44-6c57358793cmr189654766d6.5.1726742874499; Thu, 19 Sep 2024
 03:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com> <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
In-Reply-To: <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Sep 2024 06:47:43 -0400
Message-ID: <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
Subject: Re: "git worktree repair" modifies the wrong repository
To: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 6:16=E2=80=AFAM Russell Stuart
<russell+git.vger.kernel.org@stuart.id.au> wrote:
> I can't resist pointing out if "git worktree add" had of preserved the
> relative paths I gave it, it would not have happened.

The idea of relative paths has been discussed previously[*] but was
never implemented; although they may help some cases, they break other
cases or at least make the other cases more difficult. For instance,
relative paths only help if the main and linked worktrees move
together in some uniform fashion, but don't help if they move in
distinct ways. Storing *both* the absolute and relative paths rather
than only the absolute path was also discussed and seemed promising,
but concerns were raised that doing so could break other Git-related
tools or non-canonical Git implementations (or even perhaps older
versions of Git itself), thus was never pursued.

FOOTNOTES

[*] The previous discussion was in the context of an earlier
implementation of git-worktree, long before there was a "repair"
subcommand. In fact, the very original implementation of linked
worktrees (which was actually `git checkout --to=3D<path>` would attempt
to automatically repair itself whenever any Git command discovered
some sort of breakage, however, that initial implementation was buggy
in some fashion (I don't have the details at hand), so the auto-repair
feature was removed very early on. The "repair" subcommand came much
later and took the conservative approach of addressing common problems
people were reporting at the time, and was extended as new reports
came in, rather than trying to tackle every possible way in which
someone could wield a foot-gun.
