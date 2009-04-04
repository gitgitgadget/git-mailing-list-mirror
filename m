From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 4/4] tests: skip perl tests if NO_PERL is defined
Date: Sat, 4 Apr 2009 16:30:10 -0700
Message-ID: <20090404T225904Z@curie.orbis-terrarum.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193359.GD5547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 01:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFL6-0000OV-6R
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 01:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbZDDXaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbZDDXaT
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 19:30:19 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:45939 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753255AbZDDXaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 19:30:18 -0400
Received: (qmail 19297 invoked from network); 4 Apr 2009 23:30:14 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 04 Apr 2009 23:30:14 +0000
Received: (qmail 27305 invoked by uid 10000); 4 Apr 2009 16:30:10 -0700
Content-Disposition: inline
In-Reply-To: <20090403193359.GD5547@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115603>


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2009 at 03:33:59PM -0400, Jeff King wrote:
> These scripts all test git programs that are written in
> perl, and thus obviously won't work if NO_PERL is defined.
> We pass NO_PERL to the scripts from the building Makefile
> via the GIT-BUILD-OPTIONS file.
Something is missing in the porting of the patch (possibly from an earlier
version where I did check for perl usage in the testcases and just avoided
those tests).

Testing on a box without Perl, I get the following failures.
You can reproduce by doing mv /usr/bin/perl{,.tmp},=20
gmake NO_PERL=3D1 clean all test

This is the only one that doesn't appear to use perl.
*** t6030-bisect-porcelain.sh ***
* FAIL 2: bisect starts with only one bad
* FAIL 3: bisect does not start with only one good
* FAIL 4: bisect start with one bad and good
* FAIL 5: bisect fails if given any junk instead of revs
* FAIL 7: bisect reset: back in another branch
* FAIL 8: bisect reset when not bisecting
* FAIL 9: bisect reset removes packed refs
* FAIL 10: bisect start: back in good branch
* FAIL 11: bisect start: no ".git/BISECT_START" if junk rev
* FAIL 12: bisect start: no ".git/BISECT_START" if mistaken rev
* FAIL 14: bisect skip: successfull result
* FAIL 15: bisect skip: cannot tell between 3 commits
* FAIL 16: bisect skip: cannot tell between 2 commits
* FAIL 17: bisect skip: with commit both bad and skipped
* FAIL 18: "git bisect run" simple case
* FAIL 19: "git bisect run" with more complex "git bisect start"
* FAIL 20: bisect skip: add line and then a new test
* FAIL 21: bisect skip and bisect replay
* FAIL 22: bisect run & skip: cannot tell between 2
* FAIL 23: bisect run & skip: find first bad
* FAIL 24: bisect skip only one range
* FAIL 25: bisect skip many ranges
* FAIL 26: bisect starting with a detached HEAD
* FAIL 27: bisect errors out if bad and good are mistaken
* FAIL 28: bisect does not create a "bisect" branch
* FAIL 30: good merge base when good and bad are siblings
* FAIL 31: skipped merge base when good and bad are siblings
* FAIL 32: bad merge base when good and bad are siblings
* FAIL 34: good merge bases when good and bad are siblings
* FAIL 35: optimized merge base checks

All the rest of these are all due to perl in test infrastructure:
*** t0020-crlf.sh ***
* FAIL 1: setup
* FAIL 7: switch off autocrlf, safecrlf, reset HEAD
* FAIL 10: checkout with autocrlf=3Dtrue
* FAIL 11: checkout with autocrlf=3Dinput
* FAIL 12: apply patch (autocrlf=3Dinput)
* FAIL 13: apply patch --cached (autocrlf=3Dinput)
* FAIL 14: apply patch --index (autocrlf=3Dinput)
* FAIL 15: apply patch (autocrlf=3Dtrue)
* FAIL 16: apply patch --cached (autocrlf=3Dtrue)
* FAIL 17: apply patch --index (autocrlf=3Dtrue)
* FAIL 18: .gitattributes says two is binary
* FAIL 20: .gitattributes says two and three are text
* FAIL 21: in-tree .gitattributes (1)
* FAIL 22: in-tree .gitattributes (2)
* FAIL 23: in-tree .gitattributes (3)
* FAIL 24: in-tree .gitattributes (4)

