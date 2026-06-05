Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5E3254BD
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678665; cv=pass; b=BVBInf7gfQH2mERUP1sNas7k95z3j+QVVjKEiZmHr981rzSME32XadByXfz+a/b0AO08UWu1dpfBE8RnPihzcAi+iLmQLpOBBNEHB4EFxW5kXUq/6nnj893bSDzmxyagi3pNL00b5KnL0etHGOJ7rqi5xxkMSc5P6fuiTnMyTJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678665; c=relaxed/simple;
	bh=CGMhhQRAhc02PQIn0dfHNiy+Vt1oV4tdsSpgmXDwnVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDaYQhTHaE0gQfvYcDJoRHuyiLyablEGbTDCQqBJkdftTmX5drdhgLU8n9z/h9RvmxPggwpB8FxTCUfN6V96pvFgk1p4i1QcvheXTxxm+3fOecDPQfWWXtIclXqJQ0stqLi+Ba4P1vkpu2G+mubWi6ic8yTUPD3woZ3fHQJ7WQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDl+l/Pu; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDl+l/Pu"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68e66128so2248927e87.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780678663; cv=none;
        d=google.com; s=arc-20240605;
        b=V/KmIJfRmx4rVxbLFRKH8a65AunpWgQILtQu8HjvMX7nWAy2yCrbOFw2N1cdLzR2oL
         kdmsUuX1MoVSGBPmmD3/FzjmhBl291wMia5PQmjN0raVsvg7w9VwVmhe4/senXZyBpbe
         Wj2z2d2MN1cy3I1pSbxbheLk1Wm96tP07MCOz0vTinTRfUN95SIjmiwMH6XrqKSR55GA
         DXQ3+jWNXXXVNo94YC3taCg9dYy1TKwiag8QTc+MxBXqPAIt7lScPE1hStw4L46WvkWr
         PI8hTvg3GXQKtJoVV3xSE5u/8zOzUQ045fbbJs30cQCwze0fvMuyvXtZ4nzBD3WOxbVQ
         wUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGMhhQRAhc02PQIn0dfHNiy+Vt1oV4tdsSpgmXDwnVc=;
        fh=CsShytAkrADug3mKv1mvsojbh2AykAOyn8ikbQcVtQw=;
        b=CVCH0MYFz2AqIST/ee8fSXyVsy6Cy6BatqAMM2rhorzLnm2FTr0iP7RSCsoPfQDo4P
         0DKT+gL+IoBg2voqOev4mk+brK1MHJYvlQINtSzgqt60tijcYinZjgyni+fm9qFmiA5z
         SbnmSo0h/78y9zalSk9L2BtpF2SQx8Ci9rHh1KaOfeuBsHg/sDaMozCsET55YYQRAUU2
         KXT7rCmpA/h+XWoTICjFCp4kmMDq6JKFygcY5K3piz6WOPwVb5lAjWX/eZE+D0j5jDCj
         Mw9S7zTqTrAQJseC5eN99J8VZR2/vpeietsj2et6I07Zv87EpuS1aC25y0gZ/SHmxbbk
         pocA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780678663; x=1781283463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGMhhQRAhc02PQIn0dfHNiy+Vt1oV4tdsSpgmXDwnVc=;
        b=TDl+l/PuwszvvD0KqqqAVd0O7LOrMAeXIL8IKc/6QHcoBJeaweWP46IWARnpm7jk84
         hYrE1a47wdmO8ApVWkaVn45kPddXcKWyd6C9bvfTlHkM2V75dyYXOqyOIYKjjBmnP44Z
         THQVGtlzhVoPoc/zO6YpPEpmY/vmRH7js4zy2ZABM+vIXLqXYTnwkXjGtu4vpLzO87JY
         g6aQkb11GUVnBmP3UJBwwWaEbXbr8SEklTTGdQKkTHcFGo7sTWaU8cLGMmgOCyByJFd+
         xGPwkKVlEGlcTsF8CJfXQoaaNhgz9TeYLH3huMTevUBVMPlyLVPgDhOG+UOXwLJGlqf5
         d0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678663; x=1781283463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGMhhQRAhc02PQIn0dfHNiy+Vt1oV4tdsSpgmXDwnVc=;
        b=bm5gJOltuC7Ledi+quXXvisONFk0RDsg5em+ZEHBR1th/Rvh9vFHUUXowfT4a4fGBh
         /NwIJyMiAIKSZSseLR4jA6JuRqhz4HQ8K6QkbkISqAP+vi0eAkCk4hdBLMHCIVMerJXC
         cbRlPyAoCdHUCSfSouGy2p1sUpuEthIgkp7bCKiYqwlQpUpGotlEEc073d9+fJqjeGbs
         ILXkWrJJEjNJt1AoBWBXc5MKCW3NZtRlRb0wFOeasf2n5+IN0RBcLwMi9SlE9dKVXg5j
         5SaNlrftvbuIJLmjNfmzMduRzas9kcHIfyhBxttggOZz18PuYvEcucrZtP2KSYL4KPK1
         rI2g==
