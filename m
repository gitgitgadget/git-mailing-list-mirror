From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 16:02:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505031539480.30848-100000@iabervon.org>
References: <20050503192753.GA6435@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:57:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3VO-0001tw-2i
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVECUCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVECUCW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:02:22 -0400
Received: from iabervon.org ([66.92.72.58]:15366 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261666AbVECUCS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 16:02:18 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DT3an-0003lE-00; Tue, 3 May 2005 16:02:05 -0400
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050503192753.GA6435@taniwha.stupidest.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Chris Wedgwood wrote:

> i thought this was all common code?  if it's not maybe now is the time
> to change that?

The other versions are getting the tagged compressed object along with the
intended hash from an external source. They both verify the result as they
go (as opposed to the normal case which takes the uncompressed data
and finds the hash, and therefore has to be right). The common part is
really "open the file" and "close (and place) the file", which weren't
previously sufficiently complex to justify sharing the code.

	-Daniel
*This .sig left intentionally blank*

