From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: help with git query
Date: Tue, 14 Apr 2009 08:26:52 +0200
Message-ID: <20090414062652.GC3948@atjola.homenet>
References: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com> <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com> <20090414054654.GC19027@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>,
	E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:28:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltc8C-0000Cn-W3
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZDNG0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 02:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbZDNG0y
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:26:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:39784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750812AbZDNG0x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 02:26:53 -0400
Received: (qmail invoked by alias); 14 Apr 2009 06:26:51 -0000
Received: from i59F5BDC9.versanet.de (EHLO atjola.local) [89.245.189.201]
  by mail.gmx.net (mp065) with SMTP; 14 Apr 2009 08:26:51 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+kHV4wxlCkxe6MoRC7jBPXRkxB2B77rxB0A+8eJ2
	u3XRRbnGYHoABK
Content-Disposition: inline
In-Reply-To: <20090414054654.GC19027@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116520>

On 2009.04.14 01:46:54 -0400, Jeff King wrote:
> On Mon, Apr 13, 2009 at 03:31:49PM -0500, Nathan W. Panike wrote:
>=20
> > > for each branch:
> > >  - info about the latest commit on that branch (date and time, me=
ssage, etc.)
> >=20
> > Depending on what you want to do---from a bash shell, you could do:
> >=20
> > for i in $(git branch -a | cut -b3-); do echo $i; git show -s $i; e=
cho; done
>=20
> Ick, please use the plumbing designed for this exact thing instead of
> trying to parse "git branch":
>=20
>   $ git for-each-ref --format=3D'%(subject)
>     %(authorname) %(authoremail)
>     %(authordate)' refs/heads/
>=20
> or however you want to format it. See "git help for-each-ref" for a l=
ist
> of fields (you can also just pipe the output of for-each-ref into a
> shell loop, as in your example, but with the format options there is
> often no need).

git log --no-walk --branches --decorate --pretty=3Dshort

is what I use, sometimes. Some other "pretty" format might be more
suitable for your use case.

Bj=F6rn
