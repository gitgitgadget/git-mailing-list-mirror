From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 11:38:24 -0700
Message-ID: <7vhcn2c673.fsf@assigned-by-dhcp.cox.net>
References: <11870975181798-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 20:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL1Hy-00022Y-3q
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 20:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556AbXHNSig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXHNSig
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 14:38:36 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33688 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbXHNSie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 14:38:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814183826.BLEQ5405.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 14:38:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bueQ1X00X1kojtg0000000; Tue, 14 Aug 2007 14:38:25 -0400
In-Reply-To: <11870975181798-git-send-email-bdowning@lavos.net> (Brian
	Downing's message of "Tue, 14 Aug 2007 08:18:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55845>

Brian Downing <bdowning@lavos.net> writes:

> We can now read .gitattributes files out of the index, but the index
> must be loaded for this to work.

That interface is at too low a level, I am afraid.  Many
commands do want to control when they read the index and it
affects the result, especially when the work tree traversal
implemented in dir.c is involved.

I am not rejecting/objecting, but just raising concerns.  I do
not have time to review this today, but just wanted to see if
you fully assessed the implications (and if so that would save
work on my end).
