Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFD522C
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inp3v0h2"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CE62D77
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 23:05:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc411be7e5so214555ad.1
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 23:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699772732; x=1700377532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jskzLhWIyGnKvQRWbbApwe4jsPXgn5382s/m63nUYrg=;
        b=inp3v0h233TCe9gf1WUXLBFsIXnJhVXvm1dBDAoMBhQ1giHIwrKyZqAHkVL9rF0ZBA
         xW8PETFZkr/iWvbbn0sVIwIIPuKXwiybDNO30NvUaYpp+FcO22Ne86rbtd8qn42V+p82
         UzNyuyvBVNp5QXjgEWfIsKFuH55KXONtcuJgB70rZNZK/xYvfoTkiHp2R/fdz/KJBRtL
         BB0lHcpWAYr1DYVtTtkVwsU5vhj8I+ZirCo2feIGT+CyVAe5N9Uk9OorHhAPhlZOQ6Ey
         8tAYQTFmTW9RxJfwR80zghdkRDXFpP/xDcqUQzssQq9ErQCn1JMhPYH+iu4uEDVNY2SY
         I0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699772732; x=1700377532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jskzLhWIyGnKvQRWbbApwe4jsPXgn5382s/m63nUYrg=;
        b=OB7FJDt53I0liEg2tobRU23K19c4DkEhZzUfCDdhthblV8a1ABkRjPNywEpQK8ylEQ
         c/lSnv0UucmeyTfjNXPaBvMMxhnLknUXff6U8ptHclF/Q7r8YrgiiMd6nIucy+SN3YLC
         3T6pC16aSiQRUKkt26nlB+3mIm4qQJEIjqy+/FGim5Zo9xrTUOcJeE5SeIFWLFBcJUC2
         VRpd7wYeOhM4lhaIN8gD8XZr5ppEZbamTcIvJxXUg2TQHmSNQEnwoBixbQsNYyNKPz4E
         iB0fCRXeoJrjQXbHtpL5QQql5GQi09pgc6fD25SClI9WgzWWjfsm9bHIUYSAzdEqniyx
         wchg==
X-Gm-Message-State: AOJu0YyHBlNp4DHa0D9agKHcfUcT2Avs8HEaEe4sEUN2iWcEMdudMuka
	bnIReCuwyTtF4OoOygS2BW1Nwe3B6l6l5ONKfd2S3Pju6+vqQnhPJR5YBw==
X-Google-Smtp-Source: AGHT+IGLG8K05kE1K4DsKl66PmNGoW0kcNSy/ZOk7WigF8qo+z7zlftiG4Bxnoe9gX8sHFXLlSUqyrNqKB5eANaV5zw=
X-Received: by 2002:a17:902:bd45:b0:1cc:23f2:262f with SMTP id
 b5-20020a170902bd4500b001cc23f2262fmr213763plx.16.1699772731235; Sat, 11 Nov
 2023 23:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cywmintp.fsf@ellen.idiomdrottning.org> <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com> <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
 <CABPp-BEcqSJ79b9WLm+KgKkcPwSwTv3o13meU_aXakQhV6iKDQ@mail.gmail.com>
 <CAESOdVBjEYAp+P_mYdByYrPmbiu9DWL=Z_r19H8D9bxkJrquFA@mail.gmail.com> <CABPp-BF35JvbXcjLxJkQtKeVhQ2qYaBXBoN4P07BEWS8mxTaMA@mail.gmail.com>
