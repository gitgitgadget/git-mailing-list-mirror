From: Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: git reset --hard and uncommitted files in index
Date: Thu, 21 May 2009 22:32:36 -0400
Message-ID: <gv52s4$e7h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 04:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7KbL-0000Kx-EK
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 04:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbZEVCfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZEVCfD
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 22:35:03 -0400
Received: from main.gmane.org ([80.91.229.2]:39140 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbZEVCfD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 22:35:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M7Kb8-00016D-Di
	for git@vger.kernel.org; Fri, 22 May 2009 02:35:02 +0000
Received: from 236-76.162.dsl.aei.ca ([216.162.76.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 02:35:02 +0000
Received: from dermoth by 236-76.162.dsl.aei.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 02:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 236-76.162.dsl.aei.ca
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119709>

Hi,

Today I was working on a script that modify many files on a repository,
therefore during testing phase I needed to reset --hard to get back to
the last commit. This operation does not affect untracked files.

Since i was going to commit the script, at some point I decided to add
it to the index so I could track/revert changes to it. On the next reset
Git deleted the script.

Fortunately "git add" creates an object that I could easily recover
(thanks to wereHamster on #git for pointing that out), however I was
wondering if it's really the desired behavior to *delete* a file that
have been added to the index but isn't on the previous commit? Shouldn't
git just unstage it?

--
Thomas
