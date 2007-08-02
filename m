From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 16:05:46 -0700
Message-ID: <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjjr-00023U-EQ
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbXHBXFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757334AbXHBXFs
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:05:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50774 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbXHBXFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:05:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802230548.VQKK1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 19:05:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XB5m1X00A1kojtg0000000; Thu, 02 Aug 2007 19:05:46 -0400
In-Reply-To: <85vebxy47e.fsf@lola.goethe.zz> (David Kastrup's message of "Fri,
	03 Aug 2007 00:14:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54636>

David Kastrup <dak@gnu.org> writes:

> Robert Schiele <rschiele@gmail.com> writes:
> ...
>> Thus we have to decide whether we want some textbook example code
>> and thus break this platform completely or whether we want to fix
>> the issues you have listed and thus have a more portable
>> application.
>
> The "issues" are with Solaris, apparently.  There is always a price
> for portability.  If Solaris users can fix their problems with a
> global search and replace of the first line in *.sh, the question is
> whether it is worth the hassle of having unreadable but "portable"
> code.  After all, it has to be read also by humans.

I am in the camp of avoiding "it is even in POSIX so it's your
fault if your shell does not support it".  We do not take POSIX
too seriously in that way, although we do say "let's not use it,
it is not even in POSIX".  In other words, I've been trying to
be, and as a result of that we are, fairly conservative.

However, there is a line we need to draw when bending bacwards
for compatibility, and I think a system that does not have a
working command substitution $( ... )  is on the other side of
that line.
