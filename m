From: dherring@ll.mit.edu
Subject: docs and completion and dashless commands
Date: Fri, 22 Aug 2008 16:26:32 -0400 (EDT)
Message-ID: <alpine.LNX.0.999999.0808221550100.11892@mojave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdby-0007xx-Hm
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYHVUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYHVUuy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:50:54 -0400
Received: from LLMAIL1.LL.MIT.EDU ([129.55.12.41]:39233 "EHLO ll.mit.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751583AbYHVUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:50:54 -0400
X-Greylist: delayed 1186 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2008 16:50:54 EDT
Received: (from smtp@localhost)
	by ll.mit.edu (8.12.10/8.8.8) id m7MKV5V8000636
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:31:05 -0400 (EDT)
Received: from mojave.llan.ll.mit.edu(              ), claiming to be "mojave"
 via SMTP by llpost, id smtpdAAAqUa4D5; Fri Aug 22 16:26:32 2008
X-X-Sender: dherring@mojave
User-Agent: Alpine 0.999999 (LNX 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93362>

First off, I'm not too keen on these dashless commands.
- We now have `man git-X` but can't run `git-X`
- A separate completion script must be installed for bash
- Lose completion for all other shells
- History expansion is complicated (e.g. `!git-push` vs `!git push`)

I tracked down "Invoke git-repo-config directly" (March 06) and related 
threads; so I somewhat understand the logic.  However the notions that 
moving bin/git-X to libexec/git-core/git-X somehow hides complexity for 
the user or fixes problems with PATH seem misguided.  Maybe there were 
some other reasons I missed?

Anyway, could someone modify INSTALL to mention 
contrib/completion/git-completion.bash and putting `git --exec-path` in 
PATH for other shells?  A man page about configuring shells for git would 
also be nice.  These docs might also instruct users to call git-config and 
set their global username and email.

Also, with the dashless commands, it may be more appropriate to distribute 
a texinfo tree than flat manpages.

Thanks,
Daniel
