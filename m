From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-ls-files -l
Date: Tue, 30 Dec 2008 12:32:20 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812301226110.3082@localhost.localdomain>
References: <87abae6hbn.fsf@jidanni.org> <m3wsdiaptg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHlIP-0004Xk-S3
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 21:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYL3UdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYL3UdN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 15:33:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39240 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751831AbYL3UdM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 15:33:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBUKWLHw031383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Dec 2008 12:32:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBUKWKsn026998;
	Tue, 30 Dec 2008 12:32:20 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <m3wsdiaptg.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.421 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104203>



On Tue, 30 Dec 2008, Jakub Narebski wrote:
> 
> I think it would be easy to add '-l' also to git-ls-files. Please
> remember to provide size only for blobs, as provoding size for trees
> would make it harder to change to future packv4, where tree objects
> would be stored deconstructed.

Personally, more than "git ls-files -l", I've occasionally wanted a real 
"git ls" that really looks more like "ls". That includes:

 - turning a list of files in a subdirectory into a "directory" entry 
   (which is not very natural for "git ls-files" as an index operation, 
   since the index is fundamentally flat).

 - yes, adding "-l" as an option, but really showing the stat information. 
   Right now, you can do "git ls-files --stage", and it will show a kind 
   of extended information, but while it shows the mode, it doesn't show 
   the owner/timestamp/etc parts of the index, and those are sometimes 
   interesting.

Btw, the "ls-tree -l" format is not nice. Don't use it as a basis 
to pattern "ls -l" (or if you want to just extend ls-tree, whatever).

			Linus
