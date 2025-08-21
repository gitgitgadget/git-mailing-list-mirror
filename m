Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537C393DF2
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818529; cv=none; b=ZvI2tt9dJdmsqI+Rn8rs+It28t7aAaSFHKI+stawTJh5pjmL1KpdXPWpIUDArN19qeJrreB25+C3mNxLGla0q1Sm+j3r/fV8UWQnQNeG4RkRzjfJpJ226IErC3yyXTvXzpzFQX2nkBcUNMO4vIs/wFCipQl7KojjSdKJbL1HXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818529; c=relaxed/simple;
	bh=bbjVHEf1cpo8m00X6J8llBd2l5pZzP1IDwOflTgf1+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcIiKrCPfMdnes9LLeU+Q4Mqadff2T34/Rt8UJICxokrK2HQyeuZB2VPRd6tZ829JCtzb/IGN43FWGazsxmyEuQiarB4/QPl9yvQmb1cwk8gw1Vmjb7uTvL7gs/UUlJRr9vNCy2js8xXeL8g/i7cpfqgA2sf4Myy7DIxx7PU/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPSn/40C; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPSn/40C"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e66c013e4dso7941755ab.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818527; x=1756423327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A14zFLD9og1S6p6Ch0+7B5xMrPiFL3vZo57Et5tJfE=;
        b=CPSn/40C13V7/tWWT4wbxg6olXcZ9FUUgPEipTH98hS+mnbBqBZ7/pgtRwlyawuYYy
         hR5qiAOUHm32c/3aLapDMTob8q/zn2TjpyLD6tdxHMt6iZLNXXfFi35Q0Kudt9qoOfeT
         7lxgqmN0ZksFl4OeVFWHgvGANqtwMZ0tYqbkpFI8GWuAdLmvmz9tiVL140sp73p2vu67
         J+VwJBQEQp+dENrL1+lCjC8/QKXyUMTmFGBhmXJXlhhDrxyhzf1ZWkgejAsheZIZvh+q
         XqfTp5IHlnudKGIgwysSHxz1JATQGW3Sykxs4pfNJiGU6Pc5k94E6gw2bCt+DOPkdPdu
         mUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818527; x=1756423327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A14zFLD9og1S6p6Ch0+7B5xMrPiFL3vZo57Et5tJfE=;
        b=VZs45v+2jSA1zNTYmP1qCqA30mlJARhjNMnidx955qBk7fAjtoTyV/7y4uxUU+Mi++
         qgHdr1lGiil0nz/onqn3ybExR4PFeerD5tXha9IGvFthzyWoHQaRpTLJULoVlN3N9bbI
         c4wHqGlaZUGkxNF8uHUS1eLz1qkyQZMmed5nFWK5Py0CSbPxi94+hHB5c29NuGszHZYI
         8HSwWQXLSgidQhstfayoliKb75bPX270oeMDIZ/1e1wXDdEzb8SpWV1ACODyul4beHO5
         Ddv8JW1FSHFpw5qBlv91t94PBBPBUGdTp/v0wp752U9X7QwcyGTUVqITkfSRpC+zdJPe
         w/3Q==
X-Gm-Message-State: AOJu0YzvEMmHd8vEYdVJox67bQMdxRp2ifc3C3miLIiEZO6wAsHgGmRZ
	4XDeUxuE2NgMY6Up/KJ2Qm2ng7R+u3o7b0dhM3+RJHG58RLJ6kHnWjMHrO+/tyZAGKkfJbbHzOM
	zon4ShE0EJ6If9isfVdjmTumcEZHO+aU=
X-Gm-Gg: ASbGncvDWbZJ4UJILDCTJveszhpazOvM2hpHFYV4Mz42nJhVYFMbbxvVDda+hv0n5qb
	wMc0YhBRYYSgIMxy/UmHE7Yq67YaeRUBXp1+ipYPyZof2lnybMUWJ4Wfi8TpouxC+RqXjmwxAAA
	bO8KW/2PXRyTXbr/o16XNyIVX2TX2g2fFJpXQbzGveIC1na84HeYDgv1OSE9YO2IZQolIGIBI1F
	5tKH+T+pQBGuiEo5yXXTR6mrq9siKtOYpIdgJWI
