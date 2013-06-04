From: Jeff King <peff@peff.net>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Tue, 4 Jun 2013 17:06:00 -0400
Message-ID: <20130604210600.GA3271@sigill.intra.peff.net>
References: <20130604141314.GD22308@pomac.netswarm.net>
 <20130604160815.GB15953@sigill.intra.peff.net>
 <51AE3A88.2080203@kdbg.org>
 <20130604191025.GG28153@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ian Kumlien <pomac@vapor.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyQl-00062u-RX
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab3FDVGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:06:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:44169 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab3FDVGG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:06:06 -0400
Received: (qmail 7881 invoked by uid 102); 4 Jun 2013 21:06:51 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 16:06:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 17:06:00 -0400
Content-Disposition: inline
In-Reply-To: <20130604191025.GG28153@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226402>

On Tue, Jun 04, 2013 at 12:10:25PM -0700, Jonathan Nieder wrote:

> >> However, since changing user id and leaving $HOME is so common, there is
> >> a patch under consideration to loosen the check only for the case of
> >> EACCES on files in $HOME. That commit is 4698c8f (config: allow
> >> inaccessible configuration under $HOME, 2013-04-12); it's not yet in any
> >> released version of git, though.
> [...]
> > I've a PHP script in ~/public_html that runs git. Without the mentioned
> > patch, the script bails out due to this error. This time it's Apache
> > that gets me into trouble because at the time the PHP script and git
> > run, $HOME is still /root, but the user identity is not root anymore.
> > The patch is direly needed; without it, I need to use 'env
> > HOME=/home/j6t /usr/local/bin/git' in my script.
> 
> I could be remembering wrong, but I thought it was not so much "under
> consideration" as "accepted for 1.8.4".  I haven't heard any
> compelling reasons not to apply it.
> 
> Would it would make sense against earlier releases as well?

Yeah, I think it would. I only said "under consideration" because I saw
that it was in "next" and not elsewhere, and did not hunt down the exact
status in "What's Cooking".

-Peff
