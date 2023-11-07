Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96651C684
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhl33iRO"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED6121
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:38:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc209561c3so3065ad.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699378711; x=1699983511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SrdQP2YJDO7S3oP9SvjoGFzthIMDYSnVb2LeuP0U4U=;
        b=mhl33iROnCAt70gaz7hm4GIV43RvEFcKGCv0gDyb/4eWPfF8jdFSg0ey+TGmM056kL
         +n16PwO+vSTsRh5l96JkcrrKflqlkLj20hiBceVyuOJUbGC1HAxf1pKZfqbwCS40+FlO
         jyiWnjxgwKpTH5bgVnUbHWQXrt2+/9sdhRgiMWjCraIXOBa7pgeY6pBOyFJOBA8P13dY
         GINggCo2IdtnazQ6py9EMRSN5EHD5mW5nS/9AVXOprQi1TmbeaYsfFVRpAec8O2T1NE2
         lE6/plqZwzwavyM3pV1D/ZuM5nUPOOWM3TYwzN+0M0QzvT+fqUt62EZgCcYxVIWQm+uF
         8OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378711; x=1699983511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SrdQP2YJDO7S3oP9SvjoGFzthIMDYSnVb2LeuP0U4U=;
        b=rmgmwpokEkZUYnS5p4ty2Cahb65Ddho+Jd+nInQwP50zHHaCAjm34yQRltufrCXboX
         e3wMNAQQ/PY357qoFoPcG2nZNnvP1TUR6YSTpWkVypakyp7/lJfBYC5TI+apphSPWiYm
         icVtb5DpiWzNVooR7e73sVGQCSJ+6dPoTo4YhrBEDE4SIyT5NTEUHEZ45LUGrxh5L7oe
         0TIDVPgfrXY98GXcFkQbzc10dGMj4iJqT+wIXguChgv/Hkd72wn9pXrrG/A+gTqmJzqa
         htp9ejdSxl/6/562IYzI6yRPTLRyoeSciTgllM4/Oy3wGiXwnrX6ZfvIUBMvlI+V3I7b
         WevQ==
X-Gm-Message-State: AOJu0Yxa+T7kFL0p0YPh8zDR6CMtlbqxz13ote1bjr1muaTM90uUhXTe
	McKAa8Q18wL0e5VmfAZ/Fy00OkX2sPg3lEQHLAp2JA==
X-Google-Smtp-Source: AGHT+IFkQEFOGgJHZvao+BU4vipymXiybvnpkFhntwLCbBtBHkMCfa6aYT2YC7usRM8btZX6D60/DoapwkKkmr3k4Yc=
X-Received: by 2002:a17:902:d58a:b0:1cc:b957:d320 with SMTP id
 k10-20020a170902d58a00b001ccb957d320mr290117plh.0.1699378710440; Tue, 07 Nov
 2023 09:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
In-Reply-To: <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Tue, 7 Nov 2023 09:38:19 -0800
Message-ID: <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
Subject: Re: first-class conflicts?
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren <newren@gmail.com>, Sandra Snan <sandra.snan@idiomdrottning.org>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(new attempt in plain text)

On Tue, Nov 7, 2023 at 3:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Elijah
>
> [I've cc'd Martin to see if he has anything to add about how "jj"
> manages the issues around storing conflicts.]
>
> On 07/11/2023 08:16, Elijah Newren wrote:
> > On Mon, Nov 6, 2023 at 1:26=E2=80=AFPM Sandra Snan
> > <sandra.snan@idiomdrottning.org> wrote:
> >>
> >> Is this feature from jj also a good idea for git?
> >> https://martinvonz.github.io/jj/v0.11.0/conflicts/
> >
> > Martin talked about this and other features at Git Merge 2022, a
> > little over a year ago.  I talked to him in more depth about these
> > while there.  I personally think he has some really interesting
> > features here, though at the time, I thought that the additional
> > object type might be too much to ask for in a Git change, and it was
> > an intrinsic part of the implementation back then.
> >
> > Martin also gave us an update at the 2023 Git Contributors summit, and
> > in particular noted a significant implementation change to not have
> > per-file storage of conflicts, but rather storing at the commit level
> > the multiple conflicting trees involved.  That model might be
> > something we could implement in Git.  And if we did, it'd solve
> > various issues such as people wanting to be able to stash conflicts,
> > or wanting to be able to partially resolve conflicts and fix it up
> > later, or be able to collaboratively resolve conflicts without having
> > everyone have access to the same checkout.
>
> One thing to think about if we ever want to implement this is what other
> data we need to store along with the conflict trees to preserve the
> context in which the conflict was created. For example the files that
> are read by "git commit" when it commits a conflict resolution. For a
> single cherry-pick/revert it would probably be fairly straight forward
> to store CHERRY_PICK_HEAD/REVERT_HEAD and add it as a parent so it gets
> transferred along with the conflicts. For a sequence of cherry-picks or
> a rebase it is more complicated to preserve the context of the conflict.
> Even "git merge" can create several files in addition to MERGE_HEAD
> which are read when the conflict resolution is committed.

Good point. We actually don't store any extra data in jj. The old
per-path conflict model was prepared for having some label associated
with each term of the conflict but we never actually used it.

If we add such metadata, it would probably have to be something that
makes sense even after pushing the conflict to another repo, so it
probably shouldn't be commit ids, unless we made sure to also push
those commits. Also note that if you `jj restore --from <commit with
conflict>`, you can get a conflict into a commit that didn't have
conflicts previously. Or if you already had conflicts in the
destination commit, your root trees (the multiple root trees
constituting the conflict) will now have conflicts that potentially
were created by two completely unrelated operations, so you would kind
of need different labels for different paths.

https://github.com/martinvonz/jj/issues/1176 has some more discussion
about this.

> > But we'd also have to be careful and think through usecases, including
> > in the surrounding community.  People would probably want to ensure
> > that e.g. "Protected" or "Integration" branches don't get accept
> > fetches or pushes of conflicted commits,
>
> I think this is a really important point, while it can be useful to
> share conflicts so they can be collaboratively resolved we don't want to
> propagate them into "stable" or production branches. I wonder how 'jj'
> handles this.

Agreed. `jj git push` refuses to push commits with conflicts, because
it's very unlikely that the remote will be able to make any sense of
it. Our commit backend at Google does support conflicts, so users can
check out each other's conflicted commits there (except that we
haven't even started dogfooding yet).

> > git status would probably
> > need some special warnings or notices, git checkout would probably
> > benefit from additional warnings/notices checks for those cases, git
> > log should probably display conflicted commits differently, we'd need
> > to add special handling for higher order conflicts (e.g. a merge with
> > conflicts is itself involved in a merge) probably similar to what jj
> > has done, and audit a lot of other code paths to see what would be
> > needed.
>
> As you point out there is a lot more to this than just being able to
> store the conflict data in a commit - in many ways I think that is the
> easiest part of the solution to sharing conflicts.

Yes, I think it would be a very large project. Unlike jj, Git of
course has to worry about backwards compatibility. For example, you
would have to decide if your goal - even in the long term - is to make
`git rebase` etc. not get interrupted due to conflicts.
