From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BISECTED] git-svn: "Failed to read object ..." during clone
Date: Wed, 28 May 2008 16:19:05 +0200
Message-ID: <20080528141905.GA17387@atjola.homenet>
References: <20080528030128.GA28904@atjola.homenet> <7vskw3vsys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1MVY-0003zW-54
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 16:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYE1OTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 10:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbYE1OTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:19:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751150AbYE1OTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:19:09 -0400
Received: (qmail invoked by alias); 28 May 2008 14:19:06 -0000
Received: from i577BAB6E.versanet.de (EHLO atjola.local) [87.123.171.110]
  by mail.gmx.net (mp054) with SMTP; 28 May 2008 16:19:06 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+etyoQAReegwYpMwxkybmD06vgo3qFjl2FXHWHUv
	BKHCqye74ru2Mn
Content-Disposition: inline
In-Reply-To: <7vskw3vsys.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83092>

On 2008.05.27 23:32:59 -0700, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > Hi Adam,
> >
> > when cloning the SVN repository at svn://svn.debian.org/estron/ git=
-svn bails
> > out with:
> > Failed to read object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 at
> > /usr/local/bin/git-svn line 3195, <GEN36> line 645.
>=20
> Heh, I should have been more careful.  The series introduces Git::cat=
_blob
> that returns the size of a blob but the interface is broken and signa=
ls
> error by returning zero.  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 is=
 a
> zero sized blob.
>=20
> Would this be enough?

At least the failing clone command now works and the history for the
previously empty .cvsignore file (which I guess was the one that caused
the failure) looks good. Didn't check anything else on that clone,
because I had just randomly chosen that repository to test something
completely different and then noticed the clone failure.

Thanks,
Bj=F6rn
