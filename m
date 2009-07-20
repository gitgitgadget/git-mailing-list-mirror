From: Jeff King <peff@peff.net>
Subject: Re: cvs import and internal plumbing commands
Date: Mon, 20 Jul 2009 11:34:00 -0400
Message-ID: <20090720153400.GE5347@coredump.intra.peff.net>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
 <20090716100121.GA6742@coredump.intra.peff.net>
 <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
 <20090717214523.GA29955@coredump.intra.peff.net>
 <7vprbwvzu7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antony Stubbs <antony.stubbs@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSusO-0005Ym-5m
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbZGTPd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbZGTPd4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:33:56 -0400
Received: from peff.net ([208.65.91.99]:32875 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZGTPdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:33:55 -0400
Received: (qmail 26790 invoked by uid 107); 20 Jul 2009 15:35:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Jul 2009 11:35:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 11:34:00 -0400
Content-Disposition: inline
In-Reply-To: <7vprbwvzu7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123615>

On Sun, Jul 19, 2009 at 07:43:28PM -0700, Junio C Hamano wrote:

> We encourage script writers to just prepend "git --exec-path" at the
> beginning of their PATH and give guarantee that this simple procedure will
> keep their scripts working, so it might be a good idea to have an example
> for that as well.

I had it in my head that such a strategy was supposed to be a temporary
step in the process of getting rid of dashed forms. That is, you can do
that now to avoid having your scripts break, but in the long run, you
should be converting to the space form.

But I guess the plan was softened, and we have no deprecation plan for
dashed forms in exec-path. So maybe my thinking was outdated.

> So the preferred fix might be just the matter of adding one line
> 
> 	$ENV{'PATH'} = `git --exec-path`. ":$ENV{'PATH'}";
> 
> at the beginning of the script.

I can see that for a totally third-party script which wanted to use git
plumbing.  But why do that for a git-* script? The "git" wrapper sets up
the environment like that already.

-Peff
