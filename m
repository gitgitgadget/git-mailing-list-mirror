From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 05:37:09 -0500
Message-ID: <20100222103709.GA16531@coredump.intra.peff.net>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
 <6672d0161002220017u7270c637k83a796cfc8730a64@mail.gmail.com>
 <alpine.DEB.1.00.1002220936030.20986@pacific.mpi-cbg.de>
 <201002221048.59188.trast@student.ethz.ch>
 <alpine.DEB.1.00.1002221108100.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVfB-0001d1-DL
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab0BVKhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 05:37:11 -0500
Received: from peff.net ([208.65.91.99]:60207 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab0BVKhK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:37:10 -0500
Received: (qmail 24687 invoked by uid 107); 22 Feb 2010 10:37:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 05:37:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 05:37:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002221108100.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140669>

On Mon, Feb 22, 2010 at 11:08:51AM +0100, Johannes Schindelin wrote:

> > You mean this one?
> >=20
> >   http://permalink.gmane.org/gmane.comp.version-control.git/108330
>=20
> Yes, indeed. But it was applied, I just did not find it due to the na=
me,=20
> which is not intuitive to this developer.

It is also slightly overkill if all you want to do is pull Junio's
topics from pu (I found myself always forgetting the right incantation
of command line options). The script posted by Bj=C3=B6rn is much short=
er,
but recovers all topic branches. If you just want to pull one, I think:

  #!/bin/sh
  sha1=3D`git log --oneline --first-parent origin/pu |
        grep -m 1 "Merge branch '$1'" |
        cut -d ' ' -f1`
  git branch ${2:-$1} $sha1^2

should work. Though I have not been using it very long myself, so it is
possible that it has bugs. :)

-Peff
