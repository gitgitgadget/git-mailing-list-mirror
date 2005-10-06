From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Thu, 6 Oct 2005 07:39:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510060737160.31407@g5.osdl.org>
References: <20051005191300.GC17475@hexapodia.org> 
 <Pine.LNX.4.64.0510051541300.31407@g5.osdl.org>
 <81b0412b0510060641g3a3c6e02m6827370dd61b5ea6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andy Isaacson <adi@hexapodia.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENWuF-0002aU-SB
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 16:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVJFOjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVJFOjN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 10:39:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751043AbVJFOjM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 10:39:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j96Ed44s017811
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Oct 2005 07:39:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j96Ed3vl003458;
	Thu, 6 Oct 2005 07:39:03 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510060641g3a3c6e02m6827370dd61b5ea6@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9770>



On Thu, 6 Oct 2005, Alex Riesen wrote:
> On 10/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >         git ls-remote http://www.linux-mips.org/pub/scm/linux.git | wc -l
> >
> 
> Which, btw, failed for me, when I tried to run it home (which has no 
> .git in it yet). Do the scripts git-ls-remote.sh and git-parse-remote.sh 
> really need .git/...?

Good point. No they don't. You should be able to run "git ls-remote" 
outside of a local git directory.

> Just in case they don't, the attached patch removes the die("Not a git archive")

Junio, please apply.

(It still wants the "git-sh-setup" part if only because it uses "die()" in 
another place).

		Linus
