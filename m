From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 13:50:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305072323.GA31169@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.30394.172067.743310@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.36569.805689.922989@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOL5E-0003cy-8N
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 22:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933665AbXCEVu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 16:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933666AbXCEVu5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 16:50:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38026 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933665AbXCEVu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 16:50:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25Lokq8010301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Mar 2007 13:50:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l25LojML001939;
	Mon, 5 Mar 2007 13:50:45 -0800
In-Reply-To: <17900.36569.805689.922989@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.46 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41491>



On Mon, 5 Mar 2007, Bill Lear wrote:
> 
> Not because git wrote the file, but because git notices that content
> changes, and writes the file (and timestamps it) "smartly".  If
> someone writes into the repo, the timestamp stored becomes invalidated
> and the write of the file just creates the timestamp at the time of
> the checkout.  If no write into the repo index occurs, the stored
> timestamp is applied after the file is checked out.

But Bill, don't you realize that restoring the timestamp is *WRONG*?

There's no way that git can know whether you did a "make" in between 
switching back and forth between branches. That's true on a very 
fundamental level, but it's doubly true when anybody uses a separate 
object directory (which doesn't leave any information *at*all* in the 
source tree about the fact that somebody did a "make").

So stop even asking for this. We'd have to be totally and utterly 
incompetent to do what you ask for. We're simply not that stupid. 

We already pointed out how you can do what you want to do *other* ways 
that are *not* idiotic and incompetent. I don't think you even answered.

			Linus
