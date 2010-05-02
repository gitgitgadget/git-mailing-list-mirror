From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: WANTED: patch splitting tool - waypoints
Date: Sun, 2 May 2010 23:10:33 +0200
Message-ID: <201005022310.34169.robin.rosenberg@dewire.com>
References: <20100502115842.GA11607@brong.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bron Gondwana <brong@brong.net>
X-From: git-owner@vger.kernel.org Sun May 02 23:10:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8gR4-0006rz-5b
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 23:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773Ab0EBVKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 17:10:41 -0400
Received: from mail.dewire.com ([83.140.172.130]:13537 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758751Ab0EBVKk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 17:10:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C4DB4138BF58;
	Sun,  2 May 2010 23:10:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jcY5l2+4yfj4; Sun,  2 May 2010 23:10:37 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id ED09A800388;
	Sun,  2 May 2010 23:10:36 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20100502115842.GA11607@brong.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146203>

s=F6ndagen den 2 maj 2010 13.58.42 skrev  Bron Gondwana:
> Hi,
>=20
> My toolkit is missing a tool.  I've never seen it
> or anything like it, but I can describe it - and
> hopefully someone else knows if it exists.
>=20
> It's basically a combination of git rebase -i and
> git add -p.  Something that allows you to split
> either a single patch or a series of patches that
> had bad "waypoints".
>=20
> You can imagine the patch as a journey from A to B.
> Only, that's a long journey, and the path between
> them is a big ugly code dump.  The commits along
> the way include various adventures down rabbit holes
> that got backed out much later without necessarily
> tidying up the history along the way.
>=20
> This tool allows you to easily generate one
> intermediate state.  Repeated application generates
> multiple intermediate states until you have a nice
> tidy patch series, every step of the way bisectable.
>=20
> So the journey A =3D> B becomes the journey A =3D> W =3D> B.
>=20
> The tool allows you to quickly choose which hunks to
> add to patch(A=3D>W) and which to add to patch(W=3D>B),
> but also lets you make edits to the intermediate state
> easily so that W will compile even if some bits of the
> patch were intermingled.
>=20
>=20
> Does anybody know of a tool that can do this?  Does it
> sounds like something others would use?  I'm thinking
> that you could sort of get there with a combination of
> rebase squash, git add -p and a git stash holding the
> state of 'B', but it would need to be scripted enough
> that repeated application isn't a pain.  And a graphical/
> ncurses interface like the kernel's "make menuconfig" at
> the very least would make it much easier than paging
> through piles of diff fragments and hoping you never
> made a mistake.

What I do is close to what you describe. I use rebase -i and
edit commits that contain too much using git gui, i.e. I remove
stuff that do not belong in that commit and ammend the commit.
Then I commit that extra "junk" into a (new) commit and continue.

The next round with rebase -i I rearrange and squash things. Onviously
some junk gets deleted too, though the squashing takes care of most
of that work.

I have a vision for Eclipse working with the history view (would transl=
ate=20
well to any GUI) but when is not in my calendar yet.

-- robin
