Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817F2DCBEC
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746534; cv=pass; b=n0L7aP0PByo5Gpovwq/lmnNEPEN0kLttSo/brY0twd5rQpnGq8xqJ9LQYrdFhQQsy6Y5pg8NDzYBTQUTbBp+di7GQmnygxZjRVk60sdnGN+IjJ19TXIdbOFsiEByfu9v4i41M0H/sHLeVNl0GaarE4xZyqZjM1rLnmCGFpScWE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746534; c=relaxed/simple;
	bh=7BeP0Jz2cdaMV7TJShntW57CLMj3OCWwPVBQ1eZLJQY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IL42AELXjwZo3qU1r+gA8PsC0n5GVS3BUtoo3ggmUFXQArMTuRCr/9L4FytrdxtioIAbA9rzN3F/x01nOMfxnOHfhumxSi2li9FEqKOSkeMBEoV11Irt37xCbet1acK5UXPuKtTsr70kOlSdzovdRJ7l9RRa35Fc9B8q81HIHKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJlOmkwD; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJlOmkwD"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso3202090eec.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 12:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791746531; cv=none;
        d=google.com; s=arc-20260327;
        b=N7CzNEwRBlD3c+uncXYz7DIvWO1ev6xGvl1wSCVBvl8T8/bvLu8jA05TLWE1mP07h6
         ZQgVln62FFJaKoTTZuG4PLrSchEyxMieWEXCuMRA1gW+hszVYoHPXvpiAtpPQvWkeqh7
         U1sPrH+WGe/AnGf6CqOC9bzVuIKkUpvswFVK42A3KMNdCV8ou+8J2y7yp53OljtxcmW8
         Ty3nLY8FyjY9O5uliu3Z+y8DtREo+zEYIkflh/45hIyZfV2ITk1g+ZvI4SLmEyQON6/i
         Oien/Kjy9IUzuhI2qk9O5Ghr5Apb1TcIBjlhAhklHyVGxdIxixN6yklFvMv+OGT1j3wm
         3kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vnlJLICh4hBSpyaB3x7w8jl6Qq1qCjT02aU8Uc6GF6s=;
        fh=b8N9nCtT/yjThjOQEtQlp+punGNy5cQPv5dlTNiIRFc=;
        b=q581Ek7glzmBFJic/kSj2eGkmsV5jbnM2ACZ7kP0xzHtUuDlV0FZuIkOoLy0WFwarM
         QPI8hhoPcZSHaVm30A73e/2kFCQtGqIXMjlDFr8YG9yU/gkG3jjSGC3TSJYNvNn2tZ6W
         6WFEppKXsufX7oRQe/soMcPmYpBcRWxrVOvqlAMuQXmniOep0S8zRtf8UoCjnry0oTw7
         +6vrMDz7qjalf+3wIqehLvcZi5xFr4/3swo7FG2N5SMX0MoSehmgyIeVLpDz0eAkIpd7
         tQShjXEMcn7+QEhyt5ZByLmG0SrG0d0ArSDeAq1Zz9tr+14wH5HBMYzTDC3X4BquEapP
         rU4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791746531; x=1792351331; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnlJLICh4hBSpyaB3x7w8jl6Qq1qCjT02aU8Uc6GF6s=;
        b=VJlOmkwDoRNDHWxMoew4kBaUzzC2/ByzOKzKofipOniYIm2MesXHLNf0uYpe2fkUlP
         rxitHLh1cQpe3Ov088RHT0D7jWGgQCH7EZkgdo8UTYgyggAvHXos/u5h9bNLNMon4Ou9
         80/1zeaZypKc9GBgyP+47pbPNYdyFROOJwwsgbyVxX9KzBheaGfem9NbVH3H820Grky2
         UeI0OpPCQ7iZ4iqsxSlsl6JKetb+9BOsLYGqzfF22fNysMY5l9P04nqoADqMadS+uK3W
         k6T3qnxqpoOwd2Lnl1x0SKbiAOLDvzm4wQJgm2/oafHJq7PSyRsEuifrTNJ2n3JWwgoS
         hOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791746531; x=1792351331;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vnlJLICh4hBSpyaB3x7w8jl6Qq1qCjT02aU8Uc6GF6s=;
        b=mjQbLTdw/pIAsCuvK9EtLN0ZYeEs/Alj/ybAT50SVCN7dA2arzfuAQbdRoFM1+C8oT
         mPxZFiNuwQdpLFOq76BZw71DpefJSafmzvRyo4uJqY+OV2rTyIM5C0GbDCs3yqPtExLa
         roU27FfowvTwy56+9k4+/05bjNyvUSdXYJDvZjFKo1aj0ASZD+w/0WyaWGdPIZ7TbfBr
         aKQI6LtXjHQR702Gnk/0mt7lNZyXc3ajlNANDOCBXLasUoxsEylODqsvuc/Y1te++iJT
         NraUHI0kHevdmaV2X8N0PzcPuJvkdYDvqfVJ9uXpxaTaSJA9AuXnjt/+TbgXgOjiH7lr
         FXjw==
