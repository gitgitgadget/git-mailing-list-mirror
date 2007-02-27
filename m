From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 08:00:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702270751260.12485@woody.linux-foundation.org>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4kh-0005D1-NQ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbXB0QA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933061AbXB0QA1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:00:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38230 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932601AbXB0QAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 11:00:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RG0IhB007816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 08:00:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RG0HET020786;
	Tue, 27 Feb 2007 08:00:17 -0800
In-Reply-To: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40754>



On Tue, 27 Feb 2007, Junio C Hamano wrote:
> 
> I take that as a sign that git hasn't been exercised well and
> yet more ancient bugs are sleeping, waiting to be triggered, not
> as a sign that we are very careful and adding only small number
> of risky new code in the releases.

I'd say that it's good news. I'd be a lot more worried if there is a big 
rash of *new* bugs being introduced, rather than small and subtle *old* 
bugs being fixed.

There were a number of "December, 2006" bugs there, and I'd worry more 
about those. The old bugs were all fairly obscure (face it, nobody 
actually uses SCM's to track symlinks, because symlinks are not 
historically tracked by most SCM's).

And the _really_ old bugs (eg the mailinfo one) were either features that 
you'd never use on Unix anyway (trust_executable_bit) and thus haven't 
gotten any testing, or were about over-long buffers that mostly wouldn't 
realistically trigger in practice (ie lack of coverage).

Finding bugs is good. Some of it may well be due to just having more 
users. And much of it is probably because everybody has bugs - but 
absolutely none of the bugs on that list looked even remotely like a "we'd 
screw up the repository". They were all pretty much harmless details.

		Linus
