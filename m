Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6111F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKSItG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 03:49:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46532 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeKSItF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 03:49:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so19967122lfc.13
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XiOpPvcJXXsDhBuDuURqCTaOKzhjAsNHUytwYnsYyXM=;
        b=l9WcC7MIiQHUV5gEcwxZU54JCIrpYaZXzJ2fUGxcy2DEgC1BKDq08r77JqThlRumvJ
         QhxJakIB3jdESYilkXIm724XAMmwIWL0VCkOUDVPM7F0XPJNM+Y6/eOvCKlpJhE7a0Aj
         6Gvc0tRtUDRcrYkeMLA7lqGxemSubnnq/iBnHYt3k5YpffeTKITDklag52E3YK1mLSNL
         S5SA0EClY6xOOjRQG/XEo28sdhzSV4mUN7RghrmVBcL+UTiR5qNmVniN0+Gu40GxN1oP
         JDFH+0gb65JnECj6FLfNYnc7Z/hkoZhvuaUm9S8k/+C9LMoI24txq0tUHbfZIgi9DHHT
         PfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XiOpPvcJXXsDhBuDuURqCTaOKzhjAsNHUytwYnsYyXM=;
        b=NN0q2j8JTEQijSfzXMQR2d7f6Z0coZCdUc9u1JXRjGewg90bFzMf92oxFo68rexUQT
         N4E1SnbOA+su7C2k51LtoZm7M8t9rdQ+G6WJlEgvPpB+/g7lqND4djiV8JSeZzrD+V4/
         JbRoCV9MqsYZCl2f07AQvZjdDb6XT0wtUk2V0ttyGVlEEC6wNbBwTgXKXRG55mjrQGg+
         JTlSZ+CRiqpVtruj+M8c4tjRqFQZ4oU4j0bFM2wyMziFXFlDlwcBn0nSLilXlE2HKmXZ
         6MsvuGOz3JHYVvNPek8rFWXqBDGeuIANwgZfmICYemvuy0mfwiQ+TGs256dZy0YKhKFj
         ZAxw==
X-Gm-Message-State: AGRZ1gK3iSd92f2OmospjzEEjwfaUQGvpAFe7Zwj/lvyDLhaqfpWcpNE
        dK/Wqt+TQyKXTnXMrAkjwes+VmfsstW52szEwDl4Sg==
X-Google-Smtp-Source: AJdET5cPAvsu4a4Gh+xTw0q4w198YtJIHaZ1/lAlIgYy4FCt//umllqPPYWp1OUu3Dx/aMalxzs8JQlHkOGc0BEFpZ0=
X-Received: by 2002:ac2:4215:: with SMTP id y21mr3448264lfh.6.1542580050033;
 Sun, 18 Nov 2018 14:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <CACsJy8Dk=Z4z5BD-XD_uTJg9Aysd5A--BUjnZR4i5=PfoabAPg@mail.gmail.com>
In-Reply-To: <CACsJy8Dk=Z4z5BD-XD_uTJg9Aysd5A--BUjnZR4i5=PfoabAPg@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sun, 18 Nov 2018 14:27:18 -0800
Message-ID: <CAPL8ZismWQ7CCZXZJAqtu7v2CD0SyN5kncgXnXb7sL9mmqwhcQ@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't think this counts as a typical modification and is probably hard =
to detect automatically.

Clever use of commands! (side: wouldn't it just be easier to just use
git commit --amend, though?)

Either way, I agree that there should be a way to manually create a
change graph or modify one into any possible shape. I've updated the
"change" command to do what you want - the new version will have
subcommands for creating arbitrary change graphs.

> subject line will change over time and the original one may become irrele=
vant.

There's a section on change naming further down the document. My
criteria for name selection was that good names should be unique,
short to type, and memorable to the user. Being relevant to the commit
wasn't actually a requirement for me except insofar as it helps make
them memorable. If we agree that these are reasonable criteria, commit
hashes wouldn't be as good a choice since they'd satisfy the
uniqueness criteria but would not be short or memorable. I expect that
whatever criteria we select probably won't be optimal for all users
which is why the design also includes a new hook for name selection. I
believe that selected words from the commit comment should cover all
three criteria in the majority of cases, and that the hook and the
"change rename" command should cover the remaining corner cases. This
breaks the "git change" symmetry with "git branch", but after
responding to other messages regarding that command, I'm starting to
think that's not really a problem.

> How do we group changes of a topic together? I think branch-diff could ta=
ke advantage of that.

Could you clarify your use-case for me? I'm not sure what you mean by
"changes of a topic". Are you referring to gerrit topics here? Topic
branches? Or are you asking for some way for end-users to classify and
organize their unsubmitted changes?

> Could we just organize it like a normal history?
> Basically all commits will be linked in a new merge history.

From what I can tell, you're suggesting the following changes:
1. Reorder the parents such that the content parent comes last rather
than first.
2. Move parent-type from the structured portion of the header to the
unstructured portion of the commit message.

I'm fine with 1 if that makes something easier.

Regarding 2, I can see some good reasons to put parent-type in the
header rather than the user-readable portion of the commit message
- fsck can rely on them when checking the database for validity (for
example, it can assert that the current repository version doesn't
attach a non-empty tree, that the content parent always points to a
real commit, the commit message is empty, that the number of
parent-types matches the number of parents, that the enum values are
valid, that the parent orders are correct, etc.).
- accidental collisions are impossible (users can't accidentally
corrupt their database by adding or removing the word "parent-type" in
a commit message).
- it doesn't spam the user-readable region with machine-readable
repository internals.

