From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Qgit RFC] commit --amend
Date: Thu, 5 Jul 2007 20:54:26 +0200
Message-ID: <20070705185426.GB3991@efreet.light.src>
References: <20070610150839.GG4084@efreet.light.src> <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com> <20070611044258.GJ4084@efreet.light.src> <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 20:54:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6WTO-0004gG-MY
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 20:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760152AbXGESyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760172AbXGESyd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 14:54:33 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:46065 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760014AbXGESyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 14:54:32 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id AA02457451;
	Thu,  5 Jul 2007 20:54:30 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id OYgybRw-rYuO; Thu,  5 Jul 2007 20:54:28 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 457C15744B;
	Thu,  5 Jul 2007 20:54:28 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I6WTC-0004mp-Ir; Thu, 05 Jul 2007 20:54:26 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51690>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 11, 2007 at 07:45:51 +0200, Marco Costalba wrote:
> On 6/11/07, Jan Hudec <bulb@ucw.cz> wrote:
>> I think I mostly understood it now. Thank you.
>
> Anyhow I think this could be useful to you:
>
> 	/*
> 	   getAllRefSha() returns the list of sha of a given
> 	   type, where type is a mask of Git::RefType flags
> 	   see src/git.h.
> 	   In this case we want the sha of the current branch
> 	*/
> 	QStringList revs =3D getAllRefSha(CUR_BRANCH);
> =09
> 	if (!revs.isEmpty()) {
>
> 		// all the sha info is stored in this QGit::Rev
> 		// class defined in src/common.h
> 		const Rev* r =3D revLookup(revs.first());
>
> 		// short log (title) is
> 		r->shortLog();
>
> 		// message body is
> 		r->longLog();
>
> 		// etc....
> 	}

I thought I should be using something more explicit. Like getRefSha("HEAD",
ANY_REF, false) -- only to find that it wouldn't work. That means that this
code would not work either. Why? Well, because HEAD does not have to be
a symbolic ref. If you check out anything else than branch (which you can),
HEAD will be set to the SHA1 directly and if you commit in such state (which
you also can), the HEAD will be different from anything in refs/.

Therefore I'll either have to always ask git via run("git-rev-parse HEAD",
head), add HEAD into the map, or store HEAD somewhere in the Git object.
Which do you think makes most sense?

(Note: Yes, I noted that getRefSha("HEAD", ANY_REF, true) should work, but =
of
course that is the run("git-rev-parse HEAD") case.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGjT5iRel1vVwhjGURAjufAJ98WwRnLrT0e2Jy42gFhqxm42+gAwCfSufX
uOchoQCkdInXsKs9Vxw9wfM=
=rdjw
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
