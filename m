From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] Add git-changelog-script to show the changes between
 two commits
Date: Thu, 21 Jul 2005 13:00:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507211256460.6074@g5.osdl.org>
References: <20050721063143.GO20369@mythryan2.michonline.com>
 <20050721194138.GP20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 22:01:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvhEG-0001VX-EW
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 22:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVGUUBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 16:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVGUUBB
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 16:01:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261861AbVGUUA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2005 16:00:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6LK0sjA027864
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Jul 2005 13:00:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6LK0pBP021794;
	Thu, 21 Jul 2005 13:00:53 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050721194138.GP20369@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Jul 2005, Ryan Anderson wrote:
>
> Nevermind, I apparently wanted:
> 	git-whatchanged HEAD ^$LAST_RELEASED_COMMIT

Yes. And since git-whatchanged uses git-rev-parse, and can thus use the 
extended git commit format, including ranges, you can literally write the 
above as

	git-whatchanged $LAST_RELEASED_COMMIT..

(or, if you only care about the log, not the actual diff lines, use the 
faster and simpler

	git log $LAST_RELEASED_COMMIT..

which will also show you merges - something git-whatchanged doesn't do).

You can also use the "--pretty" format specializers, so

	git log --pretty=short $LAST_RELEASED_COMMIT..

will do exactly what you'd expect it to do.

		Linus
