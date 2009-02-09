From: Nicolas Pitre <nico@cam.org>
Subject: Re: git ready: daily git tips
Date: Mon, 09 Feb 2009 15:42:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902091524520.30940@xanadu.home>
References: <1234131508141-2294642.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nick Quaranto <nick@quaran.to>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWcyk-0006Id-BM
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZBIUmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbZBIUmP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:42:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60928 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbZBIUmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:42:14 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KET008D0G67K4C1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Feb 2009 15:42:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1234131508141-2294642.post@n2.nabble.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109118>

On Sun, 8 Feb 2009, Nick Quaranto wrote:

> 
> I started this blog just around a month ago on a quest to learn more about
> git on a daily basis and to show others how awesome it is. If you have any
> suggestions on what content to cover or how things should be done
> differently, I would greatly appreciate it. Thanks!
> 
> http://gitready.com

Well done.

One topic that IMHO you fail to cover, and which is being neglected 
almost everywhere else too, is the reflog.

The reflog is really your safety net when working with git.  It records 
everything you do. So even if you screw up a rebase, perform the wrong 
merge, or any other kind of undesired operation, then you may always go 
back to a previous state.  Either you use -g with 'git log' to see all 
those recorded states, or even 'git reflog' without any argument to get 
a condensed list for HEAD.

The <branch>@{<spec>} notation can be used anywhere a ref is normally 
required.  The special branch "HEAD" shows every state the HEAD pointer 
went through, including branch switches.  The <branch< part can be left 
out to mean "currently checked-out branch".

One thing that I use all the time after a 'git pull' is 'git log @{1}..' 
where "@{1}" means the first previous tip of the current branch, so 
effectively showing me the log of what the pull brought in my branch.


Nicolas
