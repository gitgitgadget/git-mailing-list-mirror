From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Thu, 18 Feb 2010 14:18:06 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1002181416410.4141@localhost.localdomain>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain> <7vbpfm9tst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:19:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiEiD-0004k3-M3
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 23:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758443Ab0BRWTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 17:19:01 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58081 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753153Ab0BRWTA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 17:19:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1IMI6oZ000550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Feb 2010 14:18:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1IMI6Sx007174;
	Thu, 18 Feb 2010 14:18:06 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vbpfm9tst.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140387>



On Thu, 18 Feb 2010, Junio C Hamano wrote:
> 
> I personally like the general direction you are going.  One minor detail I
> do not know about is whether to move "builtin.h" with others, or leave it
> at the top.  Also I don't particularly find "-I. -Ibuiltin/" ugly.  It
> would make sense to use "-I." and rewrite our '#include "xyzzy.h"' into
> '#include <xyzzy.h>' even if we were not doing this change.

I was actually thinking of just changing everybody to use

	-#include "builtin.h"
	+#include "builtin/cmd.h"

and I even did that with a sed script, but then the renames aren't pure 
renames any more, so I decided that in order to make the patch be a 
minimal rename thing, that would be a second phase.

		Linus
