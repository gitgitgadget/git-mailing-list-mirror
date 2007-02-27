From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 23:15:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272314540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070227155042.GB3230@spearce.org>
 <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAbw-0008Em-Um
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbXB0WPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXB0WPp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:15:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:43667 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751934AbXB0WPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:15:44 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:15:43 -0000
X-Provags-ID: V01U2FsdGVkX1/6N5Yt+uH6P6OLf0Iv/snCupn3PBex4SBL7kpR/3
	COJA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40823>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> On Tue, 27 Feb 2007, Shawn O. Pearce wrote:
> > 
> > We have thus far reformatted OBJ_TREEs with a new dictionary based
> > compression scheme.  In this scheme we pool the filenames and modes
> > that appear within trees into a single table within the packfile.
> > All trees are then converted to use a 22 byte record format:
> > 
> >   - 2 byte network byte order index into the string pool
> >   - 20 byte SHA-1
> 
> Umm. Am I missing something, or is this totally braindamaged?
> 
> Are you really expecting there to never be more than 64k basenames? 
> Trust me, that's a totally broken assumption. Anything that tracks 
> generated stuff will _easily_ have several tens of thousands of random 
> filenames even in a single tree, much less over the whole history of the 
> repository.

The sane thing, of course, is to use some sort of prefix coding, together 
with an escape code.

Ciao,
Dscho
