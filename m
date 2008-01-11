From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 10:10:00 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
 <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDOLs-0002aE-1F
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760256AbYAKSK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760846AbYAKSK7
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:10:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43003 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757687AbYAKSK6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 13:10:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BIA1Fr006065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 10:10:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BIA0ME002648;
	Fri, 11 Jan 2008 10:10:00 -0800
In-Reply-To: <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70181>



On Fri, 11 Jan 2008, Steffen Prohaska wrote:
> 
> Ah sorry, I misunderstood you in [1].  I thought your last point
> "Mixed Windows usage" meant what I have in mind:  A user working
> in a mixed Windows/Unix environment who creates a file using
> Windows tools and commits it in the Unix environment.  In this
> case the CRLF file will be transferred from Windows to Unix
> without git being involved.  The right thing for git on Unix is
> to remove CRLF during a commit but still write only LF during
> check out.  So autocrlf=input is the right choice.

Oh, ok, I didn't realize.

But yes, if you use a network share across windows and Unixand actually 
*share* the working tree over it, then yes, you'd want "autocrlf=input" on 
the unix side.

However, I think that falls under the "0.1%" case, not the "99.9%" case.

I realize that people probably do that more often with centralized 
systems, but with a distributed thing, it probably makes a *ton* more 
sense to have separate trees. But I could kind of see having a shared 
development directory and accessing it from different types of machines 
too.

I'd also bet that crlf behavior of git itself will be the *least* of your 
problems in that situation. You'd have all the *other* tools to worry 
about, and would probably be very aware indeed of any CRLF issues. So  at 
that point, the "automatic" or default behaviour is probably not a big 
deal, because everything _else_ you do likely needs special effort too!

			Linus
