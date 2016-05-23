From: Francois Beutin <beutinf@ensimag.grenoble-inp.fr>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Mon, 23 May 2016 14:51:39 +0200 (CEST)
Message-ID: <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, matthieu moy <matthieu.moy@grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Mon May 23 14:44:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4pDe-0003yC-19
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 14:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbcEWMoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 08:44:13 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:38913 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169AbcEWMoL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 08:44:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E4CDB251D;
	Mon, 23 May 2016 14:44:05 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2xfaPcYRbz1x; Mon, 23 May 2016 14:44:05 +0200 (CEST)
Received: from zm-int-mbx7.grenet.fr (zm-int-mbx7.grenet.fr [130.190.242.146])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D474C2513;
	Mon, 23 May 2016 14:44:05 +0200 (CEST)
In-Reply-To: <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Win)/8.0.9_GA_6191)
Thread-Topic: Git remote whitelist/blacklist
Thread-Index: AQLJLMcy5aI0sQo5p+pO4Y/K+qYQcZ3S6uzwnGoegUQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295319>

I agree that we cannot have a completly secure and reliable=20
way to forbid a push to the wrong remote. This is not what
our feature is trying to do, we assume that if a programmer=20
tweaks his config file and changes the rules he knows what
he is doing and we won't try to prevent it.
Our goal is to implement a safeguard against accidental push,
the feature will work only if the programmer wants it to.

----- Mail original -----
> De: "Randall S. Becker" <rsbecker@nexbridge.com>
> =C3=80: "Francois Beutin" <beutinf@ensimag.grenoble-inp.fr>, git@vger=
=2Ekernel.org
> Cc: "matthieu moy" <matthieu.moy@grenoble-inp.fr>, "simon rabourg" <s=
imon.rabourg@ensimag.grenoble-inp.fr>, "wiliam
> duclot" <wiliam.duclot@ensimag.grenoble-inp.fr>, "antoine queru" <ant=
oine.queru@ensimag.grenoble-inp.fr>
> Envoy=C3=A9: Vendredi 20 Mai 2016 16:22:17
> Objet: RE: [Opinion gathering] Git remote whitelist/blacklist
>=20
> On May 20, 2016 10:22 AM, Francois Beutin wrote:
> > We (Ensimag students) plan to implement the "remote whitelist/black=
list"
> > feature described in the SoC 2016 ideas, but first I would like to =
be sure
> > we
> > agree on what exactly this feature would be, and that the community=
 sees an
> > interest in it.
> >=20
> > The general idea is to add a way to prevent accidental push to the =
wrong
> > repository, we see two ways to do it:
> > First solution:
> >  - a whitelist: Git will accept a push to a repository in it
> >  - a blacklist: Git will refuse a push to a repository in it
> >  - a default policy
> >=20
> > Second solution:
> >  - a default policy
> >  - a list of repository not following the default policy
> >=20
> > The new options in config if we implement the first solution:
> >=20
> > [remote]
> > 	# List of repository that will be allowed/denied with
> > 					# a whitelist/blacklist
> > 	whitelisted =3D "http://git-hosting.org"
> > 	blacklisted =3D "http://git-hosting2.org"
> >=20
> > 	# What is displayed when the user attempts a push on an
> > 		# unauthorised repository? (this option overwrites
> > 		# the default message)
> > 	denymessage =3D "message"
> >=20
> > 	# What git should do if the user attempts a push on an
> > 		# unauthorised repository (reject or warn and
> > 		# ask the user)?
> > 	denypolicy =3D reject(default)/warning
> >=20
> > 	# How should unknown repositories be treated?
> > 	defaultpolicy =3D allow(default)/deny
> >=20
> >=20
> > Some concrete usage example:
> >=20
> >  - A beginner is working on company code, to prevent him from
> > 	accidentally pushing the code on a public repository, the
> > 	company (or him) can do:
> > git config --global remote.defaultpolicy "deny"
> > git config --global remote.denymessage "Not the company's server!"
> > git config --global remote.denypolicy "reject"
> > git config --global remote.whitelisted "http://company-server.com"
> >=20
> >=20
> >  - A regular git user fears that he might accidentally push sensibl=
e
> > 	code to a public repository he often uses for free-time
> > 	projects, he can do:
> > git config remote.defaultpolicy "allow"	#not really needed
> > git config remote.denymessage "Are you sure it is the good server?"
> > git config remote.denypolicy "warning"
> > git config remote.blacklisted "http://github/personnalproject"
> >=20
> >=20
> > We would like to gather opinions about this before starting to
> > 	implement it, is there any controversy? Do you prefer the
> > 	first or second solution (or none)? Do you find the option's
> > 	names accurate?
>=20
> How would this feature be secure and made reliably consistent in mana=
ging the
> policies (I do like storing the lists separate from the repository, b=
tw)? My
> concern is that by using git config, a legitimate clone can be made o=
f a
> repository with these attributes, then the attributes overridden by l=
ocal
> config on the clone turning the policy off, changing the remote, and =
thereby
> allowing a push to an unauthorized destination (example: one on the
> originally intended blacklist). It is unclear to me how a policy mana=
ger
> would keep track of this or even know this happened and prevent polic=
ies
> from being bypassed - could you clarify this for the requirements?
>=20
> Cheers,
> Randall
>=20
> -- Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)/NonStop(211288444200000000)
> -- In my real life, I talk too much.
>=20
>=20
>=20
>=20
