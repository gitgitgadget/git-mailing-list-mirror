From: linux@horizon.com
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: 2 Jul 2007 23:23:15 -0400
Message-ID: <20070703032315.7279.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0707022207420.4071@racer.site>
Cc: git@vger.kernel.org
To: Johannes.Schindelin@gmx.de, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Jul 03 05:23:31 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5YzB-0008IC-RI
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 05:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXGCDXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 23:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbXGCDXS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 23:23:18 -0400
Received: from science.horizon.com ([192.35.100.1]:10359 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752694AbXGCDXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 23:23:17 -0400
Received: (qmail 7280 invoked by uid 1000); 2 Jul 2007 23:23:15 -0400
In-Reply-To: <Pine.LNX.4.64.0707022207420.4071@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51444>

> Why not do 'git branch temp v2.6.22-rc7' to begin with? Or even better: 
> git checkout -b temp v2.6.22-rc7.

In my case, it was the "master" branch; I couldn't remember if I'd done
any hacking on it.  But I used the branch name "temp" while demonstrating
how to recreate the problem.

> But in any case, you should know that there is no floating tag in git, and 
> therefore, by storing it in the "branch" temp, you doom that branch to 
> not be able to be committed to.

I just wanted to fast-forward my master to -rc7, like the git-merge-ff
utility that's been floating around.

> What you should have done, of course, is
> 
> $ git checkout temp
> $ git merge v2.6.22-rc7

But if I'd have changes to my master, I would have examined them and
either rebased them or assigned a branch name.  It was just a way to
either do what I wanted or get an error message, all in one step.

>> $ git checkout temp
>> $ (make minor change)
>> $ git commit -a
>> fatal: 087ea061253277de2b27e82d8572a386835a1b7e is not a valid 'commit' object
>> 
>> git-fetch does odd things when handed a tag rather than a commit.

> No. It is perfectly sane to fetch a tag, and to store it.

I suppose, but should the result be put in the "refs/heads" directory?

And until git-merge-ff is available, what's the recommended way to
"advance master to tag <foo>, but only if that wouldn't lose anything?"
