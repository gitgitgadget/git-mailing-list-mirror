From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 13:55:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702211348060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070221104209.GM21842@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 13:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJr0E-0007eP-Jl
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 13:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbXBUMzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 07:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbXBUMzT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 07:55:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:42756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbXBUMzS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 07:55:18 -0500
Received: (qmail invoked by alias); 21 Feb 2007 12:55:16 -0000
X-Provags-ID: V01U2FsdGVkX18EUtVNo3EEooNOLil52oq1ycqFWVLd+CVRBkXCb9
	1xBQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070221104209.GM21842@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40297>

Hi,

On Wed, 21 Feb 2007, Martin Waitz wrote:

> On Wed, Feb 21, 2007 at 01:39:48AM +0100, Johannes Schindelin wrote:
> > In that case, .gitattributes (I mean a tracked one) would be wrong, 
> > wrong, wrong.
> 
> I don't think so.

What you conveniently "forgot" to quote was the case: if we want this to 
decide on when to use crlf<->lf transformation, we should decide that 
locally.

But you are probably right: the information if a file _is_ fair game for 
crlf munging is probably something we might want to _be able_ to have 
tracked.

BUT there are a whole lot of problems with that approach, as Junio pointed 
out, like merging attributes files, like what to do if a file is not 
changed by a commit, but its attributes are, etc.

So, why not make the autodetection really brilliant at first, and _if_ we 
hit a hard case which cannot be autodetect, _then_ add .gitattributes 
which should _only_ force settings on misdetected files?

Ciao,
Dscho
