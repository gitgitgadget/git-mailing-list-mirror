Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA2155726
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732878323; cv=none; b=WuRzLpafUZbMadpVP6JmVdyVDQNpqKt/ZG0Vs2MidYpbF+aEVDyAuGhSvkeEYMaUg7dPjNmBtoSt9cfQpKbtmb7zF1l4EDzP7G7BQRWT5ZluvNqRov/XrPHQZJyJ48iZqiL+Tvm4OkHHfn1hiLony8EWianZLJeHS1VXN0TEbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732878323; c=relaxed/simple;
	bh=ZA6Yu/BAX6DLSY/2chbjunUPZ0cdyusckEvtrCk3qs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPSDdPwQy6TMuS18uIZ1WpwXkB4kt0zKXbwG2DI///Ayvo/wA8o6zvgUChLGb/85a8qfuqEX/aL055n7eRqPcw59t9FJAc24k9SMuFuVb9aG6h4wbVO/JfIJ7v6ZeUkXwC/YBC1wGoouyD3zfH6aTJrkL53EtezGu/GgesdAUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+bk+Bxb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+bk+Bxb"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so2034835a12.0
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732878320; x=1733483120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAJaGQ8pAFs9/TfnTqCprsarIWsj3nF4kgPH7ZcSW18=;
        b=f+bk+BxbcGDzFTp36Uphmlo3Yp3Hz+TZB5rRrDJKwB6Z1TzVu8/7pqPRDczgML5IQT
         7Iqypp+G69gFiMG/GQzHKzi/Uh5JgzPCl/dcg/jQFCePrWFUwtZAYwE2o/i/wIGtV4bF
         uLnb5GGavXLHXhpdXbnRwrCVFegREyHV7HhonnRIISErnY5VcOi/zHoGvLmwp6FtavGA
         FZQ+RgMmNe9140bTDlWvUnfYG8sW1A0CPdtv/0Ccoxhk6OXVWLzjd7JLZk+9x1YDdeGa
         zhYnnpsjLmLN1y4seEzUwlLSI8qXpzueVBQ8dlMYKhoXUc4aUMsBJ4SFtkRhqTCDVOb/
         Eg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732878320; x=1733483120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAJaGQ8pAFs9/TfnTqCprsarIWsj3nF4kgPH7ZcSW18=;
        b=Jy1np9oM7f4pk3B5o6Zlj4tbyS+rxQtxtuEjPa2S7QRA6h4qNYRvQH0SIvgn/GaZO/
         RghF6EP/FgHAjUcOeopK1zdQQDPjWI5MLwAHaa0MSOVBI2tCIvgABxAwIgJtVSrSQKO3
         kuUIr8r/imHcgszkURsP+9G8RZtMH5C3IbNZC3xRIwEyVwax6tBwJ0BGPH6dVQDolCsj
         cX5YrDLL+G/QVm4UK7oRfHu/341tOGIYHhNoZlI40clWDzNpG4yeKmdmhk3JewuhIesH
         0Y/PpxECvNO34XRoMiKlprGhZkNDCzKk/56ALg+0caSfj7dwuMrPY5wXLhnEdmwESuev
         bgtw==
X-Gm-Message-State: AOJu0YxfoqjXQ/bXNVdb49jDwj/zKjKCDLC+w6elDdrXlwEC22x/6Z3W
	GtCTWShnfF+2EGXemR2NvhsZR6sLpiPoGXtHj8e7GBjiRzCXLHfltv11KA==
X-Gm-Gg: ASbGnctsDc9dxfJwa1YtdEaKbj8IQ1J1iVUgBA1qUBsnliEEoBKEp5rwL4QygsMwFDJ
	6BYq9pOsTm6hGNg5tmcup+gBYrALvO80aHl4FyhhrCw+ygasoX/hjyIePVnw2VUDJ3j+pwgmCgA
	YQV+Xpr9ZtU0Z7Ibh6v1SIHAGN0PE83hebnoohFfL0Zo5X1RFcIqL/DkfQVq2UJfzdE3GoZ1U27
	ZQtqtMWOCdnTovU4SUeE09zgzi5Ml1q3Y5zLsfkdUdIEg==
