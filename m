From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 09:01:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org>
References: <1178794261.5806.98.camel@murta.transitives.com>
 <4643049C.3D5F30D8@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmB59-0005rk-Ji
	for gcvg-git@gmane.org; Thu, 10 May 2007 18:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbXEJQB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXEJQB0
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 12:01:26 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:57318 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752989AbXEJQBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 12:01:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4AG1Fun021971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 09:01:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4AG1F6t024590;
	Thu, 10 May 2007 09:01:15 -0700
In-Reply-To: <4643049C.3D5F30D8@eudaptics.com>
X-Spam-Status: No, hits=-2.98 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46873>



On Thu, 10 May 2007, Johannes Sixt wrote:
>
> - cherry-pick them before commit
> 
>   $ git cherry-pick -n x
>   $ git cherry-pick -n y
>   $ git cherry-pick -n z

I've done this (actually, mostly with "revert", but cherry-pick and revert 
are literally the same things).

However:

>   $ git commit -m "$(for c in x y z; do git show --stat $c; done)" -e

I'm too lazy to do this part, so I always do it by hand.

> You didn't really think that git couldn't do that, did you? ;)

Clearly git can, but equally clearly it really *would* be pretty nice if 
you could just do

	git cherry-pick x y z

and create one commit and have the message already somewhat done for you 
(and "git revert" doing the same).

So if somebody does that, I'll certainly applaud..

		Linus
