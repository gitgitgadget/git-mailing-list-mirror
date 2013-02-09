From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sat, 09 Feb 2013 16:58:19 +0100
Message-ID: <1360425499.3369.10.camel@t520>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
	 <1359915086.24730.19.camel@t520> <510F03FC.6080501@gmail.com>
	 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-yCm1YdXJ3WwL6yyFIpv8"
Cc: Phil Hord <phil.hord@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 16:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4CpF-0002Cl-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 16:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab3BIP6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 10:58:23 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:54066 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab3BIP6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 10:58:23 -0500
Received: by mail-bk0-f53.google.com with SMTP id j10so2042686bkw.40
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version;
        bh=F8CcU/vhcndMEti3/i+YEWQVM8rFwoEs2vGFmMxn5B0=;
        b=NQOWkxPENDfqg+je/4NZyju3dP3d4PuTYf9cELHKWMlgZNWUITu63yZK/aK5J6VM8N
         3iRi1ZRAPcJXr+S0HaYfChGula0c4WXUCvE1p5b4v01Fwi71ZmCbx2tj28tjPLaavwOZ
         Wf941ZxnAExYMXzeA50Oz0PeP7QjTKLQPyRR7CUY85yNqi6oxXknGEFfhuNfIh2rxhPp
         J9RRre+L+DqQV/itETYjWa+HxK41ieg81HAPSUNmPwaWLIRbCr5Q3Q7godkVfVvAppSU
         LENCQdstoo9iu3V7ol8wpXmY/EiFxf/v1zjQBJptpIX6N/r3ZQySAZqR1VLRRMiiMBeI
         pBRQ==
X-Received: by 10.204.7.144 with SMTP id d16mr2464648bkd.48.1360425500887;
        Sat, 09 Feb 2013 07:58:20 -0800 (PST)
Received: from ?IPv6:2001:bf0:c001:30:dc04:a74e:e8c1:7f28? ([2001:bf0:c001:30:dc04:a74e:e8c1:7f28])
        by mx.google.com with ESMTPS id c10sm11247833bkw.1.2013.02.09.07.58.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 07:58:20 -0800 (PST)
In-Reply-To: <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215865>


--=-yCm1YdXJ3WwL6yyFIpv8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After thinking a while about how to solve the problems I have, I
consider the following things as a solution to my problem.

Add an option --isolated, -i to git checkout: Check out a branch / tag /
revision but do not touch the index. This could be used together with
--work-tree to check out a branch into an arbitrary directory. Also, it
satisfies all 4 criteria from [1] and therefore is perfect for
deployment from a bare repository.

What do you think about this feature request?

Yours, Robert Clausecker

[1]: http://sitaramc.github.com/the-list-and-irc/deploy.html

Am Dienstag, den 05.02.2013, 10:11 -0500 schrieb Phil Hord:
> On Sun, Feb 3, 2013 at 7:42 PM, Sitaram Chamarty <sitaramc@gmail.com> wro=
te:
> > On 02/03/2013 11:41 PM, Robert Clausecker wrote:
> >>
> >> Am Sonntag, den 03.02.2013, 21:55 +0530 schrieb Sitaram Chamarty:
> >>> Could you help me understand why piping it to tar (actually 'tar -C
> >>> /dest/dir -x') is not sufficient to achieve what you want?
> >>
> >> Piping the output of git archive into tar is of course a possible
> >> solution; I just don't like the fact that you need to pipe the output
> >> into a separate program to do something that should be possible with a
> >> simple switch and not an extra command. It feels unintuitive and like =
a
> >> workaround to make an archive just to unpack it on-the-fly. Also, addi=
ng
> >> such a command (or at least documenting the way to do this using a pip=
e
> >> to tar somewhere in the man pages) is a small and simple change that
> >> improves usability.
> >
> > I realise it appears to be the fashion these days to get away from the
> > Unix philosophy of having different tools do different things and
> > combining them as needed.
> >
> > Ignoring the option-heavy GNU, and looking at the more traditional BSD
> > tar manpage [1], I notice the following flags that could still be
> > potentially needed by someone running 'git archive': '-t' (instead of
> > '-x'), '-C dir', '--exclude/include', '-k', '-m', '--numeric-owner', -o=
,
> > -P, -p, -q, -s, -T, -U, -v, -w, and -X.
>=20
> OP did not ask about tar so I do not see why any of these tar options
> are relevant.  It seems like what he really wants is 'git archive
> --format=3Dnative' , maybe.   You can almost create this option by
> saying
>=20
>    git config tar.native.command "tar -x"
>=20
> except that you do not get the opportunity to specify a target directory.
>=20
> But maybe he really wants a form of 'git checkout' instead.
>=20
>=20
> > And I'm ignoring the esoteric ones like "--chroot" and "-S" (sparse mod=
e).
> >
> > How many of these options would you like included in git?  And if you
> > say "I don't need any of those; I just need '-x'", that's not relevant.
> >  Someone else may need any or all of those flags, and if you accept "-x=
"
> > you have to accept some of the others too.
>=20
> This is only true if you cannot stop yourself from thinking about
> 'tar'.  What about zip, for example?
>=20
> I think none of these options is relevant.
>=20
>=20
> > Also, I often want to deploy to a different host, and I might do that
> > like so:
> >
> >     git archive ... | ssh host tar -C /deploy/dir -x
> >
> > Why not put that ssh functionality into git also?
>=20
> This slippery-slope argument is growing tiresome.
>=20
> Phil
>=20
> p.s. Conceded: OP set off this avalanche by disparaging the vaunted
> PIPE operation.


--=-yCm1YdXJ3WwL6yyFIpv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJRFnIbAAoJEDpa/qG5y+V5CPEH/jdGXOLBBvbPz63NIYTFB7Z4
Z8AZYCApkMdtvugcMv1LPf1JaRd3oSAjmWRxzLeRaQMZyOsvU8UeRgiVNGKEFE51
SObFYclAcULEky5iGv8QRtQnG2DzRtX6e3tKDt/D/cYKJYYiqZrNdd46ip9fYX5X
uuygWHsPe5GYZuQ10fpzrB0B0DC+zDd9bbzHr7Y8zk2vmd6gHTIYW3+viR/7cj8x
b5jSkGf7SQ/DrJ33cVQAflbzDUV8UbHjHxcHSgEfy/RKw8wkMzNq6+jGpZh3+XE7
JE+hOOZEwiB4Ul0M5BXnEjmFqzlQD9blSqVu4gaNccmpPAe3NBqdtnt4wwIYF4s=
=S9wG
-----END PGP SIGNATURE-----

--=-yCm1YdXJ3WwL6yyFIpv8--
