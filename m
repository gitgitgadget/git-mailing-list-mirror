From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Repo corrupted somehow?
Date: Tue, 4 Nov 2008 23:21:44 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811042241450.19665@iabervon.org>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 05:23:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxZv2-0007hv-RD
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 05:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbYKEEVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 23:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbYKEEVq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 23:21:46 -0500
Received: from iabervon.org ([66.92.72.58]:55804 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYKEEVq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 23:21:46 -0500
Received: (qmail 10230 invoked by uid 1000); 5 Nov 2008 04:21:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2008 04:21:44 -0000
In-Reply-To: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100143>

On Mon, 3 Nov 2008, Andrew Arnott wrote:

> I was just git commit'ing, and then I was doing a git rebase to squash
> several commits into one when the rebase failed.  I then did a
> git checkout -f master
> git reset --hard
> but no matter what I do, git thinks that several files have changed.
> The diff shows all the lines in these several files removed and then
> added, yet without any changes made to them.

That sounds like some failure of CRLF conversion, like it's converting all 
of the line endings somehow when writing to the working tree and then not 
expecting them to be different. Do you have some sort of interesting 
configuration for those? I wonder if you've got a .gitattributes that 
matches the names that git uses for the files, but are on a 
case-insensitive filesystem which lists those files in a way where their 
names don't match (or vice versa).

	-Daniel
*This .sig left intentionally blank*
