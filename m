From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "git-ls-files" work in subdirectories
Date: Sun, 21 Aug 2005 16:17:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508211613340.3317@g5.osdl.org>
References: <Pine.LNX.4.58.0508211210500.3317@g5.osdl.org>
 <20050821224622.GB26241@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 01:20:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6z4n-0007DU-OO
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 01:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVHUXSB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 19:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVHUXSB
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 19:18:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750903AbVHUXSA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 19:18:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7LNHsjA010489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Aug 2005 16:17:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7LNHrBw017754;
	Sun, 21 Aug 2005 16:17:53 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050821224622.GB26241@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 21 Aug 2005, Chris Wedgwood wrote:
> 
> is there some aversion to getopt or similar get?

getopt() is too limited, and getopt_long() is very glibc-specific and thus
inherently evil. And the complexity of doing autoconf or similar is worse
than just doing it by hand.

I've considered doing a small library that could just be contained withing 
the git sources to avoid duplication, but it just hasn't been worth it.

If somebody wants to do it, go wild. The rules are
 - anything that is not expected of "modern unix" is too unportable (glibc 
   is not a realistic expectation, but a lot of GNU tools _are_ realistic)
 - autoconf and its ilk are worse than the disease they are trying to fix

		Linus
