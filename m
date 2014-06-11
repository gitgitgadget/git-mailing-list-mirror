From: Peter Krefting <peter@softwolves.pp.se>
Subject: Confusing error message in rebase when commit becomes empty
Date: Wed, 11 Jun 2014 13:49:04 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 14:49:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuhxr-0005ha-Ri
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 14:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbaFKMtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 08:49:10 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:56505 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932373AbaFKMtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 08:49:09 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s5BCn5vb009651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Jun 2014 14:49:05 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s5BCn4SF009648;
	Wed, 11 Jun 2014 14:49:04 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 11 Jun 2014 14:49:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251365>

Hi!

I am rebasing a branch to combine a couple of commits. One is a revert 
of a previous commit. Since there are commits in-between, I do 
"squash" to make sure I get everything, and then add the actual change 
on top of that. The problem is that rebase stops with a confusing 
error message (from commit, presumably):

   $ git rebase --interactive
   [...]
   You asked to amend the most recent commit, but doing so would make
   it empty. You can repeat your command with --allow-empty, or you can
   remove the commit entirely with "git reset HEAD^".
   rebase in progress; onto 342b22f
   You are currently rebasing branch 'mybranch' on '342b22f'.

   No changes

   Could not apply 4682a1f20f6ac29546536921bc6ea0386441e23e... Revert "something"

OK, so I should retry the command with --allow-empty, then:

   $ git rebase --interactive --allow-empty
   error: unknown option `allow-empty'

Nope, that's not quite right.

Running "git rebase --continue" does work as expected, but perhaps it 
just shouldn't stop in this case?

-- 
\\// Peter - http://www.softwolves.pp.se/
