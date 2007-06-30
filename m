From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 13:22:45 -0700
Message-ID: <7vlke1b3ai.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	<7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 22:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jSy-0007GI-LS
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbXF3UWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbXF3UWq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:22:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51059 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXF3UWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:22:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630202245.MJMR1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 16:22:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HwNk1X0081kojtg0000000; Sat, 30 Jun 2007 16:22:45 -0400
In-Reply-To: <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 30 Jun 2007 12:17:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51255>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Anyway, while actually removing the "git-xyzzy" things is not practical 
>> right now, we can certainly start slowly to deprecate it internally inside 
>> git itself - in the shell scripts we use, and the test vectors.
>
> So I am somewhat negative on this, unless there is a way for
> scripts to say "Even though I say 'git foo', I do mean 'git foo'
> not whatever the user has aliased".

Having said that, I am not opposed to encourage distros to set
gitexecdir to $(prefix)/libexec in their modified Makefile.
There is no reason to contaminate a directory on end users'
$PATH with hundreds of commands that begin with "git-" prefix.

In fact, I used to configure my copy of git with gitexecdir set
to outside my $PATH when we first started pushing it to make
sure everything works (I do not install git from distro on my
machine so I know I have only one instance of bin/git in my
path).  It used to work, but I am no longer using that layout
these days, so it is entirely possible that we might have broken
the support along the way.  And _that_ is worth fixing.
