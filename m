From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 09:02:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701231506.32396.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231624.41716.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 18:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9P2U-0002Ub-DR
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 18:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbXAWRC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932968AbXAWRC1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 12:02:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40024 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932911AbXAWRC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 12:02:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0NH2G3U009584
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 09:02:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0NH2CCN025020;
	Tue, 23 Jan 2007 09:02:14 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.776 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37550>



On Tue, 23 Jan 2007, Johannes Schindelin wrote:
> 
> Yes. But it _does_ have a dependency on perl and bash. For example, when 
> you merge git-merge-one-file is spawned -- a bash script.

That's just disgusting. I thought we fixed it, but apparently we only did 
so for git-merge-recursive. Hmm?

All the other uses seem to be just a case of

	git-merge-index -o git-merge-one-file -a

and wouldn't it be beautiful if the default action for git-merge-index (if 
you do _not_ specify a merger program) was to do the simple one-file 
three-way merge that we can already do for real merges?

Wouldn't it be nice if we could just do

	git-merge-index -o -a

and be done with it? 

Johannes, this should be right up your alley.. Hint hint..

		Linus
