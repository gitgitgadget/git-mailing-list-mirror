Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86F19048F
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824253; cv=none; b=ENMrb7CTD+HuEcB8HuYClgzdd1I2RPWV6mi8pB91C1jqLKeS5alUfcxhNq0b6IX5D7upEVx/Zo3I0EFjotS0/x8G3aX/Xfi4gDp/mJ4tJj7CicybrhXr2JwowntS3ocBUP96oOtRayFgGE3e0PuveE/mVkP3u3CRuRpdvQADTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824253; c=relaxed/simple;
	bh=mKshPa9sKtP6/6gRxM4S95vSgVfRRtTN0uztrIs5Zx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Io22SXt4Gv5UQZXq40qxQFgkRi/YXS9wYH7uBshThQYSEG0b7rND3cGA1hwzKxIGli0DH8Y3oyA0uCbd2VOCzmZQ0oLazOQ3GH1q19zrQ037C73fx24fz58sva4bonoWQnLHlCTWQdUHZZVefdV9Lfw5OiZxKnqVSV5mmR/PWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2eIeUAZ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2eIeUAZ"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8550803e1afso371151039f.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 12:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739824250; x=1740429050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q59tHp+vShdrIrKNIg9EHdzCCCzdEOzUIuxcMLMWNLg=;
        b=P2eIeUAZvGNK/l/MgnrwacwXwOzN/QqiNMhhqocA1FsPaRW6CW5bs4HuhN6st/lHRg
         2t25LeQX7XB8XmXhnOtHeVEGFr05t9TtGd6MZ3wahuu7bx0kGbTVOL7ihWd6+0y8qCNG
         wChzKXsLaYHnXL1cC4belYA0nRo61NBqNFs3Msjan8jh9yuv/i50xdzVWtFFWxUf6QAu
         UNgCKdVX6k72vp9PY7JGuZGLLg07KpPbIRU8ZoFQuYWYgzAEp/+Urw5gf+llKy5e8+lN
         jiW6RE+qqEYTgXcQOP3iUl7uywD+vEp45S/3RzWhF7rWiVQsWTGji3dXwB5l4mIws0T1
         wrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739824250; x=1740429050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q59tHp+vShdrIrKNIg9EHdzCCCzdEOzUIuxcMLMWNLg=;
        b=GVQBJpgeoASNjM1w1859dH+CXnqb/Ap4Nw/l2mMULLKBpU/xHKr9Rpa1IHYAZW7r3y
         soZSRewLgTq98NZUhiNSX4FDPBaxPioIj1EmQpkz4T/Z+1hrmwL6lRSq0Y2u700G9YUC
         5kwVgKeEKo3Mi1ZUYeKb9PaByF9Yi9E8spQFQT1hqOj4wdgvbLUYBA+2JfE+Nmvr+5Sh
         OLLsazq+2HZL06QndBzv/JkIaQJ2ojxTvje3aruiB/59SaLEx4OcT3VRV60Z0ad6PtAK
         mrmKEbO+MK6QkARk60vU/o27EeqqneOaHOB10sn8R1vdPezwsgWez891sd5/dxGUx16/
         nRuQ==
X-Gm-Message-State: AOJu0YyvedHm7bB0CbQbaZujHd/3PO8Htm1HH3k1zFt7qK8ylvp9idNT
	/XXi7B8P0X7g8Yrl4MPQhIaMcViwC2lDUqNRzzMBgAPV7Xc3g3uXJ10Mr7JW0Zira+jGxJf/BwY
	nzP4jqmI19Ty3ShYHJcj6w1Atx9c=
X-Gm-Gg: ASbGncvtROlY/5XfqGA/0VJEIt1AvpUqN2Qbww0YWOR5QQM/RVbmOn+xUvTy+aYBijv
	MAq/DjOMXKJ+x5zQdqK6fAefrO+L47v5b5uvnRl/p9gxpzDmjc6gWVOTTa25oX9cH5bxsQCmVmX
	xW5crGETZnUId8tGOyulOjcGsniU1HYQ==
X-Google-Smtp-Source: AGHT+IEjuWFEL75irBhXbDeu5ZYPvhIPW+JuUiy+RFr60lO+7p4Z7/vh2NJuKyHmcjKsQYQFTDGr029LwzrrvcA0GHM=
X-Received: by 2002:a05:6602:6d04:b0:855:9d17:b050 with SMTP id
 ca18e2360f4ac-8559d17b6f2mr347839039f.9.1739824250723; Mon, 17 Feb 2025
 12:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com> <89722894c875bc0208945c036700dba74cc0068f.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <89722894c875bc0208945c036700dba74cc0068f.1739723830.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Feb 2025 12:30:39 -0800
X-Gm-Features: AWEUYZloE352fYFr_bBaBqSJBBmGLUmhbxQ0TrSgwTo2huL5VM5W1QNmyWC6XbA
Message-ID: <CABPp-BEQSsVUPUJyB+SqAsD89NFAzF_ibqOFqrs510kHX0u6xw@mail.gmail.com>
Subject: Re: [PATCH 5/5] merge-tree: fix link formatting in html docs
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:37=E2=80=AFAM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> In the html documentation the link to the "OUTPUT" section is surrounded
> by square brackets. Fix this by adding explicit link text to the cross
> reference.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-merge-tree.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index efb16b4f27d..cf0578f9b5e 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -49,7 +49,8 @@ OPTIONS
>         Do not quote filenames in the <Conflicted file info> section,
>         and end each filename with a NUL character rather than
>         newline.  Also begin the messages section with a NUL character
> -       instead of a newline.  See <<OUTPUT>> below for more information.
> +       instead of a newline.  See <<OUTPUT,OUTPUT>> below for more
> +       information.
>
>  --name-only::
>         In the Conflicted file info section, instead of writing a list
> --
> gitgitgadget

Seems to be the only line in git-merge-tree.txt matching <<.*>> which
also matches <<[,]*>>; i.e. looks like the only case that needed to be
fixed.  Thanks for fixing it.