*** t1300-repo-config.sh ***
* FAIL 71: --null --list
* FAIL 72: --null --get-regexp

*** t3300-funny-names.sh ***
* FAIL 3: git ls-files -z with-funny
* FAIL 7: git diff-index -z with-funny
* FAIL 8: git diff-tree -z with-funny

*** t4012-diff-binary.sh ***
* FAIL 9: diff --no-index with binary creation

*** t4014-format-patch.sh ***
* FAIL 16: no threading
* FAIL 17: thread
* FAIL 18: thread in-reply-to
* FAIL 19: thread cover-letter
* FAIL 20: thread cover-letter in-reply-to
* FAIL 21: thread explicit shallow
* FAIL 22: thread deep
* FAIL 23: thread deep in-reply-to
* FAIL 24: thread deep cover-letter
* FAIL 25: thread deep cover-letter in-reply-to
* FAIL 26: thread via config
* FAIL 27: thread deep via config
* FAIL 28: thread config + override
* FAIL 29: thread config + --no-thread

*** t4020-diff-external.sh ***
* FAIL 12: force diff with "diff"
* FAIL 15: diff --cached

*** t4029-diff-trailing-space.sh ***
* FAIL 1: diff honors config option, diff.suppressBlankEmpty

*** t4030-diff-textconv.sh ***
* FAIL 5: diff produces text
* FAIL 7: log produces text
* FAIL 9: status -v produces text
* FAIL 10: diffstat does not run textconv
* FAIL 11: textconv does not act on symlinks

*** t4031-diff-rewrite-binary.sh ***
* FAIL 6: rewrite diff respects textconv

*** t4103-apply-binary.sh ***
* FAIL 3: check binary diff -- should fail.
* FAIL 4: check binary diff (copy) -- should fail.
* FAIL 5: check incomplete binary diff with replacement -- should fail.
* FAIL 6: check incomplete binary diff with replacement (copy) -- should fa=
il.
* FAIL 9: apply binary diff -- should fail.
* FAIL 10: apply binary diff -- should fail.
* FAIL 11: apply binary diff (copy) -- should fail.
* FAIL 12: apply binary diff (copy) -- should fail.

*** t4116-apply-reverse.sh ***
* FAIL 1: setup
* FAIL 2: apply in forward
* FAIL 3: apply in reverse
* FAIL 4: setup separate repository lacking postimage
* FAIL 5: apply in forward without postimage
* FAIL 6: apply in reverse without postimage
* FAIL 7: reversing a whitespace introduction

*** t4200-rerere.sh ***
* FAIL 15: clear removed the directory
	test ! -d .git/rr-cache/b5a3939d25d0a649294d5d94f2d338ef8da51812
