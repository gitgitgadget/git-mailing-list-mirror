From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 21:50:59 -0500
Organization: me
Message-ID: <200511242151.00162.tomlins@cam.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <Pine.LNX.4.64.0511241020050.13959@g5.osdl.org> <20051124195256.GR3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161096AbVKYCu0@vger.kernel.org Fri Nov 25 03:51:15 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161096AbVKYCu0@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfTg8-0006Wi-QB
	for glk-linux-kernel-3@gmane.org; Fri, 25 Nov 2005 03:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbVKYCu0 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 24 Nov 2005 21:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbVKYCu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 21:50:26 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:16082 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1161068AbVKYCuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 21:50:25 -0500
Received: from grover (dsl-156-165.aei.ca [66.36.156.165])
	by aeimail.aei.ca (8.12.10/8.12.10) with ESMTP id jAP2oEu4017768;
	Thu, 24 Nov 2005 21:50:14 -0500 (EST)
To: Nick Hengeveld <nickh@reactrix.com>
User-Agent: KMail/1.8.2
In-Reply-To: <20051124195256.GR3968@reactrix.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12728>

On Thursday 24 November 2005 14:52, Nick Hengeveld wrote:
> On Thu, Nov 24, 2005 at 10:37:15AM -0800, Linus Torvalds wrote:
> 
> > I just repacked and updated it now, so how http should work too, although 
> > inefficiently (because it will get a whole new pack - just one of the 
> > disadvantages of the non-native protocols).
> 
> There's room to improve on that particular inefficiency.  The http
> commit walker could use Range: headers to fetch loose objects directly
> from inside a pack if it didn't make sense to fetch the entire pack.
> For this to work, pack fetches would need to be deferred until the
> entire tree had been walked, and the commit walker could decide whether
> to fetch the pack or loose objects based on the percentage of packed
> objects it needed to fetch.  It would also need to fetch all
> tag/commit/tree objects using ranges to be able to fully walk the tree.

Alternately, when creating a new archive the client could ask the server
what protocols are active.  It could then use the best one for the clone and
update the .git/origin files with the optimal one for incremental pulls.

Thoughts?
Ed Tomlinson
