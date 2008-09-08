From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 08 Sep 2008 10:17:40 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809081008330.23787@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
 <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
 <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
 <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
 <alpine.LFD.1.10.0809071304130.23787@xanadu.home>
 <9e4733910809071333t57d03257m34fd6a752e40177e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:18:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KchZt-0008SI-Kx
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbYIHORr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbYIHORq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:17:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53149 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYIHORq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:17:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6V00985RPG4IM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 08 Sep 2008 10:17:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910809071333t57d03257m34fd6a752e40177e@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95251>

On Sun, 7 Sep 2008, Jon Smirl wrote:

> On 9/7/08, Nicolas Pitre <nico@cam.org> wrote:
> > Please have a look at commit eac12e2d4d7f.  This fix improved things for
> >  my gcc repack tests.
> 
> Do you have any test numbers for something like a 2000 delta chain
> before and after?

What kind of number do you want?

Before that change I wasn't able to repack an already tightly packed 
(about 340MB) gcc repository on my machine while the same but sparsely 
packed (3GB or so) repository could be repacked just fine.

> You can get to Mozilla CVS with rsync.
> https://wiki.mozilla.org/How_to_Create_a_CVS_Mirror
> I think it was the master Mozilla makefile with the 2000 deltas.
> The whole repo is 15GB so you probably just want the Makefile,v

I have a test Mozilla repo dating back to the time you were playing with 
it too (I think).  Its directory date is 2007-04-12.  It was quite 
tightly packed already, but I just ran a "git repack -a -d -f 
--window=100 --depth=2000" on it and now have a 380MB pack file for it.


Nicolas
