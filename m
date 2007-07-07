From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use /etc/mailname for the hostname part of the email
 address.
Date: Fri, 6 Jul 2007 19:54:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707061945220.31544@woody.linux-foundation.org>
References: <11837748652889-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <kraai@asturias.ftbfs.org>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 04:55:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I70Rs-0006ie-2k
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 04:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbXGGCyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 22:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXGGCyz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 22:54:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42135 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753300AbXGGCyy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 22:54:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l672seb8019852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 19:54:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l672sYHV002829;
	Fri, 6 Jul 2007 19:54:34 -0700
In-Reply-To: <11837748652889-git-send-email-kraai@ftbfs.org>
X-Spam-Status: No, hits=-4.64 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51802>



On Fri, 6 Jul 2007, Matt Kraai wrote:
>
> From: Matt Kraai <kraai@asturias.ftbfs.org>
> 
> /etc/mailname contains the hostname to be used on outgoing email
> messages generated locally on Debian systems

I think this is taking us into a bad direction.

The thing is, I actually personally tend to _prefer_ the committer name as 
being "user@hostname" rather than a "real" email address.

It often tells you something much more.

For example, take a look at the kernel archive, and do

	git log --author=torvalds

and notice how the exact author string changes - not just because 
"osdl.org" became "linux-foundation.org", but because it ends up encoding 
which *machine* I did things on.

For example, while I do almost all my work at any time on my "main" 
machine (right now "woody" - not because I'm horny, but because it's an 
Intel woodcrest machine, the way my previous main machine was called "g5" 
because it was an IBM PowerPC G5 machine), but I sometimes do things on 
another machine because that's the machine that showed the problem, or was 
the machine that it got tested on (32-bit x86 things: "macmini" or "evo"), 
or it was just the laptop I use while travelling ("evo" again).

IOW, I don't think the authorship really even _has_ to be seen as a "real 
email" address. The "user@hostname" in many ways is nicer. Sure, when the 
patches come in as emails (which ends up being most of them), it obviously 
ends up being the email, but I don't think that's at all required.

If you actually want to contact the people involved with a patch, you 
should use the "Signed-off-by:" and "Cc:" lines in the commit message, not 
necessarily the author thing!

			Linus
