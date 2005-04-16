From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:33:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161827480.30848-100000@iabervon.org>
References: <12c511ca050416152452a4c620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:29:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvmy-0007U9-3V
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDPWdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDPWdB
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:33:01 -0400
Received: from iabervon.org ([66.92.72.58]:33286 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261162AbVDPWc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:32:59 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMvqo-00042N-00; Sat, 16 Apr 2005 18:33:18 -0400
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca050416152452a4c620@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Tony Luck wrote:

> On 4/16/05, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > +        buffer = read_sha1_file(sha1, type, &size);
> 
> You never free this buffer.

Ideally, this should all be rearranged to share the code with
read-tree, and it should be fixed in common.

> It would also be nice if you saved "tree" objects in some temporary file
> and did not install them until after you had fetched all the blobs and
> trees that this tree references.  Then if your connection is interrupted
> you can just restart it.

It looks over everything relevant, even if it doesn't need to download
anything, so it should work to continue if it stops in between.

	-Daniel
*This .sig left intentionally blank*

