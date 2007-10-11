From: Sergio <sergio.callegari@gmail.com>
Subject: Re: How to have multiple working copy directories use the same repository?
Date: Thu, 11 Oct 2007 19:21:10 +0000 (UTC)
Message-ID: <loom.20071011T191233-202@post.gmane.org>
References: <744844.82514.qm@web55015.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 22:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig4Gh-0004wU-8u
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbXJKUER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbXJKUER
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:04:17 -0400
Received: from main.gmane.org ([80.91.229.2]:45254 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbXJKUEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 16:04:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ig3tc-000281-JQ
	for git@vger.kernel.org; Thu, 11 Oct 2007 19:40:36 +0000
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 19:40:36 +0000
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 19:40:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60629>

One possibility can be to use the "git-new-workdir"
script that is distributed in the contrib directory
of git source. It allows to have many work dirs insisting
on the same repo (yet possibly operating on different branches!)

I believe that you might need to be careful with that,
though:

1) There is no check about the possibility of messing things
up by working on the same branch from two points.
2) There should be a basic infrastructure to avoid nasty
things from happening but I do not know if it is complete.
3) Implementation is based on symlinks in the git directory,
so it is only for architectures supporting symlinks and, since
there are many symlinks, if something gets changed by mistake and
some symlink looses consistency with the others bad things may
happen.

Sergio  
