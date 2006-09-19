From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: more support for PATH_INFO based URLs
Date: Tue, 19 Sep 2006 10:19:33 +0200
Message-ID: <20060919081933.GB31940@admingilde.org>
References: <20060916210832.GV17042@admingilde.org> <eejhtr$paa$1@sea.gmane.org> <eejlht$870$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 10:19:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPapP-0006Om-0o
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 10:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWISITg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 04:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWISITf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 04:19:35 -0400
Received: from agent.admingilde.org ([213.95.21.5]:61882 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751303AbWISITf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 04:19:35 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GPapJ-0000HC-JC; Tue, 19 Sep 2006 10:19:33 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eejlht$870$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27266>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Sep 17, 2006 at 04:20:23PM +0200, Jakub Narebski wrote:
> matled (Matthias Lederhofer) on #git proposed to use ':' as a separator
> between branch and filename (as branch doesn't need to be flat,=20
> e.g. "jc/diff" like branch name), because valid branch name cannot contain
> ':' (and this limit is only for branch name).

you are right, my patch doesn't work with hierarchical branch names.
However using ":" alone does not work eighter.
My main motivation for this patch was to be able to export .html files
and to have working links between them.
However a <a href=3D"main.html"> link inside "branch:index.html" would
try to get "main.html" and not "branch:main.html".

Perhaps use ":/" as separator?
Or try to add more words to the branch name until we get a valid one.
But I don't know how this plays with Linus' latest ref-pack work
where both "a" and "a/b" are valid branch names (If I understood it
correctly).  Perhaps use a similiar algorith as the one I used
to get the project path?

> He also said that filename doesn't need to be necessary file (which would=
 be
> then present in "blob_plain" view), but it can be also a directory (which
> then would be present in "tree" view). We can either check type using
> git-cat-file -t via git_get_type subroutine, or assume that if we want for
> directory to be shown, it should end with "/".

yes, this was something I wanted to do later, too.

--=20
Martin Waitz

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFD6gVj/Eaxd/oD7IRAtRlAJ9QmLOAUZ87Mw9Hf3JaYviN+tX6mwCfQbjb
VGy2o/YlrKplBwmx+vuT824=
=r27S
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
