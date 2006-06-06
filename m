From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Integrity check
Date: Tue, 6 Jun 2006 15:56:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606061553420.5498@g5.osdl.org>
References: <pan.2006.06.06.22.46.26.518589@canit.se>
 <Pine.LNX.4.64.0606061550100.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 00:57:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnkU1-0000RK-0l
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 00:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWFFW5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 18:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWFFW5E
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 18:57:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751296AbWFFW5D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 18:57:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k56Muw2g022881
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Jun 2006 15:56:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k56MuwVx005033;
	Tue, 6 Jun 2006 15:56:58 -0700
To: Kenneth Johansson <ken@canit.se>
In-Reply-To: <Pine.LNX.4.64.0606061550100.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21412>



On Tue, 6 Jun 2006, Linus Torvalds wrote:
> 
> In the future, just do "git fsck-objects --full" if you're nervous. That 
> will do a full integrity check.

Btw, this can output some scary-sounding "unreachable commit xxxxxx" 
messages or similar, without that actually necessarily being a problem at 
all. Unreachable objects are normal if you've deleted branches, for 
example, or if you rebase (or your upstream rebases, like the "pu" branch 
in the git archive). 

So if you just see a few unreachable objects, doing a "git prune" will get 
rid of them, and they aren't normally any sign of actual trouble.

		Linus