In-Reply-To: <CABPp-BF35JvbXcjLxJkQtKeVhQ2qYaBXBoN4P07BEWS8mxTaMA@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Sat, 11 Nov 2023 23:05:19 -0800
Message-ID: <CAESOdVCGG6JfW8kuSBPe0bPNyOqW-K6AWKp9acZv_B=teDd3KA@mail.gmail.com>
Subject: Re: first-class conflicts?
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Sandra Snan <sandra.snan@idiomdrottning.org>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 1:41=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> Hi Martin,
>
> On Wed, Nov 8, 2023 at 10:23=E2=80=AFAM Martin von Zweigbergk
> <martinvonz@google.com> wrote:
> > On Tue, Nov 7, 2023 at 11:31=E2=80=AFPM Elijah Newren <newren@gmail.com=
> wrote:
> > > On Tue, Nov 7, 2023 at 9:38=E2=80=AFAM Martin von Zweigbergk
> > > <martinvonz@google.com> wrote:
> > > >
> [...]
> > > I am curious more about the data you do store.  My fuzzy memory is
> > > that you store a commit header involving something of the form "A + B
> > > - C", where those are all commit IDs.  Is that correct?
> >
> > We actually store it outside the Git repo (together with the "change
> > id"). We have avoided using commit headers because I wasn't sure how
> > well different tools deal with unexpected commit headers, and because
> > I wanted commits to be indistinguishable from commits created by a
> > regular Git binary. The latter argument doesn't apply to commits with
> > conflicts since those are clearly not from a regular Git binary
> > anyway, and we don't allow pushing them to a remote.
> >
> > >  Is this in
> > > addition to a normal "tree" header as in Git, or are one of A or B
> > > found in the tree header?
> >
> > It's in addition. For the tree, we actually write a tree object with
> > three subtrees:
> >
> > .jjconflict-base-0: C
> > .jjconflict-side-0: A
> > .jjconflict-side-1: B
> >
> > The tree is not authoritative - we use the Git-external storage for
> > that. The reason we write the trees is mostly to prevent them from
> > getting GC'd.
>
> Oh, that seems like a clever way to handle reachability and make sure
> the relevant trees are automatically included in any pushes or pulls.
>
> > Also, if a user does `git checkout <conflicted commit>`,
> > they'll see those subdirectories and will hopefully be reminded that
> > they did something odd (perhaps we should drop the leading `.` so `ls`
> > will show them...). They can also diff the directories in a diff tool
> > if they like.
>
> Oh, so they don't get a regular top-level looking tree with
> possibly-conflicted-files present? Or is this in addition to the
> regular repository contents?

They get a regular tree with conflict markers if they use `jj
checkout`, but not if they use `git checkout`.

> If in addition, are you worried about
> users ever creating real entries named ".jjconflict-base-<N>" in their
> repository?

I'm not worried about that since it's not the source of truth, so at
most they waste some time.

By the way, if the user did use `git checkout` and got those
`.jjconflict-*` directories in the working copy, and then ran a `jj`
command afterwards, then jj would think that the conflict was resolved
by replacing the conflicted paths (and all other paths!) by those
`.jjconflict-*` directories :) The user would probably realize their
mistake pretty quickly and run `jj abandon` to discard those changes.

>
> > >  I think you said there was also the
> > > possibility for more than three terms.  Are those for when a
> > > conflicted commit is merged with another branch that adds more
> > > conflicts, or are there other cases too?  (Octopus merges?)
> >
> > Yes, they can happen in both of those cases you mention. More
> > generally, whenever you apply a diff between two trees onto another
> > tree, you might end up with a higher-arity conflict. So merging in
> > another branch can do that, or doing an octopus merge (which is the
> > same thing at the tree level, just different at the commit level), or
> > rebasing or reverting a commit.
> >
> > We simplify conflicts algebraically, so rebasing a commit multiple
> > times does not increase the arity - the intermediate parents were both
> > added and removed and thus cancel out. These simple algorithms for
> > simplifying conflicts are encapsulated in
> > https://github.com/martinvonz/jj/blob/main/lib/src/merge.rs. Most of
> > them are independent of the type of values being merged; they can be
> > used for doing algebra on tree ids, content hunks, refs, etc. (in the
> > test cases, we mostly merge integers because integer literals are
> > compact).
>
> It's done on content hunks as well?  That's interesting.

Yes, when merging trees, we start at the root tree and try to resolve
conflicts at the tree entry level (i.e. without reading file
contents). I think git does the same. If that's not enough we need to
recurse into subtrees or file contents. When merging files, we find
matching regions of the inputs and use the same algorithm on the
individual chunks between the matching regions.

>
> When exactly would it be done on refs, though?  I'm not following that on=
e.

First of all, note that jj allows refs to be in a conflicted state
similar to how trees can be in a conflicted state. We merge refs for a
few different reasons. If you run two concurrent operations on a repo,
we merge any changes to the refs. We do the same thing when you fetch
branches from a remote. For example, if you've fetched branch "main"
from a remote, then moved it locally, and then you fetch again from
the remote, we'll attempt to merge those refs. We use the same
function for merging there, but if it fails, we then also
automatically resolve two operations moving the branch forward
different amounts (e.g. one operation moves a ref from X~10 to X~5
while the other moves it forward to X, we resolve to X).
https://github.com/martinvonz/jj/blob/main/docs/technical/concurrency.md
talks a bit more about that.

