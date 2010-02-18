From: martin f krafft <madduck@madduck.net>
Subject: Re: Using trees for metatagging
Date: Fri, 19 Feb 2010 11:53:23 +1300
Message-ID: <20100218225323.GK9756@lapse.rw.madduck.net>
References: <20100218041240.GA4127@lapse.rw.madduck.net>
 <32541b131002181057gf27538ybf09dbf80b8dbce8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Avery Pennarun <apenwarr@gmail.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFFo-0004yR-VM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 23:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab0BRWxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 17:53:47 -0500
Received: from clegg.madduck.net ([193.242.105.96]:46081 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0BRWxq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 17:53:46 -0500
Received: from lapse.rw.madduck.net (koruout.airnz.co.nz [162.112.38.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7479B1D409C;
	Thu, 18 Feb 2010 23:53:31 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id A8F3C24C; Fri, 19 Feb 2010 11:53:23 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <32541b131002181057gf27538ybf09dbf80b8dbce8@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140389>

also sprach Avery Pennarun <apenwarr@gmail.com> [2010.02.19.0757 +1300]=
:
> > 1. Does Git provide plumbing for me to find out which trees
> > =A0 reference a given blob? If not, I will have to iterate all
> > trees =A0 and record which ones have a given message as a child.
>=20
> No, you will have to iterate.  Also, if *other* people have trees
> referencing that blob in *their* repositories, you won't know, so
> you can never be sure that you've successfully found all objects
> in the universe that refer to a particular blob.

The idea is obviously that you could merge ancestries and thus
propagate all those changes.

> > 2. Is there a way you can fathom by which unlinking a blob from the
> > =A0 main hierarchy also causes it to be unlinked from this meta tre=
e
> > =A0 I am speaking of as well? Similarly, if a blob is rewritten, ho=
w
> > =A0 could I make sure it replaces the old blob in all referencing
> > =A0 trees?
>=20
> blobs cannot replace other blobs.

It was a shortcut on my behalf. I meant that a new tree is written
with the ref to the old blob removed and the ref to the new blob
added.

> And a tree that contains a particular blob (indexed by sha1) will
> never *not* contain that blob, because the identity of that tree
> is based on the identitity of the blobs it contains.  You can
> create a new tree that doesn't contain the blob, but the commit
> that contained the old tree will never contain the new tree.  You
> would have to create a new commit that contains the new tree, but
> any commits based on your old commit will never be based on your
> new commit.  And so on.

Right, this is the basis of merging. I understand all this.
I suppose I didn't express myself clearly enough.

So I am trying to figure out:

1. how to create new trees for all trees that reference a blob that
   is superseeded by a new blob in some sort of scalable way;

2. how to maintain a separate ancestry of commits pointing to those
   trees in a way to be able to harness Git's merging capabilities.

Is this clearer?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"alle vorurteile kommen aus den eingeweiden."
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net
