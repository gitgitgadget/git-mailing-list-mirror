Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EB3D75C7
	for <git@vger.kernel.org>; Mon, 11 May 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495420; cv=none; b=gs5YSFHdDouRSO5Nu0t0uKwwcqhLMVy+bugQbc0lHMQ++PMsaft6/JLj+LPOTM2S6z2FcKlYfBYjPh/fL9B/7QX8bVmbelcWz3rCbhJCZSEf9rzxgKqtg9RVXj4GCjxiUdW3t8ST6ra/bCnZxaeGIWky4p/IGNE1XbKdrQkoyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495420; c=relaxed/simple;
	bh=2ERvR+7XPucbPElWEmeW9sMLtTIl1mmrExe86BBeYaw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rSzwjTl5VVXU04K3Jz/D/AiTLdI8O68V0mRQkeRRJxXHOipuTMSyTZ3jveNrGPTR0HTScDTzESvVyDM6yTrPxf75RjzYFw/RdotI2jrFStlpHLc9DxpOARSUKtHgR0rzYc7djqePJVyliOErJTqQ1HEfeHb2qXc4P4QJg7zUlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHUUZwHs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHUUZwHs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-452169ae568so3153062f8f.3
        for <git@vger.kernel.org>; Mon, 11 May 2026 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778495417; x=1779100217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sAqcq2jhyXUU3KeS6e+9V2jhxoxY3xx/eOL0Ol7zi8=;
        b=NHUUZwHsdm4HQGSWGgHoHuTDqsqM7EJBM8yuvzHawW+NERyyVpY1Du+JYpzYU8Z3o8
         +WGAkuij4ga9eGxQn3FI5fmfCuDJQojl2hl4ri7K7FexifKd0URtWM+WHenrZSh8/hSR
         HW2KUKEp3+k+QcpYRNnZJxf9zvZmrS2eeUUCxJJglQQwJhqFcKK8JGBO/oCYRl9l194X
         C12n2pby8wUDdRr5GpAWYuTta9hEt3S9OzBmYB8HD1uosqSiECnoA0g06aBRVB87Vb1/
         6wMT5NB5xTIDEQJYzYwjmm06XyEQyoTHbjsmkZerBwqM41Tv9NHjCX6UJwYhcr+qDt63
         JXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778495417; x=1779100217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sAqcq2jhyXUU3KeS6e+9V2jhxoxY3xx/eOL0Ol7zi8=;
        b=MBHeEP6AUER/YS+VPBIRXPG/ndDi2DOq7B3HEIMOW16C+xSUwAYW/HimcrC/9LqVY0
         b/XUlS7cSJAnqflEaZ2JCmC75cuqM5cEdH6+xeoh3HKJ2nWc7F/SJdEPk6w5vQz7m5GT
         TpFSh363W1E1KAOoFyb3ddzrA0dQJiuv5xlLIzSqulEK6fiQGkY/uVf4eI1ui+qRClOA
         b6e3kDm9oKoc88YdYwzWjMQgf+BoHevpQ0QGVQUt6O1haBmGlfpI44/Qvn/duA5nY5Uy
         PxWcaLXuOsRb7+8qqIdtnoyKkqvZiJd2fuK+YCWdXcOVTIxEOQxVpG6Y/c2VtACv0Mhh
         Ivmg==
X-Forwarded-Encrypted: i=1; AFNElJ8v+PJSTwlejXmiGEAX1/IeCObk+f4fqd2PP9PyyMozQEqIJU4e4YQNe36lXILBtMzJ960=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cDT5pQX9+X81q55gdleWB2d+C9VJ6sDj1lTqssAB3aU7+flN
	kurHpFyH5cOCCwF2KzcBlKd5t0q3sqP+65nDPptMlHSOchUzXa2DUw0zCIaWqg==
X-Gm-Gg: Acq92OFAC/0b+NN4mfkjCaI6E9aJ/mawG/mTQ8VO+6poyRz88FznWLak5UDkJ5WDT3N
	jfga1V3s2oEWNhNJqFffy2DVys/d7tl8dWkojuhzPETOZogEtXNxl5WhvHGvKC1YLNE1DW4asqG
	eiufVaXklpKDrHUwnMdt0GRjrwAJlW3NMX1fJtrjVG9uABAbZmL4cCHeoRgPF/rSjUQl2YB5MEE
	0QEcvxpm6VXqX5MSTdAG5u6bAoUw+y/tAho8MV+ry3S5d5xQ+pAspPU7V/vFoSaBQ9wKyLDHH1g
	z85uhkh2sVl19MD2+CYfg/6cgy+X6hmMUWkv2kCgdBiTa1h2uFojSmBQALxrbq0bslxGa94nJEe
	9vZVx+f+GMZcilOv4FEpyCt1x+V9Q+/crlzBrNAxJOZK5Xyhu8h12DLCXMm76sGY6fYHizdA1Le
	RddIDFzMk9z7wRXAJDQMHINH1FKNjU/+WRIJf6wBAiZxtMePBwJlcG/zNlHigZM0Pm3wCuGREH7
	WP+XYhdUmo=
