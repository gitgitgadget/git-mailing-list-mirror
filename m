Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5494D8DD
	for <git@vger.kernel.org>; Fri, 31 May 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191737; cv=none; b=OCRSNf7vw70O2DCmphXkUlC+Mr089yAOp2Cyc56M3GclKR0JxzJADGbxX607qrMvEjoZzjLkiK32CFONa0vJVQ0aMSDiyTAvg3p7vQiqwd6c/aYO2ny2Ot4lbR6tjXQenp0fyQksGUx1g4Vph3vtjC//Q1WpYmpIqKuuv1jgoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191737; c=relaxed/simple;
	bh=UJXOawF3jqFfbkKizS+nATaB5gRiuxyVgSqQGPpYfOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbDVVD9VcEemv5KXHT4FjMlWPIUXsgvwYPiub9MzcMQJPOtZe+sYEaeYjUofsocnyau4ShmV6gnnvo+dULIiJNnmh8zPABVOH/uK7fg1PdppzIg5yYxLTVC4XDqiNPqPVGF4x0fj60e/5WQdF/Ys9aOGCoPRzM+OZ3CP9QJE5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6aedd5167d1so4936036d6.1
        for <git@vger.kernel.org>; Fri, 31 May 2024 14:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191734; x=1717796534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F6jN5WOZlilZcKxLwuhruhlkprI+pCBfJq6ep5ZbZQ=;
        b=Hgt8oRrrJgkYW9dMzekW8tAHQJorzfVWTiDYX1HiDl8kTnvFTo9VAy5S+h5M6h1yS6
         QB6ePpDrPUHYYv4jzi4S+edEe0Qs00rY/B20YihI/wpqtgh7Ka0TfGe9Dz3qu502WrAu
         IE9Ub7cgZ13jyB0edQYMDUulYcs+oXTheIuEyaSYopyDJEu1oaxYFkWOByaTWYpvGria
         nFN8Q1q0SG5nZZgEzJ5lUjDYLNEzyuKL50Cs/Rp5EC9tLFrUX8/HS5vRkfLlJEFpMpqw
         krcdk0F8RZ3HeH4x9Eft7kV6sKATObTXnqggdXRtPvyIYQ6vmmxuZT9nryMArdXbXWDy
         TNCg==
X-Gm-Message-State: AOJu0Yz6EGsI8jhXl6qFtUvy1XrukVivOanxIKyuiGFVGOtTe/50rimg
	FU3IYicNJfvVEfUgWZqZJXfzQQgB7VUN1c4ez+V9bFyVRHmdj34YJ3tCXXN3Otre/1g0mv8/YSx
	fLE6T5t0AHoOPdsL8kzNVzgcYsUU=
X-Google-Smtp-Source: AGHT+IGNXpbTUvBW7LDC+4xyWKyo18NDBM4vr6LzJRxoV3dkVH+FYyc9e9e52U9oRUSG0B6nYm4ctm1uBTsm0GT62Kg=
X-Received: by 2002:ad4:4483:0:b0:6ae:ce52:207f with SMTP id
 6a1803df08f44-6aece5220a8mr27060126d6.0.1717191734007; Fri, 31 May 2024
 14:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADg0FA_9shzJKN=dBfnavu5eTDNhbz=g0WP2sehAjSqHP4WFkA@mail.gmail.com>
In-Reply-To: <CADg0FA_9shzJKN=dBfnavu5eTDNhbz=g0WP2sehAjSqHP4WFkA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 May 2024 17:42:03 -0400
Message-ID: <CAPig+cT1pTkKd1A0o_qjP+Oyx+zyCevV8EAg5Ub9guAyd3UjgA@mail.gmail.com>
Subject: Re: [bug report] git diff --relative not doing well with worktree in hooks
To: Antoine Bolvy <antoine.bolvy@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 7:38=E2=80=AFAM Antoine Bolvy <antoine.bolvy@gmail.=
com> wrote:
> I noticed a weird behavior when using git diff --relative with worktrees =
and
> hooks. When called from a pre-commit hook from a worktree, the relative o=
ption
> has no effect.
>
> [main tree] Displays
> ```
> /home/arch/git/awfus/hook-repro/test/folder
> bar
> ```
> [in worktree] Displays
> ```
> /home/arch/git/awfus/hook-repro/worktree/folder
> folder/foo
> ```
> The path is no longer show relative. This causes issues with more complex
> scripts.

I'm not sure there's a satisfactory resolution here. Your hook is
running afoul of the environment variables Git sets up when the hook
is run outside of the "main" worktree.

If you change your hook from:

    #!/bin/bash
    cd folder || exit
    pwd # display the current working directory
    git diff --cached --relative --name-only

to:

    #!/bin/bash
    cd folder || exit
    pwd # display the current working directory
    unset $(git rev-parse --local-env-vars)
    git diff --cached --relative --name-only

then it works as expected.

The relevant portion from the "githooks" manual page is:

    Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
    exported so that Git commands run by the hook can correctly locate
    the repository. If your hook needs to invoke Git commands in a
    foreign repository or in a different working tree of the same
    repository, then it should clear these environment variables so
    they do not interfere with Git operations at the foreign
    location. For example:

        local_desc=3D$(git describe)
        foreign_desc=3D$(unset $(git rev-parse --local-env-vars); git -C
../foreign-repo describe)
