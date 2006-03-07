From: Junio C Hamano <junkio@cox.net>
Subject: Re: PATCH: Allow format-patch to attach patches
Date: Mon, 06 Mar 2006 17:01:26 -0800
Message-ID: <7vpskz5aqh.fsf@assigned-by-dhcp.cox.net>
References: <440C352C.9070009@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 02:02:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGQaO-0003B3-PL
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 02:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWCGBBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 20:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWCGBBb
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 20:01:31 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45457 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932571AbWCGBBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 20:01:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307005934.OBLU20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 19:59:34 -0500
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <440C352C.9070009@codeweavers.com> (Mike McCormack's message of
	"Mon, 06 Mar 2006 22:12:12 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17312>

Nicely done.

Especially I like the part that you explicitly set charset to
UTF-8 to the primary part.

The only two and half minor issues I might have about this are:

 (1) is the type text/x-patch appropriate?

 (2) is it possible to cheaply come up with a safe mime-magic,
     instead of a hardcoded long string and hope it does not
     clash?

You can just say "Yes it is an established practice, widely
accepted and that is what you are responding to so obviously you
can grok it ;-)" to (1).  About (2), you would probably need to
read the "diff-tree -p" output beforehand if we want to be
absolutely sure, so punting on the issue like this might be the
best practical approach for now, but I am asking it anyway
because people may have better ideas.

The remaining half issue is if would it make sense to sometimes
optionally use non 8-bit CTE for the patch part.  I do _NOT_
want to receive CTE=QP patch myself, nor I want to encourage it
(actually I would want to actively discourage it), but I do not
mind if people find use of such a patch in a distant corner of
the galaxy where I do not have to touch such a patch.
