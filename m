From: Jeff King <peff@peff.net>
Subject: Re: Failure using webdav basic auth by git client
Date: Sun, 11 Nov 2012 13:28:42 -0500
Message-ID: <20121111182842.GC21654@sigill.intra.peff.net>
References: <121F1C4AA6A845229D3DF5808B4F0F9E@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "'Pyeron, Jason J CTR (US)'" <jason.j.pyeron.ctr@mail.mil>,
	git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXcHC-0000at-JL
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab2KKS2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:28:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44080 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab2KKS2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:28:45 -0500
Received: (qmail 3402 invoked by uid 107); 11 Nov 2012 18:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 13:29:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 13:28:42 -0500
Content-Disposition: inline
In-Reply-To: <121F1C4AA6A845229D3DF5808B4F0F9E@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209437>

On Sun, Nov 11, 2012 at 01:09:02PM -0500, Jason Pyeron wrote:

> > My google fu has failed me on this issue. I am trying to setup http(s)
> > repositories for git. If I require authenticated users then git asks
> > for a username and password for the first volley of communications, but
> > then does not include the Authorization header on subsequent requests.
> [...]
> > > GET /git/test/info/refs?service=git-receive-pack HTTP/1.1
> > User-Agent: git/1.7.9

Can you try with a more recent git version? There were some bugs with
on-demand http auth when using the dumb protocol (which I see you are
using). They were fixed in v1.7.10.2 and higher.

Also, consider setting up the smart-http protocol, as it is way more
efficient.

-Peff
