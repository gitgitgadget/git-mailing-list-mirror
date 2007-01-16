From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 17:31:15 -0500
Message-ID: <2696299C-A54D-4A7E-BA3B-029C8E4B278D@silverinsanity.com>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com> <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD383E.50105@midwinter.com> <Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <eojh8r$9e6$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6wq8-0007oz-3Z
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXAPWb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbXAPWb3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:31:29 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:53510 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbXAPWb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:31:28 -0500
Received: from [10.0.0.93] (unknown [64.241.37.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 82B531FFC02B;
	Tue, 16 Jan 2007 22:31:24 +0000 (UTC)
In-Reply-To: <eojh8r$9e6$1@sea.gmane.org>
To: Jakub Narebski <jnareb@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36973>


On Jan 16, 2007, at 4:49 PM, Jakub Narebski wrote:

> Johannes Schindelin wrote:
>
>> Usually, however, this results in a conflict which you have to  
>> resolve.
>> And _you_ do not have a hard time verifying that the patch already  
>> went
>> in, and you just say "git rebase --skip" and the rebasing will  
>> continue
>> _without_ having committed the now obsolete patch.
>
> Unfortunately, at least with git 1.4.4.x, not quite. You have to have
> index clean to do "git rebase --skip", while usually there would be
> conflict when applying patch that is already present some deeper.
>
> I think that is a bug in git-rebase.

Agreed.  I tend to "git checkout HEAD -- files" before a "git rebase  
--skip" to fix that, although I guess "git reset --hard" would work  
just the same.  But by saying "--skip" means "these changes are  
irrelevant", so it should clean up after itself.  It's a definite  
usability snafu.

I'd put a simple patch to add the reset to git-merge.sh, but I'm not  
sure I understand what --skip is doing in there with a 30 second  
peek.  Maybe if I get more tuits, I'll do it, but someone more  
familiar with it can probably do it much faster (and be more certain  
it's the right thing to do).

~~ Brian
