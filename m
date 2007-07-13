From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 00:00:19 +0100
Message-ID: <1184367619.2785.58.camel@shinybook.infradead.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
	 <Pine.LNX.4.64.0707111940080.4516@racer.site>
	 <20070711202615.GE3069@efreet.light.src>
	 <200707120857.53090.andyparkins@gmail.com>
	 <1184261246.31598.139.camel@pmac.infradead.org>
	 <20070713003700.GA21304@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jul 14 00:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9U6j-0007GP-KP
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 00:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762179AbXGMW70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 18:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759709AbXGMW70
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 18:59:26 -0400
Received: from canuck.infradead.org ([209.217.80.40]:34549 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757574AbXGMW7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 18:59:25 -0400
Received: from shinybook-bcm.infradead.org ([2001:8b0:10b:1:20a:95ff:fef3:9992])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9U6Z-0005nr-If; Fri, 13 Jul 2007 18:59:20 -0400
In-Reply-To: <20070713003700.GA21304@thunk.org>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52419>

On Thu, 2007-07-12 at 20:37 -0400, Theodore Tso wrote:
> I could use separate trees, I suppose, but then I have to keep
> multiple copies of the .o files around in all of those separate trees,
> and it's cheaper and more efficient to keep them in the ccache cache
> IMHO.  And with 7200 RPM laptop drives and dual core processors
> combined with ccache, I hardly notice the rebuild/relink time. 

I'm not entirely sure why it would be cheaper and more efficient to keep
your object files in ccache rather than in the build tree. It takes time
for ccache to do the preprocessing and fetch them, and it takes even
more time to redo the linking.

Disk space is cheap too, and you can always 'make clean' or even remove
all the source files too, if you really care.

Not that I'm presuming to suggest that there's anything _wrong_ with
your choice of workflow, of course -- it just doesn't really make much
sense to me.

Branches just seem like a source of complexity and hence pain. Using git
was just starting to become sensible for newbies, and now when people
are forced to deal with multiple branches it's all horribly painful
again.

-- 
dwmw2
