Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AB3B291
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5UUvJOM"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65349DA
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 12:11:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b96095abso3202251e87.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699647113; x=1700251913; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs9BoFABgSymqo4NGVvwq4tLzEmRY0ZqsUnbaS5Hl58=;
        b=A5UUvJOMkHPcmGFcf0ZnJOGOpN0mAU93E5EMDYk6E4xXwnnpn/qCzXQExwfhNorHzr
         IcP4ayV6OezWm697DvLXIlGq6TVO5kmBicony2znC6wSFUxjFk/yN8OfJCdfHgUrbB/2
         aV+5TZFoeHQQ11oPEyBizIS7BQfE5v2eL5w9IMmED9JseyZkPnwfwnL2yKXm4SU8h6o4
         W+4sbayQLVrO7TpFfd4qCk+kMt1UFI5t8TJiZrL1pmJEUm1nFcwka4NIoGwAYUNhH7PA
         kG19VV2YfGJxwZVn9x8mylalJmLFSEt8bHXHj7ctBjkdHlz8iHXNfdaj3QFQQ0cLo8ww
         amGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647113; x=1700251913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs9BoFABgSymqo4NGVvwq4tLzEmRY0ZqsUnbaS5Hl58=;
        b=em8HbUH+x0EJqnJFiSIipSCaogFzRoBjQJ+6fbUrZZZSEmLzL+Qce7PPzpwFIYKy97
         Ab5GeX9WbGoNjDwDLPUYi3fm9s+wmEvfRXwRSsArlzQQZ8MvlHfoeDtYlusYh7rkm+XC
         HEnGFTgq9T5KG07SEvTbsfCqMdlqYcGEklzqYJmbFlLdJmkyzedkvwRlQg0zzWjOpa5W
         vxnbSSwUy1HHDA22td8a5cUgXAycsf3L0urRetlHw/xWqe2/9GhMdlDJ1OepOFZHI8Yq
         ky5rBO2GntgSzDH1VDyYr65TyQGaX9AvpGPCO8SFlpG5CZGotHjDZcmMyGgQdAejNmH7
         kR2Q==
X-Gm-Message-State: AOJu0Yy0zAjb6nYwezpJwWNzRLfBmcIEASXPTlUoTlEO41u5yBiM+lej
	hIjVwEmZbYSUfJVCcvjF6CUjxYwhNwYpdQteMoJ4o7kZ1lk=
X-Google-Smtp-Source: AGHT+IE2tTK78ruNLToKdBNqMxSo+vePEuD8YfSswwK+C5eInkblIj0ZKG2YVF4xLEeOiVrUnzK4oYmgyjzgmX7IFLc=
X-Received: by 2002:a05:6512:1153:b0:504:7cc6:1ad7 with SMTP id
 m19-20020a056512115300b005047cc61ad7mr173954lfg.1.1699647112461; Fri, 10 Nov
 2023 12:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107130303.GS7041@raven.inka.de> <CABPp-BEAU8rPeNHphut0ZxcLdH0pzjh+Z_CF+rg2uhvVZoZfxg@mail.gmail.com>
 <20231108113636.GT7041@raven.inka.de>
In-Reply-To: <20231108113636.GT7041@raven.inka.de>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 12:11:40 -0800
Message-ID: <CABPp-BGRycdj5Z_YzPLvQ1CqBdz5Px797gHD6P8sf8mNfxghrQ@mail.gmail.com>
Subject: Re: Error when "git mv" file in a sparsed checkout
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 8, 2023 at 3:38=E2=80=AFAM Josef Wolf <jw@raven.inka.de> wrote:
>
> Thanks for the reply, Elijah!
>
[...]
> > > Error message suggests, there already exists a file named "new-filena=
me". This
> > > is not true at all. There is no file named "new-filename" in the enti=
re
> > > repository. Not in any directory of any branch.
> >
> > You are correct; the wording of the error message here is suboptimal
> > and seems to have been focused more on the git-add case (the error
> > message is shared by git-add, git-mv, and git-rm).  Thanks for
> > pointing it out!  We could improve that wording, perhaps with
> > something like:
> >
> >     The following paths and/or pathspecs match paths that are
> >     outside of your sparse-checkout definition, so will not be
> >     updated:
> >
> > Which is still slightly slanted towards git-add and git-rm cases, but
> > I hope it works better than the current message.  Thoughts?
>
> Yes, the wording was pretty much confusing me, since i could not find a f=
ile
> named "new-file" anywhere in the repo.
>
>
> There are more things confusing concerning sparse mode:

Sweet, thanks for taking the time to write these up.  It certainly
helps confirm some of the directions we picked and changes we made to
make things a little clearer, and helps us continue working in that
direction.  Some comments below on individual points...

