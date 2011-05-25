From: Jeff King <peff@peff.net>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 15:50:32 -0400
Message-ID: <20110525195032.GC27260@sigill.intra.peff.net>
References: <loom.20110525T192418-887@post.gmane.org>
 <7vvcwy37de.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Ligocki <sligocki@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:50:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPK6K-0006v7-GA
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab1EYTuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:50:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39925
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab1EYTue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:50:34 -0400
Received: (qmail 4684 invoked by uid 107); 25 May 2011 19:50:34 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 15:50:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 15:50:32 -0400
Content-Disposition: inline
In-Reply-To: <7vvcwy37de.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174455>

On Wed, May 25, 2011 at 12:30:53PM -0700, Junio C Hamano wrote:

> I think so.  An earlier version of "git merge" used to say something like:
> 
>     Committed merge ..., made by resolve.
> 
> back in Sept 2005, so it is not so recent development. If we change it
> now, scripts in thousands of existing users hands might cringe instead,
> though.

I was going to say "those scripts are stupid and broken for parsing
stderr", but:

  1. We actually write this (and many other diagnostic messages) to
     stdout, not stderr. That seems weird and unusual.

  2. The message ends up in the reflog.

Also, most of the rest of the merge output has been gettext-ized, but
not this message. If we are going to declare it not parseable, should we
also be internationalizing it?

-Peff
