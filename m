From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 01:10:55 +0200
Message-ID: <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 01:12:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnMDz-0002Ag-M3
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 01:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbYDSXLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 19:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYDSXLB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 19:11:01 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:63975 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYDSXLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 19:11:00 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6101.orange.nl (SMTP Server) with ESMTP id B7D8E1C00083;
	Sun, 20 Apr 2008 01:10:56 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6101.orange.nl (SMTP Server) with ESMTP id 77CE91C00082;
	Sun, 20 Apr 2008 01:10:56 +0200 (CEST)
X-ME-UUID: 20080419231056490.77CE91C00082@mwinf6101.orange.nl
In-Reply-To: <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79934>


On 20 apr 2008, at 00:54, Linus Torvalds wrote:
> Pieter? Assuming the lstat() cost is the dominant one, it should cut  
> down
> your "git status ." cost by about 15-20% or so. Can you confirm?

The number of lstats are cut down by your patch: 428761 vs. 338091.  
Funnily enough, there is no significant difference in run-time:

Command                                            Mean     Std
git status .                                       13.970  1.298
/Users/pieter/projects/External/git/git-status .   13.759  0.321


System times are also approximately the same (10.79s vs 10.43s).

- Pieter
