From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git pull (Re: need advice on usage patterns)
Date: Sun, 25 Jul 2010 22:36:34 -0500
Message-ID: <20100726033634.GA30877@burratino>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 05:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdEVu-0002FU-AF
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 05:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab0GZDhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 23:37:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48192 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab0GZDhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 23:37:46 -0400
Received: by iwn7 with SMTP id 7so2434003iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 20:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7kMvUiNWiv9KhKkVwAzYT/o5C6hh1kjzeECGIVbiQ/I=;
        b=id0xiGonop1BxhSe9tdNDiqOJt3QuM6f3MEaA5+RM+JRu6mFvojjFL4pK+jvLIBs8s
         2a1DH/KAP7r0TVgoWp0JJeNL+Htv/oWnqRlFXx/5AZpsLj2nLxt+1yM6uJHa2jCA8lmL
         3oi5w3D6KB5q09/uDi+Sju2QQ8WpWF3b759V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QZaQgNWn7SdnRPvHo1rx0VF2pNHqAEEnmNKfROI21K6hNqQSibpXUguV0MJp6+CftV
         JuIScp7XCkL3s4997ouFVZoy+jRW/8GlMXdfIVhcOvRro4jCOGCUIJGoTa2XuAROVm0Q
         yrjOZXq77sSSpgtONDPE2MjF9gve5srT3qB9E=
Received: by 10.231.177.25 with SMTP id bg25mr7316892ibb.154.1280115464379;
        Sun, 25 Jul 2010 20:37:44 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm3198188ibe.5.2010.07.25.20.37.41
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 20:37:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151801>

Hi Geoff,

Geoff Russell wrote:

> There are notes on the "git pull" man page about not working on a rem=
ote branch
> but having a local branch with a different name and merging the remot=
e branch.
> Why is this necessary?

The "git pull" man page is very unclear, I agree.  Especially when
starting out, I would recommend looking at the User=E2=80=99s Manual (a=
nd the
other resources the git(1) man page recommends).

In this case, the section to look at would be Chapter 4, on Sharing
development with others[1].

Thanks for noticing.
Jonathan

[1] http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#sh=
aring-development

-- 8< --
Subject: pull documentation: Flesh out description

The current description in the pull man page does not say much more
than that =E2=80=9Cgit pull=E2=80=9D is fetch + merge.  Though that is =
all a person
needs to know in the end, it would be useful to summarize a bit about
what those commands do for new readers.

Most of this description is taken from the =E2=80=9Cgit merge=E2=80=9D =
docs.

Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-pull.txt |   61 +++++++++++++++++++++++++++++++++++-=
-------
 1 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ab4de10..8803680 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,29 +8,66 @@ git-pull - Fetch from and merge with another reposito=
ry or a local branch
=20
 SYNOPSIS
 --------
-'git pull' <options> <repository> <refspec>...
+'git pull' <options> <repository> <branch>...
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
+branch.  In its default mode, a `git pull` is shorthand for
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
-with uncommitted changes is discouraged: while possible, it leaves you
-in a state that is hard to back out of in the case of a conflict.
+<repository> should be the name of a remote repository as
+passed to linkgit:git-fetch[1].  <branch> can be an
+arbitrary refspec (for example, the name of a tag), but
+usually it is the name of a branch in the remote repository.
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
+are presented and handled.  To cancel a conflicting merge,
+use `git reset --merge`.
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
1.7.1
