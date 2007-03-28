From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 18:52:33 -0700
Message-ID: <7vk5x2m8wu.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	<7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
	<38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com>
	<7vircnou7i.fsf@assigned-by-dhcp.cox.net>
	<20070327104623.GA26796@sigill.intra.peff.net>
	<7vlkhjne9k.fsf@assigned-by-dhcp.cox.net>
	<20070327110246.GA30217@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 03:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWNL4-00082h-MG
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 03:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXC1Bwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 21:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbXC1Bwg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 21:52:36 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33480 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbXC1Bwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 21:52:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328015233.WKET28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 27 Mar 2007 21:52:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id g1sZ1W00D1kojtg0000000; Tue, 27 Mar 2007 21:52:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43342>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 27, 2007 at 03:59:19AM -0700, Junio C Hamano wrote:
>
>> It might be easier but I do not think that is useful.  When
>> git-commit runs the $EDITOR for the commit log message, I think
>> people would expect (if you are using vi) "!!git log" to honor
>> their alias.
>
> Then git-commit can unset GIT_NOALIAS when it expects to call into
> "user" code such as the editor.

Surely, but then it is not just a matter of "setting GIT_NOALIAS
at the top of all git programs" anymore.  You need to audit the
code.

> A potentially bigger problem with any such scheme is that non-git
> scripts would have to set GIT_NOALIAS. Not a big deal for new scripts,
> but it might break old scripts.

You are right.  Both GIT_NOALIAS and "write git-foo if you do
not want to be affected with alias" would fail that.
