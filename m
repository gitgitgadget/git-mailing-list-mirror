From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-clone ignores umask for working tree
Date: Fri, 6 Jul 2012 17:20:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
References: <CALxABCZn5W-cEQ9PS+4XoqhH7L+5P3KN==_RrcruK+oKdijmWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 23:27:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnG3L-0003BC-8v
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 23:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580Ab2GFV06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 17:26:58 -0400
Received: from iabervon.org ([66.92.72.58]:34983 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab2GFV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 17:26:57 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2012 17:26:57 EDT
Received: (qmail 28413 invoked by uid 1000); 6 Jul 2012 21:20:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jul 2012 21:20:15 -0000
In-Reply-To: <CALxABCZn5W-cEQ9PS+4XoqhH7L+5P3KN==_RrcruK+oKdijmWw@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201151>

On Fri, 6 Jul 2012, Alex Riesen wrote:

> Hi list,
> 
> when git-clone was built in, its treatment of umask has changed: the shell
> version respected umask for newly created directories by using plain mkdir(1),
> and the builtin version just uses mkdir(work_tree, 0755).
>
> Is it intentional?

I have the vague feeling that it was intentional, but it's entirely 
plausible that I just overlooked that mkdir(2) applies umask and went for 
the mode that you normally want. I don't think there's any particular need 
for this operation to be more restrictive than umask.

	-Daniel
*This .sig left intentionally blank*
