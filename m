From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Wed, 9 Nov 2005 17:01:46 -0800
Message-ID: <20051110010146.GC4051@reactrix.com>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net> <20050924125001.GB25069@pasky.or.cz> <7virwqwd3z.fsf@assigned-by-dhcp.cox.net> <20051109223303.GG30496@pasky.or.cz> <7v3bm59zxu.fsf@assigned-by-dhcp.cox.net> <20051109233614.GA4051@reactrix.com> <20051109234405.GK30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 02:05:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea0qh-0000zg-7e
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 02:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVKJBD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 20:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVKJBD2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 20:03:28 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:43850 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751249AbVKJBD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 20:03:27 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAA1269p014399;
	Wed, 9 Nov 2005 17:02:21 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAA11kJn014393;
	Wed, 9 Nov 2005 17:01:46 -0800
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051109234405.GK30496@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11457>

On Thu, Nov 10, 2005 at 12:44:05AM +0100, Petr Baudis wrote:

> Hmm. Yes, that's bad. Couldn't the HTTP pusher actually get the current
> server info, update it at the pusher's side and send it back?

Yes, although duplicating all of what update-server-info does is going
to take a while...

However, the only thing of interest to update-server-info that http-push
is able to change is a ref.  It would be much more straightforward to
lock and update info/refs after a successful push; is that good enough?
The same thing could apply to objects/info/packs if/when http-push
starts sending packs.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
