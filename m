Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F114901B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165200; cv=none; b=Avwq4DG/YusHRSpr4pgeuXaqThiMUEUFqkMMJrOdtVzqNu3aSBnQJ7x1lMwqUNEr3UZxEeLbAvQOmdhJhIojFFNvDLZHWMeT9S9TMdsLL6TV6a9e+dqa9JEfntN/8soAngw2b/qooLdyKROGXv5ltSLLt2JFQMSARsEiUkbEBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165200; c=relaxed/simple;
	bh=1fJAGrd2JKvCL4wqbT4VM7M7ptBj0Z6nvLm6h3w3zt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXKFTyepKyk3L4a2yKW912yCxCSBkv37VttbJlQlWgmXPrerCGlHqajMkNI6nJ7Tv+OaPEVs75iy+ACJ0OTKWx+6iXo8F6CoWGci8+m02Ev8JXxZwZbISmGg9wMdFIzBFT96y1AAHqaU3C5fWclLpppwUoZ+PnCaQecbnV9ae0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99f576d6eso40869585a.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 01:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727165197; x=1727769997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qTC+xjeKVRNxZ1Ye3IgsjHwsNhOy8Rxob13t7b2NwM=;
        b=ICv5WE4M8q2b67IzfCPhF+6DdGasumhTPTTnh1bTVCefyLeoDE9i/4cjroz3100Yva
         P3tqu5UfFXhv/2asb9fr7+5+pVymgkZaOSu2SysY7+kjja828qvPtbwHnntt3REIYKa3
         qgj9evJSX+O3yTgqOtIpdSDyBBO4UWEpXS12fn8nhFOoqsKnT3OFJdJgKjlT10V1JtrQ
         1gh/eKzIRSaUSiomr0+7fxQ7oqoD3yN84XirPWY5tjFVysfzmX050ocneNmMrlRPyAKB
         G7f1FLFryI36xZsy4gmxEbWmgLUZO8piVVxjODdUFAV3131iKVHKk2LPGLaelEthBM+7
         GEUw==
X-Gm-Message-State: AOJu0Yw6MLU3/utKXTQAIvo0qFH4Ulb3/e3NKx7BMDvWZZ/Ae4b89mj8
	p9qH4vLDQsQaje1iUgX3KHo1piASr6mHbdz3QQ31O49VTZQ7xdY2eQ54Kqx2kQ2W8PnZ610pw5v
	uzk22MmFWy/PAW4Ov0fP2xHQ8PXOQpXHL82c=
X-Google-Smtp-Source: AGHT+IFZZFIKDSegDvVZYUckrnfPz+6+4e3pAmAPF02g0doOe5rIB8ysDlAoQIZ461vH0nCrPJ7sNpxmAwAeAeEx7tU=
X-Received: by 2002:a05:6214:1305:b0:6c3:69f9:fb5b with SMTP id
 6a1803df08f44-6c7bc44f0f8mr101416666d6.0.1727165196533; Tue, 24 Sep 2024
 01:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1783.git.git.1726880551891.gitgitgadget@gmail.com>
In-Reply-To: <pull.1783.git.git.1726880551891.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Sep 2024 04:06:25 -0400
Message-ID: <CAPig+cQXFy=xPVpoSq6Wq0pxMRCjS=WbkgdO+3LySPX=q0nPCw@mail.gmail.com>
Subject: Re: [PATCH] builtin/worktree: support relative paths for worktrees
To: Francesco Guastella via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Francesco Guastella <guastella.francesco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 9:02=E2=80=AFPM Francesco Guastella via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
>     builtin/worktree: support relative paths for worktrees
>
>     As of now, when creating or managing worktrees, paths are always stor=
ed
>     in absolute form. While this behavior works well in many scenarios, i=
t
>     presents significant challenges when worktrees are accessed across
>     different operating systems or when the repository is moved to a
>     different location in the filesystem. Absolute paths hard-coded in th=
e
>     .git and gitdir files can break these links, causing issues that may
>     require manual intervention to resolve.
>
>     To address this, I have introduced a new configuration option:
>     worktree.useRelativePaths. This option allows users to specify whethe=
r
>     they prefer Git to store worktree paths in relative form rather than
>     absolute. The new feature enhances Git=E2=80=99s flexibility, particu=
larly in
>     environments where repositories need to be portable across different
>     systems or where directories are frequently relocated.
>
>     Key Changes: The new worktree.useRelativePaths option can be enabled =
by
>     the user to store paths in relative form. When enabled, any new
>     worktrees added using the git worktree add command will have their pa=
ths
>     stored as relative paths in the necessary git files.
>
>     The git worktree move command has been updated to respect the current
>     value of worktree.useRelativePaths. When a worktree is moved, Git wil=
l
>     now automatically adjust the path format (relative or absolute) to ma=
tch
>     the user's configuration setting.
>
>     The git worktree repair command has been similarly enhanced. It will =
now
>     automatically convert paths between relative and absolute forms based=
 on
