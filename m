From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 08:45:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
References: <20060612043949.20992.qmail@science.horizon.com>
 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 17:46:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpoc6-0007lk-VK
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 17:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbWFLPp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWFLPp7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 11:45:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751989AbWFLPp6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 11:45:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CFjrgt016253
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 08:45:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CFjqeP025210;
	Mon, 12 Jun 2006 08:45:53 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21707>



On Mon, 12 Jun 2006, Jon Smirl wrote:
> 
> I've stablized like this. 1GB RAM with 2.8Ghz P4 hyperthread. Is there
> anyway to tell what it is doing in the kernel for so much time?

oprofile will tell you.

I don't see why it would spend a lot of time in the kernel, unless it's 
the SVN part that does a ton of reads or something. git should have almost 
no kernel footprint apart from the individual objects creation/reading, so 
once it's repacked, I generally see very little system time.

What does top say? (Ie can you see _which_ process spends time in the 
kernel?)

		Linus
