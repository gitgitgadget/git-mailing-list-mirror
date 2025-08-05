Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52B10FD
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357353; cv=none; b=HFD1FBDIKgJEu77ulTlvakontbnZz6qWrupZSg05453v5gpzivXef65hVEX37czTKaY37KDhIgLoZ3fAuMFt0pmCMtQ3/L7w9jBG4Xojqpw0cj3VfhU28qPXiAgs3h5fKdIfHkyka7seJUDVlh1ZlTFNLyvMArlIvtjWwh4OQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357353; c=relaxed/simple;
	bh=b1FkEfY7m6URIqG6L0rC8s51NWcbauw9jUA6g3wRvMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3g6e0AZeQyBcVsOttZfLeNK6jyUS7SaKSyXu+NTYg1FCBjNufkf1QA+nX0VGNH05KT4L6Thz6tZwPYbne4vX2Pb09mByjubVWAQm3+Oitf1Y5qiU+7pNs7Wz+e15ebTE1e8XK2jdzbSgKpCkUuBf5NV9e/d4MfmtN+EOd47Vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsdJdvn6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsdJdvn6"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af94e75445dso420726966b.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754357350; x=1754962150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGrqOMngi2y4lbL3hc3/S+ocqEt2YLuFE5DUz8TffMM=;
        b=VsdJdvn6aME6QQ3+f933eLjDOPOAdEvIiSFtTXgwlz1q90fb87Nbr3kYtbMVX1t4Ct
         ftSLttgJAmmBIaaqk1x6/HTCFievguDPTBJ0z6tjHH9qBXDxifGRwVyCshyRGqpWmi8y
         Kowr6AeQ1Nn+Hh4cVKJO30ZzbDKfMiIFR0OVyEcNrbYPju7N4YKJxE1ZeKplyCE9qjHp
         4LkTtsKef2tgCMbKaapYJtUb6bONW/ZrsNwYlLTzAITxT7SRbsBwi4GspDOJva0phF6J
         d7eBmqD1sMxDrvYU/H+EhcB3XjEL8JPyAlETxdttne9AV5pmNXEEaw74t93rZI2ELzcm
         52Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754357350; x=1754962150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGrqOMngi2y4lbL3hc3/S+ocqEt2YLuFE5DUz8TffMM=;
        b=PGo2tOJ8PkLgZgVJ7pdPkiU47gnWXl0TJATlSy8H4tIr/LXO7+dpOCNxJoLOfa7N+K
         LBV41is5LnS8rSfhJt3NZ8Y8/zrXMJajjHIOvuSJ6s1FUkC7zUvh83GKKvu8PQohQWot
         rQ1f8K4KcjJSLruZPioVBtvODFvFODu/9pxoetsUXz9DsC7SK7q6jUmkV7NkV64b98a3
         Aj5O2nlkGIlEZnbvFFfe6tDZIqUcn+5WXatJ8l1OCUG7KsiEwg1GSaIkfGmyHSBK62A4
         irhYwC/48ze+CW5/BJwjNlUrhb1ASLiR2WZ7ZVPAMosn+xfke2CIT8JF5iORZaa9n4Tv
         M8Kg==
X-Gm-Message-State: AOJu0Yzk+Mmo73GCV9ywN8bo7JW232226SjL2ymFqoRdEPDbHrjIdBmV
	v2RJuzhl874YxgrS2HRjtGeWzIrgD9r9vAqlC7uEF0J61Y0Dp+G5tK2xyRkeX6gUejzwKCh/vXg
	kYnrTveOBQ42iLPSSKgAnjublYgE1Wmo=
X-Gm-Gg: ASbGncs2QQ+h7rf8aWbgKdr6AUUVVYNUNtvzb2cxVN12GhgF3OBWL5LdAmowabYJ0rb
	/TbmJ+BzS911yqU4KbM8IFrYRp0NthhCwD/3F02GzsCE3/75RZrWBmajfNh/pXnghlWtTnikvid
	qfyE8FJl5hpAbB/sdTO9VNIzopGPjiUOQ8X/8Mnb253i6GEC/P6asHwvRnvy1jfMlIV7jq06X7F
	J8rsVBefc0x8Jg76jca13SrZxuWDLEsID1aCXgjrba2oEtcHrWd
X-Google-Smtp-Source: AGHT+IGnRKMmWMS+Wub8Kn33PC/GhyNad6KA3ZVmF+iGkmTJQyOyF+E91SqwGO6KzGNqim9QrlIZwSOwQE9H7UIEfO0=
X-Received: by 2002:a17:906:730e:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-af94016a3e8mr1132014466b.29.1754357349932; Mon, 04 Aug 2025
 18:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
 <20250803161033.77696-1-ben.knoble+github@gmail.com> <xmqqo6svd6wt.fsf@gitster.g>
In-Reply-To: <xmqqo6svd6wt.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 4 Aug 2025 21:28:58 -0400
X-Gm-Features: Ac12FXxuHaulYBAp5w4l4fpK2ff-NUXJZPn2xajCP3rj9A5MkBe7ZEtaBGpiuuM
Message-ID: <CALnO6CDemUHgvGLH4gOZSF7o9Yv-=ScgfPmVJsjmfFGBK0Hw1A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] permit -h/--help-all in more scenarios
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > This series enables --help-all outside of repository contexts,
>
> I've been familiar with "git commit -h" (and commands other than
> "commit") outside a repository, but did not even know that "git
> commit --help-all" didn't work outside.  For commands that use
> parse-options, these come from the same source of informatino, so it
> does not make any sense for one to work and the other to refuse to
> work.  Good.
>
> > and
> > allows -h with other arguments (without breaking existing ls-remote/gre=
p
> > usage).
>
> I somehow thought we already talked you out of this.

You did! Forgot to drop that segment from the cover letter.

> Do you mean something like "git add -h foo" and "git add -h -N foo"
> would say "'git add foo' would add the current contents in foo to
> the index" and "'git add -N foo' would make the index aware of the
> path foo without actually adding its contents (yet)"?  I do not think
> it makes much sense to behave exactly the same as "git add -h" when
> the user says "git add -h foo" or "git add -h -N foo", as if we
> didn't even see the extra things on the command line.

So this is moot. Good catch, thanks.
