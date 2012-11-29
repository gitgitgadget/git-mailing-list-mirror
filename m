From: Jeff King <peff@peff.net>
Subject: Re: Ubuntu: gitweb always =?utf-8?Q?looks_?=
 =?utf-8?Q?for_projects_in_=2Fvar=2Fcache=2Fgit_=28=E2=80=9C404_-_no_proje?=
 =?utf-8?B?Y3RzIGZvdW5k4oCdKQ==?=
Date: Thu, 29 Nov 2012 13:28:26 -0500
Message-ID: <20121129182826.GB17309@sigill.intra.peff.net>
References: <loom.20121129T145320-133@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alfonso =?utf-8?Q?Mu=C3=B1oz-Pomer?= Fuentes 
	<alfonso.munozpomer@vti.bund.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:28:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8qp-0003KI-VR
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab2K2S23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 13:28:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41318 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab2K2S22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:28:28 -0500
Received: (qmail 24165 invoked by uid 107); 29 Nov 2012 18:29:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 13:29:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 13:28:26 -0500
Content-Disposition: inline
In-Reply-To: <loom.20121129T145320-133@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210854>

On Thu, Nov 29, 2012 at 01:55:57PM +0000, Alfonso Mu=C3=B1oz-Pomer Fuen=
tes wrote:

> I=E2=80=99ve discovered this weird behaviour in gitweb and documented=
 a workaround in
> StackOverflow:
> http://stackoverflow.com/questions/13609475/ubuntu-gitweb-always-look=
s-for-projects-in-var-cache-git-404-no-projects-f
>=20
> Basically, the variable $projectroot in gitweb.cgi in the beginning i=
s reset to
> the system default value in git_get_projects_list, when it is declare=
d again.
>=20
> Is this a known bug? Or am I missing something?

I think the analysis in that stack overflow post is wrong. The use of
"our" in git_get_projects_list is not the culprit.

The problem is that one should not edit gitweb.cgi directly; its
built-in defaults (which you are tweaking) are overridden by
/etc/gitweb.conf, which is shipped by the Ubuntu package. You should
be making your changes in the config file, not the CGI script.

-Peff
