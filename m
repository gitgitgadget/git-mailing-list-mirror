From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log --follow?
Date: Thu, 12 Jul 2007 12:01:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707121154240.20061@woody.linux-foundation.org>
References: <20070704203541.GA13286@artemis.corp> <7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
 <7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707121026080.20061@woody.linux-foundation.org>
 <7vsl7ttq97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:01:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93vH-0001wg-3H
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXGLTBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbXGLTBs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:01:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45677 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597AbXGLTBs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 15:01:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CJ1T1o014182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 12:01:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CJ1OuT027662;
	Thu, 12 Jul 2007 12:01:24 -0700
In-Reply-To: <7vsl7ttq97.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.615 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52321>



On Thu, 12 Jul 2007, Junio C Hamano wrote:
> 
> Yeah, I just tried the blame from 'pu' (I have been carrying
> that original patch from you there).  The output is not very
> intuitive in that it talks about each commit but it is not
> apparent _why_ the command talks about that commit.  Maybe
> adding "there are the lines in the final image of the blob you
> are blaming that came from this commit" to the output would make
> the output easier to read.

That doesn't necessarily work, at least not incrementally. The same commit 
can show up multiple times for *different* 'blame_entry' things, and I 
don't think we want to show such a commit multiple times, and I also don't 
think we know what all the blame entries are going to be until the end.

So right now I use that METAINFO_SHOWN flag to just show the commit once. 
That makes the log a *lot* more readable.

In my original patch (the one you apparently have in 'pu'), I did that 
differently (and not very well), but maybe that approach lends itself 
better to showing some kind of patch.

I think my newer version is likely better.

		Linus
