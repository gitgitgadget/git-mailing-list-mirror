From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 00:36:22 +0200
Message-ID: <43C2E566.2060006@cc.jyu.fi>
References: <43C2D2C4.2010904@cc.jyu.fi> <Pine.LNX.4.64.0601091321390.5588@g5.osdl.org>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew5Xj-0005ih-AZ
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 23:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWAIWbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWAIWbI
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 17:31:08 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:32942 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S1751574AbWAIWbH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 17:31:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id k09MUoSo004997;
	Tue, 10 Jan 2006 00:30:50 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id k09MUl1q004992;
	Tue, 10 Jan 2006 00:30:48 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 44977468169;
	Tue, 10 Jan 2006 00:36:22 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601091321390.5588@g5.osdl.org>
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14378>

Linus Torvalds wrote:

>You should realize that git _does_not_know_ about your file. You never 
>even told git about it. So git won't ever evenlook at it, much less delete 
>it.
>
>So when you do a "git checkout -f", what that does is to rewrite all the 
>files that git KNOWS about. Any files git doesn't know about will not ever 
>be touched. Your "1.txt" file might as well be an object file, for all git 
>knows. And git won't remove your object files or any other files that it 
>doesn't know.
>
>(Now, in all fairness, even if you had done "git add", I don't think git 
>will remove the file. If you committed the file and then checked out the 
>previous version, _then_ it would remove the committed file).
>  
>
Now that you say it, I got it, thanks. I expected earlier that git would
perform also the
remove of non-added files as other commands like "git-commit" are anyway
aware
if you have files in your working dir that have not yet added.

>If what you want to do is to clean the git directory of all files that git 
>doesn't know about, you can do that with
>
>	git-ls-files -z --others | xargs -0 rm --
>  
>
Thanks for the tip. I have now added alias git-reset-ff='git-ls-files -z
--others | xargs -0 rm --'
And git-reset-fff (forte fortissimo) would probably blow the whole hd
away :-)

Mika
