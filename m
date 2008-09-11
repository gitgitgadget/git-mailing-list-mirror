From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 21:55:16 +0200
Message-ID: <20080911195516.GE1451@cuci.nl>
References: <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org> <20080911192356.GC1451@cuci.nl> <alpine.LFD.1.10.0809111534300.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsHL-0000Wa-Em
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 21:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbYIKTzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 15:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbYIKTzS
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 15:55:18 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45525 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbYIKTzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 15:55:17 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 24AA55465; Thu, 11 Sep 2008 21:55:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111534300.23787@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95633>

Nicolas Pitre wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> when doing things with temporary branches.  The origin field is meant to
>> be filled *ONLY* when cherry-picking from one permanent branch to
>> another permanent branch.  This is a *rare* operation.

>... and therefore you might as well just have a separate file (which 
>might or might not be tracked by git like the .gitignore files are) 
>to keep that information?  Since this is a rare operation, modifying the 
>core database structure for this doesn't appear that appealing to most 
>so far.

For various reasons, the best alternate place would be at the trailing
end of the free-form field.  Using a separate structure causes
(performance) problems (mostly).

>And, while recording this origin link is optional, you are likely to 
>make mistakes like forgotting to record it,

That is just as likely filling in the wrong commit message.

> or you might even wish to 
>fix it with better links after the facts.

That is not possible for commit messages, and should not be possible for
origin links either (same reasons).

>  Having it versionned also 
>means that older git versions will be able to carry that information 
>even if they won't make any use of it, and that also solves the 
>cryptographic issue since that data is part of the top commit SHA1.

It would allow the data to be faked, that is undesirable for "git blame".
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
