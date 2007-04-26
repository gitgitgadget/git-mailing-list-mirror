From: Eric Wong <normalperson@yhbt.net>
Subject: Re: speeding up git-svn when directories are copied?
Date: Thu, 26 Apr 2007 08:45:12 -0700
Message-ID: <20070426154512.GA29248@muzzle>
References: <20070423141601.GA5797@diana.vm.bytemark.co.uk> <20070424015405.GA7232@untitled> <20070424100100.GA23811@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh69o-0000vV-Ms
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 17:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXDZPpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Apr 2007 11:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbXDZPpQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 11:45:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33755 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbXDZPpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 11:45:14 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A8E5E7DC0A0;
	Thu, 26 Apr 2007 08:45:12 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 26 Apr 2007 08:45:12 -0700
Content-Disposition: inline
In-Reply-To: <20070424100100.GA23811@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45639>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-04-23 18:54:05 -0700, Eric Wong wrote:
>=20
> > Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > When importing a whole repository, git-svn currently takes a _lot=
_
> > > of time. Almost all of it seems to be spent getting the full text
> > > of each and every file when a tag or new branch is created.
> >
> > Try SVN 1.4.3 with my patch[1] to get do_switch() working. trunk
> > should work without the patch.
> >
> > [1] - http://svn.haxx.se/dev/archive-2007-01/0936.shtml
> >
> > do_switch() is broken otherwise, and do_update() is extremely
> > inefficient.
>=20
> Thanks for the help. I applied your patch to a clean 1.4.3 tree, and
> built subversion itself plus the perl bindings. But git-svn is still
> slow, and the testcase you gave in that thread still fails.
>=20
> (I'm pretty sure that I'm actually using the bindings I've built; I
> install them to a nonstandard location, so if I don't set PERL5LIB
> they aren't found at all, and perl complains. When I do set it to my
> patched bindings, perl accepts it but your testcase fails.)

Hmm... I've been using 1.4.3 + patch since January on at least
one of my machines and do_switch() has worked correctly every time.

git-svn will display a message telling you that it's using do_switch()
when following a branch.  Otherwise, it'll say it's using do_update().

--=20
Eric Wong
