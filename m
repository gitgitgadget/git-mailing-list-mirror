From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Fri, 11 May 2007 17:40:12 -0700
Message-ID: <7vlkfu98nn.fsf@assigned-by-dhcp.cox.net>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<200705111326.35577.jnareb@gmail.com>
	<7v7irfcns1.fsf@assigned-by-dhcp.cox.net>
	<200705120106.53624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 02:40:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmfem-0003tS-GD
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXELAkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757793AbXELAkP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:40:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43877 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbXELAkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:40:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512004014.CUUZ2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 20:40:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id y0gD1W00e1kojtg0000000; Fri, 11 May 2007 20:40:13 -0400
In-Reply-To: <200705120106.53624.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 12 May 2007 01:06:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47003>

Jakub Narebski <jnareb@gmail.com> writes:

> -'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
> +'git-add' [-n] [-v] [-f] (-u [[--] <file>...] | [--] <file>...)

I do not think this is correct; does -u take optionally path and
when path is ambiguous you can add -- to disambiguate?

Honestly, I would rather not sprinkle synopsis with too many
nested parentheses and brackets, which only makes it harder to
see without giving a clear "this combines with that but is not
compatible with the other" information.  Adding comment to the
section that begins with "-u::" that says "... commit -a; this
option does not take any paths parameters." would be cleaner,
and easier to understand.

Of course, I would prefer a patch to allow use of paths with -u
even more, but that is what I already said ;-).
