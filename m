From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing to a non-bare repository
Date: Sat, 03 Feb 2007 13:18:04 -0800
Message-ID: <7vd54r2b5f.fsf@assigned-by-dhcp.cox.net>
References: <45C3FB08.1020805@midwinter.com>
	<7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
	<45C459DD.8080201@fs.ei.tum.de>
	<Pine.LNX.4.64.0702031146050.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSGx-0006eJ-E7
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbXBCVSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXBCVSJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:18:09 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:60896 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751698AbXBCVSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:18:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203211805.DUJD1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 16:18:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K9J41W0161kojtg0000000; Sat, 03 Feb 2007 16:18:05 -0500
In-Reply-To: <Pine.LNX.4.64.0702031146050.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 3 Feb 2007 11:48:46 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38603>

(sorry, resending to avoid vger spam filter)

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 3 Feb 2007, Simon 'corecode' Schubert wrote:
>> 
>> However, your suggestion does not help people who don't know better.  Pushing
>> into the HEAD branch of another repo breaks stuff there.  Badly.  This should
>> be prevented, really.
>
> No, please don't break it. I do it all the time.
>
> I just do "git push remote".
>
> And then eventually on the remote end I do end up having to "update", but 
> that's a simple "git checkout -f".

I do not think anybody is disputing the fact that the current
git-push does work as expected.

But expectation is a relative thing.  The current behaviour is
likely to confuse new people; it is like a sharp-edged razor
that can cut through fingers if the user does not know which end
is the handle and which end is the blade.

I sent a "if Simon wanted to do it, it is simple" concept patch,
but obviously Simon or anybody can do the same check in the
update hook if needed.  However, that would make the newbie
safety opt_in, and there inevitably will come a discussion on
what should be the default.

And I suspect that the recent trend is that people would want
the default to be more newbie friendly, while leaving an opt_in
escape hatch for power-user convenience.  Obviously my patch
does not have that escape hatch, and as such it is not meant for
inclusion as-is.