>     the worktree.useRelativePaths setting, making it easier to maintain
>     consistent links across different environments.

Using relative rather than absolute paths has been discussed
previously[1], and the general feeling was that relative paths would
probably be beneficial (despite some obvious downsides mentioned by
Junio in his response[2]). That earlier discussion petered out without
any changes being made partly because some stated and some implied
questions lacked answers.

A significant concern was whether any such change could be made
without breaking existing third-party tooling, non-canonical Git
implementations, and even older versions of Git itself. Your choice of
controlling the behavior via a configuration option somewhat sidesteps
the issue by giving the user the choice of tolerating or not
tolerating such potential breakage.

Sidestepping like that may be the best we can hope for, though it
would also be nice if the choice could be automated and hidden from
the user as an implementation detail. One idea which was floated was
for Git to store both the absolute and relative paths, thus leveraging
the benefits of both path types. But that, too, has the potential
downside of breaking existing tooling and other Git implementations,
so it requires careful consideration. At any rate, it would be good to
hear your thoughts on the idea since it might somehow fit into the
overall scheme laid out by your work, or your work may gain additional
direction by taking that idea into consideration.

Anyhow, below is a set of questions and observations that I jotted
down as I lightly scanned the patch and played around with "git
worktree" after applying the patch. Many of the items may seem to
sound negative, but do not interpret that as rejection of the idea of
using relative paths; as stated above earlier discussion looked upon
relative paths as potentially beneficial.

It's possible that the actual code changes in the patch answer some of
the questions I ask below, but I simply don't have the mental
bandwidth to digest and reason about a 3,500 line patch in order to
figure out the answers myself. As such, any answers and responses you
can provide directly will be appreciated.

Here are my notes...

Since it is likely that third-party tools and non-canonical Git
implementations (and even older versions of Git itself) will break
with relative paths, people have created tools which let them switch
between the two on-demand. This way, they can benefit from relative
paths but still interoperate (albeit in a painfully manual fashion)
with those tools or implementations which would otherwise break. Does
this implementation provide such a tool? At first glance, based upon
your above commentary, it sounded as if "git worktree repair" would
serve a similar purpose after a user manually changes the
worktree.useRelativePaths setting, but that doesn't seem to be the
case in practice.

That leads to the next question: Should there be a dedicated
git-worktree subcommand which both changes the
worktree.useRelativePaths setting and converts all the stored paths to
reflect the new setting?

Your above commentary says that "git worktree repair" converts between
absolute and relative, but it's not clear whether it does this for
*all* worktrees or only worktrees which it fixes. Moreover, does it
convert both <repo>/worktrees/<id>/gitdir and <worktree>/.git in
unison or does it only convert the path in a file it actually repairs?
Based upon testing, I'm guessing it only does the absolute/relative
conversion *if* it actually repairs a file, and *only* converts the
repaired file. As such, the links between <repo> and <worktree> can
end up a mix of absolute and relative.

According to your above commentary, "git worktree repair" converts
between absolute and relative but the documentation for "repair" in
Documentation/git-worktree.txt has not been updated to reflect this
(unlike the documentation for "git worktree move" which now does
conversion and is documented as doing so).

The new worktree.useRelativePaths configuration should be documented
in Documentation/config/worktree.txt.

