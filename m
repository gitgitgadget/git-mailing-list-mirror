From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to restore the original head after `git-reset --hard master^`
Date: Tue, 11 Oct 2005 10:04:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510111003180.14597@g5.osdl.org>
References: <434BD65A.9000108@ust.hk> <Pine.LNX.4.64.0510110856520.14597@g5.osdl.org>
 <Pine.LNX.4.63.0510111240410.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Lau <benlau@ust.hk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 19:07:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPNYP-0006Gn-Et
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 19:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJKREi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVJKREi
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 13:04:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751460AbVJKREi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 13:04:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BH4Q4s023087
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 10:04:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BH4P7f016469;
	Tue, 11 Oct 2005 10:04:26 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510111240410.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9975>



On Tue, 11 Oct 2005, Daniel Barkalow wrote:
> 
> That reminds me: if you lose all of your refs, it's hard to get them back, 
> because git-fsck-objects aborts if you don't specify any heads or have any 
> refs. Is there some reason for this check?

"git prune" is the reason for that check.  Pruning your whole object store 
is likely not what you want ;)

You might make it abort only when "--unreachable" has been specified..

		Linus
