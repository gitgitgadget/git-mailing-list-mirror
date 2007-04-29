From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sat, 28 Apr 2007 23:59:18 -0700
Message-ID: <7vy7kbeke1.fsf@assigned-by-dhcp.cox.net>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
	<1177693212202-git-send-email-lcapitulino@mandriva.com.br>
	<7vabwtobpg.fsf@assigned-by-dhcp.cox.net>
	<20070427181326.14bbbf5c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sun Apr 29 08:59:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi3Ne-0006Ex-9V
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 08:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXD2G7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 02:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbXD2G7U
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 02:59:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55991 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXD2G7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 02:59:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429065919.POUM1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 02:59:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id suzJ1W00a1kojtg0000000; Sun, 29 Apr 2007 02:59:19 -0400
In-Reply-To: <20070427181326.14bbbf5c@localhost> (Luiz Fernando
	N. Capitulino's message of "Fri, 27 Apr 2007 18:13:26 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45819>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

> Em Fri, 27 Apr 2007 12:32:11 -0700
> Junio C Hamano <junkio@cox.net> escreveu:
>
> | "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
> | writes:
> | 
> | > From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
> | >
> | > This macro may be used to iterate over revisions, so, instead of
> | > doing: ...
> | 
> | I am not a big fan of magic control-flow macros, as it makes the
> | code harder to grok for people new to the codebase.
>
>  Yeah, I agree. But I think that any experienced programmer will
> understand it.
>
>  Anyways, I don't want to raise polemic discussions for minor
> changes. Feel free to drop this one then.

I on the other hand like the kernel style list macros.

The reason I do not like this particular one is because both
operations you are hiding are not simple operations like
"initialize a variable to list head" or "follow a single pointer
in the structure", but rather heavyweight operations with rather
complex semantics.  I would want to make sure that people
realize they are calling something heavyweight when they use the
revision traversal.
