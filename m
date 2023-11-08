Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26B358B2
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aklu8a1A"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B4172E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 10:23:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc79f73e58so6945ad.1
        for <git@vger.kernel.org>; Wed, 08 Nov 2023 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699467790; x=1700072590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrndM5/kp8inTyd5kskWDFDOgH3z/uAjUTDrlQWjhT8=;
        b=aklu8a1ACm25VWndJyfdZq2FQfwOM+nwS5x3Rgnk+Z+6MVNu0XxdQRbzSNnAImIA9g
         Bul/PH0YdAIbKtjBrKIK23GksdS/f8ceQjhjDGr1YmfSvJLj/KJi4Zxq5YgDqS8yeJ18
         la7di5YHsA6W8axqbRIYdzLye9Jk28qKFwYJBWJZ6GQKw7vSIosjwJF69z6upbP2Tax5
         FuNgq4qdCBNdG1VmFHze6npw+lBKyK0eUFTeUxhwI9VQ+QTv0qWLw0mCizoXB4HA33Ni
         s42rmEZeJ/af2giPrjFi4wnsFKBf9e55GQ2nOqhvNc9u50kezMOFQ8YCwB53U959a9VU
         XECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467790; x=1700072590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrndM5/kp8inTyd5kskWDFDOgH3z/uAjUTDrlQWjhT8=;
        b=IShqNEEM9XlY/R8+V2GvjbHlBr5XelOzKXELe5/ddQmZHOZYClYQBEAwfWjM7CWTPg
         1+03ODrICXmrlQybAB6BUCTTvsnVGOER/4OPQf8gHbyVgZ7QuwtuBxll25abtSYSj3JY
         G6fWt/1CetTiAaWtx+MM6ujbDM8TYGiAzQ7T6FKIob5rMGSTWVAn2Y5ZDSnwyflRZvJn
         iX/4ttXJ+AfxsI9xshTfz74NT4348ccTyHIUSygfnUQ3AU64kMuFojE7gsg3+CXwA5iQ
         28glh9f7dp9OIlpgHyv8Jlv+dB+6zfnlGuWw0SiSTqlY8ZptW69Rtzi7PHAq2+Gg70V9
         2DFA==
X-Gm-Message-State: AOJu0YxG+l5G3SFLKznNvHQ6IuNVn+GhQZUO+QjIXEyX22fU9PzCd1PS
	SYmJNPCiVHbBQwMpvmwiJpDEby6XA3N509zWmMH4msnkE6b7qGR9M3aeBaSy
X-Google-Smtp-Source: AGHT+IHae/ULJaKsgbfwUf18QFGQ+5vFbRPfob5rX8JmsVSILo9tQdnDVtRRWycrUb2M/FZim9VHba1oSWSKvUXNQIk=
X-Received: by 2002:a17:902:cece:b0:1cc:a89f:3927 with SMTP id
 d14-20020a170902cece00b001cca89f3927mr8130plg.7.1699467789917; Wed, 08 Nov
 2023 10:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com> <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
 <CABPp-BEcqSJ79b9WLm+KgKkcPwSwTv3o13meU_aXakQhV6iKDQ@mail.gmail.com>
In-Reply-To: <CABPp-BEcqSJ79b9WLm+KgKkcPwSwTv3o13meU_aXakQhV6iKDQ@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Wed, 8 Nov 2023 10:22:58 -0800
Message-ID: <CAESOdVBjEYAp+P_mYdByYrPmbiu9DWL=Z_r19H8D9bxkJrquFA@mail.gmail.com>
Subject: Re: first-class conflicts?
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Sandra Snan <sandra.snan@idiomdrottning.org>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elijah,


