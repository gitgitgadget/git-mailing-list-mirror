Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA97E0FF
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776558259; cv=pass; b=nqh+5YI2/ZYjbjTn1HYBwXgueHdEw79xk+s8sNAc9VEp528uHzWWU9NonlO/F+600GGGmDtW9tWH5FA4aY5tOn9vzKCU+N+BAwXfYdqEbIHVEyMdKkc1mvhcHKG1Y7RXKIH6XSmBqU5F9wLt1rLj+dxEqgDLK2GIbLqvucnuGCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776558259; c=relaxed/simple;
	bh=lf3jaY4ToSHxXlx2O7eou+Yxp/qVjkJFt+Vz+Kf5liY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fINwyxAMcKZGRrUoGyIpK2l9yQiFTk7Ce3cGJCqQm1UnehtzB5OznjbpdXA8QMV7cSSGmC7wA3E3dc1vIYpfts5im3lkGMjisdVVIfXrMVMttt63QW+7J4MtzzjLWKnBgiex7+FX+AU/ITyoBAInnDDMT3zUIg83alBvVpdnylg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMKa7LhV; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMKa7LhV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b24fdac394so17658475ad.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 17:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776558257; cv=none;
        d=google.com; s=arc-20240605;
        b=La4YS09UkPHIWKXkdDK+LfyvMb4baVbYRCTsNBwUjvwFfFrv0WHtMDB88IzS1b5PZF
         q/mmC3ixEsSmSk0ezvtBRWVq8TUOa+hrQ8NBXfL4H+Wca9wgREVotbfl9pOI+mWNZ6wJ
         4kMqs7PQA/M5ztM2ZyXG8C2pOgmifWrMQJNWMvPPy8MmnMaEOvxedHqHyKXl235G8hbS
         SxnrrRZHU2vdO5u/ai/htvJssP4CwlpWAq5vxLfk4dig1iw21E9NbWAx127ID5es3uua
         2SHEtu9414GDx7zlO6iRxHQTVWUdnrdN5tbDnJfcNGehAMlbZnB7yelfG3x+FiHKDM+A
         ZePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YsIF2LGe0TsB9mB/+pX9myIE64c+bQIeRiW5LMgOSRU=;
        fh=SlejNgZhDGxYE3RoeDx16OjaGxHLTwSxXQ+/jdvn8IE=;
        b=FhNvUWcFReSAfULCZbSmQVupHEG0Dq/MO8pFpCEsl7pgJGLSX3T0iU46pSXVfOZYz8
         tappiqntRgbmdfjY3nugz9JM7+8VsP7KsGrpgojoKUVFgYXAMkOGUWTHgyqLXeq0NuKr
         kDS0aMt6TZFkM8lqVDpbZBxGSVfP7AvPFXnR+WSD7Wqhb5p1DwezySkErlSXfgJUD5t7
         jb+YJ0FjC/gOIVzCoNd/YNkxh4OkmyccXmkXSEzuKcCc3YiCBVOsPw9COGZGXg3X8jWx
         GfBwlR8j9YBKgnOJkLyHsL036REgoSQ1JYV5suEEfLRYZmcHigeKHLiyedReP+nEzcjT
         CNTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776558257; x=1777163057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsIF2LGe0TsB9mB/+pX9myIE64c+bQIeRiW5LMgOSRU=;
        b=VMKa7LhV9pCId1Cd9zFRYGt2SFDgyoGU9Uv9XzrJPLvUpeJKxGx+JLwI34HxN8d1pV
         3DQ60AjQ2ASQ2WSFbAtpWVlne1jyXwAlMrT+TJmDMAAJeA7wh1yWdO8Ue/amH/6J2X09
         LYEcqC9Il0IgqNebhbDcjix2H1RtfRxn4FchuePTEDXS3cQJN8a2nSjxi7pOg18luGpN
         pFfw1kmLzw1UNJpFWk3p8XPjy7THrmW2u4VHCw0fw7NiJ6sDOWnO3KUmML+T8KgnuiCN
         UP79mtqLcFXFczTmHB4+ETfuFwgxuO43bKjqPTcBYuIte9pphLMH7pdL214v1yFvpKBA
         qAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776558257; x=1777163057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YsIF2LGe0TsB9mB/+pX9myIE64c+bQIeRiW5LMgOSRU=;
        b=UfwOP/jWYYH17M/4hl2kncnYWvGqcJVrnjPUpDDk1/pOBau75t1pfD9JT5dbDtpb6u
         kB/mEhZNLeCzZUisVvsl+7Gdv25ZaYJzuT6E67gDh63H6UktmgfVzsQjCvv4R17rjYpG
         N2eDG/h26iyMbHSqhLIC/bCQCKMHLSVShO5Uj0GJSGm5Zi+RmsEBlIpc/QIHNWsoKdA/
         To0+NOs/+Vwcjc9jb8L2mw0YF0GFKukt1kt6u7okJ57YrKtx9nkeN+CRqPeS8daS3wQi
         cF89eHv8fXHnqgBApqFde6B33u4AiRdP3t1hNdXdyqfnHMKNC4hGtQOtcdMayCkSjZsl
         TW3Q==
