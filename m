From: Jeff King <peff@peff.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 12:50:57 -0500
Message-ID: <20131206175057.GA23716@sigill.intra.peff.net>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
 <20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
 <20131206210958.59f553060e3802d56f4a53b8@domain007.com>
 <CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Muzaffer Tolga Ozses <tolga@ozses.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 18:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VozYV-0004pD-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 18:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab3LFRvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 12:51:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:51713 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754417Ab3LFRu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 12:50:59 -0500
Received: (qmail 29872 invoked by uid 102); 6 Dec 2013 17:50:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 11:50:59 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 12:50:57 -0500
Content-Disposition: inline
In-Reply-To: <CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238939>

On Fri, Dec 06, 2013 at 07:44:21PM +0200, Muzaffer Tolga Ozses wrote:

> stty tells me
> speed 38400 baud; line = 0;
> eol = M-^?; eol2 = M-^?; swtch = M-^?;
> ixany iutf8
> 
> And I run identical commands on both servers, only URL changes.

What protocol/transport are you using (http, ssh, git)?

Can you try running with:

  GIT_TRACE_PACKET=$PWD/trace.out git clone ...

You should be able to see whether the client tells the server to
suppress progress output (look for the first "want" line in the output,
which may or may not contain the flag "no-progress"). That will let us
figure out whether it is the client who is unexpectedly asking to turn
off progress, or whether the server is failing to produce progress.

-Peff