On Tue, Nov 7, 2023 at 11:31=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> Hi Martin,
>
> On Tue, Nov 7, 2023 at 9:38=E2=80=AFAM Martin von Zweigbergk
> <martinvonz@google.com> wrote:
> >
> [...]
> > > One thing to think about if we ever want to implement this is what ot=
her
> > > data we need to store along with the conflict trees to preserve the
> > > context in which the conflict was created. For example the files that
> > > are read by "git commit" when it commits a conflict resolution. For a
> > > single cherry-pick/revert it would probably be fairly straight forwar=
d
> > > to store CHERRY_PICK_HEAD/REVERT_HEAD and add it as a parent so it ge=
ts
> > > transferred along with the conflicts. For a sequence of cherry-picks =
or
> > > a rebase it is more complicated to preserve the context of the confli=
ct.
> > > Even "git merge" can create several files in addition to MERGE_HEAD
> > > which are read when the conflict resolution is committed.
> >
> > Good point. We actually don't store any extra data in jj. The old
> > per-path conflict model was prepared for having some label associated
> > with each term of the conflict but we never actually used it.
> >
> > If we add such metadata, it would probably have to be something that
> > makes sense even after pushing the conflict to another repo, so it
> > probably shouldn't be commit ids, unless we made sure to also push
> > those commits. Also note that if you `jj restore --from <commit with
> > conflict>`, you can get a conflict into a commit that didn't have
> > conflicts previously. Or if you already had conflicts in the
> > destination commit, your root trees (the multiple root trees
> > constituting the conflict) will now have conflicts that potentially
> > were created by two completely unrelated operations, so you would kind
> > of need different labels for different paths.
> >
> > https://github.com/martinvonz/jj/issues/1176 has some more discussion
> > about this.
>
> Interesting link; thanks for sharing.
>
> I am curious more about the data you do store.  My fuzzy memory is
> that you store a commit header involving something of the form "A + B
> - C", where those are all commit IDs.  Is that correct?

