From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 12:08:23 -0800
Message-ID: <7vu0bwdo08.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
	<200601211636.02340.lan@ac-sw.com>
	<7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
	<200601220033.26321.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.64.0601221106330.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 22 21:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0lW4-0005XN-Ug
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 21:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWAVUI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 15:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWAVUI1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 15:08:27 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20194 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751333AbWAVUIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 15:08:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122200709.JBKD6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 15:07:09 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601221106330.25300@iabervon.org> (Daniel
	Barkalow's message of "Sun, 22 Jan 2006 12:53:51 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15058>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think you're misunderstanding the use of the "bind" file or equivalent. 
>...
> So moving back to (A) wouldn't keep the binding point of subproject, 
> because it would rewrite bind to what it had been.

A lot better said than my version of the response.  Thanks.

> I'm going to suggest again keeping this information in the index file (but 
> not in the index data structure, so the changes to the code are only in 
> the library routines to read and write the file, and, of course, anything 
> that's actually trying to manipulate the binding locations). I started 
> working on a patch to pu to skip S_IFDIR entries from the index file when 
> building the table in memory, and that was straightforward, but I got into 
> sysadmin issues when I was going to test giving it something to skip.

I have been thinking about this one, and having read that
read-cache code I think the coding is not too involved.

My current inclination is to use the same version number (2) by
default and promote it to a new version number (3) once you add
subproject-binding information to the index file.  Then current
tools would keep working on repositories created or operated
upon with the new tools, as long as the project does not use the
new feature.
