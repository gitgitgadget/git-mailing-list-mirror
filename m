Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FE224F2
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968784; cv=none; b=hXKAHhksF1VNtO5igTK+i97hCm9/ZRe7FVxNOg+n4H6ZsVURDnEct/Z7ZbkwyF29VwcP+1zBwRaiJvi4oloVvmNesQbcCRTEj/BFTpL0V2iRBwrIwOd3nCHjgrALiu5gQT3VteI2SQ8zdfT2QOIWdCB51A1IQa2fL2Xh1Mcqlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968784; c=relaxed/simple;
	bh=o4wc35ht854xyjNvOQG9BnU/vJR0gZokONxHXvJgk3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbjkOQLK1mnq0dQ26UJhMOJwRWGHcDVkZUR6Nz5zWq3kq7xq+vhE5kiOSN3pnJQLzPJJAVkr8WzdxZ9Mx5ePyxYfVdroq3+9hEkHk98l8nWPDnjtFeUMuDpkpyStZSGSaBHpGdscPK0GTvL1hM30R7tctSVvDIuy17/A7X4SevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-222ba2a19bdso202896fac.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 14:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710968782; x=1711573582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgpluuY93Rpav+0wP/DidA9uDNjADEZmPJmGa61esFI=;
        b=FFQh2/qFolPDKUaJW0AaNVJbT658u2P9qq2h4uGoeSd9dGxs7fnyuGcoWnumoaqNiZ
         pYBnDpPRBsfoyz149K+LPai1/ZdWIWE8RO/n85ImYmzJclz1BM8jEsPhP3l6+ta9dv2M
         WKgX1W1uIyGcS/ywX9ORN1e6RWSjoWRqBhGlsTKJJWhsYamgs8VaACuvg5+/5tJ5EEer
         hG2UBrgakO7KYqRwjr7mT1gTBdBsVfyHGe6LYc1UjVSCMTYsBFJqUXfL0yIpjTMZ50S1
         6uF+TQRYeOpgScGjxm6NKd4rj5Q2P7Bdyx3MrJsgbrR+2nOOgUHNPGqxg9wGUKETZJtL
         94dw==
X-Forwarded-Encrypted: i=1; AJvYcCUjBhhNyiulETefj+JfIUB5Lc1STwUFch61nTE1uN8szwk4AqIwWYkRhUcwu0s90MWJhLjn40mReOt1Ckpi5K5uKBMy
X-Gm-Message-State: AOJu0Yz++GNyX1Y1OlIzEn5+XvQtGrSLyYZFIEWppIM0QABhjmF3J42u
	kBZzrNpoupyalvMNMq3uEXEC15qKgpgBoiuB24ETm8CBmFWAqNPqih3AI3Xt6pYycAxylHPPLkg
	+GshMS5vA+NO2xBY3hBVVpoRDLUfMSASL
X-Google-Smtp-Source: AGHT+IGS+pm9cQD2IlkjaMWe1RFqqwZ8+00pqP6XpsLwB8AzCdBJ8CoQ0rldvpB1d6WdSv03e5R7/SLrnsyoTCOTbXo=
X-Received: by 2002:a05:6870:4c17:b0:220:8d82:3838 with SMTP id
 pk23-20020a0568704c1700b002208d823838mr284399oab.28.1710968781811; Wed, 20
 Mar 2024 14:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1700.git.1710964109659.gitgitgadget@gmail.com> <xmqqle6cfx81.fsf@gitster.g>
In-Reply-To: <xmqqle6cfx81.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 20 Mar 2024 17:06:10 -0400
Message-ID: <CAPig+cSYP=_UirE8nDEoMDX1_GuTVFPt1wrbonYN848xPMZBvw@mail.gmail.com>
Subject: Re: [PATCH] t9803-git-p4-shell-metachars.sh: update to use
 test_path_* functions
To: Junio C Hamano <gitster@pobox.com>
Cc: Sanchit Jindal via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Sanchit Jindal <sanchit1053@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 4:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> A few minor points.
>
>  * As our test numbers uniquely identify test scripts, your commit
>    title can be "t9803: use test_path_* helpers".

I meant to mention this, as well, in my review but forgot.
