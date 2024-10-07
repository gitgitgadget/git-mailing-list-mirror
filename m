Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2295338D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314285; cv=none; b=PGa7K5P9UZMGcIBBLEzAyeZlJzCJ3rFBagkI9EKVa55toc2wKdD1pntaTMjnELD7kHAw7DrZMtqAUneLiRGyxz4VFBhnfE3cI7gf2AWdndxLklebauZU9WdG6x7wAzHge5Ot8FEkBoUFgKldUGewNpHqAswhZEIM5TmNwKDMziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314285; c=relaxed/simple;
	bh=E9f018Ug0FjuJGGRjIuUc1OaQuCq3hezSrSq000GF7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S31kraMlmFUBipmMUUuFoKqbP1PU9xXyBPhujqnV2kFRGcBVlPhdNaFjOueaq+kmrmI+FpkV6OZbbgtoSS7E7ifzp7yZ+OBYa+yzgTtPEV+azIfLJUQFwGVi2Od53a8wfgW32bECRAkUZOiNxeXdCQGP36uuPuGhh3F5XrF2ysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYhogunI; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYhogunI"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cf3286261so172410439f.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314283; x=1728919083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXemFt8PweX6nIVPNvnGn8BA0FfluDGOpRGiCFg06yU=;
        b=cYhogunIEw6gPV2qZGsWlq2/TtC4WXe1NuhmeQ4xNPjdQmF5SfbaUrxOr8wkrHjS8f
         ogTToCOZOPnivL2Kny3yhu1FasP6w8oxrsLFNgqNfViw9hLJ92H1h8L1ia53bqASFNyr
         43WRZWos1+He6PbhScqG2HpbDoPTqVdkG/u3znFCgGY4EED+6EO0lF46jyST85KB34Jk
         I0gWqB2r7rOk3LwT06Qz+WRuU+9Yc8YkQx1UF3hksNE1rMD+0zVshqK/CWBvziZNUaB7
         9E4bQoXdBndvBoRqqGU2VqbRn6JYpj4O1Mo9LS3H4LlYJ6/g2h+vboQUr3kMaFc9OgBh
         GUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314283; x=1728919083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXemFt8PweX6nIVPNvnGn8BA0FfluDGOpRGiCFg06yU=;
        b=rdBbY1zkHZ3KM0qR5A5W7xK2IIyAWVG3FGhoSqIh2+XLkc3H4P56KFBbKPYrc9ZDLc
         IwJxUPb/sb8MdKaLVHhAyi26mdmVJcfb4flDXVYCedmMRXBZ+eBxE0Jm+hgWBqc/4mse
         0H0DtpNz1PG1VpG8SdfWdUntwAJxzz5cwkwdJvSbD3wOQnIWKQeOFx2frSAr+fTz2gx6
         ubYFBv2wzPvqqE6Uj1eX8UIoZY8K0bmwp6joOT29ESzUKIqmRX/jwit4oUpdJIsecOkk
         L27Aj9oqx3K1x1W5Hi2LKsiY02gQ5u931OeTGbdf1D6jTeuvc59dsDndUp1+WG404V0f
         xRQA==
X-Gm-Message-State: AOJu0YzsbXT+XYuowPgBKqPNu+f8AnekEGTwgF6dmeFo5tf3ZDyCx+hd
	zLcqAciRVEE9b4Tlc42u6TIF6AzCm2Nb2yCL7mTi9FabGtS10TYJiX6Q1MFH1ETZLIiinjrm6g+
	BqxToZOTEgnVP/G2mHDbhp6WI24A=
X-Google-Smtp-Source: AGHT+IEb5DTNt7FdXlhFLhaL7Jn8HmMbS6ZQu0AbgFOA0fl41kWcc21b2H7IQAqvhqQp5R5C1sMiSSI8Y4vFo54o/BM=
X-Received: by 2002:a05:6602:2c0a:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-834f7c73cb6mr1331127839f.3.1728314283008; Mon, 07 Oct 2024
 08:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728298931.git.code@khaugsbakk.name> <fef203471f4492af1468a0c91088324c394effd5.1728298931.git.code@khaugsbakk.name>
In-Reply-To: <fef203471f4492af1468a0c91088324c394effd5.1728298931.git.code@khaugsbakk.name>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 7 Oct 2024 08:17:51 -0700
Message-ID: <CABPp-BHoYSmxCDDXhC8MGxGV+wzaNc96Fbv60JAbhgX9O_x7oQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: merge-tree: provide a commit message
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:11=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Provide a commit message in the example command.
>
> The command will hang since it is waiting for a commit message on
> stdin.  Which is usable but not straightforward enough since this is
> example code.

This is fine, but...

>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Unlike on some other manuals you probably won=E2=80=99t end up runnin=
g these
>     commands directly to test things out.  But you might end up copying a=
nd
>     modifying it when playing around with the command.
>
>  Documentation/git-merge-tree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 84cb2edf6d0..590cbf5df79 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -213,7 +213,7 @@ used as a part of a series of steps such as:
>
>         NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>         test $? -eq 0 || die "There were conflicts..."
> -       NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> +       NEWCOMMIT=3D$(git commit-tree $NEWTREE -mMerge -p $BRANCH1 -p $BR=
ANCH2)

...perhaps this can be -F ${FILE_WITH_COMMIT_MESSAGE} ?  I personally
have a problem with writing example code that models horrible commit
messages; I'd rather give them an example that hangs waiting on stdin
than do that.

>         git update-ref $BRANCH1 $NEWCOMMIT
>
>  Note that when the exit status is non-zero, `NEWTREE` in this sequence
> --
> 2.46.1.641.g54e7913fcb6
