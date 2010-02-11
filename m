From: Marc Fournier <marc.fournier@camptocamp.com>
Subject: git-subtree.sh - regression introduced by da949cc55
Date: Thu, 11 Feb 2010 14:08:37 +0100
Message-ID: <20100211130837.GA29916@lonquimay.wrk.lsn.camptocamp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 14:29:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfZ6H-0005OR-87
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 14:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab0BKN2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 08:28:52 -0500
Received: from c2cpc15.camptocamp.com ([128.179.66.15]:35018 "EHLO
	mail.camptocamp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab0BKN2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 08:28:51 -0500
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 08:28:51 EST
Received: from lonquimay.localdomain (251-189-236-89-pool.cable.fcom.ch [89.236.189.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.camptocamp.com (Postfix) with ESMTP id D204D80766;
	Thu, 11 Feb 2010 15:08:37 +0100 (CET)
Received: by lonquimay.localdomain (Postfix, from userid 1000)
	id 82A81AE0F0; Thu, 11 Feb 2010 14:08:37 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139589>

Hello,

Up to this commit, I was able to split out new trees out of sub-directories
of my project.

I used this to create a subproject out of a directory, without necessarily
knowing in advance that I could need the content of this directory in other
projects.

Since da949cc55, older unrelated commits get prepended to the history.

This issue is quite easy to reproduce:

 1. choose a directory in your project which hasn't been added with
    "git subtree add". Let's say it's called my/directory/.
 2. "git subtree split --prefix=my/directory --branch the-new-tree"
 3. "git log --stat the-new-tree"
 4. notice the mess which happens at the first commit concerning
    my/directory/ and how it then includes random older commits which have
    nothing related to my/directory.

Jakub, I'm not sure I understand what this patch is supposed to fix. Could
you provide an example ? Or a test case ?

Thanks !
Marc
