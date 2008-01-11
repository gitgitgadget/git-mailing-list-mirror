From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 11:16:02 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
 <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org> <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 20:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDPNa-0002Dj-KI
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 20:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761751AbYAKTQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 14:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761662AbYAKTQy
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 14:16:54 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48960 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759447AbYAKTQx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 14:16:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BJG387008724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 11:16:04 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BJG2WW005205;
	Fri, 11 Jan 2008 11:16:02 -0800
In-Reply-To: <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70193>



On Fri, 11 Jan 2008, Steffen Prohaska wrote:
> 
> I already started to teach everyone the new "autocrlf=input" policy to 
> avoid these questions.

I certainly don't think "autocrlf=input" is wrong. It might even be a 
reasonable default on Unix, although I don't think it's nearly as obvious 
as the Windows case. I wouldn't mind using it myself, for example, 
although probably only because I know that for the stuff I work on it 
simply cannot possibly ever do the wrong thing.

In fact, we had a case of bogus CRLF in one of the kernel documentation 
files for some reason that we ended up fixing by hand. "autocflf=input" 
would have fixed it (except in that case it wouldn't have, since it came 
from the original kernel tree, long before crlf was an issue for git ;)

So I'd say that autocrlf=input is quite possibly a good idea on Unix in 
general, but my gut feel is still that it's not a big enough issue to be 
actually worth making a default change over. But there's absolutely 
nothing wrong with having it as a policy at a company that has mixed Unix 
and Windows machines.

(Every place I've ever been at, people who had a choice would never ever 
develop under Windows, so I've never seen any real mixing - even when some 
parts of the project were DOS/Windows stuff, there was a clear boundary 
between the stuff that was actually done under Windows)

			Linus