X-Gm-Message-State: AFq9FYLuGKQJtk01dcWNFUBsqhAeTqnEYlqOQZV00vkPAHI+MOezXtTb
	1V8NOl38AhKcfpfpCLbS7+xJ7T64zQ58zUwhNPxUJkd+PXWePJ9ShJs6i23QuZTZ99MKC5moiL5
	FGVXDa3Eq8BQ8sy+au48xUTnGIzGlJzM+4hFS
X-Gm-Gg: AYBFou1iXj9JRs9Xq1SpnLNqd6wlcxgDwfdGDMM0BqR5WpsGL5XQ8/wuPbB0yYZ19eD
	u2VQPz7gAfdzoYa39cP1ACYGIHN8xaIk3AsQQC9lemSgs3FLu45YdOZKp+yvDR41CwFCzESCCbw
	9Lq625poGeTxKS/qTvLG3eqfTQDAZ+KQKn7ihvbe0itB8tpWP+dZF1zk4ztZU7qrS56YOoDWg6c
	Mts0YUDjKsR2szacBSChHQkCDlwVCeDNowXTVYK9VjQz1ThY3z5TJhKCwwkrmd4VeQYJoHtPklS
	PA6K+ZDl/0grn4oH4fsCULzy070agdAhExXSNHu/gLoLsWEsGcx6UnyvRslwNsZNiiNeRJPE+6y
	LPil0/aSWX8o=
X-Received: by 2002:a05:7300:e9cb:20b0:358:c707:4c3d with SMTP id
 5a478bee46e88-358c7075049mr5703409eec.4.1791746531062; Sun, 11 Oct 2026
 12:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aniket Gupta <aniketgupta3001@gmail.com>
Date: Mon, 12 Oct 2026 00:52:00 +0530
X-Gm-Features: AclHuK9nHM5UivtmXIpMX6IP3s09BZiyJuAEbvc47BX1hBR2M-NMDK27Bgo_iSE
Message-ID: <CAKzR9tBLEzrj-9_LOBwm=rL=yUqqUEBZ_7W+8mhhwKppRO1jyA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: fix lookup for new commits
To: Marc Becker <becm@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Marc,

I tried this on top of 6de20f609 with DEVELOPER=1 and did not get warnings.

> Queries for commits created during the same 'git fast-import'  session
> result in a crash:
>     < reset refs/heads/newbranch
>     < from <new-commit-oid>
>     > fatal: not a valid commit: <new-commit-oid>

I was able to repro this. With the patch fsck is clean and it works
nicely. Same goes for "commit" with "from <new-oid>", a tag made in
the same session, and a tag of a tag. Existing commits and tags and
"from <blob>" behave like before.

One small nitpick: there is a double space in "'git fast-import'  session".

> to avoid crash and (eventually) improve lookup speed.

Did you measure this? If not, maybe drop it or say it is only a
possible side effect.

> +static struct object_entry *dereference(struct object_entry *oe, struct object_id *oid);

This is over 80 columns, can it be wrapped like the definition?

>  builtin/fast-import.c | 18 ++++++++++++++----

I could not find a test for this. Can you add one to t9300? You can
get the new oid with get-mark and use it in a "reset ... from <oid>"
in the same stream.

Thanks,
Aniket
