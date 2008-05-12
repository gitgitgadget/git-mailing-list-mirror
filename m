From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 21:43:34 +0300
Message-ID: <20080512184334.GB5160@mithlond.arda.local>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 12 20:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvd0e-0006WE-Mp
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbYELSni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756220AbYELSnh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:43:37 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:44049 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755436AbYELSnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:43:37 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 482324D8002F313D; Mon, 12 May 2008 21:43:35 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jvczm-0001zX-Cb; Mon, 12 May 2008 21:43:34 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805121810501.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81900>

Johannes Schindelin wrote (2008-05-12 18:13 +0100):

> On Mon, 12 May 2008, Teemu Likonen wrote:
> 
> > Probably a crazy idea: What if "gc --aggressive" first removed
> > *.keep files and after packing and garbage-collecting and whatever
> > it does it would add a .keep file for the newly created pack?
> 
> Most .keep files are not meant to be removed by git-gc.  Usually,
> .keep files are only created interactively (if you _want_ to keep
> a pack, e.g. when it has been optimally packed and is big), or by
> git-index-pack while it is writing a pack (IIRC).
> 
> So I think it would be wrong for "gc --aggressive" to remove the .keep
> files.

I guess you're right. Maybe "gc --aggressive" could delete only certain
machine-generated .keep files which have an identifier inside?

Well, I don't really have any problems with the current behaviour; it
just feels a bit strange that, for example, Linus's kernel repository
grew about 90MB after just one update pull and gc. Also, dangling
objects are kept forever in .keep packs (which are created with "git
clone", for example).
