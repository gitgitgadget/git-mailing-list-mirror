From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: quoting in get_author_ident_from_commit
Date: Wed, 22 Sep 2010 23:23:02 +0200
Message-ID: <20100922212302.GA22368@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 23:23:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyWmZ-0002qH-FK
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 23:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab0IVVXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 17:23:07 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56200 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0IVVXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 17:23:05 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OyWmO-0000yb-JL; Wed, 22 Sep 2010 23:23:04 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OyWmM-0006ZU-NY; Wed, 22 Sep 2010 23:23:02 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156835>

Hello,

I wonder about the quoting done in get_author_ident_from_commit's sed
script.

It first does 's/'\''/'\''\\'\'\''/g', then 's/'\''/'\''\'\'\''/g' (the
latter once for each resulting line).
What sed actually sees is:

	s/'/'\\''/g
	s/'/'\''/g=20

The second instruction only substitutes a single quote by three single
quotes because \' is just interpreted as '.

So I think just removing the three occurences of the second substitute
command just can be removed, as ''' effectively is the same as '.

Do I miss something?

(The first command was introduced in
aa66c7ec77d474b737da607d6cb2d07f56628def, the second was introduced wit=
h
git commit -m in fec3ef101c0f18bbf2400423dc70e686e9d25b0)

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
