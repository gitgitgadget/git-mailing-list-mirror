Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA47172B
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154406; cv=none; b=RaJ5ZHaDQ9uoVBwLNA/7h2l0IVtSsYWqXPJsQfVtNdB1IgOsMte8mEihVMHChnTXBuaja3xkvZTY1Q0roXN1u9CE2EbOfJ+El1g67vM2dcLcxs/KFigmJAiF53vQ0AC61GY0JRtQTaQnYpfoB4AMNeJ7Avy1/IeL6Rauo5ozpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154406; c=relaxed/simple;
	bh=Fp3fLHNdY/cXkiuwtS1+QgNv7I/lrl708yA+P+r7pk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnvROEo6UPFkmzo/BtGkrlXuG0+YPWyhiAaN+hai7iqAECakRV+vtNtICUUU5IwNb2+A7l4jEZ8uzd66rTaONCaKBN+7I8JvkEgR/T5+ZXFIpJe2aeQ9NGg8EXa7a9XfnH8WgdXaIXH3h3b7qAiDPaZhZlGKN8P6rFTliqZ5f4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktQbroAr; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktQbroAr"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222a9eae9a7so3705641fac.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712154404; x=1712759204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ces6jawGhNfQxP+/lxNE5bMMOCIJee0OGkyEuzPutIQ=;
        b=ktQbroArK3lodpo/X1Kku3jNAAhTHmfqr2XW8HSCZ1NeQzSD5vn0QNZvzd//ZdRKqV
         vmQHLvxkkAfdi2lDzYxAknQn0t7YIlPVucG/iA/6pPPjcjPBBTxFpDj0n9GujznX1Iuk
         Vq89uqwOrTTks/LMFlXcAJXxs2ezllvQmL4yAqVODk4sj4qmPoLKoRU2nqvkAclN6Ogc
         MZ697mNI5FHhbia3sC5g3VdwqH2VbXld8U+jG/sy0Ho5dWh1hWLiDaEegMBYeZrTMYSD
         /4xs8de5yxW3zs24EH3GyodYDmZQeeCX1PCkxxTmdsg+jjlfUkVcV8h/tuYLL5gQOyoJ
         coPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154404; x=1712759204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ces6jawGhNfQxP+/lxNE5bMMOCIJee0OGkyEuzPutIQ=;
        b=b1/P1R0CmhSl7OBP9BuIaep/O+ou8IFi9jcTK/P+qiRCLISSr27ASu05M5BNB1rCxv
         PSDdTV8JRbUMihi0aKX4xzWSgL24AwyYpWEOPqPKxcaBRlCMdjZm6NKu+xZYkPYlqvYO
         q4qmSXv842pp6T+jSc4J6foVXyDu05mI7HK/nHi8QfHRZx8jPIPKWsHzBQPWlKtTNu+W
         088Rn+H2qOFeTN6FRBO29xivSyXHKX0jr8wThLc8s6Rp7FgO5hIxmnsS3x+JRU6PLhu7
         uEjVwbBFM8irMxKjAtfmXnA/c4Z4kZ9wUWGCx38bWT/E3sF6TFSnvMUzOS8cvP/SMb+l
         hOOA==
X-Gm-Message-State: AOJu0Yx7RY95RdHNyVM4+vdrjLG/nZIltQcoG+XiJTEwDYvf9m+55Psa
	QKXuk/NqPugVFooUviWEeRS3L8Csm/3PI5anCHQ6Cy3oGZOJvFKpNXi/UVU/MfLYb4NnM/3OZ50
	kOobCqy2edXHRgpzipOfCa2VTncj441Ba1i8=
X-Google-Smtp-Source: AGHT+IGvqkxsXDfqMS2thyNE4N0r9OekphBcqjhRXuMfVYqmP0AwsM2cJF2TasGc/U07SJzFqh3KPOj6bdvUEMnE7Fk=
X-Received: by 2002:a05:6871:a117:b0:229:f445:d6b3 with SMTP id
 vs23-20020a056871a11700b00229f445d6b3mr19087320oab.5.1712154404042; Wed, 03
 Apr 2024 07:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
 <0f65aae3-15a1-456d-8285-7923a880deea@app.fastmail.com>
