From: alan <alan@clueserver.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 14:18:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051414140.14017@blackbox.fnordora.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Chris Lee <chris133@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xmR-00047y-JY
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXAEWnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXAEWnR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:43:17 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:37603 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbXAEWnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 17:43:16 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 17:43:16 EST
Received: by clueserver.org (Postfix, from userid 500)
	id BA0B9F50C8F; Fri,  5 Jan 2007 14:18:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id B52C2F5057F;
	Fri,  5 Jan 2007 14:18:16 -0800 (PST)
X-X-Sender: alan@blackbox.fnordora.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Jan 2007, Linus Torvalds wrote:

>
>
> On Fri, 5 Jan 2007, Junio C Hamano wrote:
>>
>> Somehow we forgot to turn save_commit_buffer off while walking
>> the reachable objects.  Releasing the memory for commit object
>> data that we do not use matters for large projects (for example,
>> about 90MB is saved while traversing linux-2.6 history).
>
> Heh. Maybe we should just make the default the other way? It's probably
> pretty easy to find any users that suddenly start segfaulting ;)

I am trying to import a subversion repository and have yet to be able to 
suck down the whole thing without segfaulting.  It is a large repository. 
Works fine until about the last 10% and then runs out of memory.

open3: fork failed: Cannot allocate memory at /usr/bin/git-svn line 2711
512 at /usr/bin/git-svn line 446
         main::fetch_lib() called at /usr/bin/git-svn line 314
         main::fetch() called at /usr/bin/git-svn line 173

I need to try the "partial download" script and see if that helps.

-- 
"Invoking the supernatural can explain anything, and hence explains nothing."
                   - University of Utah bioengineering professor Gregory Clark
