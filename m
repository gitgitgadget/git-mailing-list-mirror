From: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: Git rescue mission
Date: 08 Feb 2007 22:12:37 +0200
Message-ID: <87fy9gz9vu.fsf@host94.eke.fi>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFm0-0007uD-0b
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423312AbXBHUU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423306AbXBHUU1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:20:27 -0500
Received: from [194.100.36.62] ([194.100.36.62]:46502 "EHLO host94.eke.fi"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423312AbXBHUUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:20:25 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2007 15:20:24 EST
Received: from host94.eke.fi (localhost.localdomain [127.0.0.1])
	by host94.eke.fi (8.13.4/8.13.4/Debian-3) with ESMTP id l18KCcOh002125;
	Thu, 8 Feb 2007 22:12:38 +0200
Received: (from kp@localhost)
	by host94.eke.fi (8.13.4/8.13.4/Submit) id l18KCbn3002122;
	Thu, 8 Feb 2007 22:12:37 +0200
In-Reply-To: <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39085>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For example, a command like "git pull" will leave a special magic name 
> around to tell you what the original HEAD was before the pull, and that 
> magic name is (surprise surprise) called ORIG_HEAD. So if the pull 
> succeeded, but you realized it was an error (perhaps you had even intended 
> to do it, but once you pulled, you just saw that what you pulled was crap, 
> so you decide that you didn't really want to do it after all), you can 
> just do
> 
> 	git reset --hard ORIG_HEAD
> 
> and you're back to where you were _before_ the pull.

I usually undo a pull by throwing away just the merge commit by

        git reset --hard HEAD^

This seems to always get me back to the head commit I had previously, but I'm
wondering would git in some circumstances leave me with the commits I just pulled
and throw away my own work instead. Or is it guaranteed that I always reset
to the parent commit I had before the pull (i.e. ORIG_HEAD)?

Of course HEAD^ doesn't work the same with fast-forward merges, so it would
probably make more sense to just use ORIG_HEAD all the time.
