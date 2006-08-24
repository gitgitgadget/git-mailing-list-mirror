From: Blu <blu@daga.cl>
Subject: Re: use case
Date: Wed, 23 Aug 2006 20:37:36 -0400
Message-ID: <20060824003736.GJ14223@daga.cl>
References: <20060821182338.GA21395@daga.cl> <Pine.LNX.4.63.0608212231430.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 24 02:37:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG3E6-00083H-Pg
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 02:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbWHXAhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 20:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWHXAhj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 20:37:39 -0400
Received: from [201.215.212.46] ([201.215.212.46]:35723 "EHLO daga.cl")
	by vger.kernel.org with ESMTP id S965240AbWHXAhi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 20:37:38 -0400
Received: from blu by daga.cl with local (Exim 4.62)
	(envelope-from <blu@daga.cl>)
	id 1GG3E0-0005N0-Kg
	for git@vger.kernel.org; Wed, 23 Aug 2006 20:37:36 -0400
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608212231430.28360@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25938>

On Mon, Aug 21, 2006 at 10:47:47PM +0200, Johannes Schindelin wrote:
> Ideally, you really would have a common revision to start from. Since you 
> do not have that yet, you have to go low-level for the first octopus.
> 
> Suppose you have the last common version as tip of branch "ancestor", you 
> could do
> 
> 	git merge-octopus ancestor -- HEAD branch1 branch2 ...

This one didn't work. It complains about not having common ancestors too.
I did a manual merge anyway.

> After this -- if everything went well -- you should have a committable 
> state in the index. Before you commit, you should do
> 
> 	git rev-parse branch1 > .git/MERGE_HEAD
> 	git rev-parse branch2 >> .git/MERGE_HEAD
> 	git rev-parse branch3 >> .git/MERGE_HEAD
> 	...
> 
> to tell git that you want to commit an octopus merge. This will tell 
> git-commit what the parents of the merge are.

This trick did it. Now I have a proper merge commit with common ancestors.
Thanks a lot.

-- 
Blu.
