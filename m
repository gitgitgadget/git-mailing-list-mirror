Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248293C6AB
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToDjEOw8"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26D118
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 14:58:13 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so32413501fa.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 14:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699657092; x=1700261892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RSjpQYBY6D5ksCI1SIAAyqLQEDs9hmkaMgJuKlCENM=;
        b=ToDjEOw8ABIAsbLRWOOCU56fi1nibdKYziUGnDuiyGSRjA4ehHzN3s3GXUlKCp2dHp
         cQhdmpPW1xwEZNCHPiNXp0qHlP8vVWM2KXwcNxTUoxj1iiTSUhM+TDBPAumkG2YALZSC
         NcrStkBs8kZwwZfhlIS5JoL6mfuoXktTkSDmhWKnHSs+cntEjoMrxMaLeCGDRHn6J2VD
         qtZhoczlw4mdiwM0AuQbq9E3H3pmolD+3aQXuMG/4eGg+TcCKQRfs6BxNbfW2hCzw132
         tI1SqR3c7zkdWPvw28YGvbeevWj1xU0ZVQ8rgOf7Sn5wh1H1PtzJq+zLYC6xuGh8+9qZ
         p9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699657092; x=1700261892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RSjpQYBY6D5ksCI1SIAAyqLQEDs9hmkaMgJuKlCENM=;
        b=PQA8Ds/MBO5G9wu2KJ2bGtoY1SnFMlNC2cFPBv20j8E+9CtJVH7wcradYE26DAb2gm
         Vcj8V36BBM7foUclAfpGQ82PvcKpURNGkeJF8wVetTXwnAuRwQ2vgHFhEznYMjgv32tc
         rQ9TDbLEtLI0wvvs+AzN7zLkAYYkIFoEmkaf8yRsRKpGBzL7hvR8aGUnPu46O3g7kFiW
         EJ8w8FSv8oTKvar1tG+YuWlMEFni6/uD25CmXZblEFEptnZv1rnYE1jsC1rthlJa2cfA
         QJ8QVAGrzkBJHNrtkpnytqmx7drh4+NeMLyG5hHCOySw5ohcwqaES0GWa6SgjCkf1QtT
         jrgw==
X-Gm-Message-State: AOJu0Yxdhv3hG4PeZ+066iXvlPUqnd6+KhbBBPN+SeRxZ6ANxOKtM9Yu
	m6ySqWYYij1Q7304KUnH/N77eFH2NgO5+C94S98NgYy+gF4=
X-Google-Smtp-Source: AGHT+IFQY93PURb57NJTSkueOzc7RZeRFIiZ/jtTG3t2xLANEyTBrqghyPBdYcgfriFI63PVQx7hA0qxcxdOcpwOiZQ=
X-Received: by 2002:a2e:b951:0:b0:2c5:be8:68ae with SMTP id
 17-20020a2eb951000000b002c50be868aemr473014ljs.0.1699657091433; Fri, 10 Nov
 2023 14:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com> <CABPp-BGd-W8T7EsvKYyjdi3=mfSTJ8zM-uzVsFnh1AWyV2wEzQ@mail.gmail.com>
 <a1cd2dba-3a74-4b41-8585-209b4a13b8c4@gmail.com>
