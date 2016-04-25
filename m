From: Jeff King <peff@peff.net>
Subject: Re: definition for _attribute() in remote.c
Date: Mon, 25 Apr 2016 17:39:26 -0400
Message-ID: <20160425213926.GC11227@sigill.intra.peff.net>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley>
 <20160425211030.GA10309@sigill.intra.peff.net>
 <F23050BD4C62408D97A64B1D885007A8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:39:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoE9-00007K-JL
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbcDYVja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:39:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:56145 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965080AbcDYVj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:39:29 -0400
Received: (qmail 9630 invoked by uid 102); 25 Apr 2016 21:39:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:39:28 -0400
Received: (qmail 6865 invoked by uid 107); 25 Apr 2016 21:39:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:39:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 17:39:26 -0400
Content-Disposition: inline
In-Reply-To: <F23050BD4C62408D97A64B1D885007A8@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292568>

On Mon, Apr 25, 2016 at 10:34:27PM +0100, Philip Oakley wrote:

> It's not the __attribute__ definition (a Gnu C ism), rather its the
> __attribute variant, which has a definition in regex_internal.h, and is used
> in the regex code. It's that one that's used in remote.c that I can't fathom
> (i.e. how it worked in normally)
> 
> regex_internal.h#L160-164
> #ifdef __GNUC__
> # define __attribute(arg) __attribute__ (arg)
> #else
> # define __attribute(arg)
> #endif
> 
> thus when the compilation get to remote.c#L1662 it fails to find that
> definition.
> 
> Should that line use the gnu extension name?

Yeah, sorry, see my followup response. We don't use "__attribute" at
all ourselves. The reference you found is in compat code that we pulled
in (so it does its own thing entirely), and the one in remote.c is just
a typo/think-o that happened to work on gcc, et al.

-Peff
