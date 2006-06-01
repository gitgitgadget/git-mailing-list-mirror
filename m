From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Wed, 31 May 2006 23:37:13 -0700
Message-ID: <7v3beptm92.fsf@assigned-by-dhcp.cox.net>
References: <20060529085738.GB29500@spearce.org>
	<7virnp8a30.fsf@assigned-by-dhcp.cox.net>
	<20060529094605.GB27194@spearce.org>
	<7vhd373o15.fsf@assigned-by-dhcp.cox.net>
	<20060531021808.GC21222@spearce.org>
	<7v64jm2380.fsf@assigned-by-dhcp.cox.net>
	<20060601033430.GA13485@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 08:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flgo5-0005tA-Md
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 08:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWFAGhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 02:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWFAGhR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 02:37:17 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5508 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965294AbWFAGhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 02:37:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060601063714.YIRU18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Jun 2006 02:37:14 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060601033430.GA13485@spearce.org> (Shawn Pearce's message of
	"Wed, 31 May 2006 23:34:30 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21104>

Shawn Pearce <spearce@spearce.org> writes:

> Because git-commit currently performs a status update and throws
> that data into the editor buffer.  That takes longer than committing
> from the command line.  Especially if I've just done a git-diff or
> git-status to see what is changed and about to be committed...

Ah, why does it take this many exchanges to extract the true
motive behind what people do even in a technical forum like
this, I wonder...

So what you want is not multiple -m options nor piping to fmt.
What you really want is an option that is the opposite of -v to
git-commit that omits the status list ("_could_ commit if you
update-index" part -- since "will commit" is something we would
need to compute anyway).

> On a project the size of GIT on a Unix system this isn't a big deal;
> on a 9000 file project on Cygwin this difference is significant
> to me.

I suspect you are suffering from lstat() performance.  I wonder
if "assume unchanged" git help your situation?
