From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Problem with --work-tree
Date: Mon, 18 Aug 2008 11:32:28 +0200
Message-ID: <g8bfjc$551$1@ger.gmane.org>
References: <48A74325.1040805@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 11:33:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV17U-0001fz-Ks
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 11:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYHRJcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 05:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYHRJcp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 05:32:45 -0400
Received: from main.gmane.org ([80.91.229.2]:50177 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbYHRJco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 05:32:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KV16L-0005UV-7U
	for git@vger.kernel.org; Mon, 18 Aug 2008 09:32:37 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 09:32:37 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 09:32:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48A74325.1040805@school9.perm.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92693>

=D0=A1=D0=B5=D1=80=D0=B3=D0=B5=D0=B9 =D0=A8=D0=B0=D1=80=D1=8B=D0=B1=D0=B8=
=D0=BD venit, vidit, dixit 16.08.2008 23:14:
> Hi,
>=20
> I've got the following problem. I've got a GIT repo at=20
> /home/nazgul/src/test-work-tree and I've got some changed files in th=
is=20
> repo. I want to see this changes when a `git` runs outside this=20
> directory. I tried to run `git=20
> --git-dir=3D/home/nazgul/src/test-work-tree/.git=20
> --work-tree=3D/home/nazgul/src/test-work-tree diff-index --name-statu=
s=20
> HEAD` from my home directory. In such way diff-index tells me that al=
l=20
> files from my repo has been deleted. I think it is because this comma=
nd=20
> does not understand a --work-tree parameter. And I saw the same probl=
em=20
> with a git diff command (something like that: git=20
> --git-dir=3D/home/nazgul/src/test-work-tree/.git=20
> --work-tree=3D/home/nazgul/src/test-work-tree diff).
>=20
> I use git version debian.1.5.6.3.1
>=20
> Is it my mistake or it is bugs in a GIT?

Working from a path outside the work tree is broken (read: not meeting
the obvious/naive meaning of the --work-tree option and core.worktree
setting) in many places, unfortunately. Some commands work with
--git-dir and the like, but some just don't. I use a shell alias which
cds into the work tree first. This works with everything except for som=
e
stubborn tcl/tk scripts doing their own thing (gui...) in case git-dir
and work-tree are not in the standard places (.git, .).

Michael
