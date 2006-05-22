From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Mon, 22 May 2006 16:18:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221615030.3697@g5.osdl.org>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE>
 <44722A8F.9020609@zytor.com> <20060522220206.GA10488@pasky.or.cz>
 <447239F0.9030705@zytor.com> <20060522225054.GL11941@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:19:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJfv-0002of-5E
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWEVXS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWEVXS4
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:18:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751296AbWEVXSz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:18:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MNIntH004741
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 16:18:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MNImAV017745;
	Mon, 22 May 2006 16:18:48 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060522225054.GL11941@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20550>



On Tue, 23 May 2006, Petr Baudis wrote:
> 
> Even rsync and HTTP cg-clones? git:// and git+ssh:// fetching follows an
> almost entirely different code patch and it's much more efficient since
> I just accumulate the tag object ids I want to check and then pour them
> to git-fetch-pack - I cannot do that with git-(local|http)-fetch. :-(

Sure you can. Well, not to http-fetch, but git-fetch-pack should work fine 
for a local repo.

The git-clone script will literally special-case rsync:// and http://. 
Everything else should work fine with git-fetch-pack.

		Linus
