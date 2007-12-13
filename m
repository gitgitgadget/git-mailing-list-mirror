From: Jeff King <peff@peff.net>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 04:10:56 -0500
Message-ID: <20071213091055.GA5674@coredump.intra.peff.net>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 10:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2k6d-0007E6-L7
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbXLMJLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbXLMJLA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:11:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3230 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbXLMJK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:10:59 -0500
Received: (qmail 8229 invoked by uid 111); 13 Dec 2007 09:10:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Dec 2007 04:10:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2007 04:10:56 -0500
Content-Disposition: inline
In-Reply-To: <20071213090604.GA12398@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68134>

On Thu, Dec 13, 2007 at 10:06:04AM +0100, Pierre Habouzit wrote:

> No we can't. And I believe that such a thing is definitely bad practice
> :/ So if you really need to, we will have to add some PARSE_OPT_STICKARG
> or sth alike that would check that the argument was "sticked" to the
> option either with `-wA,B,C` or `--long-opt=A,B,C` depending on the fact
> that an option is short or long.

Yes, I am not sure if the right solution is to just say "we are changing
how -w works". Because it either must change, or it must be inconsistent
with the rest of the option parsing for the rest of eternity.

> Though note that you can't migrate things that use init_revisions and so
> on to parseoptions yet, because revisions also have dashed tokens (--not
> e.g.) and that the first run of parse_options will just hate it and

Ah, yes. I hadn't really considered that angle yet (my basic testing had
just been on non-dashed revision parameters).

I will table this patch for now, then, since it obviously is too complex
for v1.5.4.

Thanks for your input.

-Peff
