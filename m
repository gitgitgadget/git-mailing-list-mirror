From: Peter Hagervall <hager@cs.umu.se>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 21:46:00 +0200
Message-ID: <20060427194559.GA26386@brainysmurf.cs.umu.se>
References: <20060427101254.GA22769@peppar.cs.umu.se> <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain> <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604271535460.18816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 21:46:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZCRK-0006Ig-Et
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 21:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWD0TqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWD0TqL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 15:46:11 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:13002 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S964928AbWD0TqK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 15:46:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id CDCB22AA8;
	Thu, 27 Apr 2006 21:46:09 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 18008-03; Thu, 27 Apr 2006 21:46:01 +0200 (MEST)
Received: from brainysmurf.cs.umu.se (brainysmurf.cs.umu.se [130.239.89.21])
	by mail.cs.umu.se (Postfix) with ESMTP id 142192B9B;
	Thu, 27 Apr 2006 21:46:01 +0200 (MEST)
Received: by brainysmurf.cs.umu.se (Postfix, from userid 12006)
	id 7B47A73C; Thu, 27 Apr 2006 21:46:00 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604271535460.18816@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19241>

On Thu, Apr 27, 2006 at 03:39:14PM -0400, Nicolas Pitre wrote:
> On Thu, 27 Apr 2006, Junio C Hamano wrote:
> 
> > Nicolas Pitre <nico@cam.org> writes:
> > 
> > > On Thu, 27 Apr 2006, Peter Hagervall wrote:
> > >
> > >> Answering the call Linus made[1], sort of, but for a completely
> > >> different program.
> > >> 
> > >> Anyway, it ought to be at least as portable as the shell script, and a
> > >> whole lot faster, however much that matters.
> > >> 
> > > [...]
> > >> +	for (i = 0; i < 16; i++) {
> > >> +		subdir[0] = hex_digits[i];
> > >> +		for (j = 0; j < 16; j++) {
> > >> +			subdir[1] = hex_digits[j];
> > >> +			if (access(subdir, R_OK | X_OK))
> > >> +				continue;
> > >> +			chdir(subdir);
> > >> +			if (!(dp = opendir("."))) {
> > >> +				error("can't open subdir %s", subdir);
> > >> +				continue;
> > >> +			}
> > >
> > > Looks like you're missing a chdir(".."); there.
> > 
> > Why would you even _need_ to chdir() anywhere, anyway?
> 
> To avoid appending the filename to the path before each lstat() I'd 
> guess.

Yes, that's pretty much the reason.

	Peter
