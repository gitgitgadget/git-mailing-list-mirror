From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 13:05:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506231245560.30848-100000@iabervon.org>
References: <tnxr7et9su7.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 19:01:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlV4F-000122-Qe
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 19:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVFWRGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVFWRGy
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 13:06:54 -0400
Received: from iabervon.org ([66.92.72.58]:64262 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262629AbVFWRGs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 13:06:48 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlV8R-0000ca-00; Thu, 23 Jun 2005 13:05:03 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxr7et9su7.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Jun 2005, Catalin Marinas wrote:

> Actually StGIT still lists the old commit as the 2nd parent since I
> want to implement a log command which can also show only the commits
> against a single patch. If this 2nd parent would not be stored,
> pushing a patch onto the stack when its base was changed would reset
> all the history for that patch.

I think that it's important to avoid having the array of "rebased the
patch" commits be reachable from the final series if that series is going
to be merged into the mainline at the end.

If you want to keep the history of a patch, you should be able to do it by
rebasing that history as well as the latest patch, so you'd get a
two-parent commit with two rebased parents when you rebased a two-parent
commit.

	-Daniel
*This .sig left intentionally blank*

