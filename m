From: Nicolas Pitre <nico@cam.org>
Subject: Re: Should "pull --rebase" try to be a little cleverer?
Date: Mon, 21 Jan 2008 11:03:37 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801211054320.20753@xanadu.home>
References: <alpine.LSU.1.00.0801211542150.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGz8O-0000jH-Ep
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 17:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYAUQDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 11:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbYAUQDs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:03:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51662 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYAUQDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 11:03:48 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JV000HCI4LWYS60@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Jan 2008 11:03:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0801211542150.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71287>

On Mon, 21 Jan 2008, Johannes Schindelin wrote:

> Hi,
> 
> last night an idea hit me: if I "git pull --rebase blabla master", it 
> could be that "blabla" decided to rebase "master" already, and ATM this 
> would lead to quite a few conflicts, since commits that were not mine were 
> rewritten.

Indeed.

> However, if we already have refs/remotes/blabla/master, we could DWIM the 
> --rebase call to
> 
> 	git rebase --onto FETCH_HEAD refs/remotes/blabla/master

I was believing this was already the case.  Mind you, I never verified 
it.

I think the best is really to have the equivalent of:

	git fetch blabla/master
	git rebase --onto blabla/master blabla/master@{1} HEAD


Nicolas
