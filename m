From: Keith Packard <keithp@keithp.com>
Subject: Re: Importing Mozilla CVS into git
Date: Tue, 06 Jun 2006 17:12:22 -0700
Message-ID: <1149639142.28173.37.camel@neko.keithp.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
	 <46a038f90606052255s62cda81bt62d7442beb26658a@mail.gmail.com>
	 <9e4733910606060813r41037467u74235f7a9386c1e0@mail.gmail.com>
	 <46a038f90606061257v569aefackc4920a20f2970b0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+umn++dvrGyKnjIfycYR"
Cc: keithp@keithp.com, Jon Smirl <jonsmirl@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:12:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnlfB-0003tm-P5
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWFGAMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWFGAMn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:12:43 -0400
Received: from home.keithp.com ([63.227.221.253]:24591 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751392AbWFGAMm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:12:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 1F261130022;
	Tue,  6 Jun 2006 17:12:41 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21974-02; Tue, 6 Jun 2006 17:12:40 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id B997113001E; Tue,  6 Jun 2006 17:12:40 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id B030C14001;
	Tue,  6 Jun 2006 17:12:40 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id D483A6E41E9; Tue,  6 Jun 2006 17:12:24 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606061257v569aefackc4920a20f2970b0f@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21418>


--=-+umn++dvrGyKnjIfycYR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 07:57 +1200, Martin Langhoff wrote:

> git-cvsimport has a memory leak that I've been chasing for a while and
> I'll eventually fix, so it should fit in 32MB comfortably. cvsps is
> memory bound, and will probably take quite a bit of work to fix that.
> However, I suspect we can make it a lot more efficient.

Yeah, parsecvs is a memory pig as well -- it builds a giant in-memory
representation of the entire project history using flat lists of files
for every revision, just like git used to do. Fixing that should make it
run in small amounts of memory; it only needs 40 bytes per file revision
for the raw data as it converts the cvs files to git objects as it reads
them, saving only the hash value in memory.

Not relying on cvsps has been a huge feature though; cvsps loses a
tremendous amount of data, along with making several gross and difficult
to fix errors in project history from several of my repositories.

--=20
keith.packard@intel.com

--=-+umn++dvrGyKnjIfycYR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEhhnmQp8BWwlsTdMRAvw4AKC5au7Q0vDJcM+N3zng2o74T0xFHgCcDmmP
eQILlR0X2wTzkYlaOD5rFpU=
=GGDt
-----END PGP SIGNATURE-----

--=-+umn++dvrGyKnjIfycYR--
