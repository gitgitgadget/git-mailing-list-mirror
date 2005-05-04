From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Careful object pulling
Date: Wed, 4 May 2005 12:16:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505041207480.30848-100000@iabervon.org>
References: <118833cc050504023569e00d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 18:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTMSR-0002uo-3o
	for gcvg-git@gmane.org; Wed, 04 May 2005 18:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVEDQRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVEDQRI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 12:17:08 -0400
Received: from iabervon.org ([66.92.72.58]:9221 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261914AbVEDQRG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 12:17:06 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DTMYP-0006Yx-00; Wed, 4 May 2005 12:16:53 -0400
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc050504023569e00d38@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 4 May 2005, Morten Welinder wrote:

> Something's fishy there.  You are comparing the result from link with EEXIST.

No, it just looks that way. If ret is negative, errno gets written to
it. If it's zero, we don't do anything with it. It can't be positive. So,
at the point where we test it, it must be the errno from link, which would
be EEXIST if the case we're worried about.

	-Daniel
*This .sig left intentionally blank*

