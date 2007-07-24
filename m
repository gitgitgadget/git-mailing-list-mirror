From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: StGIT (or guilt) + git-svn?
Date: Tue, 24 Jul 2007 19:48:17 -0400
Message-ID: <20070724234817.GA29700@dervierte>
References: <46A5D279.7060601@midwinter.com> <20070724112706.GA9540@dervierte> <46A5EE4B.7020905@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>,
	'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:48:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDU78-0007HH-Dk
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 01:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbXGXXsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbXGXXsX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 19:48:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:27201 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371AbXGXXsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 19:48:22 -0400
Received: by wx-out-0506.google.com with SMTP id h31so15802wxd
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 16:48:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=quIbMG98a0QaHGikEKekcuc0NNEtR1kVJ3iG3cIki0SzmDuGMsPArStPu9zClINJkH/B5OSYVaSHCSGqIGq2LuG3c9MQTbxLOD4oG0v+rDWj2hVi/FK/ThY5Ufhgu/RdS5QeTU91YtDZvLXs30TUGKW3cZ87nufHr8/60FighQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=LBq744zDfv4B2iVyWYH4jTqHkCjf6hdigOz9i8E+g/JKmR1GayUP5ZQ0XDDz4rifNMQCpfmvj+aYORmLaOQpl2BrGuJLFWKRQHLQaWU3CQFk8BkBNr5WTBRZ7yl2KK+JD1Aj1eLrkGGk+7mug74Pv+0eaExkqKkNVS2Sd8ZtxpA=
Received: by 10.70.67.2 with SMTP id p2mr119340wxa.1185320901147;
        Tue, 24 Jul 2007 16:48:21 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.131.192.220])
        by mx.google.com with ESMTPS id t26sm136001ele.2007.07.24.16.48.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 16:48:19 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 6A736CA285D; Tue, 24 Jul 2007 19:48:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46A5EE4B.7020905@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53660>

On Tue, Jul 24, 2007 at 08:19:23PM +0800, Steven Grimm wrote:
> He wants to create some files in his git-svn clone and use git to manage 
> them -- checkpointing his work in progress, backing out changes, etc., 
> without publishing those files to the svn repository. The files in 
> question are not already in svn. But he does want to work on other files 
> that *are* in the svn repository, and wants those changes to be 
> committed back.
> 
> So my assumption was that he would do something like maintain his 
> local-only changes as StGIT patches that never get committed to git. His 
> other changes would get committed from StGIT to git, and from there he'd 
> do his normal git-svn dcommit. Or maybe git-svn dcommit followed by stg 
> rebase since git-svn dcommit creates new revision IDs.

You certainly could do local versioning this way, but it isn't how I
accomplish the same thing.  I keep another branch on top of my "public"
svn commits for local stuff.  If I always run git-svn dcommit from the
public branch, the local changes will stay local.  After committing, I
just have to rebase the local branch on onto git-svn.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
