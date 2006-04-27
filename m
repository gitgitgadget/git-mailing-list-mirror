From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 15:39:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604271535460.18816@localhost.localdomain>
References: <20060427101254.GA22769@peppar.cs.umu.se>
 <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
 <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Peter Hagervall <hager@cs.umu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 21:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZCKc-0004bt-MF
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 21:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWD0TjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 15:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWD0TjQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 15:39:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56812 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965069AbWD0TjP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 15:39:15 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYE00B4LBXE2UD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 27 Apr 2006 15:39:14 -0400 (EDT)
In-reply-to: <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19240>

On Thu, 27 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Thu, 27 Apr 2006, Peter Hagervall wrote:
> >
> >> Answering the call Linus made[1], sort of, but for a completely
> >> different program.
> >> 
> >> Anyway, it ought to be at least as portable as the shell script, and a
> >> whole lot faster, however much that matters.
> >> 
> > [...]
> >> +	for (i = 0; i < 16; i++) {
> >> +		subdir[0] = hex_digits[i];
> >> +		for (j = 0; j < 16; j++) {
> >> +			subdir[1] = hex_digits[j];
> >> +			if (access(subdir, R_OK | X_OK))
> >> +				continue;
> >> +			chdir(subdir);
> >> +			if (!(dp = opendir("."))) {
> >> +				error("can't open subdir %s", subdir);
> >> +				continue;
> >> +			}
> >
> > Looks like you're missing a chdir(".."); there.
> 
> Why would you even _need_ to chdir() anywhere, anyway?

To avoid appending the filename to the path before each lstat() I'd 
guess.


Nicolas