>
> And what else is in that "etc."?

I think it's only individual file ids (blob ids) and the executable
bit. If a file's content changed and its executable bit changed, we
use the same algorithm for each of those pieces of information.

>
> > > What about recursive merges, i.e. merges where the two sides do not
> > > have a unique merge base.  What is the form of those?  (Would "- C" b=
e
> > > replaced by "- C1 - C2 - ... - Cn"?  Or would we create the virtual
> > > merge base V and then do a " - V"?  Or do we only have "A + B"?)
> >
> > We do that by recursively creating a virtual tree just like Git does,
> > I think (https://github.com/martinvonz/jj/blob/084b99e1e2c42c40f2d52038=
cdc97687b76fed89/lib/src/rewrite.rs#L56-L71).
> > I think the main difference is that by modeling conflicts, we can
> > avoid recursive conflict markers (if that's what Git does), and we can
> > even automatically resolve some cases where the virtual tree has a
> > conflict.
>
> Okay, but that talks about the mechanics of creating a recursive
> merge, omitting all the details about how the conflict header is
> written when you record the merge.  Is the virtual merge base
> represented in the algebraic "A + B - C" expressions, or is the "- C"
> part omitted?  If it is represented, and the virtual merge base had
> conflicts which you could not automatically resolve, what exactly does
> the conflicted header for the outer merge get populated with?

I think we're talking about the state in F below, right?

  F
/ \
/ \
D E
|\ /|
| X |
|/ \|
B C
\ /
\ /
A

The virtual commit/tree, which we can think of as sitting where the X
is in the graph, would have state V=3DB+C-A. The state at F would have
D+E-V=3DD+E-(B+C-A)=3DD+(E-C)+(A-B). This is encoded in `Merge::flatten()`
here:  https://github.com/martinvonz/jj/blob/e3a1e5b80ed9124091baa4d920cc9e=
8124c1f559/lib/src/merge.rs#L421-L451.
It's not specific to recursive merge; we run into the same kind of
higher-arity conflicts on regular octopus merges or repeated merges
(if you don't resolve conflicts in between).

Oh, I should also say that we don't store the unmodified trees in
these expressions. Instead, for anything we can automatically resolve,
we replace those parts of the trees. So even if A, B, and C differ at
paths X, Y, and Z, the trees we associate with V might only differ at
path Y if that's the only path we couldn't resolve. IIRC, I did it
that way because it seemed wasteful to re-attempt the merge at paths X
and Z every time we rewrite the commit. I *think* it rarely matters in
practice, but it feels like it could in some cases (maybe where two
sides make the same changes).

>
> [...]
>
> > Great questions! We don't have support for renames, so we haven't had
> > to worry about these things. We have talked a little about divergent
> > renames and the need for recording that in the commit so we can tell
> > the user about it and maybe ask them which name they want to keep. I
> > had not considered the interaction with partial conflict resolution,
> > so thanks for bringing that up. I don't have any answers now, but
> > we'll probably need to start thinking about this soon.
>
> I was wondering if that might be the answer.  When you do tackle this,
> I'd be interested to hear your thoughts.  I'm wondering if we just
> need to augment the data in the conflict header to handle such cases
> (though I guess this could risk having commit objects that are
> significantly bigger than normal in theoretical cases where many such
> paths are involved?)

Yes, that's what I've been thinking, but I think the only thing I had
been thinking of storing was for "divergent renames" (A->B on one
side, A->C on the other). Will let you know when we start thinking
about this for real. Thanks again for your input!

>
> > > I'm curious to hear what happens when you do start dogfooding, on
> > > projects with many developers and which are jj-only.  Do commits with
> > > conflicts accidentally end up in mainline branches, or are there good
> > > ways to make sure they don't hit anything considered stable?
> >
> > That won't happen at Google because our source of truth for "merged
> > PRs" (in GitHub-speak) is in our existing VCS. We will necessarily
> > have to translate from jj's data model to its data model before a
> > commit can even be sent for review.
>
> That makes sense, but I was just hoping we'd have an example to look
> to for how to keep things safe if we were to implement this.  Sadly, I
> don't think we have the benefit of relying on folks to first push
> their commits into some other VCS which lacks this feature.  ;-)

It might be best to disallow pushing conflicts to start with. It
should also be easy to add a hook on the server to disallow it only to
certain branches.
