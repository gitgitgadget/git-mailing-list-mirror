From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Re* [GIT PULL] sh updates for 2.6.25
Date: Thu, 17 Apr 2008 23:38:01 +0200
Message-ID: <20080417213801.GL23696@genesis.frugalware.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <m3ej97rmc0.fsf@localhost.localdomain> <20080416003725.GF8387@genesis.frugalware.org> <7vd4oqwkev.fsf@gitster.siamese.dyndns.org> <20080416084435.GJ8387@genesis.frugalware.org> <7v3aplr2pt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:44:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmbol-0004uO-3V
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbYDQViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYDQViI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:38:08 -0400
Received: from virgo.iok.hu ([193.202.89.103]:39688 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbYDQViH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:38:07 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E88421B2510;
	Thu, 17 Apr 2008 23:38:03 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9798E44659;
	Thu, 17 Apr 2008 23:34:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3A9851190ABD; Thu, 17 Apr 2008 23:38:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3aplr2pt.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79836>


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2008 at 12:58:54PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> When one adopts the notion of "a single line at the top summarizes what
> the commit is about", it is very natural to call that a "title", and
> having a blank line between the title and the body to separate them also
> becomes natural, and it matches how a patch is presented in email, as a
> bonus, so it matches people's expectation.
>=20
> So this format is merely a convention when viewed at the "plumbing" level,
> but it is more important than just a convention if you are living at the
> "Porcelain" level; if you deviate from that, "Porcelain" would not work
> very well for you.

I understand this, my only problem is that some project does not use an
empty line after the "title". Consider a commit message like:

----
Change foo to bar
- this patch changes foo to bar becase of baz
- ok devel1@, devel2@
----

Given that a project uses such a commit message style, the newlines are
removed when applying with git am, but the commit still has a title.

> People who are used to other systems without a good history summarization
> tools can and do write such log messages.  People who make commits on such
> systems whose commits are imported to git (perhaps even without them
> knowing about it) do not have an incentive to use a short-and-clear single
> line summary in each of their commits, as their system may not give a good
> way to make use of the result of such a practice.

That makes sense, but those commits are unlikely transferred using
format-patch+am. :)

> These days, format-patch was taught to use "the first paragraph" as the
> summarizing first line to avoid chomping a sentence in the middle.  This
> change did not hurt people who use git "Porcelain", as the commit log
> message for them is always "a single line summary, a blank line, and the
> body".  The first paragraph is the same as the first line for them.  But
> for commits that have a multi-line paragraph at the beginning, information
> lossage is avoided this way.  Now the first chunk of the message, even if
> it is splattered over two physical lines, is used as the summary.

I see. If I'm right, then basically the old behaviour is what I want. At
least after a

git reset --hard 4234a76167b12a7669dae0e6386c62e712b9dcf5^

I get the behaviour I wished. :)

(Well, almost. It inserts a newline after the first line but that's far
better than stripping all the newlines.)

Would you accept a patch that would make this configurable?

> So in short, when you use "am", it by design unfolds the "Subject: " line
> and there is no bug there.  "rebase" being implemented in terms of
> "format-patch piped to am" does mangle the message because of this, but
> if anything that is a bug in rebase, and not "am".

Yes, that's an other issue.

Thanks.

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgHwzkACgkQe81tAgORUJZDJQCbBa6G2hI1Gr3atodBAE90gQXV
hPkAn24zDwLU3e7G1QjhAEre88SHQAPz
=BJDS
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--
