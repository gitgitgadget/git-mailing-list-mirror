From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Sun, 28 Oct 2012 17:16:23 -0400
Message-ID: <20121028211623.GE26675@odin.tremily.us>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de> <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=zjcmjzIkjQU2rmur
Cc: Git <git@vger.kernel.org>, Nahor <nahor.j+gmane@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:17:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSaE4-00040U-28
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab2J1VQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:16:44 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:45541 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab2J1VQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:16:43 -0400
Received: from odin.tremily.us ([unknown] [72.68.106.55])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCM008KEGFBJ820@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 28 Oct 2012 16:16:24 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7094C682696; Sun,
 28 Oct 2012 17:16:23 -0400 (EDT)
Content-disposition: inline
In-reply-to: <508D9A12.6010104@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208568>


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 28, 2012 at 09:48:18PM +0100, Jens Lehmann wrote:
> Am 25.10.2012 02:53, schrieb W. Trevor King:
> > On Wed, Oct 24, 2012 at 09:15:32PM +0200, Jens Lehmann wrote:
> >> I still fail to see what adding that functionality to the submodule
> >> command buys us (unless we also add code which really uses the branch
> >> setting). What's wrong with doing a simple:
> >>
> >>    git config -f .gitmodules submodule.<path>.branch <record_branch>
> >>
> >> on the command line when you want to use the branch setting for your
> >> own purposes? You could easily wrap that into a helper script, no?
> >=20
> > Sure.  But why maintain my own helper script if I can edit
> > git-submodules.sh?  It seems like a number of people are using this
> > config option, and they generally store the same name in it that they
> > use to create the submodule.  This way I can save them time too.
>=20
> But people are already using the "branch" setting in *different* ways:

And they are usually storing the same string.  Now, more easily.  If
they want a different string, it is also easier.  If they don't want
to use --record, they can do things however they were already doing
them.  I don't see the problem.

> Am 23.10.2012 22:55, schrieb W. Trevor King:
> > As Phil pointed out, doing anything with this variable is ambiguous:
> >
> > On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
> >> Some projects now use the 'branch' config value to record the tracking
> >> branch for the submodule.  Some ascribe different meaning to the
> >> configuration if the value is given vs. undefined.  For example, see
> >> the Gerrit submodule-subscription mechanism.  This change will cause
> >> those workflows to behave differently than they do now.
>=20
> I don't have a problem with the amount or complexity of the code being
> added, But by adding that option we may be giving the impression that it
> is officially sanctioned, or that it will be kept up to date by further
> submodule commands.

Storing something there will be officially sanctioned.  Using it for
anything in particular will not be officially sanctioned.  Phil's
submodule_<var-name> export in foreach will expose the variable so the
user can do whatever they think is appropriate with it, but it's still
up to the user to give the option some kind of semantic meaning.

> I added Shawn to the CC, maybe he can comment on how the "branch"
> setting is used in Gerrit and what he thinks about adding code to
> set that with "git submodule add -r <branch> ..." to core git.

Good idea.

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQjaClAAoJEEUbTsx0l5OMAksP/2ecPu1rLq4PjKm8yRCvowGY
jqgRoP9h+BTFAmbffXNpaaDTMLno2kEYaxIoiudEqBKFHjogb1lw9JMDl9ZkqpZ0
djJwgOqCap2KlJC3nz+o2x1vp1IF4CRMJdDEx/+kH00IHjHON4tXFQd4a01DQcSy
+xxrEhn1O9L7mb1PGgzIQgvhZxXDiHFnFvdckPbcCq7UB8Xx4XsUN0Yho+QI78zv
YJ6PsyDaiDmoh7LPL2psPRAe98+2/B1zx8B94i4p+W1gi9bx9iw1lX7ZAxVawCpN
CGx4ghpsd7jHRS4LtBNe9Z8hLeILMRCLPoqvUfyy8iwDjFAXsc0hbJ7SzOhewVda
AXrlNgzPLuoBV12saQmw4lgm/gX1PCSFZ6DG6YALwO37nCEWDDZJFbDUCmG+w6vF
/k1IORqdrz+tfvD7RHjRFAEPwJaYgp2D9pWURHbQ4PcNxNZPpLf00Z8rQMSk9Xha
m99MkFrfpvTXOpBM+OQPWYCZVOZcq15aWr3SUCgJppTm6kKzuCbMqjInSskX2TLn
sM/J0jv3VrbLLxy0mbyYWI2+PE/lioffTxUosbmymFJsPQ0xsNG8ojoUE9QJPNAN
LwD30lzJHlfCvwZxDhgYQMdyPs7NbBlmkVzk8300RJ/ycOipIwjkunrA+FCcmPsj
QZYZLkSt6qkfNzdVYDxg
=Px5w
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
