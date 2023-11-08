Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BED278
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS8mKEq9"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112512B
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:31:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a5f2193bso533924e87.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 23:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699428683; x=1700033483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb9cgp6tR3bgikIKRtqhuEwNhqSNeMzPYve4tsk4Ne4=;
        b=hS8mKEq9T2DQeL6x1TGbxO2X4lFeUq9Q5u78dWCtEP4RnWY/RKtgU4tfdp4jaq5Q2J
         ogn0GLi+gnbzr+9QGhSvgjmn3MttiQE1e/FRfUQ/gUl7CWvLcCOmhFQ9mVHo2r2v97on
         YngstNq/fxZoAC05pD2QkHM/GjZRDSfUAh6nrxNwl3/MeH0KGIbzWgZPIxcJmmNUqv8C
         BVA4v5GNMkLDuj3w5ANF5Il9Q3/5DWqMF+r872przbFD5pUgWyWZHn0i+tiqVoSjttE3
         86q1JYaG+LcK9YyN+ndQkVCn3ObJbmbR6t1suEgvgwOIVmZJONQAOsMdFq37Yw7O6n7F
         PG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699428683; x=1700033483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb9cgp6tR3bgikIKRtqhuEwNhqSNeMzPYve4tsk4Ne4=;
        b=WkIZMb7dVKrToWnF9ZgACAQiqcbmIXwune+alcxkJT13w9clRnadwBUfYgAKZ1P++z
         wjhNxOxi6zT9le6F1LmMUAekQ0ZdA7a05Ud4Wd3yXUxWEfRYoWqWp/yQ00MFLdKbllto
         NBJwnB8ayeJHF49xKNw7U4T+bh8DqwrdY0G6hhkoGemw48jGf3/Blh+eVlGjaYJFjOt1
         NH7mQztmLGBlbMpS3H0cuxO1oBwWRoizXRNV0O7UGzNUYaVbLpwNZhig8A09V3Nej1bV
         gTgH3IpMFJ7MfiTYcyK4p8PR21E3pVDPRry9XykaDLb+xmbOlLCeXCal9POCXHqeKdW1
         IKPQ==
X-Gm-Message-State: AOJu0Yx4UoU1qcDhEKa351DTsbAsD7ohq7W4WaNxOZqvke0UlfLwA0Vz
	D9ioyt1b0v7LwoAnsOr53QGBjNAoSM7RGVRN7Qs=
X-Google-Smtp-Source: AGHT+IGyjbKgOAJJ5yGtGmccekROgTkbms1cq/6hzxrE24E+b9qIyEv87J/1y5Smrl8azoKdxFtjaOO1z1MFu9XO5WY=
X-Received: by 2002:a19:4f18:0:b0:504:33ff:156a with SMTP id
 d24-20020a194f18000000b0050433ff156amr1969044lfb.11.1699428682834; Tue, 07
 Nov 2023 23:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com> <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
In-Reply-To: <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 23:31:00 -0800
Message-ID: <CABPp-BEcqSJ79b9WLm+KgKkcPwSwTv3o13meU_aXakQhV6iKDQ@mail.gmail.com>
Subject: Re: first-class conflicts?
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: phillip.wood@dunelm.org.uk, Sandra Snan <sandra.snan@idiomdrottning.org>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Tue, Nov 7, 2023 at 9:38=E2=80=AFAM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
[...]
> > One thing to think about if we ever want to implement this is what othe=
r
> > data we need to store along with the conflict trees to preserve the
> > context in which the conflict was created. For example the files that
> > are read by "git commit" when it commits a conflict resolution. For a
> > single cherry-pick/revert it would probably be fairly straight forward
> > to store CHERRY_PICK_HEAD/REVERT_HEAD and add it as a parent so it gets
> > transferred along with the conflicts. For a sequence of cherry-picks or
> > a rebase it is more complicated to preserve the context of the conflict=
.
> > Even "git merge" can create several files in addition to MERGE_HEAD
> > which are read when the conflict resolution is committed.
>
> Good point. We actually don't store any extra data in jj. The old
> per-path conflict model was prepared for having some label associated
> with each term of the conflict but we never actually used it.
>
> If we add such metadata, it would probably have to be something that
> makes sense even after pushing the conflict to another repo, so it
> probably shouldn't be commit ids, unless we made sure to also push
> those commits. Also note that if you `jj restore --from <commit with
> conflict>`, you can get a conflict into a commit that didn't have
> conflicts previously. Or if you already had conflicts in the
> destination commit, your root trees (the multiple root trees
> constituting the conflict) will now have conflicts that potentially
> were created by two completely unrelated operations, so you would kind
> of need different labels for different paths.
>
> https://github.com/martinvonz/jj/issues/1176 has some more discussion
> about this.

Interesting link; thanks for sharing.

