From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4] git-svn: clarify the referent of dcommit's optional argument
Date: Thu, 17 May 2012 06:45:39 +1000
Message-ID: <CAH3AnrqQDfx7s1fXBgKJmFtMA33CW9qx2tWSoenqSR0pVc63WQ@mail.gmail.com>
References: <1337200956-9260-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 22:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUl6S-0000jS-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 22:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889Ab2EPUpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 16:45:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59690 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab2EPUpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 16:45:41 -0400
Received: by weyu7 with SMTP id u7so737557wey.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=g5lhUsH2TfzPL/UJ87+Ud+JCj1OTXzx2txu+N4OWVSM=;
        b=enV4Pv+wotUU4OTBT+ps+5S6/ZkRd4fTCuxJZdVBYhzoXAeTctr3myfJls6oGxKxze
         X997I5t1PmRrU2kDZBx2TMsIQ4xOwXFGma+sr8SgYUZsCo0C4qk9+HxfwrKLjiAe9M44
         wRB3VtCiCOlB9NSnxpzxtLITf465HNZcHFkcDcSsxQZx15+33BujrkO3n49C4MMtRzIc
         5B5Jd3XMVqqHe72dl6sFRT97xEdHITx09c8YOF6UmKsl8xhoMEapw0VOm7YX0W3gHP70
         QHZD0h5Ej2pvRntSdH6uZMNLiGvpsbTOowr90Vcd07sGGUu3gMK6VpP3EBR/wu4IRNkH
         xNIw==
Received: by 10.180.74.193 with SMTP id w1mr11560067wiv.4.1337201139742; Wed,
 16 May 2012 13:45:39 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Wed, 16 May 2012 13:45:39 -0700 (PDT)
In-Reply-To: <1337200956-9260-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197901>

On Thu, May 17, 2012 at 6:42 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> The documentation of the dcommit subcommand is reworded to clarify th=
at
> the optional argument refers to a git branch, not an SVN branch.
>
> The discussion of the optional argument is put into its own paragraph
> as is the guidance about using 'dcommit' in preference to 'set-tree'.
>
> The section on REBASE vs. PULL/MERGE is reworded to incorporate the
> advice to prefer 'git rebase' previously in the description of 'dcomm=
it'.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =C2=A0Documentation/git-svn.txt | 40 +++++++++++++++++++-------------=
--------
> =C2=A01 file changed, 19 insertions(+), 21 deletions(-)
>
> Restore original meaning that pull/merge causes issues specifically
> with set-tree A..B (not with set-tree A, in general).
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 34ee785..4384ed9 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -189,18 +189,16 @@ and have no uncommitted changes.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0last fetched commit from the upstream SVN.
>
> =C2=A0'dcommit'::
> - =C2=A0 =C2=A0 =C2=A0 Commit each diff from a specified head directl=
y to the SVN
> + =C2=A0 =C2=A0 =C2=A0 Commit each diff from the current branch direc=
tly to the SVN
> =C2=A0 =C2=A0 =C2=A0 =C2=A0repository, and then rebase or reset (depe=
nding on whether or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not there is a diff between SVN and head).=
 =C2=A0This will create
> =C2=A0 =C2=A0 =C2=A0 =C2=A0a revision in SVN for each commit in git.
> - =C2=A0 =C2=A0 =C2=A0 It is recommended that you run 'git svn' fetch=
 and rebase (not
> - =C2=A0 =C2=A0 =C2=A0 pull or merge) your commits against the latest=
 changes in the
> - =C2=A0 =C2=A0 =C2=A0 SVN repository.
> - =C2=A0 =C2=A0 =C2=A0 An optional revision or branch argument may be=
 specified, and
> - =C2=A0 =C2=A0 =C2=A0 causes 'git svn' to do all work on that revisi=
on/branch
> - =C2=A0 =C2=A0 =C2=A0 instead of HEAD.
> - =C2=A0 =C2=A0 =C2=A0 This is advantageous over 'set-tree' (below) b=
ecause it produces
> - =C2=A0 =C2=A0 =C2=A0 cleaner, more linear history.
> ++
> +When an optional git branch name (or a git commit object name)
> +is specified as an argument, the subcommand works on the specified
> +branch, not on the current branch.
> ++
> +Use of 'dcommit' is preferred to 'set-tree' (below).
> =C2=A0+
> =C2=A0--no-rebase;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0After committing, do not rebase or reset.
> @@ -800,18 +798,18 @@ have each person clone that repository with 'gi=
t clone':
>
> =C2=A0REBASE VS. PULL/MERGE
> =C2=A0---------------------
> -
> -Originally, 'git svn' recommended that the 'remotes/git-svn' branch =
be
> -pulled or merged from. =C2=A0This is because the author favored
> -`git svn set-tree B` to commit a single head rather than the
> -`git svn set-tree A..B` notation to commit multiple commits.
> -
> -If you use `git svn set-tree A..B` to commit several diffs and you d=
o
> -not have the latest remotes/git-svn merged into my-branch, you shoul=
d
> -use `git svn rebase` to update your work branch instead of `git pull=
` or
> -`git merge`. =C2=A0`pull`/`merge` can cause non-linear history to be=
 flattened
> -when committing into SVN, which can lead to merge commits reversing
> -previous commits in SVN.
> +Prefer to use 'git svn rebase' or 'git rebase', rather than
> +'git pull' or 'git merge' to synchronize unintegrated commits with a=
 'git svn'
> +branch. Doing so will keep the history of unintegrated commits linea=
r with
> +respect to the upstream SVN repository and allow the use of the pref=
erred
> +'git svn dcommit' subcommand to push unintegrated commits back into =
SVN.
> +
> +Originally, 'git svn' recommended that developers pulled or merged f=
rom
> +the 'git svn' branch. =C2=A0This was because the author favored `git=
 svn set-tree B`
> +to commit a single head rather than the `git svn set-tree A..B` nota=
tion to
> +commit multiple commits. Use of 'git pull' or 'git merge' with `git =
svn set-tree A...B`

A...B -> A..B

Will fix in next iteration, assuming Junio and Eric are otherwise
happy with the update.

jon.
