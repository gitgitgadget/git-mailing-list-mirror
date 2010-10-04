From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 3/6] tg-files: list files changed by the topic
	branch
Date: Mon, 4 Oct 2010 08:47:47 +0200
Message-ID: <20101004064747.GJ28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com> <20101003220330.GE28679@pengutronix.de> <AANLkTimLgWKPBjVAni=t6EK4Yr9FyJZa=Yk01SeMcwA1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2eq8-0004sU-CS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab0JDGrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:47:49 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42438 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0JDGrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:47:49 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2epw-0005BV-01; Mon, 04 Oct 2010 08:47:48 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2epv-0003OR-Op; Mon, 04 Oct 2010 08:47:47 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimLgWKPBjVAni=t6EK4Yr9FyJZa=Yk01SeMcwA1@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157988>

Hello Bert,

On Mon, Oct 04, 2010 at 08:43:52AM +0200, Bert Wesarg wrote:
> 2010/10/4 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Hi Bert,
> >
> > On Sun, Oct 03, 2010 at 11:25:54PM +0200, Bert Wesarg wrote:
> >> this could also be a --name-only option to tg-patch. But I Like th=
e
> >> similarity to 'quilt files'.
> >>
> >> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> >>
> >> ---
> >> =A0.gitignore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> >> =A0README =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +++++=
+
> >> =A0contrib/tg-completion.bash | =A0 =A01 +
> >> =A0tg-files.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 52 +++++++++++=
+++++++++++++++++++++++++++++++++
> >> =A04 files changed, 63 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/.gitignore b/.gitignore
> >> index 0342e09..0dc4d0e 100644 .gitignore
> >> --- a/.gitignore
> >> +++ b/.gitignore
> >> @@ -22,6 +22,8 @@
> >> =A0/tg-depend.txt
> >> =A0/tg-export
> >> =A0/tg-export.txt
> >> +/tg-files
> >> +/tg-files.txt
> >> =A0/tg-import
> >> =A0/tg-import.txt
> >> =A0/tg-info
> >> diff --git a/README b/README
> >> index f103d92..46f564a 100644 README
> >> --- a/README
> >> +++ b/README
> >> @@ -272,6 +272,14 @@ tg depend
> >>
> >> =A0 =A0 =A0 TODO: Subcommand for removing dependencies, obviously
> >>
> >> +tg files
> >> +~~~~~~~~
> >> + =A0 =A0 List files changed by the current or specified topic bra=
nch.
> >> +
> >> + =A0 =A0 Options:
> >> + =A0 =A0 =A0 -i =A0 =A0 =A0 =A0 =A0 =A0list files based on index =
instead of branch
> >> + =A0 =A0 =A0 -w =A0 =A0 =A0 =A0 =A0 =A0list files based on workin=
g tree instead of branch
> >> +
> >> =A0tg info
> >> =A0~~~~~~~
> >> =A0 =A0 =A0 Show a summary information about the current or specif=
ied
> >> diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.ba=
sh
> >> index 0ee233c..38567d0 100755 contrib/tg-completion.bash
> >> --- a/contrib/tg-completion.bash
> >> +++ b/contrib/tg-completion.bash
> >> @@ -467,6 +467,7 @@ _tg ()
> >> =A0 =A0 =A0 delete) =A0 =A0 =A0_tg_delete ;;
> >> =A0 =A0 =A0 depend) =A0 =A0 =A0_tg_depend ;;
> >> =A0 =A0 =A0 export) =A0 =A0 =A0_tg_export ;;
> >> + =A0 =A0 files) =A0 =A0 =A0 _tg_patch ;;
> >> =A0 =A0 =A0 help) =A0 =A0 =A0 =A0_tg_help ;;
> >> =A0 =A0 =A0 import) =A0 =A0 =A0_tg_import ;;
> >> =A0 =A0 =A0 info) =A0 =A0 =A0 =A0_tg_info ;;
> >> diff --git a/tg-files.sh b/tg-files.sh
> >> new file mode 100644
> >> index 0000000..0723bf1 tg-files.sh
> >> --- /dev/null
> >> +++ b/tg-files.sh
> >> @@ -0,0 +1,52 @@
> >> +#!/bin/sh
> >> +# TopGit - A different patch queue manager
> >> +# (c) Petr Baudis <pasky@suse.cz> =A02008
> >> +# GPLv2
> >> +
> >> +name=3D
> >> +
> >> +topic=3D
> >> +diff_opts=3D
> >> +diff_committed_only=3Dyes =A0 =A0 =A0# will be unset for index/wo=
rktree
> >> +
> >> +
> >> +## Parse options
> >> +
> >> +while [ -n "$1" ]; do
> >> + =A0 =A0 arg=3D"$1"; shift
> >> + =A0 =A0 case "$arg" in
> >> + =A0 =A0 -i)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 topic=3D'(i)'
> >> + =A0 =A0 =A0 =A0 =A0 =A0 diff_opts=3D"$diff_opts --cached";
> >> + =A0 =A0 =A0 =A0 =A0 =A0 diff_committed_only=3D;;
> >> + =A0 =A0 -w)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 topic=3D'(w)'
> >> + =A0 =A0 =A0 =A0 =A0 =A0 diff_committed_only=3D;;
> >> + =A0 =A0 -*)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 echo "Usage: tg [...] files [-i | -w] [N=
AME]" >&2
> >> + =A0 =A0 =A0 =A0 =A0 =A0 exit 1;;
> >> + =A0 =A0 *)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [ -z "$name" ] || die "name already spec=
ified ($name)"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 name=3D"$arg";;
> >> + =A0 =A0 esac
> >> +done
> >> +
> >> +
> >> +[ -n "$name" =A0-a =A0-z "$diff_committed_only" ] =A0&&
> >> + =A0 =A0 die "-i/-w are mutually exclusive with NAME"
> >> +
> >> +[ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/=
\(heads\|top-bases\)/##')"
> >> +base_rev=3D"$(git rev-parse --short --verify "refs/top-bases/$nam=
e" 2>/dev/null)" ||
> >> + =A0 =A0 die "not a TopGit-controlled branch"
> >> +
> >> +# if not index/worktree, topic is current branch
> >> +[ -z "$topic" ] && topic=3D"$name"
> >> +
> >> +
> >> +
> >> +# Evil obnoxious hack to work around the lack of git diff --exclu=
de
> >> +git diff --name-only $diff_opts "$base_rev" ${diff_committed_only=
:+"$name"} -- |
> >> + =A0 =A0 fgrep -vx ".topdeps" |
> >> + =A0 =A0 fgrep -vx ".topmsg" || : # fgrep likes to fail randomly?
> > Instead of using fgrep you could export the branch and call git dif=
f
> > --name-only $diff_opts on the resulting commit?
>=20
> If you mean using tg-export, than I think this is a bad idea. The
> operation will than be O(n), with n the total number of depending
> branches.
>=20
> I think a pretty_tree on the base and the branch with git diff-tree
> should suffice:
>=20
> git diff-tree --name-only $(pretty_tree refs/top-bases/$name)
> $(pretty_tree $name)
That's what I thought after sending the mail and shuting down my machin=
e
:-)

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
