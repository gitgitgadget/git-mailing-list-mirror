From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: q: git-fetch a tad slow?
Date: Wed, 30 Jul 2008 21:45:31 -0700
Message-ID: <20080731044531.GB1860@spearce.org>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org> <20080729090802.GA11373@elte.hu> <20080730044855.GA7225@spearce.org> <20080730190657.GC26389@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jul 31 06:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOQ3n-0005Yu-3X
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 06:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYGaEpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 00:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbYGaEpc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 00:45:32 -0400
Received: from george.spearce.org ([209.20.77.23]:56193 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYGaEpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 00:45:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2C07F383A4; Thu, 31 Jul 2008 04:45:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080730190657.GC26389@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> alas, fetching still seems to be slow:
> 
>   titan:~/tip> time git-fetch origin
> 
>   real    0m5.112s
>   user    0m0.972s
>   sys     0m3.380s

What version of git are dealing with on the client side?

I only have a MacBook Pro (2.4 GHz Intel Core 2 Duo) and I'm getting
fetch times of ~472 ms over git:// to your -tip.git tree and ~128
ms for strictly local fetch.  If your SSH overhead is ~300 ms this
is only a ~700 ms real time for `git fetch origin`, not 5100 ms.

Is your git-fetch a shell script?  Or a compiled binary?  The port
into C made it go _much_ faster, even though it is still a naive
O(N^2) matching algorithm.  Yea, we still should fix that, but
I think an upgrade to 1.5.4 or later would make the client side
improve consideribly.

-- 
Shawn.
