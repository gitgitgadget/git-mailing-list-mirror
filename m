From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/emacs/vc-git.el: various improvements.
Date: Sun, 15 Jul 2007 20:20:56 -0700
Message-ID: <7vejj9avaf.fsf@assigned-by-dhcp.cox.net>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAH8u-0007PI-ND
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849AbXGPDU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759520AbXGPDU5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:20:57 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47049 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759297AbXGPDU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:20:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716032057.UBBG1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Jul 2007 23:20:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q3Lw1X00C1kojtg0000000; Sun, 15 Jul 2007 23:20:56 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52627>

David Kastrup <dak@gnu.org> writes:

> (vc-git-symbolic-commit): Simplify and make it return
> something useful in almost all cases.

It would be easier to review and understand if "something
useful" were more specific.

It appears that the previous version of this function tried not
to barf if it got nil or false as input but now it does not seem
to worry about that case.  Also the option given to name-rev is
different which would lead to different behaviour -- arguably a
better one, but that needs to be documented in the log message.

> (vc-git-previous-version): Simplify.
> (vc-git-next-version): Simplify and make more efficient.

If you make the result symbolic using vc-git-symbolic-commit, do
you need to add --abbrev/--abbrev-commit to these functions?
These options have very small but still non zero cost.

> (vc-git-annotate-command): heed REV argument.
> (vc-annotate-extract-revision-at-line): Activate.

Ok.
