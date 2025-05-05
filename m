Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51936D17
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434574; cv=none; b=BX7y/UBUUrIVfQKueVhFFtHHCjbnMbgdyA1JKtlDQnrH0/k/dKAuNwoK+DhdNcIx6FeE+m5VK7IxKWq7rYxFWqsb9c44DDiKO5FUay5z6pe4L5m2ls4LDzxeGxAGLqe08nkSjWtAUmI/akke+ns5pgQg251ESvU4OTu8WhFjcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434574; c=relaxed/simple;
	bh=vRfMdyOe3rDUJdpchLZIBnG4fNzQAslTzsvdgOGniyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dagf6LIuVgmcwNejlrsoEYKjogXN5Pxr2QxQbTM21zLeR8SMMEMh4DilKBt2ynRfQoQ6Sxyl0uOyRQarm9gryAhg3hvIEPCGyxkffT7bqmYVrsJfdbVaWu2nGa123XzpeYDX4lULy124f/uzK9ajeZxfs1zuG6owZQgA/Lo/U7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f9c5b09dso4346826d6.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 01:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746434571; x=1747039371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyEe4VcE5wHUZxKNi6Pmblg/SF0hFdMCYKUo4xEQSWA=;
        b=Xph6AB6I8whYF/unjUmCMZrviC1XJ4wH6TkrXNyfhyAY9s5d92JIqeFetXd1nZuKIx
         aBHR3DxHX8bGEGeoFBOVhqQJ+em2EzzjXvVvIW8m0Ob2OHtLAKHc4W/4aDOhbfrL6WH1
         rlygauiHM0Tu3Pbti/ULMNcsPT6SJ+DTiZJezoPM6KiOUiXBuJh3PQPqOVOETzJa9jVx
         aIj+cE/E+9uLIvE74FhUpkz0DfK0ulVzjBs9UR3lin0kI7QVAanWBRnIIoWMYqrQdVMZ
         4Jg2vDBDnrs+bD7RRlZq/mmcUV5miF4NEwMV/g+HqHXYvB0QqSYmr+myHDHCFBVJ/krI
         3C6g==
X-Gm-Message-State: AOJu0YxxEsaDVCzspz4zbmIKWvrmOFh8DupMN/FSGnDAdEkM3q3tsfSx
	9sMyIZb6pyZU9XIVNvVh2zrHqdZEx9e/lxLrSJS/t6rHCH7TKuje7IeA6dyMerM14QNf3+7gKma
	qNmRvO8DJ4+8+t9Ck+6XklKzCSaM=
X-Gm-Gg: ASbGncvVWTpDcd8Uey2yVcLXqezm074QHkQWOQidNIkpIkudlxgj4VhzVwzcDR5boo1
	nxkbt6DkO/nbfPySllAqi8VohA9u91JjgbxWG9kDNHQSAuscnkVo5EVaUizhzGhdsbQDp5WsQeI
	rT8uy3ipa/PXe6I9ag6c9A3lFgw9BDKwbPHylHG8cY6qZC7qsT9dGL0N3AkPHrA9NQ7A==
X-Google-Smtp-Source: AGHT+IG6f9TRRnLmJeey3j6ZIGyzXHsMK7kKPCYYj6f6vmnap95/eC46XD8u1Ma/MAKCFSj/y1hP0aQ91nKalgNb+VI=
X-Received: by 2002:ad4:5aac:0:b0:6e4:449c:ab1d with SMTP id
 6a1803df08f44-6f515256a50mr74270526d6.2.1746434571488; Mon, 05 May 2025
 01:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im> <20250502-pks-maintenance-missing-tasks-v3-4-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-4-13e130d36640@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 May 2025 04:42:40 -0400
X-Gm-Features: ATxdqUE1bzfl4Q8PFrQX7H7fQOeLIADD4nUyfhEZKa46683V4i4QCyOMSdrnIyQ
Message-ID: <CAPig+cSDDbhGrym8j=PFKBCUxBQhZPzAHXGvKy-Z6POA4Ju3sw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] worktree: expose function to retrieve worktree names
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 4:44=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Introduce a function that retrieves worktree names as present in
> ".git/worktrees". This function will be used in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

I'm not convinced that this patch or the get_worktree_names() function
which it adds to worktree.[hc] adds value. Aside from the mere act of
consulting the directory at repo_git_path(r, "worktrees"), there is
nothing about the function at all related to worktrees. It doesn't
make any guarantees, such as only returning entries which at least
superficially look like worktree-metadata directories, or perform any
sort of validation. I don't see how this is any better than the caller
just implementing its own bog-standard opendir() / readdir()-loop /
closedir() over repo_git_path(r, "worktrees"). Or, if you don't want
the caller to implement its own readdir()-loop, I wouldn't be
surprised if we already have a function which does exactly this for a
provided path, though I haven't checked. If there isn't such a generic
function, perhaps it makes more sense to add one and call it with
repo_git_path(r, "worktrees") as its input?

> diff --git a/worktree.c b/worktree.c
> @@ -988,6 +988,36 @@ int should_prune_worktree(const char *id, struct str=
buf *reason, char **wtpath,
> +int get_worktree_names(struct repository *repo, struct strvec *out)
> +{
> +       worktrees_dir =3D repo_git_path(repo, "worktrees");
> +       dir =3D opendir(worktrees_dir);
> +       if (!dir) {
> +               if (errno =3D=3D ENOENT) {
> +                       ret =3D 0;
> +                       goto out;
> +               }
> +
> +               ret =3D -1;
> +               goto out;
> +       }
> +
> +       while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL)
> +               strvec_push(out, d->d_name);
> +
> +       ret =3D 0;
> +out:
> +       if (dir)
> +               closedir(dir);
> +       free(worktrees_dir);
> +       return ret;
> +}

It's subjective, but although we often recommend the `goto` approach
on this project to ensure proper cleanup, the above seems to place an
unnecessarily high cognitive load on the reader. I would think that
the following straightforward `goto`-free approach would suffice:

    worktrees_dir =3D repo_git_path(repo, "worktrees");
    dir =3D opendir(worktrees_dir);
    FREE_AND_NULL(worktrees_dir);
    if (!dir)
        return errno =3D=3D ENOENT ? 0 : -1;
    while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL)
        strvec_push(out, d->d_name);
    closedir(dir);
    return 0

> diff --git a/worktree.h b/worktree.h
> @@ -38,6 +38,14 @@ struct worktree **get_worktrees(void);
> +/*
> + * Retrieve all worktree names. Not all names may correspond to a fully
> + * functional worktree. Returns 0 on success, a negative error code on f=
ailure.
> + * Calling the function on a repository that doesn't have any worktrees =
is not
> + * considered an error.
> + */
> +int get_worktree_names(struct repository *repo, struct strvec *out);

As I was reading through the patch, I was worried that you might have
overlooked the fact that the names returned by the function might not
be fully functional worktrees or that the caller of this function
might not realize that, so I'm glad to see that you documented this
potential downside.

In fact, there is no guarantee that the returned entries are even
directories; they could be anything that someone happened to create in
the .git/worktrees directory, such as plain files, special files, etc.
So, aside from the objections I wrote above, the term "names" here is
potentially unclear and misleading, as used both in the documentation
and the function name itself, and the fact that I can't come up with a
better term further leads me to believe that this is not a function we
really want to be publishing.
