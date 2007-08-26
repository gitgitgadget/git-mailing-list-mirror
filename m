From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve error message: not a valid branch name
Date: Sun, 26 Aug 2007 14:26:28 -0700
Message-ID: <7vd4xang1n.fsf@gitster.siamese.dyndns.org>
References: <y7fyfh7x.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 23:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPPcx-0005Ak-92
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 23:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXHZV0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 17:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbXHZV0c
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 17:26:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64508 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbXHZV0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 17:26:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070826212629.TOXY9971.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 26 Aug 2007 17:26:29 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id glSV1X0021gtr5g0000000; Sun, 26 Aug 2007 17:26:29 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56738>

Jari Aalto <jari.aalto@cante.net> writes:

> (create_branch): Extend die message from 'is not a valid branch name'
> to '...(see git-check-ref-format)'.

I think you meant to say "see git-check-ref-format(1)" as you
meant the manual page.

I am a bit torn on this.  git-check-ref-format.1 is where we
currently _happen_ to describe what valid refnames should look
like, but it could be argued that it is a bug in the manual.

Two possible improvements that are mutually incompatible would
be:

 - refactor that part of the manual to be included in the pages
   for any and all commands that can take refname from the user;
   this is inpractical as almost all command would be affected.

 - move that to more central place, say git(7), and everybody
   refer to that page;

I'd personally prefer the latter, as "naming things" is such a
central thing for the use of the system (this applies to the
description of "SHA-1 expression" that we curently have in
git-rev-parse(1) as well) and it is better for users to have
understanding of such fundamental syntaxes and concepts before
even using any individual commands.
