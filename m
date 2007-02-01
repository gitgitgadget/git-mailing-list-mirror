From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 19:11:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
 <20070131231942.GB31145@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: cworth@cworth.org, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 01:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCPYB-000778-On
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 01:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933373AbXBAALg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 19:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933374AbXBAALg
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 19:11:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39511 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933373AbXBAALf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 19:11:35 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCR00B34CJA4JE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 19:11:35 -0500 (EST)
In-reply-to: <20070131231942.GB31145@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38312>

On Wed, 31 Jan 2007, Jeff King wrote:

> On Wed, Jan 31, 2007 at 02:10:37PM -0500, Nicolas Pitre wrote:
> 
> > This is not meant to frighten people or even to suggest they might be
> > doing something wrong, but rather to notify them of a state change and
> > provide a likely option in the case this state was entered by mistake.
> 
> I like this much better. Though I wonder in Carl's case if we can do
> even better, since the user is checking out a tracking branch. Does it
> really make sense to say "you are not on ANY branch"? Maybe instead:
> 
[...]
> +		case "$detached_remote" in
> +		  "") detach_warn="Note: you are not on ANY branch anymore." ;;
> +		   *) detach_warn="Note: you are on the remote tracking branch '$detached_remote'" ;;
> +		esac

No.  This is misleading.

You are _not_ on the remote tracking branch.  You just happen to have 
checked out a commit that came from a tracking branch, but you are still 
detached from any branch at that point.


Nicolas
