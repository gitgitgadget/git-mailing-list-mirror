From: Peter Krefting <peter@softwolves.pp.se>
Subject: Recovering from commit --amend in rebase --interactive
Date: Tue, 1 Jun 2010 10:27:23 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:27:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNky-0007at-6t
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab0FAJ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:27:26 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:59870 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750833Ab0FAJ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:27:25 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o519RNdW013992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Jun 2010 11:27:23 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o519RNU5013988;
	Tue, 1 Jun 2010 11:27:23 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 01 Jun 2010 11:27:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148100>

Hi!

I am a frequent user of rebase --interactive, and sometimes I do change a 
commit to "edit", which presents me with an already committed change, which 
I can fix up, and do "git commit --amend" on.

However, sometimes I get conflicts during rebase. In some cases I have 
already seen that conflict, so rerere handles it for me. I am still dropped 
out of rebase to manually add the fixes, though.

The problem now is that is way too easy to just do a "git commit --amend" 
like in the case above, and thus overwriting the previous commit 
unintentionally.

Is there an easy way of working around the issue?


Last time this happened to me, I *did* notice my mistake as I entered the 
editor, since it came up with the previous commit's message. However, as the 
commit message file was in a good shape, I found no way to break out of the 
amend. I ended up using "git reflog" to find out what I overwrote, then "git 
diff $commitid > savedpatch" to remember what the change that I mistakenly 
amended was, then "git checkout $commitid" and "git apply savedpatch" and 
"git add" on the changed files. What I am wondering if there is an easier 
way of recovering?

-- 
\\// Peter - http://www.softwolves.pp.se/
