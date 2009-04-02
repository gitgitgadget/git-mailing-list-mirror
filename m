From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 09:44:14 -0400
Message-ID: <20090402134414.GB26699@coredump.intra.peff.net>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	gitster@pobox.com
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 15:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpNF2-0004tr-PB
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 15:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZDBNo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZDBNo2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 09:44:28 -0400
Received: from peff.net ([208.65.91.99]:60380 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbZDBNo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 09:44:28 -0400
Received: (qmail 26266 invoked by uid 107); 2 Apr 2009 13:44:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 02 Apr 2009 09:44:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2009 09:44:14 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115466>

On Thu, Apr 02, 2009 at 03:34:15PM +0200, demerphq wrote:

> But one question. It seem to me odd to put this as an option to git
> remote update, and not git remote prune.
> 
> I mean, it seems weird that one must say:
> 
>    git remote update --prune
> 
> and one cannot say:
> 
>    git remote prune --all

But "git remote update" actually respects "remote groups", so it is not
just "--all". I think what you want is "git remote prune <group>".

> especially when there is a `git remote prune` already. It seems a bit
> counterintuitive to find pruning actions under "update", but not all
> that strange to find an all "--all" option for the "prune" action.

I think it makes sense under update as pruning is really just a
different (and perhaps slightly more dangerous) form of update.
Generally I would only want to run prune after having run update, so
combining them makes sense from a workflow perspective.

> Although to me having both be allowed and mean the same thing also
> makes sense.

I think that would make sense, too.

-Peff