X-Google-Smtp-Source: AGHT+IHPBGaCZU1uZVHrBPNyyO1xeurU1A1rEU+xGBmFep/ie7ogQT8WteIa80RI7Q9P5afNEqXSvLZmFBzreSJ1+pw=
X-Received: by 2002:a05:6e02:3991:b0:3de:e74:be13 with SMTP id
 e9e14a558f8ab-3e6d0827bafmr85105085ab.0.1755818526783; Thu, 21 Aug 2025
 16:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com> <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
In-Reply-To: <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 21 Aug 2025 16:21:55 -0700
X-Gm-Features: Ac12FXzF0ysSbWUcr9A5fKE3Xz8TtwfO0BQVIWQ-pI7IUfR9IdVc1d-77tIlO74
Message-ID: <CABPp-BFtfofyrJYbfp0fDTTprZZtwaH_EbPkppNEq-hgRqmwhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, 
	peff@peff.net, ps@pks.im, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:40=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The previous change established a buggy instance of 'git repack -adf
> --path-walk' when there exist paths that are tracked in the index and
> that is the only instance of those paths in the history of the
> repository. This change fixes that bug.
>
> The core problem here is that the "maybe_interesting" member of 'struct
> type_and_oid_list' is not initialized to '1'. This member was added in
> 6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
> 2024-12-20) in a way to help when creating packfiles for a small commit
> range using the sparse path algorithm (enabled by pack.useSparse=3Dtrue).
>
> The idea here is that the list is marked as "maybe_interesting" if an
> object is added that does not have the UNINITERSTING flag on it. Later,
> this is checked again in case all objects in the list were marked
> UNINTERESTING after that point in time. In this case, the algorithm
> skips the list as there is no reason to visit it.
>
> This leads to the problem where the "maybe_interesting" member was not
> appropriately initialized when the list is created from pending objects.
> This is the fix for now.

What is the fix for now?  I think I can deduce it from the above
paragraphs, but then either this sentence is unnecessary or it's just
confusing.  Perhaps change the last sentence to "Initialize it to fix
this problem." or something along those lines?

> To help avoid this from happening in the future, a follow-up change will

I appreciate the future-proofing, which I think you are alluding to,
but to me, "To help avoid this..." suggests your change might not
(fully?) fix the bug you are discussing.  Perhaps you mean "To help
avoid similar problems..." or "A follow-up change will add some
future-proofing to prevent similar problems by..."?  Or maybe I'm just
reading your sentence weird...

> make initializing lists use a shared method instead of allowing for an
> update to this initialization process to miss some existing copies.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  path-walk.c       | 2 ++
>  t/t7700-repack.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/path-walk.c b/path-walk.c
> index 2d4ddbadd50f..1215ed398f4f 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -385,6 +385,7 @@ static int setup_pending_objects(struct path_walk_inf=
o *info,
>                                         list->type =3D OBJ_TREE;
>                                         strmap_put(&ctx->paths_to_lists, =
path, list);
>                                 }
> +                               list->maybe_interesting =3D 1;
>                                 oid_array_append(&list->oids, &obj->oid);
>                                 free(path);
>                         } else {
> @@ -404,6 +405,7 @@ static int setup_pending_objects(struct path_walk_inf=
o *info,
>                                         list->type =3D OBJ_BLOB;
>                                         strmap_put(&ctx->paths_to_lists, =
path, list);
>                                 }
> +                               list->maybe_interesting =3D 1;
>                                 oid_array_append(&list->oids, &obj->oid);
>                         } else {
>                                 /* assume a root tree, such as a lightwei=
ght tag. */
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 1998d9bf291c..030e9e5b2dc7 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -838,7 +838,7 @@ test_expect_success '-n overrides repack.updateServer=
Info=3Dtrue' '
>         test_server_info_missing
>  '
>
> -test_expect_failure 'pending objects are repacked appropriately' '
> +test_expect_success 'pending objects are repacked appropriately' '
>         git init pending &&
>
>         (
> --
> gitgitgadget

Patch looks good.