X-Google-Smtp-Source: AGHT+IF0yqr9Kl/LrKHak0RlMgoE+skm6ubRTrcFfjt7SBqXoWT3KrwzWNWt1Y6RzveMh5DkZbEbbA==
X-Received: by 2002:a05:6a20:4327:b0:1d9:761:8ad8 with SMTP id adf61e73a8af0-1e0ec8a13damr11795581637.21.1732878319936;
        Fri, 29 Nov 2024 03:05:19 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c304fe2sm2856452a12.33.2024.11.29.03.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 03:05:19 -0800 (PST)
Date: Fri, 29 Nov 2024 19:05:38 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <Z0mgAt9ssu_32tTQ@ArchLinux>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>

On Fri, Nov 29, 2024 at 02:44:24AM +0000, Caleb White wrote:
> The `es/worktree-repair-copied` topic added support for repairing a
> worktree from a copy scenario. I noted[1,2] that the topic added the
> ability for a repository to "take over" a worktree from another
> repository if the worktree_id matched a worktree inside the current
> repository which can happen if two repositories use the same worktree name.
> 

I somehow understand why we need to append a hash or a random number
into the current "id" field of the "struct worktree *". But I don't see
a _strong_ reason.

I think we need to figure out the following things:

    1. In what situation, there is a possibility that the user will
    repair the worktree from another repository.
    2. Why we need to hash to make sure the worktree is unique? From the
    expression, my intuitive way is that we need to distinguish whether
    the repository is the same.

> This series teaches Git to create worktrees with a unique suffix so
> that the worktree_id is unique across all repositories even if they have
> the same name. For example creating a worktree `develop` would look like:
> 
>     foo/
>     ├── .git/worktrees/develop-5445874156/
>     └── develop/
>     bar/
>     ├── .git/worktrees/develop-1549518426/
>     └── develop/
> 
> The actual worktree directory name is still `develop`, but the
> worktree_id is unique and prevents the "take over" scenario. The suffix
> is given by the `git_rand()` function, but I'm open to suggestions if
> there's a better random or hashing function to use.
> 

The actual worktree directory name is unchanged. But we have changed the
"worktree->id" and the git filesystem. Now, we will encounter much
trouble. The main reason is that we make the worktree name and worktree
id inconsistent. There are many tools which assume that worktree id is
the worktree name. In other words, there is no difference between the
worktree id and worktree name at current.

Let me give you an example.

The user could use "git update-ref" to update a ref from another ref.
So, a situation is that the user want to update(create) the
main-worktree ref from linked-worktree ref.

    ```sh
    git init repo && cd repo
    git commit --allow-empty -m initial
    git branch branch-1
    git worktree add ./worktree-1 branch-1
    (cd worktree-1 && git update-ref refs/worktree/branch-2 HEAD)
    ```
By the above operations, we will create a worktree-specified ref under
the ".git/worktrees/<worktree_id>/refs/worktree".

What if we want to this in the main worktree:

    ```sh
    git update-ref refs/heads/branch-3 \
        worktrees/worktree-1/refs/worktree/branch-2
    ```

So, with this patch, we make worktree-id not the same as worktree name.
If we do this. "git update-ref" cannot find the
".git/worktrees/worktree-1/refs/worktree/branch-2". This is because the
filesystem is changed to ".git/worktrees/worktree-1-<hash>/...".

If we use hash / random number to distinguish. We also need to change
the ref-related code to ignore the "-<hash>". It's impossible to let the
user type the extra hash / random number. However, this requires a lot
of effort.

So, I think we need a _strong_ reason to indicate that we must append
some chars into worktree id to do this.

Thanks,
Jialuo