In-Reply-To: <0f65aae3-15a1-456d-8285-7923a880deea@app.fastmail.com>
From: Bill Wallace <wayfarer3130@gmail.com>
Date: Wed, 3 Apr 2024 10:26:34 -0400
Message-ID: <CA+2m0i_zGcFBd2+L_Q_foMQ=eJbXqUZGqDeOwfefg=Y4GMBRWw@mail.gmail.com>
Subject: Re: Worktree shares a common remote with main checkout
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The problem is that one wants different default remotes for different
worktrees - for example, suppose I'm creating a worktree for two
different projects, plus the base repository is on the "origin"
default remote.  I then have:
base_repository - a directory with the base/default origin (call it
'origin' for now as the remote name)
project1 - currently checked out with 'feat/1'
project2 - current checkout out with 'feat/2'

Now, project1 is being developed against a remote repository
'project1-origin' and project2 is being developed against a remote
repository 'project2-origin'
However, both are getting merges from origin/main on their own
projectX-origin/main branches

Now, when I'm the directory for project1 and I do any of:
   git fetch
   git checkout X
   git push

I want the correct default to be chosen for the remote - for the
base_repository that should be 'origin', while for project1 it should
be 'project1-origin' etc.
I KNOW I can specify those manually, and git push will give a
suggestion, but I WANT all of them to default to the correct remote
associated with that worktree so that I don't accidentally pick the
wrong one or forget to update the correct repository.  This is to fix
dumb fingers that sometimes do the wrong thing without thinking, and
to try to reduce the number of things that don't get done
accidentally.

What I'm doing now is to create a new non-worktree version against the
projects directories, but that then doesn't share any data.

git remote add ... has nothing to do with this, but I want something like:

git worktree add project1 --default-remote project1-origin

The idea is to make the expectations of what happens to be consistent
with cloning a new directory, or at least as close as possible to
that.

Bill.

On Fri, 22 Mar 2024 at 13:29, Kristoffer Haugsbakk <code@khaugsbakk.name> w=
rote:
>
> On Fri, Mar 22, 2024, at 15:50, Bill Wallace wrote:
> > This issue is just to fix an easy to make mistake when working with
> > multiple remote origins and worktrees, where it is too easy to push to
> > the wrong remote origin because one can't set the default origin on a
> > per-worktree basis.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > Used
> > * git worktree to create a worktree
> > * git remote add to add a custom repository
> > * git commit/push to try to push changes
> >
> > What did you expect to happen? (Expected behavior)
> > Expected to have the git push recommend a remote origin that matched
> > the worktree, but it defaults to 'origin' all
> > the time, which means I need to checkout a clean clone from the
> > specific origin I'm making changes for so that I don't accidentally
> > push to the default origin.
> >
> > What happened instead? (Actual behavior)
> > Suggests 'origin' as the default origin - which is CORRECT for the
> > main git branch, but I want to use worktrees to allow working against
> > several remote origins, with the default being determined by which
> > worktree I'm in.
> >
> > What's different between what you expected and what actually happened?
> > Suggested 'origin' for the --set-default rather than allowing me to
> > define the origin I want, for example 'wayfarer' as teh name of my own
> > remote that I have cloned on github.  The default origin is still
> > supposed to be 'origin' for pulls/naming, but when I push, it needs to
> > recommend the matching origin.
> >
> > Anything else you want to add:
> > This is a bit of feature request, but the reason I'm listing it as a
> > bug is it makes it very easy to make a mistake by pushing to the wrong
> > origin for a new branch.
>
> I don=E2=80=99t understand the expectation. git-worktree(1) just gives yo=
u a new
> worktree to work on a branch, do a bisect, maybe a rebase and so on. I
> expect `git remote add <remote>` to have nothing to do with the current
> worktree that I am in. A remote ref is for the repository, not
> per-worktree.
>
> If you are creating a local branch based on this so-called
> worktree-specific remote and this branch exists on this remote (and
> *only* on that one) then you can use `git worktree --add --guess-remote`
> to automatically track the remote branch.
