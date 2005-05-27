From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 15:06:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271502240.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org> <20050527135124.0d98c33e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 00:03:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbmvL-0005TB-3H
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVE0WFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVE0WFO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:05:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:37015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262620AbVE0WEn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 18:04:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RM4bjA010943
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 15:04:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RM4aWJ011925;
	Fri, 27 May 2005 15:04:37 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Andrew Morton wrote:
>
> Yes, I'll occasionally do patches which were written by "A" as:
> 
> From: A
> ...
> Signed-off-by: B
> 
> And that comes through email as:
> 
> 
> ...
> From: <akpm@osdl.org>
> ...
> From: A
> ...
> Signed-off-by: B
> 
> 
> which means that the algorithm for identifying the author is "the final
> From:".

No, the algorithm is:
 - the email author, _or_ if there is one, the top "From:" in the body.

And the rule is that you never remove (or add to) an existing From:, since 
the author doesn't change from being passed around.

Put another way: authorship is very different from sign-off. The sign-off 
gets stacked, the authorship is constant, and thus the rules are 
different.

Also, authorship is more important than sign-off-ship, so authorship goes 
at the top, while sign-offs go at the bottom.

> I guess the bug here is the use of From: to identify the primary author,
> because transporting the patch via email adds ambiguity.

No it doesn't, the email "from" just ends up being the "default" if no 
explicit authorship is noted.

> Maybe we should introduce "^Author:"?

It would still have the same rules, so it wouldn't change anything but the 
tag, so I don't think there is any real advantage to it.

		Linus
