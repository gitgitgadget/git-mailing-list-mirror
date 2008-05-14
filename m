From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Wed, 14 May 2008 16:29:31 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805141626070.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <20080512202414.GA8620@mithlond.arda.local>
 <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org>
 <20080513001252.GB29038@spearce.org>
 <alpine.LFD.1.10.0805132005550.23581@xanadu.home>
 <7vy76dperf.fsf@gitster.siamese.dyndns.org>
 <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
 <alpine.LFD.1.10.0805141247560.3019@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805141314440.3019@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Juergen Ruehle <j.ruehle@bmiag.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 14 22:30:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNcZ-0007b8-8b
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYENU3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 16:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYENU3f
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:29:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26981 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbYENU3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 16:29:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0V00GY1KX7NHQ1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 May 2008 16:29:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0805141314440.3019@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82145>

On Wed, 14 May 2008, Linus Torvalds wrote:

> Of course, the more aggressively we prune, the more we end up having to 
> depend on the fact that a commit that is in a pack that is marked "keep" 
> must *always* have everything that leads to it in that pack or others also 
> marked "keep". We effectively have that already (because we've always 
> pruned away the commits early), but it's a thing to keep in mind whenever 
> we prune even more aggressively.

I wonder if this is a good thing.  Such a rule would effectively put 
restrictions on how objects like big blobs could be distributed amongst 
many .keep packs.  I just wish we're not painting ourselves in a corner.


Nicolas
