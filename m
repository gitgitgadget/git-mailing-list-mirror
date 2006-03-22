From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Fix multi-paragraph list items in OPTIONS section
Date: Wed, 22 Mar 2006 21:03:27 +0100
Message-ID: <20060322200327.GA31324@diku.dk>
References: <20060320104118.GA32151@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 21:28:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM9tL-0008Q9-Gf
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 21:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWCVUZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 15:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbWCVUZL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 15:25:11 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:43695 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932695AbWCVUZJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 15:25:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id AB1CD52D6A2;
	Wed, 22 Mar 2006 21:25:07 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19446-04; Wed, 22 Mar 2006 21:25:04 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id AC6CE7701CD;
	Wed, 22 Mar 2006 21:03:27 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id AE7BD6DF823; Wed, 22 Mar 2006 21:01:47 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7E7E561EEC; Wed, 22 Mar 2006 21:03:27 +0100 (CET)
To: Francis Daly <francis@daoine.org>
Content-Disposition: inline
In-Reply-To: <20060320104118.GA32151@craic.sysops.org>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17826>

Francis Daly <francis@daoine.org> wrote Mon, Mar 20, 2006:
> On Mon, Mar 20, 2006 at 10:39:46, Jonas Fonseca wrote:
> 
> > Asciidoc cannot handle multi-paragraph description list items without the
> > need for adding special control characters and reindenting all paragraphs
> > but the first. 
> 
> This issue affects the display of current git-cvsimport and
> git-svnimport doc pages. There was a general tidy-up done in
> df8baa42fe4eeb5a021ac262caf601f44d2a5746 last October, but additions
> since then didn't keep the layout.

I think we are only a few people who cares about this and the vast
number of git manpages makes it very time consuming to keep the layout
polished. Personally, I care mostly for the git core manpages. Maybe if
they lived in a separate directory from the git porcelain manpages it
would be easier to get them into a better shape.

> I don't think there is a full "fix" for this; either the html docs are
> ugly (see the -A section in the pages mentioned above as they are now),
> or the asciidoc source files look odd (although that's probably not a
> big problem) or the manpages look a bit funny.

I found the same thing. Getting both good HTML and manpages is not
trivial unless you use only limited and simple markup. Some things
supported by the HTML generator is not available or doesn't turn out as
good in the generated manpages. This was the main reason I decided to
add a special script to strip/convert markup when generating the cg-ref
manpages.

As for the odd looking asciidoc sources, you can always generate a clean
text version. BTW, for lists you can get rid of the '+' continuations
tags by embedding the list in a pair of '--'. It makes the resulting
source a little more readable.

	--
	 - item 1, para 1
	
	item 1, para 2

	 - item 2
	--

-- 
Jonas Fonseca