> - It is not clear from git-sparse-checkout(1) when changes to
>   $GIT_DIR/info/sparse-checkout are catched up. In my case: would it be e=
nough
>   to add the new pathname just before git-mv or would a fresh git-checkou=
t be
>   needed after modifying $GIT_DIR/info/sparse-checkout? You have clarifie=
d
>   this in your response, but shouldn't this be clear from the manpage?

I believe at least part of this confusion is due to using the old
style of handling sparse checkouts; namely, by actually editing
$GIT_DIR/info/sparse-checkout.  We have taken pains to guide people
away from that workflow, because it is both more work, and leads to
more confusion.  If you instead do a
   git sparse-checkout set --no-cone <pattern1> <pattern2> ... <patternN>
or a
   git sparse-checkout add <another-pattern>
then the sparse-checkout command handles populating the
$GIT_DIR/info/sparse-checkout for you as well as any needed checkout,
meaning that there isn't a "catch up" step as there traditionally was.
And it makes it a bit clearer that if you add some path to your
sparse-checkout, then your sparse-checkout is ready to handle the
additional path right away.

> - git-sparse-checkout(1) refers to "skip-worktree bit". This concept is
>   potentially not very familiar to the average git user which uses mostly
>   porcelain. Thus, edge cases remain to be unclear.

I totally agree that the "skip-worktree bit" is something we should
avoid exposing to the user.  I called it out previously:
"""
Most sparse checkout users are unaware of this implementation
detail, and the term should generally be avoided in user-facing
descriptions and command flags.  Unfortunately, prior to the
`sparse-checkout` subcommand this low-level detail was exposed,
and as of time of writing, is still exposed in various places.
"""

However, we should also note that you reported using v2.34.1, which is
really quite old.  The current git-sparse-checkout(1) has been almost
completely overhauled in the meantime:

$ git show v2.34.1:Documentation/git-sparse-checkout.txt | wc -l
263
$ git diff --stat v2.34.1 v2.43.0-rc1 -- Documentation/git-sparse-checkout.=
txt
 Documentation/git-sparse-checkout.txt | 446 +++++++++++++++++++++++++-----=
----
 1 file changed, 333 insertions(+), 113 deletions(-)

And, in particular, "skip-worktree" doesn't appear until quite a bit
later in the file, and then only appears in a section labelled
"INTERNALS -- SPARSE CHECKOUT".

> - The pathspecs refers to .gitignore (which by itself is not very clear).=
 But
>   there are differences:
>   1. giignore is relative to containing directoy, which don't seem to mak=
e
>      much sense for sparse mode
>   2. sparse specs are the opposite of gitignore, which seems to have diff=
erent
>      meaning in some edge-cases.

Yeah, copying .gitignore syntax and merely referring to the gitignore
manual for specification of the patterns was a huge design mistake.
I've hated it since the beginning.  The internals actually managed to
make it *even more* confusing for quite some time as it referred to
everything as "excludes", regardless of whether used for gitignore or
sparse-checkout.  But yeah, these and other inherent problems with
non-cone mode are called out in the "INTERNALS -- NON-CONE PROBLEMS"
section of the manual, and is a big piece of why we recommend users
migrate away from it if possible.

> - For cone, it is not clear how the two "accepted patterns" look like wha=
t the
>   semantics are.

Yeah, it is a bit complex, and I advocated for just using a different
control file for cone mode to help us step away from the blight of
$GIT_DIR/info/sparse-checkout and its inherent tie to gitignore.  I
didn't win that one.

However, why does it actually matter?  You shouldn't be bothering with
the patterns or editing the $GIT_DIR/info/sparse-checkout file for
cone mode.  You just
    git sparse-checkout set <directory1> <directory2> ... <directoryN>
and then the file will be set up for you.

>  I understand that specifying a directory adds siblings
>   recursively. But what does the "Parent" mode mean exactly and when/how =
is
>   this recognized? I guess, this is just a mis-namer? IMHO, parent of /a/=
b/c would
>   be /a/b and not /a/b/c/* (as git-sparse-chekout(1) suggests).

No, /a/b/c/* is not the parent, that's the portion that says that all
things below a/b/c (i.e. all descendant files) should be included.

The parent parts would be where it adds /a/b/ and /a/ as patterns to
ensure things directly under a/ and directly under a/b/ are included.

I think the newer version of the manual might explain this a little
better, but honestly, attempting to explain it is a losing battle.
Users shouldn't read or edit the sparse-checkout file in cone mode.
We let them, but we strongly recommend against it.  Just pass the
actual directory names to `git sparse-checkout {set,add}` and let it
take care of the patterns for you.
