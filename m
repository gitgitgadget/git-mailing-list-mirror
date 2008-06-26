From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Thu, 26 Jun 2008 13:55:50 +0200
Message-ID: <20080626115550.GA23058@atjola.homenet>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBq5s-0003GD-Fl
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbYFZLzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 07:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbYFZLzz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:55:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:46932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753652AbYFZLzz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:55:55 -0400
Received: (qmail invoked by alias); 26 Jun 2008 11:55:53 -0000
Received: from i577B9D84.versanet.de (EHLO atjola.local) [87.123.157.132]
  by mail.gmx.net (mp062) with SMTP; 26 Jun 2008 13:55:53 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Mm8Qv/PBMw4PzdJymBdo6w8K3NqG5yDdMq6075E
	WpT0tLvQFhcSRS
Content-Disposition: inline
In-Reply-To: <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86439>

On 2008.06.25 10:22:08 -0700, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
>=20
> > I used to argue for this, but gave up, because no one seemed to agr=
ee
> > with me.  So now I just have the following in
> > /home/tytso/bin/git-revert-file and I am very happy:
> >
> > #!/bin/sh
> > #
> > prefix=3D$(git rev-parse --show-prefix)
> >
> > for i in $*
> > do
> >         git show HEAD:$prefix$i > $i
> > done
>=20
> Isn't that this?
>=20
>         #!/bin/sh
>         exec git checkout HEAD -- "$@"

I thought so at first, too, but there's one difference. Ted's version
doesn't affect the index, while yours does. Of course I cannot tell if
Ted actually intended not to touch the index ;-)

Bj=F6rn
