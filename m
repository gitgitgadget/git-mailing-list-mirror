Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6AD267
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S15RNXqT"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57BD125
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 22:31:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5094727fa67so8825130e87.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 22:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699425112; x=1700029912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/eWVDyz6Xio7N/1RrPsc9YngBGhWHlLG4BaHlFgFeI=;
        b=S15RNXqTVqK80VWNAUBo1Co9As5mnoyB1AvLChKXkkcCbH0G1YLCi8VP8QJ3AjONhG
         NaTsxguQy8UoIpVu/isrMfcd1KGw2LMl/aFEiMYH9ufOXfxNgpEx6qr8Fgjrcbzv7z2K
         l0JAo9zbZ0M+f519vPjAnxIhupj2qDM4J73H4L0TtsXzZCO23PWtc0hWn6oiDaEzaPhT
         JqAtkTixUSH6bbvRea9fjjHpjdRKXf+l0csQdzFZn+Rz8IcjMiNIaAShx3b/8Vhlc+P7
         WQfxfntXnGBVwLgTAxEqJAbwqcJjq9ReDNhZsx2WAkyR7iSUJw+mp3f3R3Saw/eDkht0
         hMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699425112; x=1700029912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/eWVDyz6Xio7N/1RrPsc9YngBGhWHlLG4BaHlFgFeI=;
        b=tneYAjcAuodn8Jvhe3rkdLTFwLEjdLQaQLEGxy+Oo/BzSuL4F1pZyMroROjrZ/6qOw
         NY7Dr70nZgrMD4racbsdzlF9jWfkkSVyLGVkmdoLwaf8l0tppQt68EkGYgfijBMc61Nv
         p/NVBgvcuaOZpHPsHMh0gem3ESxEz5s0/bmGUy9iJTaE6kJOUrqOrrzbEslYB/C+Fsv8
         qMO4OuOmnPR245CAvkuH7rmAT0qptn1Z+WU0xBdW22bf9ZBlKI3WAmBAhUFe9A4Q+pch
         K4vkl2CGbf6b3/E2vZaBzBI2nEvd3FCdQy2w2tY5knx8w5be1PrtyFg8by43pDYM2qTZ
         9Eew==
X-Gm-Message-State: AOJu0Yw2NKYbEAA2NuNDsqBslXDCbsWBVPw4Ne6uDjJ/mCglFpZyKR5p
	GUTvctFtDGL75wtWfXHFMJLEsZZuvi7gHyXWxfY=
X-Google-Smtp-Source: AGHT+IGxub1NVoo8hxSYyhgPYx9tQbSIuPo9kF8RGbEz61FIZQF132iwCSLD6ZAwgxfP8TPKkhVKsHPu/K/AmGxVXcI=
X-Received: by 2002:a05:6512:2356:b0:509:43e1:f77d with SMTP id
 p22-20020a056512235600b0050943e1f77dmr567181lfu.23.1699425111743; Tue, 07 Nov
 2023 22:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
In-Reply-To: <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 22:31:37 -0800
Message-ID: <CABPp-BGd-W8T7EsvKYyjdi3=mfSTJ8zM-uzVsFnh1AWyV2wEzQ@mail.gmail.com>
Subject: Re: first-class conflicts?
To: phillip.wood@dunelm.org.uk
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Tue, Nov 7, 2023 at 3:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Elijah
>
> [I've cc'd Martin to see if he has anything to add about how "jj"
> manages the issues around storing conflicts.]

+1.  I'll add some other questions for him too while we're at it,
separately in this thread.

[...]

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
> transferred along with the conflicts.

This is a great thing to think about and bring up.  However, I'm not
sure what part of it actually needs to be preserved; in fact, it's not
clear to me that any of it needs preserving -- especially not the
files read by "git commit".  A commit was already created, after all.

