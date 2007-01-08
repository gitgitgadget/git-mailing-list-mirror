From: Junio C Hamano <junkio@cox.net>
Subject: Re: a few remaining issues...
Date: Mon, 08 Jan 2007 13:59:29 -0800
Message-ID: <7vr6u5uqm6.fsf@assigned-by-dhcp.cox.net>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 08 22:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H42Wq-0006Vy-Vg
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 22:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbXAHV7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 16:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbXAHV7b
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 16:59:31 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35048 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964910AbXAHV7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 16:59:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108215929.FDNG3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 16:59:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8lyf1W00l1kojtg0000000; Mon, 08 Jan 2007 16:58:40 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36282>

Updates to the previous "remaining issues" list before 1.5.0.

* Bare repository.

I think what I have in 'next' to add 'core.bare' configuration
to make the bare repository detection safer is ready to be used
to port the RFC patch from Shawn to forbid working-tree
operations in a bare repository to prevent accidents from
happening.  It would be nice if we can cook it for a few days in
'next' and push it out to 'master' before v1.5.0-rc1.

Volunteers?


* Packed refs.

'git-pack-refs' should default to --prune.  There is no point
not to, really.  Objections?

We _might_ want to teach 'git-pack-refs' how to unpack, although
there is no real need for it.  I do not care too deeply either
way.


* Detached HEAD.

This is now in 'master' ;-).


* Make -u default to 'git-am'.

Since we are talking about allowing potentially incompatible UI
changes in v1.5.0 iff the change improves the general situation,
I would say why not.  I'd add --no-utf8 just in case, but
personally I do not offhand see need for it.  Projects that want
their commit log messages in legacy encoding can and should say
"i18n.commitencoding = EUCJP" or somesuch and they can continue
using their preferred encodings without changing their tools nor
work habit and without having to worry about re-coding errors.