I am curious more about the data you do store.  My fuzzy memory is
that you store a commit header involving something of the form "A + B
- C", where those are all commit IDs.  Is that correct?  Is this in
addition to a normal "tree" header as in Git, or are one of A or B
found in the tree header?  I think you said there was also the
possibility for more than three terms.  Are those for when a
conflicted commit is merged with another branch that adds more
conflicts, or are there other cases too?  (Octopus merges?)

What about recursive merges, i.e. merges where the two sides do not
have a unique merge base.  What is the form of those?  (Would "- C" be
replaced by "- C1 - C2 - ... - Cn"?  Or would we create the virtual
merge base V and then do a " - V"?  Or do we only have "A + B"?)

You previously mentioned that if someone goes to edit a commit with
conflicts, and resolves the conflicts in just one file, then you can
modify each of the trees A, B, and C such that a merging of those
trees gives the partially resolved result.  How does one do that with
special conflicts, such as:
   * User modifies file D on both sides of history, in conflicting
ways, and also renames D -> E on one side of history.  User checks out
this conflicted commit and fixes the conflicts in E (but not other
files) and does a "git add E".  When they go to commit, does the
machinery need a mapping to figure out that it needs to adjust "D" in
two of the trees while adjusting "E" in the other?
   * Similar to the above, but the side that doesn't rename D renames
olddir/ -> newdir/, and the side that renames D instead renames
D->olddir/E.  For this case, the file will end up at newdir/E; do we
need the backward mapping from newdir/E to both olddir/E and D?
   * Slightly different than the above: User renames D -> E on one
side of history, and D -> F on the other.  That's a rename/rename
(1to2) conflict.  User checks out this conflicted commit and does a
"git add F", marking it as okay, but leaving E conflicted.  How can
one adjust the tree such that no conflict for F appears, but one still
appears for E?
   * Similar to above with an extra wrinkle: User renames D -> E on
one side of history, and on the other side both renames D -> F and
adds a slightly different file named E.  That's both a rename/rename
(1to2) conflict for E & F, and an add/add conflict for E.  Users
checks out this conflicted commit and resolves textual conflict in E
(in favor of the "other side"), and does a "git add E", marking it as
resolved.  When they go to commit, we not only need to worry about
making sure a conflict for F appears, we also need to figure out how
to adjust the tree such that the merge result gives you the expected
value in E without affecting F.  How can that be done?

On the first two bullet points, there's no such thing as a reverse
mapping from conflicted files to original files from previous commits
in current Git.  Creating one, if possible, would be a fair amount of
work.  But, I'm not so sure it's even possible, due to the fact that
conflicts and files do not always have one-to-one (or even one-to-many
or many-to-one) relationships; many-to-many relationship can exist, as
I've started alluding to in the last two bullet points (see also
https://github.com/git/git/blob/98009afd24e2304bf923a64750340423473809ff/Do=
cumentation/git-merge-tree.txt#L266-L271).
In fact, they can get even more complicated (e.g.
https://github.com/git/git/blob/master/t/t6422-merge-rename-corner-cases.sh=
#L1017-L1022).

> > > But we'd also have to be careful and think through usecases, includin=
g
> > > in the surrounding community.  People would probably want to ensure
> > > that e.g. "Protected" or "Integration" branches don't get accept
> > > fetches or pushes of conflicted commits,
> >
> > I think this is a really important point, while it can be useful to
> > share conflicts so they can be collaboratively resolved we don't want t=
o
> > propagate them into "stable" or production branches. I wonder how 'jj'
> > handles this.
>
> Agreed. `jj git push` refuses to push commits with conflicts, because
> it's very unlikely that the remote will be able to make any sense of
> it. Our commit backend at Google does support conflicts, so users can
> check out each other's conflicted commits there (except that we
> haven't even started dogfooding yet).

I'm curious to hear what happens when you do start dogfooding, on
projects with many developers and which are jj-only.  Do commits with
conflicts accidentally end up in mainline branches, or are there good
ways to make sure they don't hit anything considered stable?

> > > git status would probably
> > > need some special warnings or notices, git checkout would probably
> > > benefit from additional warnings/notices checks for those cases, git
> > > log should probably display conflicted commits differently, we'd need
> > > to add special handling for higher order conflicts (e.g. a merge with
> > > conflicts is itself involved in a merge) probably similar to what jj
> > > has done, and audit a lot of other code paths to see what would be
> > > needed.
> >
> > As you point out there is a lot more to this than just being able to
> > store the conflict data in a commit - in many ways I think that is the
> > easiest part of the solution to sharing conflicts.
>
> Yes, I think it would be a very large project. Unlike jj, Git of
> course has to worry about backwards compatibility. For example, you
> would have to decide if your goal - even in the long term - is to make
> `git rebase` etc. not get interrupted due to conflicts.

...and whether to copy jj's other feature in this area in some form:
auto-rebasing any descendants when you checkout and amend an old
commit (e.g. to resolve conflicts).  :-)
