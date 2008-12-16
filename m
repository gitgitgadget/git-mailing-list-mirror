From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: git filter-branch and superproject
Date: Tue, 16 Dec 2008 11:56:38 +0000 (UTC)
Message-ID: <loom.20081216T114923-354@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 12:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYZ5-0002jc-Qg
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 12:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbYLPL4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 06:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYLPL4y
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 06:56:54 -0500
Received: from main.gmane.org ([80.91.229.2]:48383 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbYLPL4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 06:56:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCYXf-00058r-Db
	for git@vger.kernel.org; Tue, 16 Dec 2008 11:56:49 +0000
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 11:56:47 +0000
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 11:56:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/2008111317 Ubuntu/8.04 (hardy) Firefox/3.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103272>

Hi,

once a sub-project has been rewritten by filter branch, there is a problem with
references in superproject.

This is obviously a case where something "has been published" so filter-branch
is not a good idea.  However, super-projects are a very special case of
publication since they might be "in full control" of whom did the rewriting of
their submodules.

Is there a way to filter branch the superproject so that whatever commit is
referenced that is in refs/original/something in the subproject gets updated to
the corresponding rewritten commit (or an error is given if such a
correspondance does not exist)?

Namely, can filter-branch on the subproject deliver a "commit conversion table"
that can then be fed to a filter-branch in a superproject?  
