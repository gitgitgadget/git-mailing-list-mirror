From: Jeff King <peff@peff.net>
Subject: Re: Cloning bare repository always warns that its empty.
Date: Sat, 28 Jan 2012 22:24:59 -0500
Message-ID: <20120129032458.GB1347@sigill.intra.peff.net>
References: <1327806561158-7233455.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nmartin <nmartin867@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 04:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrLOg-0006aJ-22
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 04:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab2A2DZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 22:25:02 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47813
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab2A2DZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 22:25:01 -0500
Received: (qmail 7807 invoked by uid 107); 29 Jan 2012 03:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jan 2012 22:32:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jan 2012 22:24:59 -0500
Content-Disposition: inline
In-Reply-To: <1327806561158-7233455.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189278>

On Sat, Jan 28, 2012 at 07:09:21PM -0800, nmartin wrote:

> I created a bare repository (empty) on my server which I making public over
> http. I cloned this repository on another machine(A), committed changes, and
> pushed the changes to the server. On the server when I run $ git log I can
> see the commit that I pushed. However if I clone this repository on a 3rd
> machine(B).. the repository is empty.

Is your http server git-aware (i.e., running the smart-git http-backend
CGI), or it is simply serving the repository files? If the latter, then
you need to arrange to run the "git update-server-info" when you push
into it, which will update the information that "dumb" http clients will
look at.

If the server is running git v1.6.6 or later, you can turn this on in
the server repository by running:

  git config receive.updateserverinfo true

-Peff
