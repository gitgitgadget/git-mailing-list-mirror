From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [1/5] Consider a blob to be parsed
Date: Thu, 28 Apr 2005 01:49:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280131400.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504272217240.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:48:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1t2-000286-Bj
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVD1FxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVD1FwO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:52:14 -0400
Received: from iabervon.org ([66.92.72.58]:25093 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262127AbVD1FtJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:49:09 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR1tb-0002tu-00; Thu, 28 Apr 2005 01:49:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504272217240.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Linus Torvalds wrote:

> 
> 
> On Thu, 28 Apr 2005, Daniel Barkalow wrote:
> >
> > We don't parse blobs at all, so any that we've got are as parsed as
> > they're going to get. Don't make fsck-cache mark them.
> 
> NO NO NO!
> 
> This is WRONG, dammit. I fixed it once, you are re-introducing the same
> bug.


> Daniel, the problem is that you parse them only when you SEE them, and 
> that is totally different from having seen a REFERENCE to them. One says 
> "I've seen this object", the other says "I _want_ to see this object". 
> They are two totally different things.

Good point; the right fix is actually to have a parse_blob that checks to
make sure it's there, and not have a special case for the simple case.

Replacement [1/5] to follow...

	-Daniel
*This .sig left intentionally blank*