> This makes it possible to just use "git log --first-parent
> --patch" (or "git log --oneline --graph") to examine the change.

The "git log --oneline --graph" thing should work fine with the
proposal as it currently is, but I'm not sure that the --first-parent
--patch thing would be very useful no matter how we order the parents.
The metacommits have empty trees and commit messages, so such a log
would just list the metacommit hashes and nothing else. That certainly
has some utility, but I'd guess it's probably not what you were going
for. Were you intending to suggest that the metacommit should also use
the same tree and commit message as its content commit? If so, we
briefly considered this option while preparing this proposal. That
would make some commands do approximately the right thing for free.
However, when we started working through the use-cases (for example,
checking out a metacommit) we found that all the ones we looked at
would still need special cases for metacommits and those special cases
wouldn't be much simpler than they'd be with an empty tree and
message. Admittedly, git log wasn't one of the use-cases we worked
through.

  - Stefan

On Fri, Nov 16, 2018 at 10:07 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 2:00 AM <sxenos@google.com> wrote:
> > +Goals
> > +-----
> > +Legend: Goals marked with P0 are required. Goals marked with Pn should=
 be
> > +attempted unless they interfere with goals marked with Pn-1.
> > +
> > +P0. All commands that modify commits (such as the normal commit --amen=
d or
> > +    rebase command) should mark the old commit as being obsolete and r=
eplaced by
> > +    the new one. No additional commands should be required to keep the
> > +    obsolescence graph up-to-date.
>
> I sometimes "modify" a commit by "git reset @^", pick up the changes
> then "git commit -c @{1}". I don't think this counts as a typical
> modification and is probably hard to detect automatically. But I hope
> there's some way for me to tell git "yes this is a modified commit of
> that one, record that!".
>
> > +Example usage
> > +-------------
> > +# First create three dependent changes
> > +$ echo foo>bar.txt && git add .
> > +$ git commit -m "This is a test"
> > +created change metas/this_is_a_test
>
> I guess as an example, how the name metas/this_is_a_test is
> constructed does not matter much. But it's probably better to stick
> with some sort of id because subject line will change over time and
> the original one may become irrelevant. Perhaps we could use the
> original commit id as name.
>
> > +$ echo foo2>bar2.txt && git add .
> > +$ git commit -m "This is also a test"
> > +created change metas/this_is_also_a_test
> > +$ echo foo3>bar3.txt && git add .
> > +$ git commit -m "More testing"
> > +created change metas/more_testing
> > +
> > +# List all our changes in progress
> > +$ git change -l
> > +metas/this_is_a_test
> > +metas/this_is_also_a_test
> > +* metas/more_testing
> > +metas/some_change_already_merged_upstream
> > +
> > +# Now modify the earliest change, using its stable name
> > +$ git reset --hard metas/this_is_a_test
> > +$ echo morefoo>>bar.txt && git add . && git commit --amend --no-edit
> > +
> > +# Use git-evolve to fix up any dependent changes
> > +$ git evolve
> > +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> > +rebasing metas/more_testing onto metas/this_is_also_a_test
> > +Done
> > +
> > +# Use git-obslog to view the history of the this_is_a_test change
> > +$ git obslog
> > +93f110 metas/this_is_a_test@{0} commit (amend): This is a test
> > +930219 metas/this_is_a_test@{1} commit: This is a test
> > +
> > +# Now create an unrelated change
> > +$ git reset --hard origin/master
> > +$ echo newchange>unrelated.txt && git add .
> > +$ git commit -m "Unrelated change"
> > +created change metas/unrelated_change
> > +
> > +# Fetch the latest code from origin/master and use git-evolve
> > +# to rebase all dependent changes.
> > +$ git fetch origin master
> > +$ git evolve origin/master
> > +deleting metas/some_change_already_merged_upstream
> > +rebasing metas/this_is_a_test onto origin/master
> > +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> > +rebasing metas/more_testing onto metas/this_is_also_a_test
> > +rebasing metas/unrelated_change onto origin/master
> > +Conflict detected! Resolve it and then use git evolve --continue to re=
sume.
> > +
> > +# Sort out the conflict
> > +$ git mergetool
> > +$ git evolve --continue
> > +Done
> > +
> > +# Share the full history of edits for the this_is_a_test change
> > +# with a review server
> > +$ git push origin metas/this_is_a_test:refs/for/master
> > +# Share the lastest commit for =E2=80=9CUnrelated change=E2=80=9D, wit=
hout history
> > +$ git push origin HEAD:refs/for/master
>
> How do we group changes of a topic together? I think branch-diff could
> take advantage of that.
>
> > +Detailed design
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Obsolescence information is stored as a graph of meta-commits. A meta-=
commit is
> > +a specially-formatted merge commit that describes how one commit was c=
reated
> > +from others.
> > +
> > +Meta-commits look like this:
> > +
> > +$ git cat-file -p <example_meta_commit>
> > +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> > +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> > +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> > +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> > +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> > +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> > +parent-type content
> > +parent-type obsolete
> > +parent-type origin
> > +
> > +This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It =
was created by
> > +cherry-picking commit 7e1bbcd3=E2=80=9D.
>
> This feels a bit forced. Could we just organize it like a normal
> history? Something like
>
> *
> |\
> | * last version of the commit
> *
> |\
> | * second last version of the commit
> *
> |\
>
> Basically all commits will be linked in a new merge history. Real
> commits are on the second parent, first parent is to link changes
> together. This makes it possible to just use "git log --first-parent
> --patch" (or "git log --oneline --graph") to examine the change. More
> details (e.g. parent-type) could be stored as normal trailers in the
> commit message of these merges.
> --
> Duy