In-Reply-To: <a1cd2dba-3a74-4b41-8585-209b4a13b8c4@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 14:57:00 -0800
Message-ID: <CABPp-BGhJEKu2LvFoVMg-RVaiWYQx1_VjGc=NyNVo-7s-JS8rQ@mail.gmail.com>
Subject: Re: first-class conflicts?
To: phillip.wood@dunelm.org.uk
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, Nov 9, 2023 at 6:45=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
[...]
> > This is a great thing to think about and bring up.  However, I'm not
> > sure what part of it actually needs to be preserved; in fact, it's not
> > clear to me that any of it needs preserving -- especially not the
> > files read by "git commit".  A commit was already created, after all.
> >
> > It seems that CHERRY_PICK_HEAD/REVERT_HEAD files exist primarily to
> > clue in that we are in-the-middle-of-<op>, and the conflict header
> > (the "tree A + tree B - tree C" thing; whatever that's called)
> > similarly provides signal that the commit still has conflicts.
> > Secondarily, these files contain information about the tree we came
> > from and its parent tree, which allows users to investigate the diff
> > between those...but that information is also available from the
> > conflict header in the recorded commit.  The CHERRY_PICK_HEAD and
> > REVERT_HEAD files could also be used to access the commit message, but
> > that would have been stored in the conflicted commit as well.  Are
> > there any other pieces of information I'm missing?
>
> Mainly that I'm an idiot and forgot we were actually creating a commit
> and can store the message and authorship there!

You're definitely not an idiot.  The whole problem space is new and
different, so it's easy to overlook or forget certain details, and
even to make completely different assumptions than others and have no
one aware that we're operating with similar sounding but entirely
different mental models.

> More seriously I think
> being able to inspect the commit being cherry-picked (including the
> original commit message) is useful so we'd need to recreate something
> like CHERRY_PICK_HEAD when the conflict commit is checked out.

So, I see a few issues with this:

1) Even if we were to create CHERRY_PICK_HEAD as you envision, that
doesn't necessarily guarantee the user can view the original commit
because they may not have it.  It may have been a local-only commit
that wasn't pushed or pulled to the person who is now investigating
it.

2a) You highlight the original commit message, but if someone doesn't
want to immediately resolve conflicts, why would they be modifying the
commit message?

2b) Even if users did want to modify the commit message without
resolving conflicts, how would they do so?  Rebasing has
interactivity, but cherry-picking doesn't.  And interactivity seems to
be something people probably wouldn't use together with storing
conflicts; the point of interactivity is to tweak things further and
fix them up, suggesting they'd want to be running in
address-conflicts-now mode.

> Recreating CHERRY_PICK_HEAD is useful for "git status" as well.

"git status" uses this file to determine if it should display
information about currently being in the middle of a cherry-pick
operation.  Putting such a file in place would thus be misleading,
because we aren't in a cherry-pick operation anymore; that has
completed already.  I would not expect the suggested commands printed
by git-status while it thinks we're in such a state (namely, "git
cherry-pick [--continue|--skip|--abort]") to work either.  So, I'd
argue it would be a bug to create such a file when checking out a
conflicted-commit.

Of course, we would want git-status to display information about the
current commit being conflicted, but I think that could be based on
the simple conflict header without additional info.

> I think
> that means storing a little more that just the "tree A + tree B - tree
> C" thing.

I'm totally willing to believe there will be cases where more info is
needed.  I'm suspecting that conflicts with certain kinds of renames,
or which were performed with certain types of strategies or strategy
options might be some examples.  But I'm not sure I'm understanding
why CHERRY_PICK_HEAD should be one of those cases.

> > I think the big piece here is whether we also want to adopt jj's
> > behavior of automatically rebasing all descendant commits when
> > checking out and amending some historical commit (or at least having
> > the option of doing so).  That behavior allows users to amend commits
> > to resolve conflicts without figuring out complicated interactive
> > rebases to fix all the descendant commits across all relevant
> > branches.
>
> That's a potentially attractive option which is fairly simple to
> implement locally as I think you can use the commit DAG to find all the
> descendants though that could be expensive if there are lots of
> branches. However, if we're going to share conflicts I think we'd need
> something like "hg evolve" - if I push a commit with conflicts and you
> base some work on it and then I resolve the conflict and push again you
> would want to your work to be rebased onto my conflict resolution.

Ooh, that's an interesting point.

> To handle "rebase --exec" we could store the exec command and run it when
> the  conflicts are resolved.

So, my assumption is that even if we add the ability to commit
conflicts and even if we default to auto-committing them during
cherry-picks or non-interactive rebases, there will still be people
who want to resolve conflicts as they are hit rather than
auto-committing them, and thus that stop-on-conflict should always be
an option.  In the world where a user has this choice, I think it'd be
rare for users to want to auto-commit conflicts with --exec.  I'd
suggest that --exec, and even --interactive, would default to stopping
on conflicts and waiting for the user to resolve even if
auto-commit-on-conflict is the default in other cases.

That leaves me wondering if there are any cases where users want to
auto-commit conflicts in.conjunction with --exec, which I'm already
struggling to come up with, _and_ that would further want the exec
commands to be preserved in the conflicted commits (and any descendant
commits?) for later usage.  Maybe there's a case for that, but I'm not
coming up with it right now.

