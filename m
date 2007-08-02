From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 14:21:01 -0700
Message-ID: <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGi6n-0003PY-NT
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbXHBVVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755806AbXHBVVF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:21:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33581 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbXHBVVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:21:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802212102.SSOX14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 17:21:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9M11X00g1kojtg0000000; Thu, 02 Aug 2007 17:21:02 -0400
In-Reply-To: <85odhpzmbo.fsf@lola.goethe.zz> (David Kastrup's message of "Thu,
	02 Aug 2007 22:57:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54614>

David Kastrup <dak@gnu.org> writes:

> Sure.  What about the git-rebase line using $(($end - $msgnum)) ?
> That's even more risque than ##.

Is it really risque?  I do not think we have heard trouble with
the arith expansion from anybody.  A few mistakes in the past
made that said things like:

	$((end - 1))	    ;# wrong... say "$end" if you mean variable
	$((cd ...; pwd))    ;# wrong... say $( (...)) if command substitution
                             # that involves subshell

but I think we fixed them.

> Understood.  But using ${...#...} and ${...:+...} does not exactly
> seem to be news in the git code base.  Even though we have the claim
> that Solaris' sh won't deal with the former.

I do not think we have trouble with ${parameter#word}.  Much
less with ${parameter+word}; it has been in /bin/sh forever.
