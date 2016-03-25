From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [RFC/GSOC] Git Beginner | Warnings for potentially destructive
 commands
Date: Fri, 25 Mar 2016 15:48:49 +0530
Message-ID: <56F51089.2050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	philipoakley@iee.org, Jacob Keller <jacob.keller@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:19:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOpb-0007xG-MP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 11:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbcCYKS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 06:18:58 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36572 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCYKS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 06:18:57 -0400
Received: by mail-pa0-f48.google.com with SMTP id tt10so43970582pab.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=A2lhyqNw4c7+n7uW+DLs8rFSNF2VRwzKVq0gmThbYeQ=;
        b=gYYzEFbpR8tAJJfffMSOCnQBlU6qxe9cKi0bMgaYXVKWfJTsmF9ceJIsFZlgD+DAsw
         WD7tgkFJy24BxdsAUNVRuPgHY8rk9uUaKT/zz5SqXcEgyYJ/4SiMpNH1XkBFbBjRM9rD
         fl7TERjDKN+aCtKgTACdu2zDQEM9aOlm4ok0WOs5ju0gD7DQ+Yq7CvFvvsulQBR2Y8C4
         6jboS4z2iNxg52bPDg48BBnco7v9uQ12GRfpO+MXrfxcFYFb/Q6uZYg2Sc4HvM1JZiCE
         Q4v5LTEZtTrwrWYOKJi4khy31aaY0FB2e7vf6dnkFk5kVyayXEdgxzCF4oiIRKxSppHH
         YzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=A2lhyqNw4c7+n7uW+DLs8rFSNF2VRwzKVq0gmThbYeQ=;
        b=jxXJDaQm5/R5TNxxZwvneqAL7v2TEcLXGW9f2il+xVfxAqPrH0uWWYMJZI1vxb6Pq3
         /mffyWAInHGAcq2PKytGuoaYCX50GWaZGcrqEWrCg4KHX+Df5cZUh52cesuuDI8E7S3j
         bVtOIPFE17Mvmt6JLttaE0yxK9CN8ks3xccGgTXpcl8tiqm8uHsxcH31pt9eATnV2jg0
         QlLmUsRei9/Zi5nAChtPeCPhORzM8NK51R51Z7+VDEqC8Ul73ZfExp5JmIRnpYDGlwuG
         By9H1hEV2P2silQVudXY3mLOVCBMK+FblLGG98NmDUmLBAW5/loaMcZ0q0Y6Fz23Yef2
         kafg==
X-Gm-Message-State: AD7BkJLk7HL9uC2WTJXtXSa3DSeaOaOkcoYDu/nyhFFAEhFtq/mdVq+K3firLx9n75IExg==
X-Received: by 10.67.21.167 with SMTP id hl7mr19729819pad.16.1458901136091;
        Fri, 25 Mar 2016 03:18:56 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.3.234])
        by smtp.gmail.com with ESMTPSA id yj1sm15538314pac.16.2016.03.25.03.18.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 03:18:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289874>

Hi,

I made an attempt at writing warning messages for the commands the begi=
nners
will be warned against, and would like to request your comments and fee=
dback
on them. I tried to keep them simple, beginner friendly and educative o=
f the
outcome of those commands.
I'd also like to ask if `git rebase` should be kept in the
list as it may not be bad in most cases, though I prepared a
message for that anyway.


Thanks and regards,
Sidhant Sharma


The current list of graylisted commands is as follows:
$ git rebase
$ git reset --hard
$ git clean -f
$ git gc --prune=3Dnow --aggressive
$ git push -f <branch>
$ git push remote [+/:]<branch>
$ git branch -D

Warning messages:

$ ggit rebase

[WARNING] You are about to rebase your commits in <topic-branch> onto t=
he
$BASE_BRANCH, which will essentially replay the work done in $TOPIC_BRA=
NCH
since last merge onto $BASE_BRANCH.
=46or instance,
Current state:

    o---o---A---B  $BASE_BRANCH
         \
          X---Y  $TOPIC_BRANCH

State after rebasing:

    o---o---A---B---X'---Y'  $BASE_BRANCH
         \
          X---Y  $TOPIC_BRANCH

where X' and Y' are the commits making changes identical to those made =
by X and
Y respectively.
Rebasing is not usually problematic except in cases when you are rebasi=
ng
commits that do not exist in your repository.


$ ggit reset --hard

Resetting to <destination-commit-hash>
[WARNING] You are about to hard reset the current HEAD (master) by <n> =
commit(s).
This will take you back to commit <destination-commit-hash>, and discar=
d all
changes make thereafter. For instance,
Current state:

    o---o---A---B---C---D---E  $CURRENT_BRANCH

After resetting 3 commits:

    o---o---A---B  $CURRENT_BRANCH

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
[WARNING] You are about to purge commits from the <URL of origin> maste=
r branch.
=46or instance,
Current state:

        o---o---o---A---B  master on $ORIGIN_URL
             \
              X---Y---Z  your master

State after forced push:

        o---o---o---X---Y---Z  master on $ORIGIN_URL and your master

Commit A and B will be gone. If other people have worked on top of A or=
 B then
they won't be able to merge their changes easily.


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
( ggit push <remote> +<basebranch>:<targetbranch> )

Pushing changes to $REMOTE/$BRANCH
[WARNING] You are attempting to push changes from $BASE_BRANCH to $TARG=
ET_BRANCH
while allowing non-fast-forward updates. This can leave unreferenced co=
mmits
dangling in the origin repository.
=46or instance,
Current state:

        o---o---A---B  $REMOTE/$TARGET_BRANCH
             \
              X---Y---Z  your $BASE_BRANCH

State after forced push:

        o---o---A---B    (unnamed branch)
             \
              X---Y---Z  $REMOTE/$TARGET_BRANCH and your $BASE_BRANCH

Commits A and B would no longer belong to a branch with a symbolic name=
, and so
would be unreachable. Also, people who have based their work on A or B =
would
have to either merge or rebase after you have pushed.
If you wish to keep both the changesets (A,B and X,Y,Z), you may want t=
o use
`merge` or `rebase`.


$ ggit branch -D
( ggit branch -d -f )

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

Cleaning $PATH
[WARNING] You are about to clean $PATH, which will permanently delete a=
ll files
and directories present at the given path. Note that it would not be po=
ssible to
revert this action, and all files not tracked by git will be list perma=
nently.
If you only wish to see what will be deleted on running `ggit clean`, u=
se the
`-n` or `--dry-run` option.


$ ggit gc --prune=3Dnow --aggressive
(or $ ggit  gc --prune=3Dall --aggressive)

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


Accepting input:

Are you sure you want to continue? [Y/n]
