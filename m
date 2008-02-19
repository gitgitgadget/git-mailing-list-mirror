From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: rebase --onto might "loose" commits
Date: Tue, 19 Feb 2008 13:52:16 +0100
Message-ID: <20080219125216.GA10444@atjola.homenet>
References: <20080219072359.GA752@atjola.homenet> <alpine.LSU.1.00.0802191102440.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 13:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRRxz-0001YX-9z
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 13:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYBSMwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2008 07:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYBSMwU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 07:52:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:34222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752351AbYBSMwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 07:52:19 -0500
Received: (qmail invoked by alias); 19 Feb 2008 12:52:18 -0000
Received: from i577B8F4B.versanet.de (EHLO atjola.local) [87.123.143.75]
  by mail.gmx.net (mp033) with SMTP; 19 Feb 2008 13:52:18 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+R7VF8SWaRnS/S5B4tW4Gr4M7n1MTzYrtugsIW+E
	/iCeNOvRSPqg+P
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802191102440.30505@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74395>

Hi,

On 2008.02.19 11:05:40 +0000, Johannes Schindelin wrote:
> On Tue, 19 Feb 2008, Bj=F6rn Steinbrink wrote:
>=20
> > when there's nothing to rebase (ie. upstream..branch is empty), reb=
ase=20
> > fails to find any commits to rebase and correctly says "Nothing to =
do",=20
> > but when --onto is given, we already did a "reset --hard" to newbas=
e, so=20
> > it already _did_ something.
>=20
> Yes, it did something.  But if you had that:
>=20
> A - B - C - D - E
>   \
>     F
>=20
> your HEAD was E, and you said "git rebase --onto F E" what exactly do=
 you
> want it to do?  There is no commit between E and E, so it rebases
> _nothing_ onto F.  Which means that F should be your new state.

Strictly, it's correct, but the "Nothing to do" message is a bit
misleading (IMHO) and the error message made me think, that it actually
didn't want to do anything.

I'm a bit unsure about rebase being degraded to a "reset --hard" in thi=
s
case is a good idea. Might be a nice user-protection to make rebase
abort when there's nothing to rebase and --onto is given. But I don't
care that much.

Thanks,
Bj=F6rn

> P.S.: I was being corrected some time ago on the same typo: "to lose"=
=20
> means to get rid of something unintentionally, "to loose" does not ex=
ist,=20
> and "to loosen" means to make something less tight.

Ah yeah, one of my preferred typos. There's about a 50% chance for me t=
o
get that right. Although it already felt wrong when I read over the
mail, for some unknown reason I couldn't put my finger on the typo. ;-)
