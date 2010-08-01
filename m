From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2] Documentation: =?utf-8?Q?fl?=
	=?utf-8?B?ZXNoIG91dCDigJxnaXQgcHVsbOKAnQ==?= description
Date: Sat, 31 Jul 2010 21:54:39 -0500
Message-ID: <20100801025439.GA9592@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitser@pobox.com>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOiW-0006hE-V7
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab0HACzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:55:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37056 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab0HACzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:55:54 -0400
Received: by iwn7 with SMTP id 7so2792209iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=1WKTPuEBF5gOIf3urJbS0EV7/fWalzL6No+q/vg4Qwo=;
        b=QTyXu4e51QdxC4h+h1mTPq6asYXiCTe/kLozxQ/pXUlgAx8RnxPVEDBjPo1uF4oHYp
         5ck51Aut9jYjIjrVkTyun3xziFxK8STLbL38d2q+guZffJ8Sa8QTUlSyE3krppbyPLnE
         LHrfuWOX2J0LlmjXsNkcPEhySmtm3Zhxlxs7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=cKf1poXVrRKf+02KuAHIyxpAOCwfMH45HamHLWENfkO5FZMbFg5WNPl0WZyqYx5taG
         T8Bt6iQ3Lxb2PDPd+ZLpSeuJBGpqQFWFkd3Gu+OWvCaUx6F8Xz3SAhE0/4LGzH5uYWvC
         Y4QtQs564/bbIfn3p+Cy7awMA5sU3ctUoiIv0=
Received: by 10.231.157.195 with SMTP id c3mr4224971ibx.155.1280631353015;
        Sat, 31 Jul 2010 19:55:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm3780896ibk.3.2010.07.31.19.55.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:55:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152364>

The current description in the pull man page does not say much more
than that =E2=80=9Cgit pull=E2=80=9D is fetch + merge.  Though that is =
all a person
needs to know in the end, it would be useful to summarize a bit about
what those commands do for new readers.

Most of this description is taken from the =E2=80=9Cgit merge=E2=80=9D =
docs.

Now that we explain how to back out of a failed merge (reset --merge),
we can tone down the warning against that a bit.

Except, as Thomas noticed, there=E2=80=99s a risk with that because peo=
ple
might read this version of the manpage online and then conclude that
it is safe to try a merge with uncommitted changes, only to find that
their =E2=80=9Cgit reset=E2=80=9D doesn't support --merge yet.  Or wors=
e, verify that
their git-reset has --merge by a quick test (1b5b465 is in 1.6.2) but
then find that it does not help with backing out of a merge (e11d7b5
is only in 1.7.0!).  For the master copy of the documentation on
kernel.org (but not the historical versions) we should keep the
warning.

So abuse the staledocs[] macro (currently used to suppress the Note in
git.html about previous versions of documentation) to distinguish
these cases.

Noticed-by: Geoff Russell <geoffrey.russell@gmail.com>
Improved-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Improved-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v1[1]:

 - remove a stray article
 - stop lying in the synopsis
 - use an ifdef to allow the warning about situations that may be diffi=
cult to
   recover from to be kept when building the "universal" docs that shou=
ld
   apply to git versions before 1.7, too.

Junio: ideally for this to work, git-pull.html would need to get the
same special treatment as git.html gets.  Does that seem doable?  Is
Meta/dodoc.sh still the script to do it?

[1] http://thread.gmane.org/gmane.comp.version-control.git/151799/focus=
=3D151801

 Documentation/git-pull.txt |   70 ++++++++++++++++++++++++++++++++++++=
+-------
 1 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ab4de10..54e9619 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,29 +8,77 @@ git-pull - Fetch from and merge with another reposito=
ry or a local branch
=20
 SYNOPSIS
 --------
-'git pull' <options> <repository> <refspec>...
+'git pull' [options] [<repository> [<refspec>...]]
=20
=20
 DESCRIPTION
 -----------
-Runs 'git fetch' with the given parameters, and calls 'git merge'
-to merge the retrieved head(s) into the current branch.
-With `--rebase`, calls 'git rebase' instead of 'git merge'.
=20
-Note that you can use `.` (current directory) as the
-<repository> to pull from the local repository -- this is useful
-when merging local branches into the current branch.
+Incorporates changes from a remote repository into the current
+branch.  In its default mode, `git pull` is shorthand for
+`git fetch` followed by `git merge FETCH_HEAD`.
=20
-Also note that options meant for 'git pull' itself and underlying
-'git merge' must be given before the options meant for 'git fetch'.
+More precisely, 'git pull' runs 'git fetch' with the given
+parameters and calls 'git merge' to merge the retrieved branch
+heads into the current branch.
+With `--rebase`, it runs 'git rebase' instead of 'git merge'.
=20
-*Warning*: Running 'git pull' (actually, the underlying 'git merge')
+<repository> should be the name of a remote repository as
+passed to linkgit:git-fetch[1].  <refspec> can name an
+arbitrary remote ref (for example, the name of a tag) or even
+a collection of refs with corresponding remote tracking branches
+(e.g., refs/heads/*:refs/remotes/origin/*), but usually it is
+the name of a branch in the remote repository.
+
+Default values for <repository> and <branch> are read from the
+"remote" and "merge" configuration for the current branch
+as set by linkgit:git-branch[1] `--track`.
+
+Assume the following history exists and the current branch is
+"`master`":
+
+------------
+          A---B---C master on origin
+         /
+    D---E---F---G master
+------------
+
+Then "`git pull`" will fetch and replay the changes from the remote
+`master` branch since it diverged from the local `master` (i.e., `E`)
+until its current commit (`C`) on top of `master` and record the
+result in a new commit along with the names of the two parent commits
+and a log message from the user describing the changes.
+
+------------
+          A---B---C remotes/origin/master
+         /         \
+    D---E---F---G---H master
+------------
+
+See linkgit:git-merge[1] for details, including how conflicts
+are presented and handled.
+ifndef::stalenotes[]
+To cancel a conflicting merge, use `git reset --merge`.
+endif::stalenotes[]
+ifdef::stalenotes[]
+
+In git 1.7.0 or later, to cancel a conflicting merge, use
+`git reset --merge`.  *Warning*: In older versions of git, running 'gi=
t pull'
 with uncommitted changes is discouraged: while possible, it leaves you
-in a state that is hard to back out of in the case of a conflict.
+in a state that may be hard to back out of in the case of a conflict.
+endif::stalenotes[]
+
+If any of the remote changes overlap with local uncommitted changes,
+the merge will be automatically cancelled and the work tree untouched.
+It is generally best to get any local changes in working order before
+pulling or stash them away with linkgit:git-stash[1].
=20
 OPTIONS
 -------
=20
+Options meant for 'git pull' itself and the underlying 'git merge'
+must be given before the options meant for 'git fetch'.
+
 -q::
 --quiet::
 	This is passed to both underlying git-fetch to squelch reporting of
--=20
1.7.2.1.544.ga752d.dirty
