From: Matt Mackall <mpm@selenic.com>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 20:14:57 -0500
Message-ID: <20070316011457.GA4892@waste.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> <45F9EED5.3070706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, bcrl@kvack.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS1EL-0003qB-1i
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933999AbXCPB1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934000AbXCPB1i
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:27:38 -0400
Received: from waste.org ([66.93.16.53]:50981 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933999AbXCPB1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:27:37 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l2G1Ew8W013720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Mar 2007 20:14:58 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id l2G1EvS6013719;
	Thu, 15 Mar 2007 20:14:57 -0500
Content-Disposition: inline
In-Reply-To: <45F9EED5.3070706@garzik.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42311>

On Thu, Mar 15, 2007 at 09:11:49PM -0400, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >Now, it's possible that I'm just wrong, but the instruction-level profile 
> >really did pinpoint the "look up state branch pointer and jump to it" as 
> >some of the hottest part of that function. Which is just *evil*. You can 
> 
> ISTR there are a bunch of state transitions per byte, which would make 
> sense that it shows up on profiles.

Yep, not surprising.

> >Now, I'm just wondering if anybody knows if there are better zlib 
> >implementations out there? This really looks like it could be a noticeable 
> >performance issue, but I'm lazy and would be much happier to hear that 
> >somebody has already played with optimizing zlib. Especially since I'm not 
> >100% sure it's really going to be noticeable..
> 
> I could have sworn that either Matt Mackall or Ben LaHaise had cleaned 
> up the existing zlib so much that it was practically a new 
> implementation.  I'm not aware of any open source implementations 
> independent of zlib (except maybe that C++ behemoth, 7zip).

I cleaned up the version in lib/ that's used for boot on most systems.
It's quite a bit simpler and cleaner than the code lib/zlib (and
elsewhere!). But making it faster is another matter entirely - I don't
know off-hand how the two compare.

-- 
Mathematics is the supreme nostalgia of our time.
