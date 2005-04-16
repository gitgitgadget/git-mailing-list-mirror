From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:37:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161833340.30848-100000@iabervon.org>
References: <20050416223206.GU9461@lug-owl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:34:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvrf-000847-Cg
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDPWhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDPWhs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:37:48 -0400
Received: from iabervon.org ([66.92.72.58]:39430 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261168AbVDPWhm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:37:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMvvI-00042g-00; Sat, 16 Apr 2005 18:37:56 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050416223206.GU9461@lug-owl.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Jan-Benedict Glaw wrote:

> On Sat, 2005-04-16 18:03:51 -0400, Daniel Barkalow <barkalow@iabervon.org>
> wrote in message <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>:
> > --- /dev/null  (tree:ed4f6e454b40650b904ab72048b2f93a068dccc3)
> > +++ a65375b46154c90e7499b7e76998d430cd9cd29d/http-get.c  (mode:100644 sha1:6a36cfa079519a7a3ad5b1618be8711c5127b531)
> 
> > +	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
> 
> 0666 is a bit too lazy. I'd suggest 0664 or 0644.

Actually, 0444 would make most sense, since these shouldn't get modified
at all. But umask is applied to them anyway, so 0664 or 0644 (or 0660 or 
0600) is up to the local system policy. This just matches
write_sha1_buffer().

	-Daniel
*This .sig left intentionally blank*

