From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [RFC/GSOC] Git Beginner | Warnings for potentially destructive
 commands (v2)
Date: Wed, 30 Mar 2016 21:27:20 +0530
Message-ID: <56FBF760.3040106@gmail.com>
References: <56F51089.2050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	philipoakley@iee.org, Jacob Keller <jacob.keller@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 17:57:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alIUy-0005e9-F1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 17:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbcC3P52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 11:57:28 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35398 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbcC3P50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 11:57:26 -0400
Received: by mail-pf0-f181.google.com with SMTP id n5so46335465pfn.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Gjp/0JnTrIAZ1s6i2tGAy/OOMM+btoppQimaQPjOIxg=;
        b=tmX8/O0C78Yo1sqlCuXJC2EXMxaXB1qI5VLm601EdYPpESAApU/BKvrq+HaRdn2Z1d
         HsKdNUtjNNrBxMGIcqW55z9a+4rJURR4HbQSnNR2CD3tw/JQ/IXORp4ALwHgr2hDct+r
         cCFltzZ94UiUv78c8YHddU2DA6ZYIyqUUGbmEHITIQr2qild5fdoCcnjCPVvCSyKQXB8
         C06QsJzJy+V55+jmyxyAVyIwj/UdgvEUp1z20825MqhJQbFnZ0N+nf4r9xdRMaB+vOPb
         Z/VV430ao7DMfWeOK8JPpGjExxmGVePsgZkOLHuXdBD/hzG2a607xuCxOGj5wHq5MWls
         XSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Gjp/0JnTrIAZ1s6i2tGAy/OOMM+btoppQimaQPjOIxg=;
        b=ihyQZeO5na0bSqctq+X4Z5JSJSP0W7t5ygDw6f0t4PXJ7/n1vt7pKC2z1R29d64rwP
         5dy+C5Y9+5HWq+5kyXEhpGvkLMq9mPIZRL6eIQJlPUsreWItZdaclz/Gw8EkM+bVw3qU
         0Li1LX88fdB/mBuG9GvnPPiU8cHAvqJ1IyzaBGe2Avr2XWZPGWfJTYVBLZdxnVpN85Vg
         k6RS4jqVCJAg61NplVNZ9oeQlr44w1EJIJWYDqnqAXEo7Qfa3SrUrfhaWKBLEilitAjQ
         xqxvz4ev6ohbZTSsA77yStLiOc1vui16Lg3yWvDQ7A2llta+Gt2/buBQsNIOxhPa5Ov8
         2sBA==
X-Gm-Message-State: AD7BkJLm0in7aHztVaGNlAXQMch8YOq3ZpArcqcG135BJebG9LBaY/bQcyI6umbK8XE9FA==
X-Received: by 10.98.67.199 with SMTP id l68mr14230548pfi.18.1459353445680;
        Wed, 30 Mar 2016 08:57:25 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.3.234])
        by smtp.gmail.com with ESMTPSA id 82sm6932854pfb.64.2016.03.30.08.57.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 08:57:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56F51089.2050703@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290309>

Updated the warning messages, and added warnings for two more commands
(`checkout --` and `stash clear`). The list is now:
$ git rebase
$ git reset --hard
$ git clean -f
$ git gc --prune=3Dnow --aggressive
$ git push -f <branch>
$ git push remote [+/:]<branch>
$ git branch -D
$ git checkout [-p] [<tree-ish>] -- <path>
$ git stash clear

Looking forward to your comments.

Thanks and regards,
Sidhant Sharma

---

$ ggit rebase

[WARNING] You are about to rebase your commits in $TOPIC_BRANCH onto th=
e
$BASE_BRANCH, which will essentially replay the work done in $TOPIC_BRA=
NCH
since last merge onto $BASE_BRANCH.
=46or instance, assume the following history exists and the current bra=
nch is
master:

    o---o---A---B  master
         \
          X---Y  topic

After rebasing, the history would be:

    o---o---A---B  master
                 \
                    X'---Y'  topic

