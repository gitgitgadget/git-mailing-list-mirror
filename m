From: David Brown <git@davidb.org>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 19:37:22 -0800
Message-ID: <20071208033722.GA27776@old.davidb.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com> <alpine.LFD.0.99999.0712072032410.555@xanadu.home> <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com> <alpine.LFD.0.99999.0712072124160.555@xanadu.home> <9e4733910712071929h17a7d88dv37686ec7cd858c63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 04:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0qVh-0008Dq-FT
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 04:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbXLHDhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 22:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbXLHDhZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 22:37:25 -0500
Received: from mail.davidb.org ([66.93.32.219]:35323 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXLHDhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 22:37:25 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J0qVG-0007HK-CW; Fri, 07 Dec 2007 19:37:22 -0800
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910712071929h17a7d88dv37686ec7cd858c63@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67503>

On Fri, Dec 07, 2007 at 10:29:31PM -0500, Jon Smirl wrote:
>The kernel repo has the same problem but not nearly as bad.
>
>Starting from a default pack
> git repack -a -d -f  --depth=1000 --window=1000
>Uses 1GB of physical memory
>
>Now do the command again.
> git repack -a -d -f  --depth=1000 --window=1000
>Uses 1.3GB of physical memory

With my repo that contains a bunch of 50MB tarfiles, I've found I must
specify --window-memory as well to keep repack from using nearly unbounded
amounts of memory.  Perhaps it is the larger files found in gcc that
provokes this.

A window size of 1000 can take a lot of memory if the objects are large.

Dave
