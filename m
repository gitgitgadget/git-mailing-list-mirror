From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: git submodule when submodule is not a clone of a repository
Date: Fri, 18 Jan 2008 17:25:20 +0000 (UTC)
Message-ID: <loom.20080118T171433-93@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 18:26:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFuym-0003rd-KE
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 18:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbYARRZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 12:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757011AbYARRZa
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 12:25:30 -0500
Received: from main.gmane.org ([80.91.229.2]:51773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756965AbYARRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 12:25:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JFuy6-0003MP-KV
	for git@vger.kernel.org; Fri, 18 Jan 2008 17:25:26 +0000
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 17:25:26 +0000
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 17:25:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071204 Ubuntu/7.10 (gutsy) Firefox/2.0.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71042>

Hi,

I am trying to use submodules to keep a project organized.
I am using a workflow that is probably not the common one and I am running into
problems.

Basically, I have a superproject TOP, with subproject A and B. The thing is that
A and B are _not_ cloned from some existing repo.  They are two brand new
repositories created with git init.

Basically, I am doing this so that in the superproject I commit states with
specific versions of A and B (that are logically distinct things) that are known
to work fine together. Also I am doing this since A and B are actually just
started with TOP, but I have a provision of making them independently developed
things, so I like to have them separated from start.

The thing is that git-submodule makes very strong assumptions on A and B.
Particularly, if there is no url defined from them some commands (notably
update) will fail.

So I need to make a fake url for the submodule (e.g. .) and a fake origin for it
(again .)

Would it make sense to have a git submodule update not try to fetch if there is
no url defined, but still checkout the right commit for the submodule (rather
than skipping the submodule at all) ?

Sergio
