From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 22:45:41 -0400
Message-ID: <1332816105-sup-9131@pinkfloyd.chass.utoronto.ca>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca> <20120326011148.GA4428@burratino> <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca> <20120326181238.GH7942@sigill.intra.peff.net> <1332785666-sup-5513@pinkfloyd.chass.utoronto.ca> <20120326182427.GA10333@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 04:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCMPs-0003Fs-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 04:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab2C0Cpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 22:45:43 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:50432 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab2C0Cpm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 22:45:42 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:33714 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCMPl-0001g8-PR; Mon, 26 Mar 2012 22:45:41 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCMPl-0006zn-OO; Mon, 26 Mar 2012 22:45:41 -0400
In-reply-to: <20120326182427.GA10333@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193995>

Excerpts from Jeff King's message of Mon Mar 26 14:24:27 -0400 2012:

Hi Jeff,

> OK, that's gross. I would argue that your SANE_TOOL_PATH is not
> great, then, because the "sh" is not sane. But that being said, this
> is exactly the sort of thing I was talking about in my first
> message, which is that SANE_TOOL_PATH is hard to get right. If we
> can make things Just Work by using SHELL_PATH, I don't see that as a
> bad thing.

Ok, thanks for the great feedback.  I just sent an updated version of
the patch with the squash done and what I hope is a better commit
message.

> It sounds like using bash is probably the least bad thing to do, and
> doing anything else would not be worth the complexity. You could use
> "bash -posix" (or an sh-symlink to bash), but in practice I doubt it
> is really hurting anybody.

I'd need to jump through some hoops to do an sh-symlink that was
within our packaging standards, although it's not impossible.  Using
"bash -posix" is likely a better path for me to travel.  I'll still
need to plan out the change with lots of notice for users in case
there have been bashism's used in local scripts, but as you say it's
not likely hurting anyone in practice.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
