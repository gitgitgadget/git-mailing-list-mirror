From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Searching all git objects
Date: Wed, 25 Jun 2008 19:17:42 -0400
Message-ID: <20080625231742.GT11793@spearce.org>
References: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Sam G." <ceptorial@comcast.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeGC-0005fU-C2
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYFYXRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYFYXRq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:17:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58875 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbYFYXRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:17:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBeF4-0006iR-0R; Wed, 25 Jun 2008 19:17:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 92B9220FBAE; Wed, 25 Jun 2008 19:17:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86369>

"Sam G." <ceptorial@comcast.net> wrote:
> We recently had a developer make a large commit (mostly centered  
> around one file) which she believed she properly pushed to a remote  
> repository last week, but looking at both her repository and the  
> remote repository, that commit is now nowhere to be found. If somehow  
> the master branch she was working on in her repository has lost the  
> reference to the commit through perhaps some errant rebasing, then  
> perhaps an object containing the commit (or an object containing the  
> file in that commit) still exists somewhere inside her .git/objects  
> directory? We haven't done any git-gc recently. If so, how can I  
> search through every single git object in her objects directory,  
> searching for perhaps a specific part of the commit string, a line in  
> the code or the filename of the file which was changed? Any help with  
> this would be greatly appreciated. Thanks!

Odds are it is in her HEAD reflog.  You can look for it with
`git log -g`.  If you know some part of the commit message you
may be able to filter it down with `git log -g --grep=X` or part
of the change with `git log -g -SX`.

A coworker just did something like that today and lost his change;
looking in the HEAD reflog and cherry-picking the commit recovered
it quite easily.

-- 
Shawn.
