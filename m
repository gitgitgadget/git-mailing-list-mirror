From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Tue, 30 Mar 2010 23:10:07 +0300
Message-ID: <20100330201007.GA26121@LK-Perkele-V2.elisa-laajakaista.fi>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com>
 <20100330183748.GA10647@progeny.tock>
 <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 22:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwhld-0000Oy-HO
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 22:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab0C3UKY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 16:10:24 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:59928 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0C3UKX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 16:10:23 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 1290A8C078;
	Tue, 30 Mar 2010 23:10:22 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A053580DEE3; Tue, 30 Mar 2010 23:10:22 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 7FAA12BD47;
	Tue, 30 Mar 2010 23:10:12 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143598>

On Wed, Mar 31, 2010 at 12:47:09AM +0530, Ramkumar Ramachandra wrote:
>=20
> > =C2=A0The URL in the second argument can be an arbitrary string. =C2=
=A0It is up
> > =C2=A0to the remote helper to assign meaning to it.
>=20
> I'm not sure this is correct. Here's an excerpt from remote.c
> 	if (argc > 2) {
> 		url =3D argv[2];
> 	} else {
> 		url =3D remote->url[0];
> 	}
> Notice how url is set to remote->url[0], in the `else` branch, where
> the remote is an "ordinary remote" built by remote_get(). Even though
> url may be any arbitrary string in the `if` branch, there'll be
> problems when the program gets into the `else` branch transparently.

Note that remote may have no URLs. Or the passed url may be like=20
(pathological example):

'tls://srp-Ilari@[1067a6e3af81b5ea76d615280eee2bc3dd2e8079@tcp/ipv6~fe8=
0::20e:a6ff:fe6f:2288%2]:7684/gitolite-admin'

Or it may be something even more exotic with absolutely no recognizable
URL-like structure, say hypothetical git-remote-fd, which would have
passed syntax like:

"3,4"

Which doesn't even resemble an URL.

-Ilari
