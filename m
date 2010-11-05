From: Jeff King <peff@peff.net>
Subject: Re: pretty format can't work on cron job
Date: Fri, 5 Nov 2010 09:14:44 -0400
Message-ID: <20101105131444.GB11707@sigill.intra.peff.net>
References: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org>
 <4CD3C262.6080108@viscovery.net>
 <7B2091481B9ED640A92789B0CA07059587CD03@CDCEXMAIL02.tw.trendnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j.sixt@viscovery.net, git@vger.kernel.org, ellre923@gmail.com
To: chen_wang@trendmicro.com.cn
X-From: git-owner@vger.kernel.org Fri Nov 05 14:14:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEM7L-0006cS-Aa
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 14:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab0KENOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 09:14:01 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53665 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab0KENOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 09:14:00 -0400
Received: (qmail 9503 invoked by uid 111); 5 Nov 2010 13:13:59 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 05 Nov 2010 13:13:59 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Nov 2010 09:14:44 -0400
Content-Disposition: inline
In-Reply-To: <7B2091481B9ED640A92789B0CA07059587CD03@CDCEXMAIL02.tw.trendnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160813>

On Fri, Nov 05, 2010 at 04:47:05PM +0800, chen_wang@trendmicro.com.cn w=
rote:

> > > But when I put that command on cron job, even I run =E2=80=9C. /e=
tc/profile=E2=80=9D and =E2=80=9C.
> > ~/.bash_profile=E2=80=9D first, I can=E2=80=99t get correct format =
of output.
> > > -------------------------------------------------
> > > Author: %aN <amit.shah@redhat.com>; Date: Wed Oct 20 13:45:43 201=
0
> > +1030
> > >  100.0% drivers/char/
> > >  1 files changed, 14 insertions(+), 3 deletions(-)
> > > -------------------------------------------------
> >=20
> > % has a special meaning in a crontab. See man 5 crontab.
> >=20
>=20
> I warped this command in script and trigger script in crontab.
> I think it's not the root cause, because %ae still works.

I notice that the only placeholder that is broken is %aN, which convert=
s
using the .mailmap file. Maybe something in your environment is
preventing reading that file properly?

Can you show us the exact script you're calling from your crontab file?
I'm wondering if it's something to do with being in the same directory.

-Peff
