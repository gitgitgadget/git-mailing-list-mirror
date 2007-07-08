From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Qgit RFC] commit --amend
Date: Sun, 8 Jul 2007 15:38:26 +0200
Message-ID: <20070708133825.GE3991@efreet.light.src>
References: <20070610150839.GG4084@efreet.light.src> <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com> <20070611044258.GJ4084@efreet.light.src> <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com> <20070705185426.GB3991@efreet.light.src> <e5bfff550707060112p29b9565bw9ccba6601745b850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 15:38:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7WyB-0003wC-HB
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 15:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbXGHNic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 09:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbXGHNic
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 09:38:32 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:55012 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbXGHNib (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 09:38:31 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 674BE57490;
	Sun,  8 Jul 2007 15:38:30 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 4Ysdgn0Fu-tb; Sun,  8 Jul 2007 15:38:29 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0C9E357378;
	Sun,  8 Jul 2007 15:38:29 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I7Wy2-0003ZO-4k; Sun, 08 Jul 2007 15:38:26 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550707060112p29b9565bw9ccba6601745b850@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51882>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2007 at 10:12:50 +0200, Marco Costalba wrote:
> On 7/5/07, Jan Hudec <bulb@ucw.cz> wrote:
>> Therefore I'll either have to always ask git via run("git-rev-parse HEAD=
",
>> head), add HEAD into the map, or store HEAD somewhere in the Git object.
>> Which do you think makes most sense?
>
> Asking git when you need it and keep HEAD value only for the minimum
> time required to execute the commit command.
>
> - HEAD is very 'volatile'
>
> - commit is _not_ performance critical.
>
> - commit, being a write operation, is instead bugs/misbehaviour
> critical (a big point to use an high level "git-commit" BTW)
>
> - asking git with getRefSha("HEAD", ANY_REF, true)  is very quick and
> in any case much quicker then the whole commit dance.

Yes. It is also much faster to write in code, but...

> - someone can always change the repo behind you, qgit is not the only
> interface to git ;-) does exist also the command line.

And the commit in qgit should better fail loudly if that happens, because t=
he
list of files or something else might no longer make sense.

There is actually just one thing I need the head for -- passing it as 3rd
argument to git-update-ref. That should be done purely as safety measure --
if the value does not match, the command will fail. And for that safety
measure to be useful, I need value of the head at the time user openend the
commit dialog, NOT the time user clicked on commit button.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkOjRRel1vVwhjGURAvpCAJ4pDQZj4Kdq5f490lWrjGCRGwVllQCeNvGY
ak6oVquXxpLdzVlfHMU+108=
=MQLp
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
