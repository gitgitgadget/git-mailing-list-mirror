From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 3/3] branch: add --unset-upstream option
Date: Wed, 11 Jul 2012 16:14:47 +0200
Message-ID: <1342016087.6458.10.camel@centaur.cmartin.tk>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	 <1341939181-8962-4-git-send-email-cmn@elego.de>
	 <7v629vijf2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 16:14:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoxgZ-0006Nc-9p
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 16:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab2GKOO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jul 2012 10:14:28 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:34424 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757905Ab2GKOO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 10:14:26 -0400
Received: from [192.168.1.5] (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id DD17246149;
	Wed, 11 Jul 2012 16:14:21 +0200 (CEST)
In-Reply-To: <7v629vijf2.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201301>

On Tue, 2012-07-10 at 11:02 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > We have ways of setting the upstream information, but if we want to
> > unset it, we need to resort to modifying the configuration manually=
=2E
> >
> > Teach branch an --unset-upstream option that unsets this informatio=
n.
> >
> > ---
> >
> > create_branch() uses install_branch_config() which may also set
> > branch.foo.rebase, so this version might leave some configuration
> > laying around.
> >
> > I wonder if deleting the whole branch.foo section would be better. =
Can
> > we be sure that nothing else shows up there?
>=20
> "branch.foo.$unknown" may not be related to upstream at all, so that
> will not fly.  Besides, we already have unknown=3Ddescription, no?

Ah yes, that exists. I've added a bit of code to also remove
branch.foo.rebase, which I'd also consider to be part of the upstream
information.

   cmn
