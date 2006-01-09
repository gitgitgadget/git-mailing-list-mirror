From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-format-patch Date header
Date: Sun, 8 Jan 2006 22:11:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601082207510.3169@g5.osdl.org>
References: <20060108141457.8C4E85BE8F@nox.op5.se> <20060108164038.89e4439f.tihirvon@gmail.com>
 <43C12DE9.8010906@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 07:11:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvqFk-0006m5-Ls
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 07:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWAIGLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 01:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWAIGLc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 01:11:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932546AbWAIGLc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 01:11:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k096BKDZ018374
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 22:11:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k096BJUe021026;
	Sun, 8 Jan 2006 22:11:19 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C12DE9.8010906@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14354>



On Sun, 8 Jan 2006, Andreas Ericsson wrote:
> 
> Actually, that's what's printed in the commit message, so any change 
> would have to be put there and that would break backwards compatibility 
> for new tools that might want to use it.

No, git should always take the date in any of a million different formats, 
and always turn it into "seconds + timezone" internally.

The fact that git-format-patch also prints it out in the internal format 
is unambiguous (nice) but human-unreadable (bad). 

There are other unambiguous formats it could use, notably standard rfc2822 
format ("date -R").

The git "show_date()" function hopefully does exactly that rfc2822 format, 
but you'd have to make a helper program to do the conversion in 
git-format-patch.sh.

		Linus
