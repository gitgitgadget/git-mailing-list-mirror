Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884426F45F
	for <git@vger.kernel.org>; Mon,  5 May 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477009; cv=none; b=gJwEDVcXbg9H9SF+f6SvI2bxo5g9e7MKBm9ejxhwQvQ0uMyYTUcT5GJLRRVeVTAn4W5eI+EW9uLMAgJ1+6R+yiPYGKNrgARocxS13+dx9W2yMbVoC1Vs/Z+YnAnb5gY6wdOuql8z+yWdRZr1dekBiwSPxlYXVkufYl/4/qexl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477009; c=relaxed/simple;
	bh=I3lGSyuKO7kw3viPcyRbemiVLKUKxrblyZgu6q3CJSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYOy4KoqG4rg9m9D8oCXYI2Bv09bWEtNVGFQeS9bJP7lwgL+xLSJM5LctAc03oe5SPJefMrDPfGS0CbWMIsYX3abtyMEGMrD7Iw1qGpO4CqWYS/8Xunu6tcx82/rA0Z+DqWHdpULfeYVgSaBx6ZGqjrcZ7DhflVT3iGFRKIYQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so5914946d6.3
        for <git@vger.kernel.org>; Mon, 05 May 2025 13:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477006; x=1747081806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFa/CSA7WmMv+jjZfN6VqR9JtacTXD0+PQx2RMtEqrY=;
        b=im/Lb5CejfnD1cfPwI3l9sXp01JoywKOXyQcXTJ0BoEgJddeZNAZhRadQCB6ocZd17
         Ha0SN7ik3WyecLahrLBDIXMgZ77EW7+ZmkXDhlcvxEDTTkgDx04U6lp/dUPmo7GNiN+b
         Vn+Pj2UNWNYfOqYTAtPGWMXfi++NuMFbxUQGnK1qOoQBpdQlLRCJd3cSZUL0eiOClqNd
         nZcS0IIzse0kWVlxroI6nkilzYU0l1yXd02xslnu1jaz1JVXT7HhERRqH9Y2Ha403wTy
         ln1Rpxku5aUTY797AgXWzpHOXrBnZl6Vd1zzcAUoU8il6Gtd1scMkwi0wd9fTsrTq2+u
         5VsA==
X-Gm-Message-State: AOJu0Yx3gfS9ITTn5s7uDfSzhZ2ek2mmEz8UmVgrYY14nPECovu+iwW8
	kCVlL2kxc90xDJZCxfMaowdRA/V28kjggpZ1kP5FkyKpF/FKMYzurk0FqMS9Vj4GE7X5PYeOE+Q
	Xg2sYrzxeqiuJDWDZCQd5XHj/fo2eMTD3
X-Gm-Gg: ASbGncuyxO27q7RJaBe7jZz74sNOboTK3s80iYbBLRuYHomsN2GkNlaCMwl8b+o2hob
	244oQMtPfEPjhKQHWpxI+fTeIdulcQ4P2Mj1vHqdmg1Cqf71Ih796pJt0vGuvO65TfJZQUpvV8g
	6oEdDaGM9u4gW8aClfmW14TiTZQ4JVz3O1VuvmIGo0dZj+ZDl7YqKKrNk=
X-Google-Smtp-Source: AGHT+IG57GChRnimRLaEgAL1ikXYLWdglEjHKMQL95TjM7BRrDrqhSIasWoNJ2FRZjXSm8BTM0EIpZemVSor98yaR/Q=
X-Received: by 2002:a05:6214:248e:b0:6e8:98ce:dd75 with SMTP id
 6a1803df08f44-6f5156284c3mr82371946d6.9.1746477006046; Mon, 05 May 2025
 13:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com> <8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
In-Reply-To: <8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 May 2025 16:29:54 -0400
X-Gm-Features: ATxdqUGMrdWIXPtdrnCV7zTvVXm49y80ulibN5QGtOqo55_c4PyxssqEiMQUfvo
Message-ID: <CAPig+cTqqe-VmbGeMginenQY+bzuuVCxL1E2HGhgKSqzDwunCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] add-patch: respect diff.context configuration
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Leon Michalak <leonmichalak6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:18=E2=80=AFAM Leon Michalak via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This aims to teach relevant builtins (that take in `--patch`) to respect
> the user's diff.context and diff.interHunkContext file configurations.
>
> Since these are both UI options and `--patch` is designed for the end use=
r,
> I believe this was previously just an inconsistency, which this patch hop=
es
> to address.
>
> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> ---
> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> @@ -49,7 +49,53 @@ test_expect_success 'diff.context honored by "log"' '
>         ! grep firstline output &&
>         git config diff.context 8 &&
>         git log -1 -p >output &&
> -       grep "^ firstline" output
> +       grep "^ firstline" output &&
> +       git config --unset diff.context
> +'
> +
> +test_expect_success 'diff.context honored by "add"' '
> +       git add -p >output &&
> +       ! grep firstline output &&
> +       git config diff.context 8 &&
> +       git add -p >output &&
> +       grep "^ firstline" output &&
> +       git config --unset diff.context
> +'

Be aware that if any command in the &&-chain prior to `git config
--unset` fails, then `git config --unset` itself will not be executed,
hence the cleanup won't happen. The way to address this is to instead
use `test_config` to configure the value since it will ensure that the
value gets "unset" regardless of whether the test succeeds or fails:

   test_config diff.context 8 &&

The same comment applies to all the new tests.
