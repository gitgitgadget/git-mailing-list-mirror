From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a' when no
 changes were added)
Date: Sat, 24 Apr 2010 15:09:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004241503370.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <20100424164247.GM3563@machine.or.cz>
 <alpine.LFD.2.00.1004241430300.7232@xanadu.home>
 <20100424185433.GN3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Apr 24 21:09:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5kjR-00072u-DS
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 21:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab0DXTJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 15:09:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48851 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0DXTJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 15:09:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L1E00DYZAJRXHA0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Apr 2010 15:09:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100424185433.GN3563@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145697>

On Sat, 24 Apr 2010, Petr Baudis wrote:

> On Sat, Apr 24, 2010 at 02:35:17PM -0400, Nicolas Pitre wrote:
> > In that case the deficiency is in the fact that no reflog preserves the 
> > intermediate state of the index, not the fact that you might be allowed 
> > to do it.  Strictly speaking there is no intermediate ref to log, but a 
> > synthetic commit could be created for this case just like a stash but 
> > stored in the current branch's reflog.
> 
> Possibly, but I don't see how is this better than the check - it is less
> user friendly, most importantly because user that has not seen this
> twice has no idea that anything *was* saved to a reflog.

Possibly.  But the fact that some data could be lost here is a flaw.  
The reflog is the safety net making sure that whatever the user does is 
not completely destructive.

> Are there valid user scenarios where you customize your index, then want
> to override that using -a without thinking twice?

Admittedly there aren't many.  And in those few hypothetical cases then 
requiring -f would be acceptable.


Nicolas
