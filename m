Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157728C037
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696481; cv=pass; b=pQ04pa4yg2+4czjVb4INLrv4gFqdAfLR96EHkMcv/vwOSxUn36jfP4fZJFuEeQO7u+cC95NzWPtqJbhJM1YmjRVdZGRd37zb9iPnQBX0Wfd88yqxxiog1y0/PRVPP6QqQRiN/lVVawYjlak8dV5xmOp3UGr/V2LgjsMTsFxQGVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696481; c=relaxed/simple;
	bh=v4ZJKJ2sSg4Ydndq7p9LjXJJlLEcoxTrW2D3EacEXOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc9lnge7xhm19MEtlK95Ov6wHqrIxf09EFF7ZQt8RDZPHwvutrKxUqxYU/VgYBo/bAt9m+IFaM/G2JZQhLG/m5d/1wKkvQlVpBuZMoYiMGQN/6Y/09XRddxGQz6xbFsWW2ZZkPVtp3yYvfvkWLHnSovf0Pj5Sg/keblX0z81v7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9zVjUPk; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9zVjUPk"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7eeso10358889a12.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 23:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772696478; cv=none;
        d=google.com; s=arc-20240605;
        b=WN98DNG8Dn0MWGQKzqG3376jIOCY+ID+bUQjpp6n0N6KUuSN4yMj0sFKZxogVJswPR
         +JhG5RTPkAjWad4WqEK7kwpGy7zppimMxGz8POyYZLaozsewe9Z5/2ZonWh1kRX2gEhN
         qMUgC5x1BazkyOfvGzsz/NSIF6vbRTSvpNOc03nIsETY5/XWCOhKmQIap/XfoW+TYfPo
         k6NTJ73mR01YcAadsy3AoGO1tnYKCV3ihTTI7zE+BJybEfQpMm+5aAb9SjjeJkyHpVzu
         K3WToViF3iHD0gjaq+Uj7Kzr0SeUdtXaoxXFeY1shrdUmeE3XjES6vUCP8bkEERDoz/F
         lA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQSuN8dFFf4I/eusiDmcXrdmzjFUwJoohYkMVIq0o4g=;
        fh=trV3wso+Fg+3zq7fWygINWeUce3OIH/xNFBQHLchsNY=;
        b=FmLs2QVJuI6TZypaaevGYXei96czl9l+5GZxT6v6QRCgw7qN6+DfIcVV+fkNy9j6Zj
         FwaJk7lXutxYXDQZ2Y0U23D0X1uJmKrv1uzwqzDAJAu+cWmDAijTjL8X1o2D7dxmZTCl
         1F3aJKRIyf4T8iDlJ/4qbvzCG66TunmjJkWdCwnTW02H5uAwc+Wu0VPUAPUVz1z03/xE
         FTxBnxbuqjhhNkfk68SaqUSk4NAJ9cmabKcim4JAtbPwpQbdmhJGgxGMSOviUV2Ky8oC
         skfOOvhqfktKEWUtceKS6cNeDVO4GI6E8aAQ75Ov+CgKyzdNUnihajx6KIcH0UiUyb+A
         vPbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772696478; x=1773301278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQSuN8dFFf4I/eusiDmcXrdmzjFUwJoohYkMVIq0o4g=;
        b=e9zVjUPkVYC6Mb+YYPTPAHBbAjA/onpSAFDA9vckVtbBFmYhCw5QsO9TsnTdFg7RgK
         zIrONG8jNrLygAwXFD875iZm2f2wsisCzp3buLdKUoGtwIUk1BOJINYb3n1XYKcxfGuu
         vpkBKYr4n2fSAeEHeVWjNuxkdNx3DLm2zxKg0e9vy43TmIiWmlMnunj04Mo2FD6a/1U/
         e6Pwi/XrnMc573eJIxJqv9jxmmU/iz1kn25UCnLzq1Lmc+o57AKyumTbTaFVzmNgAuHD
         qclmMhR5Pf356p5PAXN1kgZUAOfhq4OmxyvYdmkykhJtczpvW8m6KGs4gKBQ/3yF4R25
         HIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696478; x=1773301278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQSuN8dFFf4I/eusiDmcXrdmzjFUwJoohYkMVIq0o4g=;
        b=AL3TyhheaCYGp3NXIjIwvTboBiiYgyP+Gscs3ynwa7aIyig//4J2FqZrapd2gc9hb8
         8VGkyQZjynB3UpMJMME3AjtKv3qRKl+bcYJHrSKDhoqcspE+890fxhG5wKYJy8W0Rttk
         5npAJ7Cj06CXXi5y3+D0slL3iT7eOsKU3MlbuByiRdgMGltW5MATBEG8TK9YHOLZxSde
         c9K7Tm0sf5A7OHVEt4+bvYx1NMSDCRaUHr50mw/tX2c/HcA3XgRDzoSCik8uYgt7yNV5
         tBWGILhQPj+BYmJFdbd9RT13kyaDT8WIkW4+T5kUV1aS07iF0eNbialznBOUN07V0yh1
         w2xg==