It seems that CHERRY_PICK_HEAD/REVERT_HEAD files exist primarily to
clue in that we are in-the-middle-of-<op>, and the conflict header
(the "tree A + tree B - tree C" thing; whatever that's called)
similarly provides signal that the commit still has conflicts.
Secondarily, these files contain information about the tree we came
from and its parent tree, which allows users to investigate the diff
between those...but that information is also available from the
conflict header in the recorded commit.  The CHERRY_PICK_HEAD and
REVERT_HEAD files could also be used to access the commit message, but
that would have been stored in the conflicted commit as well.  Are
there any other pieces of information I'm missing?

> For a sequence of cherry-picks or
> a rebase it is more complicated to preserve the context of the conflict.

I think the big piece here is whether we also want to adopt jj's
behavior of automatically rebasing all descendant commits when
checking out and amending some historical commit (or at least having
the option of doing so).  That behavior allows users to amend commits
to resolve conflicts without figuring out complicated interactive
rebases to fix all the descendant commits across all relevant
branches.  Without that feature, I agree this might be a bit more
difficult, but with that feature, I'm having a hard time figuring out
what context we actually need to preserve for a sequence of
cherry-picks or a rebase.

Digging into a few briefly...

Many of the state files are about the status of the in-progress
operation (todo-list, numbers of commits done and to do, what should
be done with not-yet-handled commits, temporary refs corresponding to
temporary labels that need to be deleted, rescheduling failed execs,
dropping or keeping redundant commits, etc.), but if the operation has
completed and new commits created (potentially with multiple files
with conflict headers), I don't see how this information is useful
anymore.

There are some special state files related to half-completed
operations (e.g. squash commits when we haven't yet reached the final
one in the sequence, a file to note that we want to edit a commit
message once the user has finished resolving conflicts, whether we
need to create a new root commit), but again, the operation has
completed and commits have been created with appropriate parentage and
commit messages so I don't think these are useful anymore either.

Other state files are related to things needing to be done at the end
of the operation, like invoke the post-rewrite hook or pop the
autostash (with knowledge of what was rewritten to what).  But the
operation would have been completed and those things done already, so
I don't see how this is necessary either.

Some state files are for controlling how commits are created (setting
committer date to author date, gpg signing options, whether to add
signoff), but, again, commits have already been created, and can be
further amended as the user wants (hopefully including resolving the
conflicts).

The biggest issue is perhaps that REBASE_HEAD is used in the
implementation of `git rebase --show-current-patch`, but all
information stored in that is still accessible -- the commit message
is stored in the commit, the author time is stored in the commit, and
the trees involved are in the conflict header.  The only thing missing
is committer timestamp, which isn't relevant anyway.

The only ones I'm pausing a bit on are the strategy and
strategy-options.  Those might be useful somehow...but I can't
currently quite put my finger on explaining how they would be useful
and I'm not sure they are.

Am I missing anything?

> Even "git merge" can create several files in addition to MERGE_HEAD
> which are read when the conflict resolution is committed.

That's a good one to bring up too, but I'm not sure I understand how
these could be useful to preserve either.  Am I missing something?  My
breakdown:
   * MERGE_HEAD: was recorded in the commit as a second parent, so we
already have that info
   * MERGE_MSG: was recorded in the commit as the commit message, so
again we already have that info
   * MERGE_AUTOSTASH: irrelevant since the stashed stuff isn't part of
the commit and was in fact unstashed after the
merge-commit-with-conflicts was created
   * MERGE_MODE: irrelevant since it's only used for reducing heads at
time of git-commit, and git-commit has already been run
   * MERGE_RR: I think this is irrelevant; the conflict record (tree A
+ tree B - tree C) lets us redo the merge if needed to get the list of
conflicted files and textual conflicts found therein

So I don't see how any of the information in these files need to be
recorded as additional auxiliary information.  However, that last item
might depend upon the strategy and strategy-options, which currently
is not recorded...hmm....

> > But we'd also have to be careful and think through usecases, including
> > in the surrounding community.  People would probably want to ensure
> > that e.g. "Protected" or "Integration" branches don't get accept
> > fetches or pushes of conflicted commits,
>
> I think this is a really important point, while it can be useful to
> share conflicts so they can be collaboratively resolved we don't want to
> propagate them into "stable" or production branches. I wonder how 'jj'
> handles this.

Yeah, figuring this out might be the biggest sticking point.

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

Yeah, another one I just thought of is that the trees referenced in
the conflicts would also need to affect reachability computations as
well, to make sure they both don't get gc'ed and that they are
transferred when appropriate.  There are lots of things that would be
involved in implementing this idea.
