From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Template commit messages.
Date: Wed, 8 Aug 2007 18:24:11 +0200
Message-ID: <20070808162411.GA4884@efreet.light.src>
References: <18071eea0708050532x2d9bfddw96a9428f4840b1fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIoKp-0005A0-3o
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 18:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762216AbXHHQYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 12:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935957AbXHHQYW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 12:24:22 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:60834 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935972AbXHHQYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 12:24:21 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5DD1C573C7;
	Wed,  8 Aug 2007 18:24:19 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id nPG1BeLsUq57; Wed,  8 Aug 2007 18:24:17 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id BFC9357265;
	Wed,  8 Aug 2007 18:24:16 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IIoKS-0001Qm-05; Wed, 08 Aug 2007 18:24:12 +0200
Content-Disposition: inline
In-Reply-To: <18071eea0708050532x2d9bfddw96a9428f4840b1fc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55330>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 05, 2007 at 13:32:48 +0100, Thomas Adam wrote:
> Am I correct in thinking that the new template messages that will be
> in the up and coming git release will alleviate an "annoyance" I've
> currently got with commit messages?

Reading the description below, I really doubt that. The templates are to
*add* stuff, not to remove it.

> Basically, I want a way of removing what is now, a long list of
> untracked files from the commit message before it hits the editor --
> I've looked at $GIT_DIR/.git/hooks/{pre,post}-commit as well as:
> $GIT_DIR/.git/hooks/commit-msg in the hopes I could add  a sed command
> there to remove the list of files, and whilst the sed command worked
> fine on the command line, adding it to any of those files didn't.

Neither of this commands actually see the list. Because the list is *not*
part of the commit message. It is a comment, which is added just before the
editor is started and stripped right afterwards.

> Was this even the right approach?  I didn't want to go messing with
> git-commit, frankly, so I am hoping that these new templates might
> just do the trick.
>=20
> You might ask why I've got such a large list of untracked files -- the
> reason is because I use the same repository to build files in, which
> themselves have no need to be added.  And whilst I can catch some of
> these instances by using .gitignore, it's not enough since not all of
> the files have a common extension or anything.  And whilst I realise
> the list of untracked file is just a friendly warning to me, I find it
> annoying and would rather it didn't appear at all if possible, since I
> know myself which files need explicitly adding.  :)

a) The files don't need a common anything to be ignored with .gitignore. It
   is a list of patterns, so you can list the names. Of course not suitable
   if the names change or there is really a huge amount of them.
b) There is actually no problem in tracking files that match ignore pattern,
   as it is only applied to files that don't appear in index. That gives you
   the option to simply ignore '*' (and live with the minor annoyance that
   you have to add -f to add command line -- git commit -a and git add -u
   will include changes in tracked files all right).
c) Consider changing the build process to put the built files in
   a subdirectory, if you have a chance. In my experience it not only helps
   keeping track whether everything is versioned that should be, but also
   helps navigating the tree (no uninteresting files interfering with shell
   completion/cluttering file selection dialogs) and offer easy way to do
   a clean build when you suspect the build might have screwed up somewhere
   (just delete the directory).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGue4rRel1vVwhjGURAgRdAKCQL39idxPlJ7DAXT4+B3jsJ/gnbACdFw7H
BowKG6GGGe0ArbUiT7Xb7e8=
=FCV6
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