We actually store it outside the Git repo (together with the "change
id"). We have avoided using commit headers because I wasn't sure how
well different tools deal with unexpected commit headers, and because
I wanted commits to be indistinguishable from commits created by a
regular Git binary. The latter argument doesn't apply to commits with
conflicts since those are clearly not from a regular Git binary
anyway, and we don't allow pushing them to a remote.

>  Is this in
> addition to a normal "tree" header as in Git, or are one of A or B
> found in the tree header?

It's in addition. For the tree, we actually write a tree object with
three subtrees:

.jjconflict-base-0: C
.jjconflict-side-0: A
.jjconflict-side-1: B

The tree is not authoritative - we use the Git-external storage for
that. The reason we write the trees is mostly to prevent them from
getting GC'd. Also, if a user does `git checkout <conflicted commit>`,
they'll see those subdirectories and will hopefully be reminded that
they did something odd (perhaps we should drop the leading `.` so `ls`
will show them...). They can also diff the directories in a diff tool
if they like.

>  I think you said there was also the
> possibility for more than three terms.  Are those for when a
> conflicted commit is merged with another branch that adds more
> conflicts, or are there other cases too?  (Octopus merges?)

Yes, they can happen in both of those cases you mention. More
generally, whenever you apply a diff between two trees onto another
tree, you might end up with a higher-arity conflict. So merging in
another branch can do that, or doing an octopus merge (which is the
same thing at the tree level, just different at the commit level), or
rebasing or reverting a commit.

We simplify conflicts algebraically, so rebasing a commit multiple
times does not increase the arity - the intermediate parents were both
added and removed and thus cancel out. These simple algorithms for
simplifying conflicts are encapsulated in
https://github.com/martinvonz/jj/blob/main/lib/src/merge.rs. Most of
them are independent of the type of values being merged; they can be
used for doing algebra on tree ids, content hunks, refs, etc. (in the
test cases, we mostly merge integers because integer literals are
compact).

> What about recursive merges, i.e. merges where the two sides do not
> have a unique merge base.  What is the form of those?  (Would "- C" be
> replaced by "- C1 - C2 - ... - Cn"?  Or would we create the virtual
> merge base V and then do a " - V"?  Or do we only have "A + B"?)

We do that by recursively creating a virtual tree just like Git does,
I think (https://github.com/martinvonz/jj/blob/084b99e1e2c42c40f2d52038cdc9=
7687b76fed89/lib/src/rewrite.rs#L56-L71).
I think the main difference is that by modeling conflicts, we can
avoid recursive conflict markers (if that's what Git does), and we can
even automatically resolve some cases where the virtual tree has a
conflict.

> You previously mentioned that if someone goes to edit a commit with
> conflicts, and resolves the conflicts in just one file, then you can
> modify each of the trees A, B, and C such that a merging of those
> trees gives the partially resolved result.  How does one do that with
> special conflicts, such as:
>    * User modifies file D on both sides of history, in conflicting
> ways, and also renames D -> E on one side of history.  User checks out
> this conflicted commit and fixes the conflicts in E (but not other
> files) and does a "git add E".  When they go to commit, does the
> machinery need a mapping to figure out that it needs to adjust "D" in
> two of the trees while adjusting "E" in the other?
>    * Similar to the above, but the side that doesn't rename D renames
> olddir/ -> newdir/, and the side that renames D instead renames
> D->olddir/E.  For this case, the file will end up at newdir/E; do we
> need the backward mapping from newdir/E to both olddir/E and D?
>    * Slightly different than the above: User renames D -> E on one
> side of history, and D -> F on the other.  That's a rename/rename
> (1to2) conflict.  User checks out this conflicted commit and does a
> "git add F", marking it as okay, but leaving E conflicted.  How can
> one adjust the tree such that no conflict for F appears, but one still
> appears for E?
>    * Similar to above with an extra wrinkle: User renames D -> E on
> one side of history, and on the other side both renames D -> F and
> adds a slightly different file named E.  That's both a rename/rename
> (1to2) conflict for E & F, and an add/add conflict for E.  Users
> checks out this conflicted commit and resolves textual conflict in E
> (in favor of the "other side"), and does a "git add E", marking it as
> resolved.  When they go to commit, we not only need to worry about
> making sure a conflict for F appears, we also need to figure out how
> to adjust the tree such that the merge result gives you the expected
> value in E without affecting F.  How can that be done?
>
> On the first two bullet points, there's no such thing as a reverse
> mapping from conflicted files to original files from previous commits
> in current Git.  Creating one, if possible, would be a fair amount of
> work.  But, I'm not so sure it's even possible, due to the fact that
> conflicts and files do not always have one-to-one (or even one-to-many
> or many-to-one) relationships; many-to-many relationship can exist, as
> I've started alluding to in the last two bullet points (see also
> https://github.com/git/git/blob/98009afd24e2304bf923a64750340423473809ff/=
Documentation/git-merge-tree.txt#L266-L271).
> In fact, they can get even more complicated (e.g.
> https://github.com/git/git/blob/master/t/t6422-merge-rename-corner-cases.=
sh#L1017-L1022).

Great questions! We don't have support for renames, so we haven't had
to worry about these things. We have talked a little about divergent
renames and the need for recording that in the commit so we can tell
the user about it and maybe ask them which name they want to keep. I
had not considered the interaction with partial conflict resolution,
so thanks for bringing that up. I don't have any answers now, but
we'll probably need to start thinking about this soon.

> > > > But we'd also have to be careful and think through usecases, includ=
ing
> > > > in the surrounding community.  People would probably want to ensure
> > > > that e.g. "Protected" or "Integration" branches don't get accept
> > > > fetches or pushes of conflicted commits,
> > >
> > > I think this is a really important point, while it can be useful to
> > > share conflicts so they can be collaboratively resolved we don't want=
 to
> > > propagate them into "stable" or production branches. I wonder how 'jj=
'
> > > handles this.
> >
> > Agreed. `jj git push` refuses to push commits with conflicts, because
> > it's very unlikely that the remote will be able to make any sense of
> > it. Our commit backend at Google does support conflicts, so users can
> > check out each other's conflicted commits there (except that we
> > haven't even started dogfooding yet).
>
> I'm curious to hear what happens when you do start dogfooding, on
> projects with many developers and which are jj-only.  Do commits with
> conflicts accidentally end up in mainline branches, or are there good
> ways to make sure they don't hit anything considered stable?

That won't happen at Google because our source of truth for "merged
PRs" (in GitHub-speak) is in our existing VCS. We will necessarily
have to translate from jj's data model to its data model before a
commit can even be sent for review.

>
> > > > git status would probably
> > > > need some special warnings or notices, git checkout would probably
> > > > benefit from additional warnings/notices checks for those cases, gi=
t
> > > > log should probably display conflicted commits differently, we'd ne=
ed
> > > > to add special handling for higher order conflicts (e.g. a merge wi=
th
> > > > conflicts is itself involved in a merge) probably similar to what j=
j
> > > > has done, and audit a lot of other code paths to see what would be
> > > > needed.
> > >
> > > As you point out there is a lot more to this than just being able to
> > > store the conflict data in a commit - in many ways I think that is th=
e
> > > easiest part of the solution to sharing conflicts.
> >
> > Yes, I think it would be a very large project. Unlike jj, Git of
> > course has to worry about backwards compatibility. For example, you
> > would have to decide if your goal - even in the long term - is to make
> > `git rebase` etc. not get interrupted due to conflicts.
>
> ...and whether to copy jj's other feature in this area in some form:
> auto-rebasing any descendants when you checkout and amend an old
> commit (e.g. to resolve conflicts).  :-)
