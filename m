From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 18:06:04 -0400
Message-ID: <20121029220604.GA21712@sigill.intra.peff.net>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
 <20121029085045.GA5023@sigill.intra.peff.net>
 <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
 <20121029212643.GA20513@sigill.intra.peff.net>
 <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net>
 <CAMP44s1SLpNpbjRXF6QHrOTO=_1=wjPo1_kV3jZV-HXOYXPbnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxTS-0004RX-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761320Ab2J2WGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:06:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43115 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837Ab2J2WGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:06:06 -0400
Received: (qmail 24387 invoked by uid 107); 29 Oct 2012 22:06:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 18:06:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 18:06:04 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1SLpNpbjRXF6QHrOTO=_1=wjPo1_kV3jZV-HXOYXPbnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208648>

On Mon, Oct 29, 2012 at 11:02:31PM +0100, Felipe Contreras wrote:

> > If remote-hg is going to live in contrib, it probably makes sense to
> > have its tests live there, too, like subtree.
> 
> Probably, I'll check that option.
> 
> But eventually I think it should be installed by default, unless
> somebody can come up for a reason not to. For now contrib might be OK.

I would one day like to have it as part of the main distribution, too,
but it would be nice to prove its worth in the field for a while first.
I especially would like to find out how it compares in practice with the
work that is in msysgit.

> > It means less test exposure, but the robustness of the tests does
> > not have to be as high.  You could also have no tests, but since you
> > have them, it seems silly not to include them. People know that
> > items in contrib/ may not be as mature as the rest of git.
> 
> Yeah, it's only a matter of figuring out how to run them.

Subtree seems to copy substantial parts of t/Makefile, but I suspect you
could get away with just using an "include". I'd also be OK with just
including a test script that pulls in test-lib.sh, and letting people
run it manually (the Makefile infrastructure is really about running a
lot of tests, but if there's only one script, it's not so hard).

-Peff
