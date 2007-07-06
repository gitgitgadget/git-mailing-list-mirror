From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: don't add multiple Signed-off-by: from the same identity
Date: Fri, 06 Jul 2007 11:11:48 -0700
Message-ID: <7vy7hte717.fsf@assigned-by-dhcp.cox.net>
References: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 20:12:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6sHx-0000Ar-9s
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 20:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764047AbXGFSLv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 14:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764033AbXGFSLv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 14:11:51 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38860 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763989AbXGFSLt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 14:11:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706181149.DDXN1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Jul 2007 14:11:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LJBo1X00J1kojtg0000000; Fri, 06 Jul 2007 14:11:49 -0400
In-Reply-To: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 6 Jul 2007 14:42:27 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51780>

If you are trying to avoid a run of Signed-off-by: lines like this:

	Signed-off-by: Original Author <oa@example.com>
	Signed-off-by: First Reviewer <fr@example.com>
	Signed-off-by: Second Reviewer <sr@example.com>
	Signed-off-by: Original Author <oa@example.com>
	Signed-off-by: Subsystem Integrator <si@example.com>

It is not a bug.  If the last signed-off-by is not from
yourself, your signed-off-by is added when you ask with "-s",
and this is very much intentionally done to follow the existing
practice of patch passing done in the kernel community, where
Signed-off-by: was invented (Linus or somebody from the kernel
circle can correct me if I am wrong).

When you are passing patches around, tweaks to the patch
contents can be made.  If your patch comes back to you from the
second reviewer, it is not what you originally sent out.  You
would want to sign it off again.

We have deliberately excluded what your other patch tries to do
for a reason.  Even though these lines are not digitally signed,
the intent of adding a Signed-off-by: line with your name is
that you are certifying its origin, according to the definition
of DCO (see Documentation/SubmittingPatches).  This should be a
conscious act from the signer's part, and making it automatic
with a config variable that you set once and forget makes it
much less meaningful.



        

        
