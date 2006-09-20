From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:19:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:20:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4nk-0003cG-VX
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWITQTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWITQTy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:19:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751686AbWITQTx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:19:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KGJenW021249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 09:19:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KGJdYf002816;
	Wed, 20 Sep 2006 09:19:40 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920160756.GP8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.507 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27364>



On Wed, 20 Sep 2006, Petr Baudis wrote:
> 
>   I personally don't think "throwing away" history is an issue. You can
> print the old sha1 and it is still in the database so you can recover
> it.

No it isn't. Once you've lost the reference, you can't really depend on it 
any more in the long run.

A lot of people do things like "git repack -a -d" by hand, and we've tried 
to encourage people to do so in cron-jobs etc. We've even had patches 
floating around that do it automatically after a pull.

In other words, once a ref is gone, you are easily going to loose the 
history to it too. Also, regardless, you should be told about it, UNLESS 
YOU HAVE EXPLICITLY STATED THAT YOU DON'T CARE ABOUT HISTORY!

That's a really important point. You can trivially say "I don't care". 
It's literally one extra character. But it should be the _user_ that says 
so, not the SCM.

The whole point of the SCM is to care.

		Linus
