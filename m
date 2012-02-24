From: Charles Brossollet <chbrosso@lltech.fr>
Subject: Submodule status inside nested submodule fails
Date: Fri, 24 Feb 2012 09:53:23 +0000 (UTC)
Message-ID: <loom.20120224T104003-230@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 11:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rwk-0006b5-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 11:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695Ab2BXKAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 05:00:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:47886 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756690Ab2BXKAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 05:00:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S0rwa-0006X7-E8
	for git@vger.kernel.org; Fri, 24 Feb 2012 11:00:04 +0100
Received: from babel.loa.espci.fr ([193.54.80.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 11:00:04 +0100
Received: from chbrosso by babel.loa.espci.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 11:00:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.54.80.96 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20100101 Firefox/10.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191425>

Hello there,

Using MSysGit 1.7.9 on Win7 (64 bit), I have a repo with the following 
structure:

main/
  src/
  ext/
    submodule/
       modules/module1
       modules/module2

submodule is... a submodule, having itself submodules.

When I query submodule status --recursive in main/, no problem.
But when I query submodule status in  ext/submodule, I get error "You need to
run this command from the toplevel of the working tree.", which is a wrong
error message.

Searching for message in git source I found the test triggering the message to
be an empty result for "git rev-parse --show-cdup". Running the command in
ext/submodule strangely returns the *absolute* path of ext/submodule, which
should not happen because this command returns path of current dir relative to
the containing working tree.

Is there something wrong with my repo? Or have I found a bug? Any help
appreciated

Charles
