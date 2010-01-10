From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 15:13:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 21:14:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU4Af-0008I7-OO
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 21:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0AJUNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 15:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662Ab0AJUNv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 15:13:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58401 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0AJUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 15:13:51 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KW1007O0S716T50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Jan 2010 15:13:50 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136586>

On Sun, 10 Jan 2010, Leo Razoumov wrote:

> Hi List,
> I am trying to find a way to check availability of new commits
> *before* doing fetch or pull. Unfortunately, neither fetch nor pull
> take "--dry-run" option (unlike push)

But... _Why_ do you want/need to do that?

You could use ls-remote to see what the remote branch is pointing to, 
e.g.:

	git ls-remote origin master

and compare with the local view of that remote branch:

	git show-ref origin/master

And if both SHA1 strings match then there is nothing new to fetch.

> I am sure I am not the only one with such an itch.

Maybe you are. There is very little point knowing that the remote repo 
has new commits if you're not going to fetch them, so I don't understand 
why you need this.


Nicolas
