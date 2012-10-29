From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 17:56:32 -0400
Message-ID: <20121029215631.GF20513@sigill.intra.peff.net>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
 <20121029085045.GA5023@sigill.intra.peff.net>
 <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
 <20121029212643.GA20513@sigill.intra.peff.net>
 <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxKD-0002yv-LO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab2J2V4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:56:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43090 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab2J2V4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 17:56:34 -0400
Received: (qmail 24043 invoked by uid 107); 29 Oct 2012 21:57:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 17:57:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 17:56:32 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208643>

On Mon, Oct 29, 2012 at 10:47:04PM +0100, Felipe Contreras wrote:

> >> Yeah, the test script is not ready for merging, it needs to check for
> >> python, hg, and hg-git.
> >>
> >> Do you have hg-git installed?
> >
> > No. But it's important that it fail gracefully; I can't even take it in
> > pu if I can't run the test suite in a sane way.
> 
> The contrib part is fine for 'pu'. The tests aren't even meant to
> exercise stuff in 'contrib', right? There might be some exceptions,
> but either way, there's plenty of stuff in 'contrib' without any
> tests. The tests I'm providing are simply a little sugar.

Yeah, contrib is a bit of a wildcard. Most things do not have tests.
Completion tests run as part of the main test suite (which to me means
that completion should arguably be promoted out of contrib). Subtree
carries its own tests that build on the test suite, but do not run all
the time.

If remote-hg is going to live in contrib, it probably makes sense to
have its tests live there, too, like subtree. It means less test
exposure, but the robustness of the tests does not have to be as high.
You could also have no tests, but since you have them, it seems silly
not to include them. People know that items in contrib/ may not be as
mature as the rest of git.

-Peff
