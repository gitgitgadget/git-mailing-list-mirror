Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2ED4C9D
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728195429; cv=none; b=BwPtk9VSwu2ra7URtijEm25bJM6StEN+Q2oHKnCyjptBW1GJy3VbtrbDN0TASOiyJBFrV5Ggcm4sQZKkfx5XrcBl9s1A1cpBmDD+xS5pm3qsLzGQcCbNVnUwaqUzI6CEOpBAQSSM5syM+ZaqKwx3+oX9Xp59lbsUYdECsSbLKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728195429; c=relaxed/simple;
	bh=19wM7L7ZDMWskt+Ooaie8gzYIb32sIMQXgQHjy9s5H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFXimp4iaWseDZN8IeAan5xySAPSxg3gWEBWhUBxv6i/mP/o+5JA3ExlOPm/j7UJrENKl9BUqmS0mgNqa5vE7v3UFSl5b1rOPWriqKZFRNqBDj8eM8b0dKI0zje4a4ZtSdph4VCe51FpqSFJLUztqIOr/s4CtW92ZrEHpz8elyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c567b2e81fso2658146d6.3
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 23:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728195427; x=1728800227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19wM7L7ZDMWskt+Ooaie8gzYIb32sIMQXgQHjy9s5H4=;
        b=UTOaUusM1BvcueZfD/fw52E8pxxSM0JNKpHLOV+1v4k45gxKJI4vujEILcR8860NIO
         myVIa6TVigBoFPP9bCQV/4A3Ddd2czwL0owYBXJ/qEzJjX6ZJYZVnLvPByzyEpcejJKs
         YTVJqRo0r4kfWo5vWKj4HESNeS0O9PZXb/NebpNUV1PsfwWQafRCOGaqKEnDKp/Adl6S
         +JVhpqO3FNcft7imWJviaSgY6Kbc6EB+uJT9QLXWPlLsAKbrysRDZPsGuNksiasAuot8
         LtFIRE1sfNF/s05RH/b3LyVG8UJ4dscJqq84BLiAx2G6I/K/p6ToAldA8LIJpWfd9f0t
         pd4w==
X-Gm-Message-State: AOJu0Yzz3JVn+ia6yuvtiJSCPmJmSIY8LvqYg59MmapzniFJIeODkJIm
	VfgBeBvrO+i/IqWHBHBhs/UNOa5lhhUVtR2LK3sOLOf0Lq/iFzPLwicHMtfoZxnJ9BysryjtBbr
	JuW9yJFBwZrRnG0MGNRu4kIp5xLCZ5g==
X-Google-Smtp-Source: AGHT+IHynzhu30cOAbGTtc3bKYIpj7ltUJDlKeJQPXSveOaPVUPaYU8bQNCByXvXDxAuGJJWBs5LIK4w8A1nr0FmnTM=
X-Received: by 2002:a05:6214:2402:b0:6c3:5cd3:9faf with SMTP id
 6a1803df08f44-6cb9a473f9amr59750616d6.7.1728195427017; Sat, 05 Oct 2024
 23:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
 <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me>
 <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
 <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com>
 <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me>
 <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com>
 <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
 <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com> <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me>
In-Reply-To: <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 02:16:56 -0400
Message-ID: <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:05=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 00:50, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > For continuity in the archive, probably best to submit it as v2 as a
> > reply to the original cover letter:
> > git send-email -v2 --reply-to=3D'20241006045847.159937-1-cdwhite3@pm.me=
' ...
>
> Thanks, I regenerated v2 patches with `format-patch` and then sent with
> `send-email`. However, the issue seems to have persisted (at least it's
> consistent?). I looked through the the patches on the listserv and that
> seems to be the only location where this occurs.

Indeed, I'm seeing the same line-wrapping breakage in the mailing list
archive and in my Inbox for v2.

I presume that you've verified that the raw patches are not broken
like that, and that the problem is happening at email time?
