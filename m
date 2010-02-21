From: Jeff King <peff@peff.net>
Subject: Re: Storing (hidden) per-commit metadata
Date: Sun, 21 Feb 2010 01:34:33 -0500
Message-ID: <20100221063433.GA2840@coredump.intra.peff.net>
References: <1266599485.29753.54.camel@ganieda>
 <1266687636-sup-7641@ben-laptop>
 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 08:23:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj5Or-0004yt-Bk
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 07:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab0BUGef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 01:34:35 -0500
Received: from peff.net ([208.65.91.99]:59147 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925Ab0BUGee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 01:34:34 -0500
Received: (qmail 8076 invoked by uid 107); 21 Feb 2010 06:34:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Feb 2010 01:34:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2010 01:34:34 -0500
Content-Disposition: inline
In-Reply-To: <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140598>

On Sat, Feb 20, 2010 at 01:57:31PM -0500, Avery Pennarun wrote:

> As for git-notes, they sound like they would be useful for this sort
> of thing.  I haven't tried them yet, but my understanding is that
> notes anywhere other than the "default" notes ref are not shown in
> commit messages, so you can use them for whatever you want.

I would want to hear more about the actual data being stored. The
strength of notes is that you can _change_ them after the commit has
been created. And the price you pay is that they are more annoying to
move around, because they are in a totally different ref.

If this is data that is being generated at the time the commit is
created and then set in stone, then it probably should be part of the
commit object.

If the only problem is that the data is ugly in "git show", then perhaps
we need a "suppress these pseudo-headers" feature for showing logs. It
keeps them easily available for inspection or for --grep, but most of
the time you would not see them.

-Peff
