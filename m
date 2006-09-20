From: Stephen Hemminger <shemminger@osdl.org>
Subject: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 08:03:08 -0700
Message-ID: <20060920080308.673a1e93@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ3bx-0007wP-VQ
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWITPDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWITPDi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:03:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751584AbWITPDh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 11:03:37 -0400
Received: from localhost.localdomain (069-064-229-129.pdx.net [69.64.229.129])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KF3CnW017248
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 08:03:15 -0700
To: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-0.616 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27348>

Jeff, you use branches on the netdev tree, but GIT doesn't seem to like
to sync these up properly. My normal method is to keep a clone'd version
of the netdev tree and use pull to resync it. I don't do any changes
to that tree.

This doesn't work with all the branches for some reason. Is this a git
bug?


$ git pull
Generating pack...
Done counting 666 objects.
Result has 400 objects.
Deltifying 400 objects.
 100% (400/400) done
Unpacking 400 objects
Total 400, written 400 (delta 324), reused 0 (delta 0)
 100% (400/400) done
* refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
  from f04b92e97d21b1921c91ec1d6d5e8bbf8606b77a to e478bec0ba0a83a48a0f6982934b6de079e7e6b3
* refs/heads/e100-sbit: does not fast forward to branch 'e100-sbit' of git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6;
  not updating.

A temporary workaround is to prune the offending branches locally
first, but that seems like a hack.
