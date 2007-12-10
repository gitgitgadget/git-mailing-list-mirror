From: Nicolas Pitre <nico@cam.org>
Subject: Re: dmalloc and leaks in git
Date: Mon, 10 Dec 2007 11:54:17 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101148250.555@xanadu.home>
References: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com>
 <alpine.LFD.0.9999.0712091251330.12046@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712100828590.12046@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ltx-0004ZG-Vb
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbXLJQyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXLJQyT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:54:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9596 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbXLJQyT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:54:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU00I63EYHOOL0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 11:54:18 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0712100828590.12046@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67735>

On Mon, 10 Dec 2007, Linus Torvalds wrote:

> 
> 
> On Sun, 9 Dec 2007, Linus Torvalds wrote:
> > 
> > For example, if you use
> > 
> > 	valgrind --tool=massif --heap=yes ...
> 
> I tried this on my copy of the gcc thing, but I didn't do the extreme 
> packing thing, so I never saw the 3.4GB usage. Massif just reported a 200M 
> heap, and about half of that was "add_object_entry".

So far, it seems that the problem occurs much more severely when you run 
'git repack -a -f' while using the already highly packed gcc repo as a 
starting point.

Remains to determine if it occurs only when the repack is threaded, or 
if that has no significance.


Nicolas
