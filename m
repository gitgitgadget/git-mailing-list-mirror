From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch.autosetupmerge: allow boolean values, or "all"
Date: Sun, 08 Jul 2007 19:27:34 -0700
Message-ID: <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081336020.4248@racer.site>
	<7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 04:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7iyV-0001cH-PH
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 04:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998AbXGIC1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 22:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758027AbXGIC1g
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 22:27:36 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48372 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbXGIC1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 22:27:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709022735.HHZU3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 22:27:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id METa1X0071kojtg0000000; Sun, 08 Jul 2007 22:27:34 -0400
In-Reply-To: <46919692.5020708@gnu.org> (Paolo Bonzini's message of "Sun, 08
	Jul 2007 21:59:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51945>

Paolo Bonzini <bonzini@gnu.org> writes:

> 	> Having prepared the patch below, I do not think if the original
>> patch even wanted to have 'all' semantics.  The surrounding text
>> only talks about "off a remote branch" and I strongly suspect
>> that nobody wanted to do this for a local branch case at all.
>
> If I remember correctly, the problem was that you are not sure that
> remote branches are in refs/remotes.

Yes, the user can use traditional layout (e.g. refs/heads/origin
is used as a remote tracking branch).

So the check with refs/remotes/ is not technically correct, but
it should probably look-up the configuration to check the
tracking, if we really want to be strict about it.

I personally do not care too much about it, though.
