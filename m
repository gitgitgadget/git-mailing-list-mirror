From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 09:42:06 +0200
Message-ID: <20070905074206.GA31750@artemis.corp>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PEIAKu/WMn1b1Hv9";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpWi-0004e2-0B
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbXIEHmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbXIEHmK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:42:10 -0400
Received: from pan.madism.org ([88.191.52.104]:53039 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755576AbXIEHmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:42:09 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3E69D1DAF1;
	Wed,  5 Sep 2007 09:42:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0BD1E3033; Wed,  5 Sep 2007 09:42:06 +0200 (CEST)
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57677>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 07:09:27AM +0000, Linus Torvalds wrote:
> I've been against automatic repacking, but that was really based on what=
=20
> appears to be potentially a very wrong assumption, namely that people=20
> would do the manual repack on their own. If it turns out that people don'=
t=20
> do it, maybe the right thing for git to do really is to at least notify=
=20
> people when they have way too many pack-files and/or loose objects.

  Well independently from the fact that one could suppose that users
should use gc on their own, the big nasty problem with repacking is that
it's really slow. And I just can't imagine git that I use to commit
blazingly fast, will then be unavailable for a very long time (repacks
on my projects -- that are not as big as the kernel but still -- usually
take more than 10 to 20 seconds each).

> I personally repack everything way more often than is necessary, and I ha=
d=20
> kind of assumed that people did it that way, but I was apparently wrong.=
=20
> Comments?

  I do, when I'm bored and that I can't get things done. you know, it
has become one of my many twitches when I have an empty tty in front of
me and that I'm doing nothing useful. Though, when I'm in a hack-attack,
well I don't necessarily remember to repack. I'm in one of the (not so
many ?) very lucky companies (yay start-ups) where I could show that git
was very superior, and we now use it as our sole SCM. So when I'm in a
hack attack, it's usually that it's a busy week, and that new patches,
trees, objects (and sometimes with large binary things in it) flows like
hell. And the repository grows larger and larger. Well, the way we chose
to avoid the "I'm coding don't bother me with administrivia"-attitude is
that our users use a small cron that basically runs git gc each day, and
an aggressive repack (with a window of 50 or 100 I don't remember) each
Week-end in a cron. Because the best criterion to repack a repository
is: when there is no-one on the computer.

  It has proven quite good, as we have never seen a repository explode
in a day, even after some funny mistakes where people rebase some big
parts of the tree many times, generating very large number of loose
objets.


  I know I don't really answer the question, but the point I try to make
is that yeah, some kind of automated way to run the gc is great, but I'm
not sure that _git_ is the tool to automate that, because when *I* use
git, I expect it to be just plain fast, and I don't want it to
occasionally hang.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3l3OvGr7W6HudhwRAj/cAJoCgKMJZAI6PRFaybBu1bErE0uxhACeKUw1
ZiMVHBaXfagt65aEAImZCcw=
=ncw4
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
