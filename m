Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01398635D
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785085260; cv=pass; b=CdEzexZKnLuRogIlyCN+tRBaa6FTWREANWzv8jpQrr6W5fSp+PCPjtW29OU/ElYOhy/7SUBxriko7N4rgLSKo9QC0jUwultDhoHY9CJlKKGWoCiGovCX37SVdmqoHhK8CkE2L7FwLKm/JZ3/HIC/WkIFbCnOlNxubQBH256dXzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785085260; c=relaxed/simple;
	bh=ki8jvdKZ+PX/2aEYtmEu5HxesgDSSHYfpDMlYs8rKeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPOA+Z6r7aDkuOMmxeeaxTckFCcYbsxtm6q9lNMtKPVKOFkW73MF8GGx24oRS1g5Sv2/AO70ZzxjVtKDGeJ7t28/lYAmU626l1adRK+5wTayapffHqSYy+Qtfc85D86jB2jljvWrG/n5DMl/gMAN1FwykwBQXV3BlUJKfE4V4Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQKSXtmG; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQKSXtmG"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso16510221fa.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785085257; cv=none;
        d=google.com; s=arc-20260327;
        b=D3wgm/GmedGPI71fjF8IbizuvaGEu7sDnO5RSGvb+tSBB4xl3dHVDNjlM9PsbR7kIY
         ygrVmz13yb4fAkrTREPM/MMXQUzzb/nA7FFsMcjGQd2AVa2KN/+CSM5aD0k6u22FNKMc
         LXSAd76aS86PGF6mC1QiNFv94R8e422rztj0tnqI3eQ15HHZQyYQ+VlC/FLrGD6O234j
         /QMwHNxfX7M/EyBnKp8QHzC07vQNNQ/pQV2Bui5Qzuhp983bREsVjmgLsz1/w8ITZcps
         gBdfY6t9031OeCTDdc8ZqJJBa3mK34HZgGvlmtXEYNeg0SyXWobth/R0FZHEdgMVikKA
         /8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ki8jvdKZ+PX/2aEYtmEu5HxesgDSSHYfpDMlYs8rKeQ=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=p0vrDebet7/kIRQ3Y9zx9gWCrB2H2FKj/wWe4wiGQoawxjKHdXbgUL97xRD4ezEPjo
         AzaIiYAKe9djSBu/YVkCuWdNkkmfj/UxeDk8vOB2iexYGb42zJm1HWYNUgbtSHz/NL/m
         YVBC/qF0tc2vJE859jDUwXxi9qrWC/vHnPvB0S3AJS4Q3xZRl5zhFh4fF1BP0gNbTeVj
         i96MyqZHx5oJFlhHeyuqVQXyQdqEgHRtYQKnk+tXnTTVqCDoI/eDt8gdvx4+WkfUDix3
         Z0NSmz+1RA6uRlAc1mWBBE2UjOgDcdilwqmxCmEzP21wI1YX21rd4NIrZj7Vh18IQaao
         3x2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785085257; x=1785690057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ki8jvdKZ+PX/2aEYtmEu5HxesgDSSHYfpDMlYs8rKeQ=;
        b=PQKSXtmG5s4nB/copEup2r1k4viWKYihWso7eO1pTUaSzNt49VO9AQgG6cbtraarhF
         hTKbhbYQKksv8dLFGwULLJWhnbXiGY68/StprTjGDua4f0yuazz8o8hpDQfRzbSN1hp7
         stIqFnMnqzlCbm/gqREG5RICfO5kFkZb33HX57ZjYOZU+RhLhU/JJ8D/gSL0wfevRyC+
         13Z0pcG0vqh9VYkQdBNhpihn4U8AgVn3XVut9EebZF+iXauHt0jZq7TnO8wuPSiNoVTQ
         bDayR0NkD2gKX0KEpp8pN8EPMSlLqjIYoatfwGKJu3edh62qJiRnTex0riDl5vq3Tadf
         IwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785085257; x=1785690057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ki8jvdKZ+PX/2aEYtmEu5HxesgDSSHYfpDMlYs8rKeQ=;
        b=QxHDJDYDRYptgVP1kIIvIrwYlWG65/LDi6flX2OKjpAsy+YkngB5d2G+fRzDN0osrz
         47n3mdfd2HAQQGm9ayClYwlbY/UEHfqvuECid9mWqSwVelvDUWKTPSTwkcJdp5KnXaIE
         KVIO7K+X4t7tx1PhAqzwZY/1kU03ml8WODj4pmxKSw+AY7c0KTG6GUsRB+fWCKFUoGik
         9qxjjV2REeLc5Nn/1uzAj75E5dUaVaJpvyiEjdKP2LoCEVi693GtLBMLZgEW+6sXPC2h
         poS1sEx7b48Q4uoDYom0Ms1nBjqkOiD7KwdaSkRxLG+3SH8C2KLHcLJyldO0/FLcUEPr
         /eJA==