X-Received: by 2002:a05:6000:1acf:b0:43d:7d6f:f529 with SMTP id ffacd0b85a97d-4515d3dc303mr36417537f8f.31.1778495417021;
        Mon, 11 May 2026 03:30:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731? ([2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm9026963f8f.3.2026.05.11.03.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:30:16 -0700 (PDT)
Message-ID: <fd05eba1-d821-4cbe-ada6-ccab97308e56@gmail.com>
Date: Mon, 11 May 2026 11:30:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] ignore: note info/exclude lives in GIT_COMMON_DIR, not
 GIT_DIR
Reply-To: phillip.wood@dunelm.org.uk
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 Caleb White <cdwhite3@pm.me>, Calvin Wan <calvinwan@google.com>,
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>,
 Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
 <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2026 15:14, D. Ben Knoble wrote:
> gitignore(5) says that the per-repository ignore file is
> $GIT_DIR/info/exclude, but in a worktree that is not the case:
> 
>      git rev-parse --git-path info/exclude
>      /path/to/main/worktree/.git/info/exclude
>      git rev-parse --git-common-dir
>      /path/to/main/worktree/.git
> 
> We actually use $GIT_COMMON_DIR/info/exclude. Adjust the documentation
> to say so.

Thanks for making the documentation match reality. Are there some more
instances than need to be changed? If I run

     git grep -n GIT_DIR/info origin/master Documentation/gitignore.adoc

I see

origin/master:Documentation/gitignore.adoc:10:$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
origin/master:Documentation/gitignore.adoc:37: * Patterns read from `$GIT_DIR/info/exclude`.
origin/master:Documentation/gitignore.adoc:53:   the `$GIT_DIR/info/exclude` file.
origin/master:Documentation/gitignore.adoc:100:   such as $GIT_DIR/info/exclude and core.excludesFile, are treated as if
origin/master:Documentation/gitignore.adoc:149:`$GIT_DIR/info/exclude`. Patterns in the exclude file are used in addition to
origin/master:Documentation/gitignore.adoc:150:those in `$GIT_DIR/info/exclude`.

We also have a ton of other files under Documentation that mention
$GIT_DIR/info/... all of which, apart from the release notes, I
think should probably be using $GIT_COMMON_DIR but we can always do
that separately

Thanks

Phillip

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>      Changes in v2:
>      
>      Only adjust the documentation.
>      
>      brian points out that a more general extension would allow using more
>      info/ files as "per-worktree," which I don't have the impetus to
>      implement myself.
>      
>      Phillip and Junio asked for a concrete use case:
>      
>          A colleague is developing a tool for managing the "skill files" of
>          various LLM tools (Claude, Windsurf, etc.). The files have
>          requirements that make it hard to generically ignore them (e.g.,
>          filenames and front-matter have to match), but different tasks
>          (corresponding to worktrees) may want different active skills, so it
>          is desirable to ignore the files. Think of this like node_modules.
>      
>          Unfortunately, since per-worktree ignores don't work, the current
>          solution is to put a .gitignore file in the corresponding directory
>          with the installed skills that ignores itself and the installed
>          skills.
>      
>      Since overall reactions seem fairly negative (or require a more general
>      extension, which I think is probably the right course but not simply
>      implemented), I've opted to adjust the docs. They originally confused
>      me, as I was surprised when my colleague reported that per-worktree
>      ignores didn't work (the docs imply they should by use of $GIT_DIR).
>      
>      Link to v1: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
>      
>      v1 notes:
>      
>      Discussed briefly at https://lore.kernel.org/git/CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com/T
>      
>      This is based on next (4f69b47b94 (Merge branch 'ps/test-set-e-clean'
>      into next, 2026-04-23)) but cleanly applies to master (94f057755b (Git
>      2.54, 2026-04-19)) and seen (50541634cb (Merge branch
>      'js/parseopt-subcommand-autocorrection' into seen, 2026-04-23)).
> 
>   Documentation/gitignore.adoc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
> index a3d24e5c34..c423b650de 100644
> --- a/Documentation/gitignore.adoc
> +++ b/Documentation/gitignore.adoc
> @@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
>   
>   SYNOPSIS
>   --------
> -$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
> +$XDG_CONFIG_HOME/git/ignore, $GIT_COMMON_DIR/info/exclude, .gitignore
>   
>   DESCRIPTION
>   -----------
> @@ -34,7 +34,7 @@ precedence, the last matching pattern decides the outcome):
>      includes such `.gitignore` files in its repository, containing patterns for
>      files generated as part of the project build.
>   
> - * Patterns read from `$GIT_DIR/info/exclude`.
> + * Patterns read from `$GIT_COMMON_DIR/info/exclude`.
>   
>    * Patterns read from the file specified by the configuration
>      variable `core.excludesFile`.
> 
> base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2