X-Gm-Message-State: AOJu0Yz/VSukWhBcpgqUHpTBrYipGyORI1UXYVHSc/ZGC+Dz8U6GtVBl
	KRtSQa3WCKGsoHKk42gc9X2qmLh2UrjMQ4dtbjQaJ+nKvboxRRltg4bBrrWAVzE5pXAU3Sv+z7h
	zFi6zqCB2eeE3KQNzVlZXu/OEu7ah22k=
X-Gm-Gg: AeBDievjX3oicViGaNiXCpSNuma5ow2C01zDQjkfDqyL+8B4mHyN1963oXwfbETt7xv
	cQQwkecOjE0kVySwTCYess8Iw0iWcagIoVXJZcKb31zruIbBJNjMHJ9QSi0TgOejnCRv2EFzdNw
	bzMU0vuGbz920bh+Y1HsUNCwvZsq1VvlXGLUfur8lc81fX3CzLcH08Ko8fcy/1EGyKHbqdnlqJI
	U5fVK2Tnyq4V813tWinpMk0pK2hrMA9P1MNEzRSzlqKTxv5WZK3OHcpSJPQrHzd13ZLMQDPBITO
	NlBn4alzXwdkKpwMB3K/z5pTw/WNC3anQtFWO+lUEawfIB9/hO/GjjWiFZFXvZ5cveHL4SAyu7g
	aIlvR/oFQ+jdmPrDUr6vV4F61wj571nPpMPN3
X-Received: by 2002:a17:902:7005:b0:2ae:55eb:f82d with SMTP id
 d9443c01a7336-2b5f9eaf865mr60802425ad.1.1776558257318; Sat, 18 Apr 2026
 17:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776124588.git.me@ttaylorr.com> <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
In-Reply-To: <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 18 Apr 2026 17:24:04 -0700
X-Gm-Features: AQROBzDw_GclD_Ut_05qO4lRpBRUC8ygt9unPezIv2_Hv_xvCIDT4Ip2-DDgU_0
Message-ID: <CABPp-BELG+poD67JCojze=bzYsWr0UvdXb2Vai=eEY=2CzaGCg@mail.gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 4:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
[...]
> +               bitmap_writer_push_commit(&writer, c, false);

$ git grep -h -A 1 bitmap_writer_push_commit -- '*.h'
void bitmap_writer_push_commit(struct bitmap_writer *writer,
                               struct commit *commit, unsigned pseudo_merge=
);

Not a big deal, but for consistency, would it make more sense to pass
0 for the third argument, or to change the function signature change
to accept bool instead of unsigned?
