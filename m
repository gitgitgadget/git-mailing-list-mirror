From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] log: use true parents for diff even when rewriting
Date: Tue, 23 Jul 2013 09:49:52 +0200
Message-ID: <20130723074952.GB1754@pengutronix.de>
References: <20130722090854.GA22222@pengutronix.de>
 <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
 <7v61w2clli.fsf@alter.siamese.dyndns.org>
 <87k3khpwhh.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 23 09:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1XMb-00020Z-5t
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 09:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab3GWHuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 03:50:23 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46316 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab3GWHt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 03:49:57 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1V1XM2-0006zG-Br; Tue, 23 Jul 2013 09:49:54 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1V1XM0-0006cS-Ke; Tue, 23 Jul 2013 09:49:52 +0200
Content-Disposition: inline
In-Reply-To: <87k3khpwhh.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231030>

Hello Thomas,

On Tue, Jul 23, 2013 at 09:27:06AM +0200, Thomas Rast wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Conceptually I can see how this will change the history
> > simplification in the vertical direction (skipping the ancestry
> > chain and jumping directly to the closest grandparent that touched
> > the specified path), but I am not sure how well this interacts with
> > history simplification in the horizontal direciton (culling
> > irrelevant side branches from the merge).
>=20
> But isn't that similarly confusing for the user as Uwe's original
> problem?  Suddenly we'd be showing a merge commit as an ordinary one,
> simply because the merged history did not affect the filtered
> pathspecs.  Thus we would show everything that has been merged on the
> *other* files as a big diff.  Would that be useful?  It would certain=
ly
> be a big difference in how the commit is shown.
the merge is only included in the output if on both parent paths the
file is touched. So this is a non-issue, isn't it? (Well, only if it ha=
s
more than 2 parents and not all ancestor paths touch the file, the
number of parents shown is changed.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
