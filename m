From: Jeff King <peff@peff.net>
Subject: Re: getting git from kernel.org is failing
Date: Tue, 23 Jul 2013 16:21:27 -0400
Message-ID: <20130723202127.GA2051@sigill.intra.peff.net>
References: <51EEDC78.4000507@googlemail.com>
 <20130723200605.GE5129@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 22:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1j9U-0000kX-Va
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 22:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934328Ab3GWUVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 16:21:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:60622 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934286Ab3GWUVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 16:21:31 -0400
Received: (qmail 23284 invoked by uid 102); 23 Jul 2013 20:21:31 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Jul 2013 15:21:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jul 2013 16:21:27 -0400
Content-Disposition: inline
In-Reply-To: <20130723200605.GE5129@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231058>

On Tue, Jul 23, 2013 at 10:06:05PM +0200, Fredrik Gustafsson wrote:

> Confirmed (tested both with and without trailing /, IIRC there was some
> configuration change recently that effect that):
> iveqy@kolya:~/slask/git$ git clone
> https://git.kernel.org/cgit/git/git.git/
> Klonar till "git"...
> error: Unable to get pack index
> https://git.kernel.org/cgit/git/git.git/objects/pack/pack-1e2bca8b5127039cff42b1cd3d47767fb577cd4f.idx

That's weird. We shouldn't be fetching an index at all unless dumb http
is in use. When I try to clone from the URL above, I also get shunted to
dumb-http (and the repo on the server appears to be poorly packed).

But if I go to:

  https://git.kernel.org/pub/scm/git/git.git

then smart HTTP works fine. I wonder if there is a problem in the cgit
setup on kernel.org (or if it was even intended that you could fetch
from the cgit URL at all; the cgit page shows the clone URLs in
/pub/scm/git).

-Peff
