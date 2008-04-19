From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 00:00:58 +0200
Message-ID: <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:01:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnL81-0006RM-7A
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbYDSWBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYDSWBD
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:01:03 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:8518 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYDSWBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 18:01:01 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id 79D8370000A0;
	Sun, 20 Apr 2008 00:00:59 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id 561F87000086;
	Sun, 20 Apr 2008 00:00:58 +0200 (CEST)
X-ME-UUID: 20080419220059352.561F87000086@mwinf6302.orange.nl
In-Reply-To: <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79924>


On 19 apr 2008, at 23:54, Linus Torvalds wrote:
>
>
> Btw, the "git status" issue is totally different.
>

Yes, I was aware of that, but still found it interesting to test.
>
> And yes, most of the time in "git status ." is going to be the lstat()
> calls. Which are expensive on OS X. And yes, we do too many of them.  
> I'll
> look at seeing if we can avoid some.

I just tested this. "git status ." does 428815 (400k!) lstats, almost  
10x as many as there are files in the repository. I'd agree that this  
is the reason it's slow on OS X :).

- Pieter
