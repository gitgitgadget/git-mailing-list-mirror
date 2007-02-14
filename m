From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 13:47:44 -0800
Message-ID: <7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
	<17875.30687.661794.512124@lisa.zopyra.com>
	<Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
	<17875.33204.413186.355557@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:48:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRzP-0005qc-D3
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbXBNVrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbXBNVrq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:47:46 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64168 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964777AbXBNVrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:47:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214214745.MDAU21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 16:47:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PZnk1W01A1kojtg0000000; Wed, 14 Feb 2007 16:47:45 -0500
In-Reply-To: <17875.33204.413186.355557@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 14 Feb 2007 15:40:04 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39759>

Bill Lear <rael@zopyra.com> writes:

> WAAAAAIAMINIT ... I think I see it:
>
> % perl -pi -e 's/.*\$Id.*//sx' $(xgrep -l '[$]Id')
>
> Could I have corrupted the pack file?  I'll bet $50 I did:
>
> % [yet another clone]
> % xgrep -l '[$]Id'
> ./.git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
> [...]
>
> %!@#$&$%(@@@!!!

We all make mistakes.  Thanks for being honest.

The segfaults could be from "git commit" codepath, not from when
you cloned.  I could try corrupting a packfile in my repository
and see where it dies, perhaps later.
 
