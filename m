From: Danielle <dsavir.h@gmail.com>
Subject: Re: Advice regarding inherited git repository
Date: Thu, 7 Jan 2016 08:40:46 +0000 (UTC)
Message-ID: <loom.20160107T093305-483@post.gmane.org>
References: <loom.20160105T183516-607@post.gmane.org> <20160106082022.GA19117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 09:41:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH68D-0004ez-HK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 09:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbcAGIlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 03:41:14 -0500
Received: from plane.gmane.org ([80.91.229.3]:45264 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbcAGIlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 03:41:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aH685-0004Zz-NX
	for git@vger.kernel.org; Thu, 07 Jan 2016 09:41:09 +0100
Received: from 16.204.8.213.static.012.net.il ([16.204.8.213.static.012.net.il])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 09:41:09 +0100
Received: from dsavir.h by 16.204.8.213.static.012.net.il with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 09:41:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.8.204.16 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283471>

> You probably should create a sandbox branch, for your own sanity.
> Because git is distributed, each separate repository is implicitly a
> branch. So if you did something like:
> 
>   1. Commit all the changes on the main site to "master". Push the
>      result to some common remote.
> 
>   2. Commit all the changes in the sandbox to its "master". Do _not_
>      push to the remote.
> 
>   3. Pull the changes from the remote into the sandbox. If they're 
worth
>      adding to the main site, push them up. If not, leave them there.
> 
> That works; "master" in the sandbox has the experimental changes, but
> you don't have to push them anywhere.  However, you are one accidental
> "git push" away from sending all of those experimental features to 
your
> remote "master". So it's easy enough to make step 1.5 "git checkout -b
> sandbox-cruft" in the sandbox repository, so git knows not to ever 
push
> it to "master".
> 
> In general, I'd also say you may benefit from splitting the changes in
> each repository into as many separate logical commits as you can (and
> possibly even to separate topic branches that you can merge
> independently). Given that you inherited this, that's _probably_ too
> much work. But if you do want to try it, I recommend "git add -p" for
> picking out individual hunks.
> 
> -Peff
> 


Thanks for answering!

I've done the above, but it caused some problems, some of which I 
haven't solved yet. What I have now is a master branch with the site in 
both repositories; and in the sandbox an additional devel branch with 
the changes done. I want to split the devel branch into the actual 
features being explored, and then merge each into master and push when 
done. The main trouble with that seems to be the settings.php file, 
which should be backed up but certainly shouldn't go from one site to 
another. Removing it from the repository caused some problems, even when 
keeping a local cache for some reason (it got lost when switching 
branches and gave me a bad moment until I figured it out). Any 
suggestions?

Add -p will certainly help in the feature branches, thanks for 
suggesting it!
