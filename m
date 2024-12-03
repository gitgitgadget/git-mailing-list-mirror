Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E92500A8
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187375; cv=none; b=BpBIbOqeKJaK0pNu4rNvbpFg5E265xGap3dY73r9jyro7c4OVAf3Wq79TRRmiCZD/JHnfxoHBYgzbzucai8Hcpcu7FoI9XJdIzDT5NF2dnMrR4ZTtWsaUlNMe0Y51hjm3STl5Wx52TiiCyuujBpzRirqip3tiAjKYnqqDazRupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187375; c=relaxed/simple;
	bh=vyb/52xiIKQLmiTqky/AFbPTjXayXj9Sj4OiZovJQs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhW2dmhP54giaZ8+W6YJHNZ0sf4+TY0H8vsZH+nmiEfrj6tzjAQD+uhVj+boIPotN0g1iHXl0MLsq10ke169LJtmJ1hjqAvqu4YYYXn3D6/jpeFE0AeNyIALHimhdwNzzYmZ6UZTia1iWfAmjlHmXI2Uv8snfEauIUVYZId/BCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8aff28aecso1776676d6.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 16:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733187372; x=1733792172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol4jr2nF94ay3hJjmH0VdGmD/g6ajG6FoPjkxB2OIvo=;
        b=fsrY1k5sd77t69ohMNf1RFU5PcWCJzekH962LFQyVY0gcO9d7ZEXN563z77coUcAVR
         ejg8mlJ40D+0begPVOupL3JlIk8BKQhdFuQvhoLmpwiYsgXeHz216tCI9ETGJQ7fdQq3
         igwfIc10/cUT5FoQG86azeRMzXzqdAOvTsQNmykHEf7mt6cIyk72fLxMauPEfKHJ6wKz
         MywT5HszuEPfKdw+ttxzkoDDXMBaohLlo8RwKEeTxgnZkLQK3jEo/e/Ud3ZLPPED/UNG
         332llJQL2IIQMWHIEUwdn4Zcd2P7dtQIKgXTby1JqLdHetr8Yjw730lmpmuhs6RLrT1X
         bTIw==
X-Forwarded-Encrypted: i=1; AJvYcCUPYKpx1O9FLRec5wxj/V6MCuY1+SMIBPjD3nmBzZIM6Yg9UrY3J0L3LBIJtetGLEWac1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5I8lfPL9CnZwRmz6Jp87vF/DyaBzQrpA9mLjgd0Lqm1LAmc0m
	C5muOI+6Vgqzjw2jOnrGFqM81M25XXbtCjRHJ/PowRMcIgJi81h94Pckf64xK2Lhky7fUBzUI4O
	Tx+T8QcDjlTmVkKRswxB8YimKN6g=
X-Gm-Gg: ASbGncuBUaRD1bC2BMHkErQYj2JAagckj/4bdgPdSMvsmTe/HbplThJ5DxAN8ygXKZm
	zxRG9ISODv3MwBy+1mjpWzPHfLNGJGUxWdeXxHWqIVGbT6XmqHQS3A+q0nozrmG0=
X-Google-Smtp-Source: AGHT+IGo1JDaAbX27dYB+0CXzusnnkKgRz7AT1NMh9pmR68LY7EAFAJX7rbpP7oYLAbpWPX0qPT8ELSOmlE9qGlT57s=
X-Received: by 2002:a05:6214:1bcf:b0:6d8:8db8:43a8 with SMTP id
 6a1803df08f44-6d8b73a341emr4676846d6.9.1733187372272; Mon, 02 Dec 2024
 16:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
 <xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux> <xmqqed2pioff.fsf@gitster.g>
In-Reply-To: <xmqqed2pioff.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 2 Dec 2024 19:56:01 -0500
Message-ID: <CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 7:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> shejialuo <shejialuo@gmail.com> writes:
> > But cross-ref operations between worktrees must explicitly specify the
> > worktree id, so I am wondering whether we should allow the user do
> > cross-ref operations in the first place:
> >
> >   1. main worktree symref points to linked worktree ref.
> >   2. A linked worktree ref points to another linked worktree ref.
>
> What is a cross-ref operation?  A worktree is either the primary
> working tree for a (non-bare) repository, or something added with
> "git add worktree" (i.e. whose .git is not the repository but a
> link file into the real repository).  Are you adding another mode
> where a worktree points at another worktree and not the repository?

Unfortunately, I haven't had time lately to follow all these
worktree-related changes or discussions, but perhaps shejialuo is
referring to the ability, from within one worktree, to mention a ref
from another worktree (which is a feature Duy added some time after
the initial worktree implementation). Specifically, from the
git-worktree man page:

    Refs that are per-worktree can still be accessed from another
    worktree via two special paths, main-worktree and worktrees. The
    former gives access to per-worktree refs of the main worktree,
    while the latter to all linked worktrees.

    For example, main-worktree/HEAD or main-worktree/refs/bisect/good
    resolve to the same value as the main worktree=E2=80=99s HEAD and
    refs/bisect/good respectively. Similarly, worktrees/foo/HEAD or
    worktrees/bar/refs/bisect/bad are the same as
    $GIT_COMMON_DIR/worktrees/foo/HEAD and
    $GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
