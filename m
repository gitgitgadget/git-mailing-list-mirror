From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: update-cache ./test.c
Date: Sun, 1 May 2005 10:54:27 +0200
Message-ID: <20050501085427.GB30692@xi.wantstofly.org>
References: <20050501084145.GA30692@xi.wantstofly.org> <20050501084710.GJ26663@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 10:49:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSA88-0006uf-03
	for gcvg-git@gmane.org; Sun, 01 May 2005 10:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVEAIyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 04:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEAIyf
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 04:54:35 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:4518 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261564AbVEAIy2
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 May 2005 04:54:28 -0400
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 663FC2B0EC; Sun,  1 May 2005 10:54:27 +0200 (MEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050501084710.GJ26663@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 01, 2005 at 10:47:10AM +0200, Thomas Glanzmann wrote:

> Hello,

Hi,


> > update-cache seems to ignore paths containing path components
> > starting with a dot:
> 
> > 	pi% update-cache --add ./test.c
> > 	Ignoring path ./test.c
> > 	pi% update-cache --add test.c
> > 	pi%
> 
> > This is slightly annoying as 'find -type f | xargs update-cache --add'
> > doesn't work because of this.  ('find * -type f | ...` does.)  Instead
> > of ignoring the file, can we just strip off the leading "./" ?
> 
> just use a shell script to obtain that:
> 
> find -type f | sed "s#^./##" | xargs update-cache --add

This also works:

	find * -type f | xargs update-cache --add

But that wasn't quite the point :)  It makes sense that update-cache
doesn't like ambiguous path names, but it's easier for update-cache to
detect and strip "^./" than for me to remember to type sed "s#^./##"
every time.


--L