X-Gm-Message-State: AOJu0YyRKx1G6iux59S196tmkXAwHXOo4Llocu+fRWLCPHaISKRHdjDI
	sJUtfIzCRYeUUrPso6uPKv45wB6nJUZwZMBPYDuevhd9DqkgB25ua4m6A6ntUjZruaS9rM8+Zl2
	VZ0+yo/433+2J1mZekrPHgJVz2mDaqjY=
X-Gm-Gg: AR+sD12NuzQQyFqhRyu2nbiI3I3bkXzMlj0cPCPvr7r3svKEz1Y5X2HwUqkPncpRXac
	ywxmI9jJ2WYtveiVeOFb6WJ8XZLgp/g5XJ+6xZIHxXFpT9ZznrK18uko0M8T8Gu/ZrWG4Ie/pAV
	JSOFn56NjcrYLSXUfndonkiih7OMAo/rfxqssX27/srq6+xQLhA436u8WEp4htVNLiI5Lh7HUKP
	5/3guKh6u4dWBaY8myAWJ9F+rVd15rsQ6R6ffykGOjFk8K/uubv67WjFiKqYHD9VAEUQiW4+lFJ
	D/9HHJGrUVtiGmZguILRS2uKruqK/E5c2A615f1T3AyTRiGrfQkAZaFUCYItCEW7r/ntxxhtim2
	YEvM7tr7sBStqDP8=
X-Received: by 2002:a05:6512:239a:b0:5b1:5eea:a576 with SMTP id
 2adb3069b0e04-5b2c1b1821emr1082382e87.21.1785085256556; Sun, 26 Jul 2026
 10:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com> <xmqqse55vhnz.fsf@gitster.g>
In-Reply-To: <xmqqse55vhnz.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 26 Jul 2026 22:30:43 +0530
X-Gm-Features: AUfX_mxRzNDQ6oONbYsh_I8eA4JtG-qlDEDvMsCrOsfHTy-N4I1lXR-Y4NxXbeg
Message-ID: <CA+rGoLce-64v7EsQuDbtTd3gx4hsspMo58siHfONWbUBehhNng@mail.gmail.com>
Subject: Re: [GSoC Patch v3 0/7] repo: add more path keys to git repo info
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 9:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Series adds keys to git repo info.
> > Keys output paths of repository components:
> > * path.toplevel: repository tree.
> > * path.superproject-working-tree: superproject tree from submodules.
> > * path.objects: repository objects.
> > * path.hooks: repository hooks.
> > * path.index: repository index.
> > * path.grafts: repository grafts.
> > * path.git-prefix: prefix offset.
>
> I guess the issues I had at the design level in the previous
> iteration is gone ;-)
>
> I'd love to hear real reviews from others on these patches, but
> at least I didn't spot anything glaringly wrong anymore.
>
> Thanks.

Sure,
until then I will work on the histogram patches in git repo structure.

Thanks for validating!

Regards,
- K Jayatheerth
