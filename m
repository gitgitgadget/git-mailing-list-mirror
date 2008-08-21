From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Push over WebDAV and hooks
Date: Thu, 21 Aug 2008 13:11:26 -0700
Message-ID: <20080821201126.GY3483@spearce.org>
References: <g8kgr5$e67$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nikolai Prokoschenko <nikolai@prokoschenko.de>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGWZ-0000ku-M8
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbYHUUL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbYHUUL1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:11:27 -0400
Received: from george.spearce.org ([209.20.77.23]:40467 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbYHUUL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:11:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5C6DB38375; Thu, 21 Aug 2008 20:11:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <g8kgr5$e67$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93194>

Nikolai Prokoschenko <nikolai@prokoschenko.de> wrote:
> I have a (bare) repository on my server. Since I need to access it from  
> firewalled networks, I can't go with git protocol or SSH; I thought  
> WebDAV is the way to go. However I've noticed that my hooks are not  
> executed and could not really think of a way the could ever work, since  
> WebDAV is essentially a virtual hard drive without any execution  
> capability. So am I right, hooks aren't supposed to work with WebDAV and  
> so I'd have to find a way to use SSH or git:// to push changes?

Correct.  Hooks can only be executed if you use SSH or git:// to push
the changes, as there is no remote execution available via WebDAV.

That said if someone was really interested in this they could try
to make hook CGIs and teach git-http-push how to execute them by
sending a GET to the proper URL.  But then you are relying on the
client to honor the hooks, and only newer clients (post that change)
would support it.

-- 
Shawn.
