From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cvs2git and file permissions
Date: Sat, 18 Jun 2005 14:23:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506181421070.2268@ppc970.osdl.org>
References: <20050618205208.GA4917@billie.cs.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 23:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjkgG-0005Ix-9V
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 23:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFRVVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVFRVVy
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 17:21:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261468AbVFRVVw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2005 17:21:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5ILLijA007702
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 18 Jun 2005 14:21:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5ILLhEH010747;
	Sat, 18 Jun 2005 14:21:43 -0700
To: skimo@liacs.nl
In-Reply-To: <20050618205208.GA4917@billie.cs.kuleuven.ac.be>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 18 Jun 2005, Sven Verdoolaege wrote:
> 
> Let cvs checkout in a temporary directory rather than
> using the pipe option to avoid loss of mode information.

Hmm.. Why do you use the "-N" flag?

Wouldn't it be much cleaner to _not_ create all those sub-directories 
under ".git-tmp", and instead do something like

	"cvs -q -d %s checkout -d .git-tmp -r%s '%s/%s'" ...
	"mv -f .git-tmp/%s %s\n", dir ? dir+1 : name, name

With that changed (and tested ;), I'll happily take it.

		Linus
