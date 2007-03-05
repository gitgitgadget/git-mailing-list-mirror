From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Tue, 6 Mar 2007 00:50:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
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
 <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
 <17900.39124.763603.695942@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
 <17900.42415.750335.329874@lisa.zopyra.com>
 <Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.43487.947400.649777@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMwl-0007Jl-No
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbXCEXuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXCEXuU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:50:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:60272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932091AbXCEXuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:50:17 -0500
Received: (qmail invoked by alias); 05 Mar 2007 23:50:16 -0000
X-Provags-ID: V01U2FsdGVkX18JFFkL92UJPEi/PDJID4lNijFxP3UThYKYPbejIv
	kwswi+bvg5j9XP
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17900.43487.947400.649777@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41507>

Hi,

On Mon, 5 Mar 2007, Bill Lear wrote:

> No, I think you missed my point.  There are two xyz.o's:
> 
> One in .master/xyz.o, and one in .branchX/xyz.o.

Why not put the two xyz.c's into .master/ and .branchX/ as well (surely, 
the source files are small compared to the object files)? And just to make 
sure, the Makefile, too (some Makefile targets depend on the timestamp of 
this, too).

And to make sure that if we're switching to a third branch, let's put the 
files there, even when the side branch does not change them, otherwise 
A->B->C->A might fail.

And while at it, we could put the information about which branch this is 
into the corresponding directories, too! Otherwise, we could rename the 
directory by mistake, and the system would stop working.

And the corresponding refs. They could be there, too.

Hth,
Dscho

P.S.: Google for the complicator's gloves.
