From: Nicolas Pitre <nico@cam.org>
Subject: Re: Compression speed for large files
Date: Mon, 03 Jul 2006 10:33:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
References: <loom.20060703T124601-969@post.gmane.org>
 <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
 <44A91C7A.6090902@fys.uio.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 16:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxPUL-00081y-CN
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 16:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGCOdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWGCOdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 10:33:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:5195 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751191AbWGCOdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 10:33:15 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1U003Q40FEKU70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Jul 2006 10:33:14 -0400 (EDT)
In-reply-to: <44A91C7A.6090902@fys.uio.no>
X-X-Sender: nico@localhost.localdomain
To: Joachim Berdal Haga <cjhaga@student.matnat.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23179>

On Mon, 3 Jul 2006, Joachim Berdal Haga wrote:

> Alex Riesen wrote:
> > On 7/3/06, Joachim B Haga <cjhaga@fys.uio.no> wrote:
> > > So: is it a good idea to change to faster compression, at least for larger
> > > files? From my (limited) testing I would suggest using Z_BEST_COMPRESSION
> > > only for small files (perhaps <1MB?) and
> > > Z_DEFAULT_COMPRESSION/Z_BEST_SPEED for
> > > larger ones.
> > 
> > Probably yes, as a per-repo config option.
> 
> I can send a patch later. If it's to be a per-repo option, it's probably too
> confusing with several values. Is it ok with
> 
> core.compression = [-1..9]
> 
> where the numbers are the zlib/gzip constants,
>   -1 = zlib default (currently 6)
>    0 = no compression
> 1..9 = various speed/size tradeoffs (9 is git default)

I think this makes a lot of sense, although IMHO I'd simply use 
Z_DEFAULT_COMPRESSION everywhere and be done with it without extra 
complexity which aren't worth the size difference.


Nicolas