The "worktrees/<id>/gitdir::" entry in
Documentation/gitrepository-layout.txt says that the contained path is
absolute. This needs to be updated to mention relative paths and
worktree.useRelativePaths.

The documentation should discuss and stress the potential dangers of
using relative paths so that people know what they are getting
themselves into. In particular, it should mention the possibility of
relative paths breaking third-party tooling, non-canonical Git
implementations, and older versions of Git itself.

Sometimes patch authors don't bother documenting newly-added "public"
API functions (possibly because a lot of existing API functions lack
documentation), so it was nice to see this patch being thorough about
documenting new API functions.

In my testing, several "git worktree" subcommands failed or misbehaved
badly when invoked from within a linked worktree. This surprised me
since my light scan over the patch seemed to indicate that you had
taken such cases into consideration, so perhaps I'm doing something
wrong(?). For my tests, I had set up a repository and worktrees like
this:

  % git init a
  % cd a
  % git config set worktree.useRelativePaths true
  % echo content >file
  % git add file
  % git commit file -m msg
  % git worktree add ../b
  % git worktree add c

"git worktree" subcommands are supposed to be agnostic in the sense
that you should be able to invoke them from within any worktree
successfully, however, with your patch applied, this seems to no
longer be the case. For instance:

  % cd c
  % git worktree lock --reason because ../../b
  fatal: '../../b' is not a working tree

Similarly, when run from within a linked worktree, "git worktree
prune" now thinks that *all* worktrees should be pruned:

  # still in "c"
  % git worktree prune -n -v
  Removing worktrees/c: gitdir file points to non-existent location
  Removing worktrees/b: gitdir file points to non-existent location

When run from within a linked worktree, "git worktree list" shows
paths relative to the main worktree (or bare repository):

  # still in "c"
  % git worktree list
  /.../a  935238d [main]
  ../b  935238d [b] prunable
  c  935238d [c] prunable

This makes the direct output useless for any sort of navigation and
especially so in --porcelain mode for scripting purposes. To fix this,
"list" should either show the absolute paths (even if they are
maintained as relative internally) or the paths need to be recomputed
and shown as relative from the *current* worktree, not from the main
worktree.

Assuming I'm not doing something wrong in my testing, then do the
above breakages indicate some gaping holes in the test suite? If so,
then we probably need a bunch of new tests to ensure that the above
behaviors don't break when relative paths are in use.

You clearly put a lot of work and care into this patch, and (as noted
above) the idea of using relative paths has previously been considered
in a reasonably positive light, so it is unlikely that reviewers want
to lightly dismiss your patch, but at 3,500 lines, the patch is
unreviewable. No reviewer is going to have the mental bandwidth to be
able to remember or reason about *every* change made by this
monolithic patch. As the author of the patch, having developed it
incrementally over the course of days or weeks, you have a good
overall understanding of all the changes in the patch and the
evolution of the code from its present state in the project to the
state in your fork, but reviewer time is a limited resource on this
project, and it is almost certainly impossible for any reviewer to be
able to properly digest this all in a single patch.

As such, aside from answering the above questions, the way to move
forward is to split these changes out into many small, independent,
well-isolated pieces, each in its own patch, and to arrange the order
of patches so that they hand-hold and lead reviewers through the
evolution from the current implementation to the end-state. Each patch
should be one step in the journey toward the end-goal, and each patch
should build upon the previous patch, requiring reviewers to remember
only one or two important items from the current patch in order to
understand the subsequent patch. For a topic with so many changes,
this will likely require quite a few patches; it may even make sense
to split it up into several series of patches, with each series
submitted separately after reviewers have had time to digest the
preceding series.

Organizing a patch series like this places a lot of extra work on your
shoulders (beyond the work you already invested making the changes to
the code itself), but providing such hand-holding and baby-steps is
the only way reviewers will be able to grasp all the changes. A
well-organized patch series is also important for future readers of
the project history when they need to understand why the current
implementation is the way it is.

[1]: The discussion begins at the "Also Eric" paragraph of this email
and continues in emails following it:
https://lore.kernel.org/git/CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8S=
GW_Q@mail.gmail.com/

[2]: https://lore.kernel.org/git/xmqqikupbxh5.fsf@gitster.g/
