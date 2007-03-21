From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Bisect: fix calculation of the number of suspicious
	revisions
Date: Wed, 21 Mar 2007 22:39:56 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070321213956.GC17632@informatik.uni-freiburg.de>
References: <20070317141209.GA7838@cepheus> <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070317195840.GA20735@informatik.uni-freiburg.de> <20070321210454.GA2844@lala> <7vodmmz3wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU8XQ-0007cr-En
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 22:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbXCUVkD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Mar 2007 17:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbXCUVkB
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 17:40:01 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44232 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986AbXCUVkA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2007 17:40:00 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HU8XH-0002YY-Et; Wed, 21 Mar 2007 22:39:59 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2LLdus7019062;
	Wed, 21 Mar 2007 22:39:56 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2LLdueI019061;
	Wed, 21 Mar 2007 22:39:56 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vodmmz3wy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42820>

Hello Junio,

Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>=20
> > Up to now the number printed was calculated assuming that the
> > current revision to test is bad.  Given that it's not possible
> > that this always matches the number of suspicious revs if the
> > current one is good, the maximum of both is taken now.
> >
> > Moreover I think the number printed was always one to high,
> > this is fixed, too.
>=20
> I know you mean well, but is it really worth an extra rev-list
> for this off-by-one, I wonder?
It may be more than one.  E.g.=20
   b
  / \
 /   \
a--c--e
 \   /
  \ /
   d

Given a is bad, e is bad, b is rev to test.

I didn't verify it, but I think the current code gives one (as it
assumes b is bad and counts one to much).  If b is good there are two
suspicious left.  I'm sure you can construct an example where it differ=
s
still more.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dhalf+a+cup+in+teaspoons
