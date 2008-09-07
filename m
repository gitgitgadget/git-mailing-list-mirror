From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Sun, 07 Sep 2008 13:08:02 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809071304130.23787@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
 <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
 <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
 <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcNlL-0006nQ-IQ
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbYIGRIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbYIGRIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:08:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12605 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYIGRIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:08:15 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6U00IKE4XERT60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Sep 2008 13:08:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95150>

On Sun, 7 Sep 2008, Jon Smirl wrote:

> On 9/7/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> >  On Sat, 6 Sep 2008, Jon Smirl wrote:
> >  >
> >
> > > When I was playing with those giant Mozilla packs speed of zlib wasn't
> >  > a big problem. Number one problem was the repack process exceeding 3GB
> >  > which forced me to get 64b hardware and 8GB of memory. If you start
> >  > swapping in a repack, kill it, it will probably take a month to
> >  > finish.
> >
> >
> > .. and you'd make things much much WORSE?
> 
> My observations on the Mozilla packs indicated that the problems were
> elsewhere in git, not in the decompression algorithms. Why does a
> single 2000 delta chain take 15% of the entire pack time? Something
> isn't right when long chains are processed which triggers far more
> decompressions than needed.

Please have a look at commit eac12e2d4d7f.  This fix improved things for 
my gcc repack tests.


Nicolas