mkdir: cannot create directory `.git/rr-cache/b5a3939d25d0a649294d5d94f2d33=
8ef8da51812': File exists

*** t5300-pack-object.sh ***
* FAIL 1: setup
* FAIL 2: pack without delta
* FAIL 3: unpack without delta
* FAIL 5: pack with REF_DELTA
* FAIL 6: unpack with REF_DELTA
* FAIL 8: pack with OFS_DELTA
* FAIL 9: unpack with OFS_DELTA
* FAIL 11: compare delta flavors
* FAIL 12: use packed objects
* FAIL 13: use packed deltified (REF_DELTA) objects
* FAIL 14: use packed deltified (OFS_DELTA) objects
* FAIL 15: survive missing objects/pack directory
* FAIL 16: verify pack
* FAIL 17: verify pack -v
* FAIL 18: verify-pack catches mismatched .idx and .pack files
* FAIL 19: verify-pack catches a corrupted pack signature
* FAIL 20: verify-pack catches a corrupted pack version
* FAIL 21: verify-pack catches a corrupted type/size of the 1st packed obje=
ct data
* FAIL 22: verify-pack catches a corrupted sum of the index file itself
* FAIL 23: build pack index for an existing pack
* FAIL 24: fake a SHA1 hash collision
* FAIL 25: make sure index-pack detects the SHA1 collision
* FAIL 26: honor pack.packSizeLimit
* FAIL 29: tolerate absurdly small packsizelimit

*** t5303-pack-corruption-resilience.sh ***
* FAIL 5: create corruption in data of first object
* FAIL 7: ... and loose copy of second object allows for partial recovery
* FAIL 11: create corruption in data of first delta

*** t6002-rev-list-bisect.sh ***
* FAIL 34: --bisect l5 ^root
* FAIL 35: --bisect l5 ^root ^c3
* FAIL 36: --bisect l5 ^root ^c3 ^b4
* FAIL 37: --bisect l3 ^root ^c3 ^b4
* FAIL 38: --bisect l5 ^b3 ^a3 ^b4 ^a4
* FAIL 39: --bisect l4 ^a2 ^a3 ^b ^a4
* FAIL 40: --bisect l3 ^a2 ^a3 ^b ^a4
* FAIL 41: --bisect a4 ^a2 ^a3 ^b4
* FAIL 42: --bisect a4 ^a2 ^a3 ^b4 ^c2
* FAIL 43: --bisect a4 ^a2 ^a3 ^b4 ^c2 ^c3
* FAIL 44: --bisect a4 ^a2 ^a3 ^b4
* FAIL 45: --bisect c3 ^a2 ^a3 ^b4 ^c2

*** t6003-rev-list-topo-order.sh ***
* FAIL 1: rev-list has correct number of entries
* FAIL 2: simple topo order
* FAIL 3: two diamonds topo order (g6)
* FAIL 4: multiple heads
* FAIL 5: multiple heads, prune at a1
* FAIL 6: multiple heads, prune at l1
* FAIL 7: cross-epoch, head at l5, prune at l1
* FAIL 8: duplicated head arguments
* FAIL 9: prune near topo
* FAIL 10: head has no parent
* FAIL 11: two nodes - one head, one base
* FAIL 12: three nodes one head, one internal, one base
* FAIL 13: linear prune l2 ^root
* FAIL 14: linear prune l2 ^l0
* FAIL 15: linear prune l2 ^l1
* FAIL 16: linear prune l5 ^a4
* FAIL 17: linear prune l5 ^l3
* FAIL 18: linear prune l5 ^l4
* FAIL 19: max-count 10 - topo order
* FAIL 20: max-count 10 - non topo order
* FAIL 21: --max-age=3Dc3, no --topo-order
* FAIL 22: one specified head reachable from another a4, c3, --topo-order
* FAIL 23: one specified head reachable from another c3, a4, --topo-order
* FAIL 24: one specified head reachable from another a4, c3, no --topo-order
* FAIL 25: one specified head reachable from another c3, a4, no --topo-order
* FAIL 26: graph with c3 and a4 parents of head
* FAIL 27: graph with a4 and c3 parents of head
* FAIL 30: simple topo order (l5r1)
* FAIL 31: simple topo order (r1l5)
* FAIL 32: don't print things unreachable from one branch
* FAIL 33: --topo-order a4 l3

*** t6011-rev-list-with-bad-commit.sh ***
* FAIL 3: corrupt second commit object
* FAIL 4: rev-list should fail
* FAIL 5: git repack _MUST_ fail

*** t6013-rev-list-reverse-parents.sh ***
* FAIL 2: --reverse --parents --full-history combines correctly
* FAIL 3: --boundary does too

annotate-tests.sh
(lots of the t8* tests).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknX7YIACgkQPpIsIjIzwixOWwCgk79jdCDnwgBHyZXZ7xCiMBF3
Ch4AnR4N186pOC1yyj7sM5nA7XhhmaEL
=fNNQ
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