X-Forwarded-Encrypted: i=1; AFNElJ/Go23ktZ2XXzovwt/olzKJ7+LryJYX+pepyn7cznTsmJ3JjJFQKGed99iP31dbRcTcMPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJTbJrpK1+UuND4p8/ofhsLrg/l3FhW/knjj9ZduSNdKc6mOH
	GYjvEqTZWjHQTQPcY1/NB0xBWTCtpxtymkQJe+th4hMCP2f69xn7n6r2bGYviFZgcsavKNkp20I
	mmt8GLjLA97OmlmrQbWwl/JrAMcEJdESMAsyT
X-Gm-Gg: Acq92OE8LbmodzbGMsXjA+YuO4hQE0w1gDC/4pTL9F1ggGTvJu9EGRPqwNhAB/2cOAD
	SmG9YgKeNHpdVk4mJBXvN35t/zGlbI1HkXplHpYcl9AUzt/KQnTXI6MVEMYlfwC1ifQ5ZhBIVWb
	dsZLRR8BUxWPzalY5/MR+bZLqX0birp5rcnlNzeMxiZvTlNyttT3q7UzSpG5uQq3UjAlGJZS4qb
	f90yJ5ZCTGi3s3YTouE2hKzdR4xO621Fh1mM9XJesyEujf+QYWjzLtLFIci25jwJ4ZsYmRQXAoF
	z2cnrhXbUoic02T91Kw=
X-Received: by 2002:ac2:4bc4:0:b0:5a8:7029:c5e8 with SMTP id
 2adb3069b0e04-5aa87be7634mr1334231e87.29.1780678662316; Fri, 05 Jun 2026
 09:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
 <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com>
In-Reply-To: <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 5 Jun 2026 09:57:30 -0700
X-Gm-Features: AVVi8CdoKRUw5jdTa5TVcNAA9cl4tbncOLZe3vEMzbfKLx7EtTZrt75DdFlOryU
Message-ID: <CAPx1Gvegc0KvE8zb90n7vLJLKx6EkmBvCWW=NPf+nwiZc+oWdQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: record creation time and free-form note
To: phillip.wood@dunelm.org.uk
Cc: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 8:31=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
> Isn't "what is the worktree for" a property of the branch that's checked
> out, not the worktree itself?

I don't think it is.

A lot of things within Git have, shall way say, "less than optimal"
names, with "branch" (with at least three different meanings),
"HEAD", and "index" being examples of this. (This is just an
observation, not a complaint: we know from studies that
oddities in names don't matter that much after a bit of usage
of some system. They're just minor stumbling blocks when
getting started.)

Work-tree or working tree is not one of them, though. It's
concise and pointed: a working tree is where you do work.

As such, the *purpose* of a working tree is exactly as general
as the purpose of doing work! That's a wide-open set.

Git's internal constraint, of requiring each working tree that
is using a branch name to have a unique-to-that-tree branch
name, is a property specific to branch names, not to branching
in general (an example of the ambiguity of "branch" here).
And of course, as you note, any working tree can be on
a detached HEAD.

Exactly what properties any given working tree should
have, and the weird entanglement Git has between the
"primary" working tree (the one created by any non-bare
clone) and all "secondary" working trees, is a mere (ahem)
matter of implementation. Descriptions, creation times,
modification times, etc., are all potentially useful.

I think, had Git initially made all repositories effectively
bare, with separate working trees added later, this might
all be a little clearer, but of course that ship sailed,
crossed *all* the oceans, sank, was refloated and refitted,
and sailed for another decade already. :-)

Chris
