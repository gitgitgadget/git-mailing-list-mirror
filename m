From: Paul Mackerras <paulus@samba.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Tue, 31 May 2005 22:15:18 +1000
Message-ID: <17052.21846.816147.370354@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 14:13:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd5c3-0005iW-2U
	for gcvg-git@gmane.org; Tue, 31 May 2005 14:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVEaMP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 08:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEaMP1
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 08:15:27 -0400
Received: from ozlabs.org ([203.10.76.45]:12946 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261880AbVEaMPX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 08:15:23 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 06ABF679E6; Tue, 31 May 2005 22:15:22 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> Ok, I just made git-rev-list DTRT when you pass it a "beginning" and 
> "end", ie it does proper reachability analysis _without_ parsing the whole 
> set of commits. 

I have made gitk use git-rev-list instead of git-rev-tree, but it
still absorbs the whole of git-rev-list's output before drawing
anything.  I'd like to make it draw the commit graph and list
incrementally as it gets the output from git-rev-list, but to do that
I need to know whether git-rev-list could ever print a commit ID
*after* one of its parents.  If it never does that then I can
restructure the code to do the drawing incrementally fairly easily.

Paul.
