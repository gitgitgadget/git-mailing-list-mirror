From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: topgit infinite loop
Date: Wed, 22 Apr 2009 21:15:44 +0200
Message-ID: <20090422191544.GA22277@pengutronix.de>
References: <1240401469.3889.2.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhx2-000302-Ag
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZDVTPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZDVTPs
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:15:48 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55499 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZDVTPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:15:48 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lwhv8-0003tU-8z; Wed, 22 Apr 2009 21:15:46 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lwhv6-0005ng-VL; Wed, 22 Apr 2009 21:15:44 +0200
Content-Disposition: inline
In-Reply-To: <1240401469.3889.2.camel@maia.lan>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117235>

On Wed, Apr 22, 2009 at 11:57:49PM +1200, Sam Vilain wrote:
> Using the current topgit master, I did a 'tg depends add' and somehow
> seem to have found an infinite loop; see http://gist.github.com/99752
>=20
> I've pushed all my t/* branches to github.com/samv/git - the t/*
> branches.  Any obvious idea what went wrong?
Yes, you have a circular dependency:

	ukleinek@cassiopeia:~/tmp/samv/git$ git show t/revcache/spec:.topdeps
	t/revcache/spec

it was introduced in a7506fa2d393068b3ed85beaaa74cf6d3d52279d.  This
patch belongs to the TopGit-patch t/revcache/spec, but the subject
suggests that it's on t/revcache/spec-bitmap.

If you want to check what went wrong, you should check the revlog of
t/revcache/spec.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
