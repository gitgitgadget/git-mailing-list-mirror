From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git push default behaviour?
Date: Fri, 9 Mar 2012 09:48:16 +0100
Message-ID: <87aa3qi2i7.fsf@thomas.inf.ethz.ch>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
	<CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
	<vpqfwdjas0m.fsf@bauges.imag.fr>
	<20120309033826.GA6164@sigill.intra.peff.net>
	<7vsjhi9wku.fsf@alter.siamese.dyndns.org>
	<7vobs69vwj.fsf@alter.siamese.dyndns.org>
	<CANgJU+WMxnNgdsP4JV6aAVW07NeWXUa5LsEa4dk5_1CZXC1nXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>, <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:48:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5vUu-0006rl-MZ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2CIIsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 03:48:20 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:43845 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730Ab2CIIsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 03:48:19 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Mar
 2012 09:48:16 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Mar
 2012 09:48:16 +0100
In-Reply-To: <CANgJU+WMxnNgdsP4JV6aAVW07NeWXUa5LsEa4dk5_1CZXC1nXA@mail.gmail.com>
	(demerphq@gmail.com's message of "Fri, 9 Mar 2012 09:06:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192695>

demerphq <demerphq@gmail.com> writes:

> A possible solution might be to give config files a "format version"
> of their own. They already contain a repository format version number,
> so add a new variable "ConfigVersionLevel". Alongside that you might
> introduce a policy of having new git "fill in" the defaults missing
> from the config file whenever it operates, so that people can
> explicitly view then all at once. Then if the defaults change in the
> future an old repo will continue to work as it did before. This alone
> would allow you to change the defaults for existing configurable
> behavior, but you need the version number to handle new options.
>
> Once you have that you can change the default behavior based on the
> version level so that older users operating in older repositories get
> the old behavior, and new repositories get the new behavior. And you
> have more flexibility in how your approach these problems when they
> come up, and it seems to me that they are inevitable.

This would be a brilliant way to confuse the hell out of existing users:
suddenly the apparent "defaults"[1] now change *between repositories*
depending on when they were created.

In short, oh please god no.


[1] using the word loosely here, for anything that the user has not
configured manually with git-config, git-remote, git branch
--set-upstream etc.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
