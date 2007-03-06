From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 05 Mar 2007 19:06:44 -0500
Message-ID: <87zm6rqlpn.fsf@graviton.dyn.troilus.org>
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
	<Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONCk-0005uA-Cf
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbXCFAGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933575AbXCFAGu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:06:50 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:44320
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933372AbXCFAGt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 19:06:49 -0500
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 0DFF989C03C; Mon,  5 Mar 2007 19:06:46 -0500 (EST)
In-Reply-To: <Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 00:50:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41508>

Johannes Schindelin writes:

> Hi,
>
> On Mon, 5 Mar 2007, Bill Lear wrote:
>
>> No, I think you missed my point.  There are two xyz.o's:
>> 
>> One in .master/xyz.o, and one in .branchX/xyz.o.
>
> Why not put the two xyz.c's into .master/ and .branchX/ as well (surely, 
> the source files are small compared to the object files)? And just to make 
> sure, the Makefile, too (some Makefile targets depend on the timestamp of 
> this, too).
>
> And to make sure that if we're switching to a third branch, let's put the 
> files there, even when the side branch does not change them, otherwise 
> A->B->C->A might fail.
>
> And while at it, we could put the information about which branch this is 
> into the corresponding directories, too! Otherwise, we could rename the 
> directory by mistake, and the system would stop working.
>
> And the corresponding refs. They could be there, too.

This all sounds a lot like git-clone's "alternate" code.

Does a repository cloned with the -s or --references flag have some
setting to make fetch and push work with the same remote repositories
as the local origin, or do the remotes have to be manually propagated
between the two local copies?  If I git-fetch in the local clone, does
it write the new objects to the local origin?

My own work habits are very similar to Bill Lear's, but my projects'
build times are small enough that it's less pain to rebuild half the
project than to propagate changes recorded under $GIT_DIR between
local branches.  I have not found a git workflow that makes me
entirely happy, but I suspect I just don't know the magic words.

Michael Poole
