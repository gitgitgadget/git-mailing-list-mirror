From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: integrating make and git
Date: Wed, 15 Apr 2009 12:20:00 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0904151148030.19665@iabervon.org>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7rl-0002d9-24
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZDOQUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZDOQUD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:20:03 -0400
Received: from iabervon.org ([66.92.72.58]:43122 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbZDOQUB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:20:01 -0400
Received: (qmail 17642 invoked by uid 1000); 15 Apr 2009 16:20:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Apr 2009 16:20:00 -0000
In-Reply-To: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116622>

On Wed, 15 Apr 2009, E R wrote:

> I have an idea about integrating make with git, and I'm wondering if
> it is a reasonable thing to do.
> 
> First of all, I am under the impression that git can quickly compute a
> hash of a directory and its contents. Is that correct?
> 
> If so, suppose you using git to manage revision control of a project
> which has some components like 'lib1', 'lib2', etc. Typically you
> would perform something like: make clean; make all and 'make all'
> would perform 'make lib1' and 'make lib2'. When checking out a
> different revision of the project you would have to perform another
> 'make clean' before 'make all' since you aren't sure of what's changed
> and the timestamps of the derived files will be more recent than the
> timestamps of the source files.

No, the timestamps of the changed source files will be newer than the 
timestamps of the derived files. Git doesn't backdate files in working 
directories, in order to avoid causing the problem you're trying to fix. 
(And because getting the history is so quick and easy with git that 
looking at dates on files in the filesystem is kind of pointless.)

	-Daniel
*This .sig left intentionally blank*