Also, another way of looking at this is that my current mental model
is that the cherry-pick or rebase operation is completed once it has
handled each of the commits in its list; the operation does not extend
until all the conflicts in the commits it creates are resolved.  The
fact that rebases do not extend until conflicts are resolved is
important because you can later further rebase conflicted-commits (as
Martin alludes to in his emails); considering the old rebase(s) to
still be in progress while a new one starts might get excessively
complex to handle.  The reason all of this matters to --exec is that
--exec is part of the rebase operation; once the rebase operation is
done, the --exec stuff is also done.  (And thus, if you don't want
--exec to run on conflicted commits, then don't opt for
auto-committing conflicts.).

> Also I wonder how annoying it would be in cases where I just want to
> rebase and resolve the conflicts now. At the moment "git rebase" stops
> at the conflict, with this feature I'd have to go and checkout the
> conflicted commit and fix the conflicts after the rebase had finished.

I agree that would often be annoying.  Personally, I think that
auto-committing conflicts as a feature should at most be an option
(even if perhaps the default in some cases), not a new mandatory
worldview.  And I'm currently not convinced that even if it were
implemented it should be the default in any cases.

> > Without that feature, I agree this might be a bit more
> > difficult,
>
> Yes, when I wrote my original message I was imagining that we'd stop at
> the first conflicting pick and store all the rebase state like some kind
> of stash on steroids so it could be continued when the conflict was
> resolved. It would be much simpler to try and avoid that.

Yeah, this is an example of how completely different mental models we
can come up with when none of us (other than Martin) know much about
the problem space.  I suspect there's at least a few more examples
like this where we still have very different mental models, and
perhaps some gems to be found by mixing and matching them.

> > There are some special state files related to half-completed
> > operations (e.g. squash commits when we haven't yet reached the final
> > one in the sequence, a file to note that we want to edit a commit
> > message once the user has finished resolving conflicts, whether we
> > need to create a new root commit), but again, the operation has
> > completed and commits have been created with appropriate parentage and
> > commit messages so I don't think these are useful anymore either.
>
> Yes, though we may want to remember which commits were squashed together
> so the user can inspect that when resolving conflicts.

Ooh, that's interesting...though it does run into the problem of users
not having access to the original commits.

> > The biggest issue is perhaps that REBASE_HEAD is used in the
> > implementation of `git rebase --show-current-patch`, but all
> > information stored in that is still accessible -- the commit message
> > is stored in the commit, the author time is stored in the commit, and
> > the trees involved are in the conflict header.  The only thing missing
> > is committer timestamp, which isn't relevant anyway.
>
> The commit message may have been edited so we lose the original message
> but I'm not sure how important that is.

Is this a reversal from your comment earlier in your email about the
importance of the original commit message for CHERRY_PICK_HEAD?  :-)

> > The only ones I'm pausing a bit on are the strategy and
> > strategy-options.  Those might be useful somehow...but I can't
> > currently quite put my finger on explaining how they would be useful
> > and I'm not sure they are.
>
> I can't think of an immediate use for them. When we re-create conflicts
> we do it per-file based on the index entries created by the original
> merge so I don't think we need to know anything about the strategy or
> strategy-options.

But we don't have index entries.  We only have trees in this
conflicted commit, and when users check it out, they probably expect
conflicted index entries to be put into place.  Can we correctly
regenerate the right conflicted index entries from the original trees
without the strategy and strategy-options command line flags?  I
suspect there might be problems here, and user-defined merge
strategies could really throw a wrench in the works.  Hmm...

> > Am I missing anything?
>
> exec commands? If the user runs "git rebase --exec" and there are
> conflicts then we'd need to defer running the exec commands until the
> conflicts are resolved. For something like "git rebase --exec 'make
> test'" that should be fine. I wonder if there are corner cases where the
> exec command changes HEAD though.

We talked about exec commands above, as well as the assumption whether
auto-committing conflicts should be mandatory vs. an option, so I
won't repeat that here.  It was definitely a very interesting topic to
bring up though; thanks!

[...]

> Yes, it would certainly be lots of work.

...but even if none of us get time and prioritization to work on it, I
personally find it a really interesting topic to discuss and explore.
Thanks for joining in and bringing up many good points!
