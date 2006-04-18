From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 19:58:53 +0200
Message-ID: <20060418175853.GA25688@wohnheim.fh-wedel.de>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 19:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVuTs-0006bt-HI
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 19:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWDRR7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWDRR7N
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 13:59:13 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:3240 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932230AbWDRR7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 13:59:13 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVuTV-00019F-00; Tue, 18 Apr 2006 19:58:53 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18861>

On Tue, 18 April 2006 08:25:47 -0700, Linus Torvalds wrote:
> On Tue, 18 Apr 2006, J=F6rn Engel wrote:
> >=20
> > $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux-2.6.git foo
> > [ stored >200M of data under foo/.git/objects ]
> >=20
> > The above looks as if new objects are not stored under
> > /home/joern/.git, as specified by GIT_OBJECT_DIRECTORY.
>=20
> The "rsync" protocol really doesn't honor git rules. It's basically j=
ust a=20
> big recursive copy, and it will copy things from the place they were=20
> before.
>=20
> I suspect that if you had used a real git-aware protocol instead, you=
'd=20
> have been fine, ie
>=20
> 	git clone git://git.kernel.org/... foo/

Is it possible for non-owners of a kernel.org account to do this?

> would probably work. (I say "probably", because very few people likel=
y use=20
> GIT_OBJECT_DIRECTORY, and it makes a lot less sense with pack-files t=
han=20
> it did originally, so it's not getting any testing).

Well, .git/objects for your kernel still consumes 121M.  It's not
gigabytes but I still wouldn't want too many copies of that lying
around.  Right now, I already feel slightly motivated to move the
whole content-addressable idea into the kernel.  It has disadvantages,
but the effect on disk- and pagecache-footprint for people like me
would come in handy.

J=F6rn

--=20
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
