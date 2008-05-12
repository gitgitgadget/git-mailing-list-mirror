From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 22:09:46 +0300
Message-ID: <20080512190946.GC5160@mithlond.arda.local>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon May 12 21:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdR8-0007XA-Lw
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760334AbYELTJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758767AbYELTJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:09:58 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35171 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758825AbYELTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:09:57 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 48232FF0002E7D16; Mon, 12 May 2008 22:09:50 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvdP8-0002EA-1E; Mon, 12 May 2008 22:09:46 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81910>

Nicolas Pitre wrote (2008-05-12 14:56 -0400):

> On Mon, 12 May 2008, Teemu Likonen wrote:
> 
> > Well, I don't really have any problems with the current behaviour;
> > it just feels a bit strange that, for example, Linus's kernel
> > repository grew about 90MB after just one update pull and gc.
> 
> That looks really odd.  Sure the repo might grow a bit, but 90MB seems
> really excessive.  How many time did pass between the initial clone
> and that subsequent pull?

As I used the kernel repo just for testing this behaviour in question
I did both things today. Timestamps tell that there were six hours
between the initial .keep pack and the new pack created by manual "git
gc".

> > Also, dangling objects are kept forever in .keep packs (which are
> > created with "git clone", for example).
> 
> A pack obtained via 'git clone' will never contain any dangling
> objects.

I think it can contain at some later point. For example, if a user first
fetches all the branches but later decides to track only one branch.
After deleting unneeded tracking branches and expiring the reflog
there'll be dangling objects in the original .keep pack created with
"git clone".
