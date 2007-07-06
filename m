From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 13:46:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061340350.4093@racer.site>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
 <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:53:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6nJm-0003up-Vd
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760947AbXGFMxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760144AbXGFMxn
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:53:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:34725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760708AbXGFMxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:53:42 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:53:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 06 Jul 2007 14:53:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pKbx5Q8op9ZKYqscSAdBNSq6yC/+NFhxGb0MVBI
	dRKJbquTNapfd0
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51748>

Hi,

On Thu, 5 Jul 2007, Daniel Barkalow wrote:

> What git-fetch and git-push care about is whether you have an entry 
> "remote.<name>.fetch" with a colon and stuff on the right of it. If so, 
> this is a pattern that is used to generate the duplicate branch heads 
> that you don't want. git clone sets it up to a default pattern 
> (refs/remotes/origin/*), and I don't think there's any way to make it 
> not do that, but you can just reconfigure it afterwards if you don't 
> like it.

Related, but not identical, is the problem illustrated in 
http://thread.gmane.org/gmane.comp.version-control.git/49888

IMHO there is a bug. IIUC git push first looks for common ref names on the 
local and remote side (yes, refs/remotes are excluded since v1.5.3-rc0~9, 
but the underlying problem is still there). Then it pushes them. But here, 
something seems to have gone wrong: refs/remotes/origin/HEAD is a symref. 
And the corresponding ref is updated. Should git-push not just _not_ 
update symrefs?

Ciao,
Dscho
