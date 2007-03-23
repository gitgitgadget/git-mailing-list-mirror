From: Jeff King <peff@peff.net>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 20:51:16 -0400
Message-ID: <20070323005116.GA29901@segfault.peff.net>
References: <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org> <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com> <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703221257020.18328@xanadu.home> <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org> <20070322221340.GA13867@segfault.peff.net> <Pine.LNX.4.64.0703221720481.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:50:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUXzX-0005cn-Qe
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 01:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934246AbXCWAut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 20:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934250AbXCWAus
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 20:50:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4475 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934246AbXCWAus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 20:50:48 -0400
Received: (qmail 29907 invoked by uid 1000); 22 Mar 2007 20:51:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703221720481.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42891>

On Thu, Mar 22, 2007 at 05:25:37PM -0700, Linus Torvalds wrote:

> That does nothing for me. Nor does
> 
> 	strings -- /usr/lib64/libefence.so | grep EF_
> 
> show that string or anything else half-way promising..
> 
> Googling for that shows that some versions of efence have had that flag 
> (not necessarily as a environment variable, though). But certainly not the 
> version I have.

Hmm. It's in the latest debian package (2.1.14.1) and works as
advertised. I just poked at the FC6 version (2.2.2 -- but Bruce's last
version seemed to be the 2.1 series, so no idea who is responsible for
this brain damage), and it now unconditionally prints the banner.
Huzzah.

It at least goes to stderr, which might be redirectable; otherwise
you're stuck editing the source (see efence.c:initialize).

-Peff
