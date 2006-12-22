From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 17:09:44 +0100
Message-ID: <20061222160944.GA4651@steel.home>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de> <20061222084425.GA4644@steel.home> <Pine.LNX.4.63.0612221316550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Dec 22 17:10:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxmyC-0004Tk-BZ
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 17:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWLVQKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 11:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWLVQKA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 11:10:00 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:43191 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965200AbWLVQJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 11:09:59 -0500
Received: from fwd27.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1Gxmy3-0001Lf-01; Fri, 22 Dec 2006 17:09:55 +0100
Received: from tigra.home (SUC5vBZXwehqLWtU+WUyd7vRiqbrvtpNslcIDK7yxA5vj0JCk6+u0k@[84.163.127.243]) by fwd27.sul.t-online.de
	with esmtp id 1Gxmxw-1AYzAm0; Fri, 22 Dec 2006 17:09:48 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5A1F8277AF;
	Fri, 22 Dec 2006 17:09:45 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.62 #1 (Debian))
	id 1Gxmxs-0001K3-Q9; Fri, 22 Dec 2006 17:09:44 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612221316550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: SUC5vBZXwehqLWtU+WUyd7vRiqbrvtpNslcIDK7yxA5vj0JCk6+u0k
X-TOI-MSGID: 72bf536d-fe9e-4f96-a84b-d358533e86c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35184>

Johannes Schindelin, Fri, Dec 22, 2006 13:18:55 +0100:
> > > If the cache tree is not up-to-date, it will be updated first. So, now
> > > 
> > > 	$ git show :Documentation/
> > > 
> > > will in effect show what files/directories are in the index' version
> > > of the directory Documentation. The three commands
> > > 
> > > 	$ git show :./
> > > 	$ git show :.
> > > 	$ git show :
> > > 
> > > are all equivalent and show the index' idea of the root directory.
> > 
> > That is a bit unexpected if you're not in the root directory of
> > repository, but in some subdir of the working directory.
> > Why root? Why not the current directory relative to root?
> 
> Why root? Because you are not asking for the working directory. Use "ls" 
> for that. You are asking for the index. If you git-show a commit, you 
> don't expect the output to be restricted by the subdirectory you're in, 
> either, right?

Of course I do. You're breaking a very well-known and widely used
idiom here: the "." means current or at least somehow related to the
current directory. Why would you expect "git show :." to show
everything from root on if your current directory is "Documentation"?
Yes, it is a commit which "git show" displays, but the patches/diffs
are restricted by filenames, and that is where the old rules come into
play. And I would actually expect ":/" to filter from the root on, and
":." to mean the current directory.
