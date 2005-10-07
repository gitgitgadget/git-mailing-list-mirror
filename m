From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Thu, 6 Oct 2005 21:56:39 -0700
Message-ID: <20051007045639.GA18998@reactrix.com>
References: <20051005214447.GF15593@reactrix.com> <Pine.LNX.4.63.0510061550510.23242@iabervon.org> <20051007000041.GH15593@reactrix.com> <7virwa5ety.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 06:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENkHo-0008Hn-8G
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 06:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVJGE4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 00:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVJGE4o
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 00:56:44 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:46998 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751369AbVJGE4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 00:56:43 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j974udV0022042;
	Thu, 6 Oct 2005 21:56:39 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j974udcd022040;
	Thu, 6 Oct 2005 21:56:39 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virwa5ety.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9796>

On Thu, Oct 06, 2005 at 05:51:53PM -0700, Junio C Hamano wrote:

> Well, I'd suggest just to hardcode a reasonable value to be a
> good net citizen, and not make it configurable.  Four, perhaps?
> 
> OTOH, we may want to have an option to disable parallel from the
> command line (I think -r 1 would mean that with yours).

I'd prefer to keep it configurable - for our purposes we'll be hitting
a single server from several clients and will probably want to limit
concurrent connections to something like two per client, but when doing
a fetch from a big server farm more connections would make sense.

> If we really want to have the number of parallel configurable,
> and -r implies recursive as you say, maybe '-j' to mimic
> parallel make?

Not that I'm a huge fan of using environment variables, but it might make
sense to use one here.  That would allow the setting to work whether
git-http-fetch is run directly or via git-fetch.  GIT_HTTP_MAX_REQUESTS?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
