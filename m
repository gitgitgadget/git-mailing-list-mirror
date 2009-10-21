From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Wed, 21 Oct 2009 05:15:28 +0200
Message-ID: <20091021031528.GB18997@atjola.homenet>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
 <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
 <alpine.LNX.2.00.0910202001050.14365@iabervon.org>
 <BLU0-SMTP889B2109047E949E039EFDAEBF0@phx.gbl>
 <alpine.LNX.2.00.0910202044150.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 05:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Rfl-0005HD-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 05:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbZJUDP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 23:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZJUDP1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 23:15:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:46915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752047AbZJUDP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 23:15:27 -0400
Received: (qmail invoked by alias); 21 Oct 2009 03:15:30 -0000
Received: from i59F57083.versanet.de (EHLO atjola.homenet) [89.245.112.131]
  by mail.gmx.net (mp055) with SMTP; 21 Oct 2009 05:15:30 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+GXPRyWaCG7EHVKfddJ14fCwam854+29yn+j+6Q8
	VX0NiGqGfLbcSp
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910202044150.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130881>

On 2009.10.20 20:55:25 -0400, Daniel Barkalow wrote:
> Maybe it should be fine to do:
>=20
> $ git fetch long-url-here master:temp
> $ git merge temp
> $ git checkout other-branch-that-also-needs-it
> $ git merge temp
>=20
> But "temp" is "refs/remotes/temp", not "refs/heads/temp"?

One (maybe important) difference there is that the "pull" gets you:

    Merge branch 'pu' of git://git.kernel.org/pub/scm/git/git

Even with "master:tmp". But with fetch+merge (storing in refs/remotes):

    Merge remote branch 'tmp'

As a minor side-effect, having the "tmp" ref makes re-running the pull
(for whatever reason) cheaper, as without it, the fetch step would
possibly re-fetch the whole stuff (not reachable through any local ref)=
=2E

Bj=F6rn, undecided...
