From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 08:38:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601120826010.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> <200601120919.08354.lan@ac-sw.com>
 <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <lan@ac-sw.com>,
	Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 14:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex2dH-00070u-NY
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 14:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWALNgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 08:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWALNgt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 08:36:49 -0500
Received: from iabervon.org ([66.92.72.58]:28939 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932194AbWALNgs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 08:36:48 -0500
Received: (qmail 31174 invoked by uid 1000); 12 Jan 2006 08:38:33 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2006 08:38:33 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14561>

On Thu, 12 Jan 2006, Martin Langhoff wrote:

> What about using nested checkouts? They work great with git as-is,
> just add an .gitignore file.
> 
> As Linus points out, there are many good reasons why a top-level
> commit should _not_ commit the nested subproject. And once you are
> observing that rule, what's left then? git status and git diff <HEAD>
> can show an aggregate of top-level and nested subprojects, but that's
> ease-of-use -- not something only.
> 
> What is your show stopper?

The core structural thing (which I'm not sure CVS handles) is having each 
commit of the outer project specify the commit of the inner project that 
it contains in some way. This would be good with CVS, but is vital with 
git, because there's no way of estimating it when you don't have a linear 
history. (With CVS, you could say that the inner project version for a 
given outer project version should be the version that was current when 
the outer project was committed. But that isn't well-defined for git.) If 
you try to debug anything involving the history, you'd have problems with 
choosing versions of the two projects that don't actually match.

	-Daniel
*This .sig left intentionally blank*
