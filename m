From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Sat, 21 Aug 2010 10:05:12 +0200
Message-ID: <20100821080512.GA30141@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 10:05:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omj5S-0005aX-GI
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 10:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab0HUIFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 04:05:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0HUIFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 04:05:10 -0400
Received: by fxm13 with SMTP id 13so2197920fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=4rqZhE09PSRFN9zoa6/k9lmOD1ZhWZ6HKoVlSUtvRiM=;
        b=LF5LEC5RhMsRiWvP6V6ClYbGYcrIYpATjMYqNs/DskwE1Cqg5F0viXhfOByFTkWjYT
         EFuM0mmF6APK93znwNZVt/EctzTP/JkJEjOHZxCQ/dO9RG8cw4xjd/2eLQhkK+LEEx6F
         3OjXERI/N2bwBB9t9FgDaT/rt6VhU1Nbeynpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=fOrEbxPyjDdrU5BBuFIdH/vgRdqT6TW199hNpPjXDS497GkzE0L5nfGeSQ4HKB+0EJ
         Ok9fvE21gCBbSx7VbXhT/YzWTetj1jCWRlFl4A951rPmkWht9hI+7Ao7bUImxtI3H7Nb
         1wuqgFzp6d1DzWYSamkOKuFeFvRKW+L1Qeqgo=
Received: by 10.223.121.147 with SMTP id h19mr1955904far.76.1282377908694;
        Sat, 21 Aug 2010 01:05:08 -0700 (PDT)
Received: from darc.lan (p549A39C7.dip.t-dialin.net [84.154.57.199])
        by mx.google.com with ESMTPS id s20sm1522025faa.4.2010.08.21.01.05.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 01:05:07 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Omj4i-0007vV-WA; Sat, 21 Aug 2010 10:05:13 +0200
Content-Disposition: inline
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154123>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2010 at 01:35:32PM -0700, Junio C Hamano wrote:
>
> If (and this may be a big IF) it is reasonable to add paths to .gitignore
> that you do not want to lose, then you would want to have three classes of
> untracked paths: "precious but ignored", "trashable" (and by definition
> ignored), and "unignored" (and by definition is not ignored and is
> precious).

I am not sure anybody would bother categorizing their files into
several classes. On the other hand, .gitignore and
=2Egit/info/exclude may already serve such a purpose.

Files that go into a tracked .gitignore are most likely generated
files, and therefore trashable. Files that go into
=2Egit/info/exclude or into an untracked .gitignore (e.g. echo '*' >
precious-simulation-results/.gitignore), are not always generated
and may not be trashable. At least they would not likely get in the
way of checkout or merge.

(As you noted below, except for the untracked .gitignore part, this
is how git behaves already.)

> As I already pointed out, we don't support the "precious but ignored"
> class.  So an obvious alternate solution to your particular case is not to
> add such a path to the gitignore mechanism.

That would defeat the point of ignoring it.

> I have a suspicion that the approach this patch takes would not help very
> much in the real life.  You just traded the lack of "precious but ignored"
> with "no file is trashable, even if it is listed in .gitignore".
>=20
> Granted, as long as it is not default, it won't negatively affect people
> who do not enable it, other than that it may add maintenance burden on the
> resulting bloated code, but I find it hard to swallow new code that does
> not convincingly solve the real problem.

Yes, I am not a big fan of this solution either. But if we do not
find a better solution, I think having it configurable cannot hurt.
The code required is minimal. As far as I am concerned, we can even
remove the -i part.

> By the way, we seem to have a few longstanding bugs that trashes an
> unignored and untracked (hence by definition precious) path during branch
> switching, and does not give a correct escape hatch.
>=20
> Doing this:
>=20
>     $ git checkout maint
>     $ echo foo >t/t2018-checkout-branch.sh
>     $ git checkout master
>=20
> does correctly error out because the unignored file needs to be
> overwritten.  But doing this after the above still errors out, which is
> probably wrong:
>=20
>     $ echo t/t2018-checkout-branch.sh >>.git/info/exclude
>     $ git checkout master

I understand your point. But this is actually a great example. I
have a bunch of such tests, which are not in shape for upstream,
but I want to keep them around anyways (and run them). Do you
really think that an untracked test which was added to
=2Egit/info/exclude should be considered trashable? If it were a
generated file, it would have been added to .gitignore.

> After doing the above:
>=20
>     $ ed .git/info/exclude ;# remove the extra entry in info/excludes
>     $d
>     w
>     q
>     $ rm t/t2018-checkout-branch.sh
>     $ echo foo >po
>     $ git checkout pu
>=20
> should error out, as "po" is a directory that has tracked contents, and we
> never said the untracked regular file "po" is trashable, but the above
> sequence happily checks the branch out.

Ok, that's bad.

Clemens

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMb4i4AAoJELKdZexG8uqMSfEH/1HTCkyaj+Qe3nych8XprJ/H
YrYhI5AL4uj7Ei7vX75VAKLe/Un1vG0YzeHm6j7qdrz/xivK4CbL69KxQwdfNZ3O
uATPIB1GvHv99NkSwse8AbmjXfiX52CyZbRRGW0BovmDDIRh0KwHmJnWP3otxtFw
UbvwFCuZLiaso+TandPDeD0e3fuayBE5R9zvv3dhn7r5NpnOFe/nohzbti1yPFPj
ewjFTaXfwijwYoBeHiMYshJLUVMmDmmp+8P+rBbDjBAoyK3VHrk0/uM8TKhBnFK8
JtCqqXzfUqWM5IFToSth/74va5q1q360eXmrLhm1IT5iHAc36cr6MDEeFCz/rvc=
=bvj1
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