X-Gm-Message-State: AOJu0Yw/Cw3TzFIGi4vWPlUrFZnbMbv3YKhx3K9Xq0VQQlE3otOlnsef
	WXcSpBy+OjQRtDY0/evikCAEqv86lKOqn+wA34+FZ2vWztmzVaN34OhITEssUf8w7feVCqmaE+r
	jOCjNKQVxy5k2oeoQOi8qC3Web/Gw+y7riA==
X-Gm-Gg: ATEYQzx+Jry9I5RsYPywKYNlTYWLPA8EXz+2oaGPPIeDRHDhHPBT+H7VprQIlUyKlxh
	VuEOw6gSG3yKNtLedJoyjmz0f59YD5PpQ5MKaCSKY95E83lAcnbH0l+AIuuQMQDAdJcASlf4HoJ
	BSi83Fohou20GC9OZ946EAuOEKqdXJnmMaKOvsAM8nPd++0RyWrWwy+QnpUjCfUzPuCldYghs/A
	Nq8gT5Dq2Di+4zWj/ajolWjb0fEBD8Wo6I/Fufk2btPAq+9+Zf5O5jsDphH+dLDXsQVBDAHST+L
	GoBWd6yX
X-Received: by 2002:a05:6402:51d4:b0:65c:972:7073 with SMTP id
 4fb4d7f45d1cf-660f02c4ee8mr2759744a12.28.1772696478248; Wed, 04 Mar 2026
 23:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
 <264862d1-0f83-4d0b-be11-d8e479c7d8da@kdbg.org>
In-Reply-To: <264862d1-0f83-4d0b-be11-d8e479c7d8da@kdbg.org>
From: Norbert Kiesel <nkiesel@gmail.com>
Date: Wed, 4 Mar 2026 23:41:06 -0800
X-Gm-Features: AaiRm50JuhLeh10UzftxOsAiZWws81B6v8nxM3dDOPJXpCV8a8EQsepnK3kb7Vc
Message-ID: <CAM+g_Nsw52JysCsv-FVznh-RAPxYm0kA=Kj2o+KVB5uZpGA0qg@mail.gmail.com>
Subject: Re: Feature request: support listing worktrees sorted by creation time
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My understanding is that the timestamp of the base worktree
directories is updated whenever a new file is created in that
directory, and thus this will not preserve the worktree creation time.
Therefore, I would like to have an explicit creation timestamp in the
worktree metadata.


On Wed, Mar 4, 2026 at 11:35=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 05.03.26 um 08:14 schrieb Norbert Kiesel:
> > I have multiple repos with more than 20 worktrees, and sometimes
> > forget the name of a recently added worktree. Therefore it would
> > really be nice if I could use something like =E2=80=98git worktree list
> > =E2=80=94created=E2=80=99 to list them by their creation timestamp. Is =
that something
> > that makes sense to you as well? I could also create a pull request
> > for this if you would like it.
> I don't think this is warranted as a feature for a special-purpose
> use-case. Assuming you don't have spaces in your worktree directory names=
,
>
>   git worktree list | cut -d' ' -f1 | xargs ls -ldtr
>
> lists the worktree directories by modification time. The last is the one
> that was modified most recently. That should help your memory.
>
> -- Hannes
>
