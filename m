From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 18:22:42 +0100
Message-ID: <200802241822.42594.robin.rosenberg.lists@dewire.com>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com> <200802241645.49718.jnareb@gmail.com> <vpqve4efiql.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Feb 24 18:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTKZW-0007Xc-RX
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 18:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYBXRWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 12:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYBXRWz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 12:22:55 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13485 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbYBXRWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 12:22:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C3129802677;
	Sun, 24 Feb 2008 18:22:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lz6czid+xRxn; Sun, 24 Feb 2008 18:22:52 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 476B780264D;
	Sun, 24 Feb 2008 18:22:52 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <vpqve4efiql.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74946>

s=F6ndagen den 24 februari 2008 skrev Matthieu Moy:
> I suppose you have to forbid merges where anything non-trivial happen=
s
> outside the tree (i.e. allow it only if the set of renamed or changed
> files is disjoint outside the tree, or only if only one of the
> branches to merge have changes outside the tree).
One still has to allow it, maybe forcing a bigger checkout in those
cases.

> That's probably not such a big limitation in practice for the user,
> since by definition the user won't modify the files outside its tree,
> so he can at least still merge with the branch he branched from.
Partial checkout is for convenience and speed of worktree operations as=
=20
I see it. Other people could have other reasons for it. Branch switchin=
g takes a lot of time with big repos, same thing with git status, add -=
u etc. Restricting the worktree scan for uninteresting parts speeds thi=
ngs up.

> I can see another problem: partial checkout is really interesting onl=
y
> if you can do a partial clone ("partial" here in the sense "subtree")=
=2E
> Otherwise, your .git/ still eats your disk space and "clone" still
> needs your bandwidth for something you won't use.

Better and more of "global" operations on repos with submodules might m=
ake them more bearable, and maybe even convenient, for example doing a =
git diff
over a set of submodules detecting renames between submodules.

-- robin
