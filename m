Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306B2222A0
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939469; cv=none; b=Vhiz0G5yt4H+zLwNODn80hWb3yjK1dqNPGtOZOAzthlff4dY4mpmlPQmXaPISkmkb4xAKdK3eluFru/XrSolAkhDCPfyBxZiIu0kuWHfinIli/3B7S8TkpGqRQ2SWi1oA+z77ILJ2eWd76+HpOLwcD++9ToHc/5mGLhlky6M7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939469; c=relaxed/simple;
	bh=CU4RL/nCo3f/JRi6nu1QspFfu94565CiKFcEwtojufM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYvnzntPiGrwpw2FMjzS0+d+p5wBRZpsVc/L3288DmLEAWdHcRKJM0i9MJgKsedhLSCfx4RxzXzfewc2XW0zCtlxETga5yLlzhBGG7SkXAjpgI6Fu8tpqUpU4oEhGhzae0EJL+riFMQqHH+ckw5ynsfz2lXYL/PNWotWHkXU/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1yZpmkL; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1yZpmkL"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e89a59d68so108954739f.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761939467; x=1762544267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luJipT2HOV8Rxd6c/NYT4eHvZUn4evG4vLPrfyBJPwU=;
        b=Q1yZpmkLSRmyIC0EK4ADuNIlNvs9SVtuLzhaaLyb6dri+RNygy8IqWZsU14idfr2l/
         DXPwRo2j001v4vCueSuAHMW9RJlLd9zhSSzjj9MXqszutPZ9zW3YGvqPCQFzZy47r9KL
         BEPyO5YpZ0DhAg9oiYhXH4MRCZsI6pABexnPNovR6sLXM0TSWCZpMTyP0XNgU078n3ln
         y09xRrzOoo+krNEaBw6bzh2YOmcHbk5WmqIFIVczhcFrDNdDoo2c2yRUpp+sV9F3YKUk
         5o3WW9SlzmguLG1yZqXd5breS+fNr1oRpfl2ZFSc0IHMttNnZm1LrrXWHLrOFDPVLyrX
         21jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761939467; x=1762544267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luJipT2HOV8Rxd6c/NYT4eHvZUn4evG4vLPrfyBJPwU=;
        b=KKBTUHG1M7aaWMvTo4aSZAF6iBSiCD/mRZf9aZxE9SRTCHgMM2UK9wdfAVSAvmi+Jw
         3tfpxGZ3vgj8NVu1SuHVlfLo2DnOm42xCBl63eWPj9nViw+EyDtkvKuX7BXEBQj6k2+j
         zxIDba7gQpj21Zp7fH5QKu6spnhA93dcie2YrZ7hfNmoOtlR99RYN/IRnlw2EIprCrSv
         9oIpYjwL1biQkbhqDfCWONKyZzMerBhgbZd9BfXOug010A+pvgFo4ZqXRp6M/OpvTRV0
         01KkDxIkKVuVvHLtrLSdeg5r376662pi07RO/8NInPFL9s0oeWYSXgB+e6zH5ONx3tpV
         sxhQ==
X-Gm-Message-State: AOJu0YxZ6ZA74Rz1SwbI3bqzil9tFjT5UK95ujim0+hHF0UK3I/DEipS
	H9kwLsUzGhM8gRZFiS/UKNDX5Q29wiXlgXkNg3FbMSuUQQG8ymjd8E+9MYINeOvgaFbVfhNI6Je
	U27DTU5nUhsYe/HrJqNkd5XCx45CXOug=
X-Gm-Gg: ASbGncsoHNEvKkVK1duIAod+0RZJ9PdA5zvatUjIH68wDsm0odfY8rFwckTqRO/cc+6
	9zCan7Mk4NGSZdIG62wEWCSET/qnmkh5x+hrOE2Ipe0oD78kSqzGkTwGySpjXPT+TJDqHEBy5ra
	5gS3C3ce+By51Q4nJU+2hYlL4e4+BVF8v6yttVuJKv27gT2awa8er/uETAFTqjb9x7j961W1o8z
	q2PxIKQeJgVZyBW8zlod66ER8U4WmxkWhjCQC6fEOllB42LKz8TIam9IU5pBmh7Hm708koKpXUF
	vLJ3+iXkNrY+9J5g
X-Google-Smtp-Source: AGHT+IFveZdsaVyFd5bgVsoyqjs+kiPZCDMkGFSvPL86U6SD/o98d4Cjf+iaPBMwWcvka4ydCg5yBefWETjFtkymU1g=
X-Received: by 2002:a05:6602:740e:b0:948:1730:c30c with SMTP id
 ca18e2360f4ac-94822976519mr778299139f.8.1761939466832; Fri, 31 Oct 2025
 12:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028081232.3068147-1-christian.couder@gmail.com> <20251030123332.3337684-1-christian.couder@gmail.com>
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 31 Oct 2025 12:37:35 -0700
X-Gm-Features: AWmQ_bkjQvNTP5affA_JAVxajvG0ZMeUZCUfTmJm0RHUBeUMzCx5sp2bVSBcBbM
Message-ID: <CABPp-BG_PhbFOS-Tre249nzMyc5YGK1yHMVgo8XGMq7Y4LewWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fast-export/import: cleanups and translation
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:33=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
>
> Introduction
> ------------
>
> In a previous v2 patch series[1] that I sent last May, there were two
> preparatory cleanup patches[2][3] that have been dropped in the v3 and
> next versions. I think these two cleanup patches are worth resending
> in their own series though.
>
> While at cleaning things up, I realized that, when working in this
> area of the code, I have often been annoyed by the fact that few error
> and warning messages were marked for translation. So I decided to also
> address this here.
>
> So patches 1/5 and 2/5 are small code cleanups that are resent, while
> patches 3/5, 4/5 and 5/5 are about marking strings for translation.
>
> [1] https://lore.kernel.org/git/20250526103314.1542316-1-christian.couder=
@gmail.com/
> [2] https://lore.kernel.org/git/20250526103314.1542316-2-christian.couder=
@gmail.com/
> [3] https://lore.kernel.org/git/20250526103314.1542316-3-christian.couder=
@gmail.com/

These all look like simple sensible fixes to me.  The only problem I
found looking over the patch is that you undersell the benefits of one
of the changes in the commit message, but that's not even really a
problem.

Series looks good to me.
