From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in  git, help users out.
Date: Tue, 06 Nov 2007 13:48:33 +0100
Message-ID: <20071106124833.GA25637@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site> <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <7vk5oviqbe.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061216330.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a8Wt8u1KmwUX3Y2C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpNrQ-000411-TS
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbXKFMsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbXKFMsg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:48:36 -0500
Received: from pan.madism.org ([88.191.52.104]:35384 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXKFMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:48:36 -0500
Received: from madism.org (unknown [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9DBF628BA1;
	Tue,  6 Nov 2007 13:48:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CA9B31E1DB; Tue,  6 Nov 2007 13:48:33 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711061216330.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63671>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 12:25:33PM +0000, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 6 Nov 2007, Junio C Hamano wrote:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > >> In the same way, I would expect "git revert <commit> -- file" to und=
o the
> > >> changes in that commit to _that_ file (something like "git merge-file
> > >> file <commit>:file <commit>^:file"), but this time commit it, since =
it
> > >> was committed at one stage.
> > >
> > > Allowing people to revert or cherry pick partially by using
> > > paths limiter is a very good idea; ...
> >
> > As Pierre said earlier, a partial revert via "revert <commit> --
> > <paths>" and a partial cherry-pick would make quite a lot of
> > sense, and in addition, it should not be too hard to add.
>
> Yes, but Pierre also said earlier that people want to revert their local
> changes.  And the logical thing to try that really is
>
> 	git revert <path>
>
> Now, if you read that out in English, it does not make too much sense:
> "revert the path" (not "revert the _changes_ to that file").  But it is
> what people try to do.
>
> However, IIUC another thing Pierre mentioned is that
>
> 	$scm revert <commit> <path>
>
> commonly means "revert the file _to the version_ stored in <commit>".
> This is just different enough from "revert the _changes_ to that file
> stored in <commit>" to bite people, no?

  Yeah but that's what checkout is for. The main source of iritation for
new users comes (IMHO) from svn, where `svn revert path/to/file` is part
of the workflow: in case of a conflict when you `svn up`, you have
either to:
  (1) fix the conflict and `svn resolved path/to/file`
  (2) drop your changes and take the trunk version `svn revert path/to/file`

People really expect git revert -- path/to/file to do the same as git
checkout HEAD -- path/to/file. Though I believe that like I said, maybe
we don't wan't git revert -- path/to/file to become the first class
command to do that, but rather to do what the user meant, hinting him in
the direction of the proper command. I wasn't really advocating that
git-revert should be a complete implementation of what git checkout
<comitish> -- <paths> does. YMMV.

--
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMGKhvGr7W6HudhwRArQBAJ4z38r718cj8O2Ri7hWzSGVOUjz1ACbBKTA
Dv1m5CbV9YV2S8UZmBxEftY=
=tL3J
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