where X' and Y' are the commits making changes identical to those made =
by X and
Y respectively.
Rebasing is not usually problematic except in cases when you are rebasi=
ng
commits that exist outside your repository (such as on a remote or on s=
omeone
else's computer).

$ ggit reset --hard

Resetting to <destination-commit-hash>
[WARNING] You are about to hard reset the current HEAD ($CURRENT_BRANCH=
) to a
previous commit in history, possibly in another branch. This will disca=
rd all
changes make thereafter.
=46or instance, assume the following history exists and the current bra=
nch is
master:

    o---o---A---B---C---D---E  master

After resetting 3 commits:

    o---o---A---B  master

The commits C, D and E and the changes made by them will be lost.
Note that if you make commits on top of B, you would have rewritten the=
 history
and would have trouble restoring it easily.
You can undo this action by resetting the HEAD to the last commit you w=
ere on,
which can be seen by running `git reflog`. The first entry (HEAD{1}) po=
ints to
the current HEAD location, second entry (HEAD{1}) points to the last po=
sition of
your HEAD and so on.
If you want to reset while retaining the changes made since, use --soft=
 instead
of --hard. This will reset without discarding the changes made in the p=
revious
commits.

$ ggit push --force

Pushing changes to $REMOTE/$BRANCH
[WARNING] You are about to purge commits from the $REMOTE/$BRANCH branc=
h and
overwrite it's history to match yours.
=46or instance, assume the following history exists where 'origin' is a=
 configured
remote and the current branch is master:

        o---o---o---A---B  origin/master
             \
              X---Y---Z  your master

After force push:

        o---o---o---X---Y---Z  origin/master and your master

Commit A and B will be gone. If other people have worked on top of A or=
 B then
they won't be able to merge their changes easily.
To revert this, you would have to force push from a computer that has n=
ot yet
pulled the changes you pushed and still has commits A and B as they wer=
e in
origin/master previously.

$ ggit push <remote> :<branch> ( ggit push <remote> --delete <branch> )

Pushing changes to $REMOTE/$BRANCH
[WARNING] You are about delete a remote branch, which will result in th=
e loss
of commits made on that branch. This may cause a problem if other peopl=
e are
working on the branch you are deleting, as they would not be able to pu=
sh or
merge their changes easily.
You can undo this by pushing the same branch to the remote with upstrea=
m flag,
that is, by running:
`$ ggit push -u $REMOTE $BRANCH`
This will work unless you have deleted the branch locally as well. In t=
hat case,
you need to restore it first.

$ ggit push <remote> +<branch>
( or ggit push <remote> +<basebranch>:<targetbranch> )

Pushing changes to $REMOTE/$BRANCH
[WARNING] You are attempting to push changes from $BASE_BRANCH to $TARG=
ET_BRANCH
while allowing non-fast-forward updates. This can leave unreferenced co=
mmits
dangling in the origin repository.
=46or instance, assume the following history exists where 'origin' is a=
 configured
remote and the current branch is master:

        o---o---A---B  origin/master
             \
              X---Y---Z  your master

State after forced push:

        o---o---A---B    (unnamed branch)
             \
              X---Y---Z  origin/master and your master

Commits A and B would no longer belong to a branch with a symbolic name=
, and so
would be unreachable. Also, people who have based their work on A or B =
would
have to either merge or rebase after you have pushed.
If you wish to keep both the changesets (A,B and X,Y,Z), you may want t=
o use
`merge` or `rebase`.

$ ggit branch -D
( or ggit branch -d -f )

Deleting branch $TARGET_BRANCH
[WARNING] You are about to force delete the $TARGET_BRANCH branch. This=
 will
cause git to delete the branch even if it has not been merged, which ma=
y result
in loss of commits. Unless you are confident the branch has been merged=
, use
`-d` or `--delete` without `--force` which will warn you if the branch =
has not
been merged.
You can restore a forcefully deleted branch by running:
`$ git branch <branch-name> <sha1>`
where <branch-name> is the name of the branch you wish to restore and <=
sha1> is
the last commit made to the branch you want to restore. You can find th=
is
information by running `git reflog`.
To undo deletion of this branch, you can run:
`$ ggit branch $TARGET_BRANCH $LAST_COMMIT_SHA`

$ ggit clean -f [<path>]

Cleaning <path>
[WARNING] You are about to clean <path>, which will delete all files an=
d
directories at the given path which are not tracked by git. Note that i=
t would
not be possible to revert this action, and all files not in present in =
the index
will be lost permanently.
If you only wish to see what will be deleted on running `ggit clean`, u=
se the
`-n` or `--dry-run` option.

$ ggit gc --prune=3Dnow --aggressive
( ggit  gc --prune=3Dall --aggressive)

Running garbage collection
[WARNING] You are about to prune all objects, regardless of their age o=
r
reachability. The `--aggressive` flag tells git to aggressively optimiz=
e the
repository at the cost of taking more time to complete the operation. B=
y setting
`--prune` option to `now` or `all`, you ask git to optimize all objects=
, and not
just the unreachable ones. Unless the repository is quiescent, you will=
 lose
newly created objects that haven=E2=80=99t been anchored with the refs =
and end up
corrupting your repository.
It is also not possible to revert the actions taken by `git gc`.

$ ggit checkout [-p] [<tree-ish>] -- <path>

Discarding changes from working tree
[WARNING] You are about to permanently discard the unstaged changes pre=
sent in
<path>. This will bring <path> to its state as stored in the index, or =
to the
state at <tree-ish>.
If you wish to see what changes will be discarded and/or choose which c=
hanges
are will be discarded, use the `-p` or `--patch` flag.
The actions made by this command cannot be undone.

$ ggit rm [--cached] <file>

Removing file(s): <file>
[WARNING] You are about to remove files/directories from the git index.=
 This
will cause git to stop tracking them, as well as delete them from the l=
ocal
filesystem. Using the `--cached` flag will only remove them from the in=
dex and
not the filesystem.
If you only wish to see which files will be removed, use the `-n` or `-=
-dry-run`
flag.
You can revert the effects of this command by either restoring the file=
s
manually and running `ggit add <file>` or by running `ggit reset --hard=
`.

$ ggit stash clear

Dropping all stashed states
[WARNING] You are about to remove all the stashed states. Note that tho=
se states
will then be subject to pruning, and may be impossible to recover. To v=
iew all
stashes, use `ggit stash list`. To selectively drop stashes, use
`ggit stash drop <stash>`.

Accepting input
Are you sure you want to continue? [Y/n]
