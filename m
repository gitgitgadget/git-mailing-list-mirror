Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCF31F453
	for <e@80x24.org>; Sun, 10 Feb 2019 06:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfBJGji (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 01:39:38 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37225 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfBJGji (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 01:39:38 -0500
Received: by mail-ot1-f45.google.com with SMTP id s13so12617473otq.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 22:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ztTF/rtgYtS+Fm48aYJ7lAr+KcVDD9KTHZ2j+KSttHU=;
        b=P2RbrZgkJCoK5dxpb0GLjSMT6DC2Bs1RAqRnVk2rlC35hdOx0z5ronBUqy9HD+Hd/X
         vPEfLwsi2DxsM07qzIU9/kCMzS0lhupvdCeg56tB8/NxpKjo4qm6sGrxvdbjOxyIg3sX
         +TsYzjzyJnzMKaTTT2VmmKpF99Ti+xy56w3bSHY4x+pdNZaU4FzVaXHx5F4uuVh87Qzp
         ZHaj8JQKLdHDYqrzoJLwzWOgFN/gsba/HFW8Dyr8fWCY34K1F3lr0eZKziLkmAQIc537
         QGiF4ZQ9Wv2RhWErMDkQ5LlFRipguDJu4UNobgmWkYkkJ7wHnpgKaqTglpCfOr+VbsgR
         WZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ztTF/rtgYtS+Fm48aYJ7lAr+KcVDD9KTHZ2j+KSttHU=;
        b=LqtOwCw9X+bqtONfAqcbbAB9BIfdwTtVVx2hckxDaOjy7XXoRs3+xMxfuzPN3rlv+S
         AdEz/5L+J0A8w9aZkjen7CCeJHQaJWX3QhL5IEWUUS8fk7kWLzTdVRugosyHefpZnjrD
         3lv4+BJqMUeioPUZwdoREXbT9XDJzVWBMkaNqABNwYqjV8FnMyodTQTHinUopReFkdZG
         wUeyIkptswLx4MGrEBkMZxvIblgVUWTGO0JQ2kPuSmomi57jB+ROnp9zWg0n2UvZWkVp
         rqUN+2NjEk8WEjs7WXrEiDBBmApaPjHzdSV8suNTEmrpEiH3QUJl0Y8X43Inewc+C3J1
         vCkg==
X-Gm-Message-State: AHQUAuZBmER8Alnrrk8wj8PatTQSpqik0O1l8BVA7zIN1JTDZpPq7W2K
        0kGf/sSoez+a2bBdIpmmjNjw725HlfJwcmDE1fHeDEZq
X-Google-Smtp-Source: AHgI3IbePnMEiSCeBMJ8Q5+CFigovdHCszP96bHqaWmrIAPhfeEube+m6xWzTKt1M9eyBKLth1nhMvX2WlkizKmIz3s=
X-Received: by 2002:a9d:3a46:: with SMTP id j64mr22761361otc.103.1549780777040;
 Sat, 09 Feb 2019 22:39:37 -0800 (PST)
MIME-Version: 1.0
From:   William Chargin <wchargin@gmail.com>
Date:   Sat, 9 Feb 2019 22:39:21 -0800
Message-ID: <CAFW+GMDA9gkih-7n=R2N_5edNK=b4X28qqPgRd7soGG160t94w@mail.gmail.com>
Subject: Workflow for GitHub branch model interop: advice?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git folks,

I=E2=80=99m looking into automating a Git workflow, and am interested in fo=
lks=E2=80=99
feedback about whether my plan is reasonable or insane.

The problem that I=E2=80=99m trying to solve is: I use GitHub a lot for wor=
k,
but often find myself frustrated with GitHub=E2=80=99s =E2=80=9Cone-branch-=
per-change=E2=80=9D
model, as opposed to the =E2=80=9Ca-change-is-a-patch=E2=80=9D model used b=
y Phabricator
or Gerrit. When working on a stack of dependent commits (e.g., =E2=80=9Cadd=
 new
API=E2=80=9D followed by =E2=80=9Creplace callers of old API with new API=
=E2=80=9D followed by
=E2=80=9Cremove old API=E2=80=9D), I find it easiest to iterate on these co=
mmits by
rewriting the whole stack heavily in interactive rebases. After
rewriting a commit from early in the stack, I need to force-push the
rebased descendants to their respective remote branches. Currently, I
have a script [1] to automate pushing to the right branches, which
mostly gets rid of the pain. However, for various reasons, I=E2=80=99d like=
 to
remove the need to force-push at all.

[1]: https://gist.github.com/wchargin/3934c1c09812a2ad0e4f2092391e1ac8

For instance, suppose that I have commits A and B, which have also been
pushed to remote branches origin/a and origin/b. I amend A to A' in an
interactive rebase, so that my local state has B' on top of A'. Then,
I further amend B' to B''. The `git log --graph --oneline` looks like:

    Local (after interactive rebase):
    * (HEAD) B''
    * A'
    * (origin/master) whatever

    Remote (not yet updated):
    * (origin/b) B
    * (origin/a) A
    * (origin/master) whatever

The desired end state is that the diff of origin/master..origin/a should
be the same as the diff of A', and the diff of origin/a..origin/b should
be the same as the diff of B''. Again, force-pushing A':a and B'':b gets
the job done, but I=E2=80=99d like to send only fast-forward updates. Ideal=
ly,
each pushed commit should be easily readable by a code reviewer: I don=E2=
=80=99t
want a singular commit on origin/b to contain both the changes due to
the rebase on A' and the changes due to the amendment of B' to B''.

My plan to achieve this is: to update branch origin/x with commit X:

 1. Check out origin/x.
 2. Merge the unique parent of X into HEAD. If there are conflicts,
    merge them verbatim: include conflict markers in the commit, and
    =E2=80=9Ctake theirs=E2=80=9D on binary files.
 3. Create a new commit whose tree is exactly the tree of X and whose
    unique parent is the merge commit created in step (2).
 4. Push this commit to origin/x.

Roughly, in code:

    $ git checkout --detach "origin/${branch}"
    $ git merge "${X}~" -m "update diffbase"
    $ if merge_needs_resolution; then git add .; git commit --no-edit; fi
    $ commit=3D"$(printf ... | git commit-tree "${X}^{tree}" -p HEAD)"
    $ git push origin "${commit}:refs/heads/${branch}"

Conceptually, the topology looks like:

    Local:
    * (HEAD) B''
    * A'
    * (origin/master) whatever

    Remote:
    * (origin/b) commit with tree B''^{tree}
    * merge A' into B verbatim
    |\
    | * (origin/a) commit with tree A'^{tree}
    * | B
    |/
    * A
    * (origin/master) whatever

(though really origin/a and origin/b^^2 will be different commits with
the same tree according to the code above=E2=80=94it would be nicer if they
shared identity, too, and this is achievable with a bit of bookkeeping).

(Please note that the topology is only important for the duration of the
code review. When the patch is accepted, all of origin/a..origin/b is
squashed into one commit before merging, anyway. In my humble opinion,
this is further evidence that =E2=80=9Ca-change-is-a-patch=E2=80=9D is a mo=
re natural
model than =E2=80=9Cone-branch-per-change=E2=80=9D, but no matter.)

So, first question: does this sound like a reasonable objective and plan
so far?

My second question is more technical and relates to the implementation.
To create the merge in step (2), I plan to use a new git-worktree in a
temporary directory. Creating a merge requires _a_ worktree (can=E2=80=99t =
be
done bare), and I=E2=80=99d prefer not to use the user=E2=80=99s primary wo=
rktree, so
that (a) I don=E2=80=99t have to worry about uncommitted or unstaged change=
s
when executing this workflow, and (b) the user isn=E2=80=99t left in a bork=
ed
state if they SIGINT the process or something goes wrong and it aborts.

But, on the other hand, creating a whole worktree is a bit heavy-handed.
Creating a new worktree for linux.git takes about 6 seconds on my
laptop, which is not terrible considering that repository=E2=80=99s size, b=
ut
would be nice to avoid if possible. It would be great if I could create
a =E2=80=9Clazy worktree=E2=80=9D and only check out files actually needed =
for the
merge. Would the partial clone feature added in v2.19 be helpful here?

I=E2=80=99d greatly appreciate any suggestions or advice! I=E2=80=99m willi=
ng to be told
that I=E2=80=99m going about this all wrong and that my local workflow is b=
ad to
begin with, preferably with such a claim accompanied by the description
of a better workflow for handling stacks of dependent commits that need
to eventually be merged as separate GitHub pull requests. :-)

Best,
WC
