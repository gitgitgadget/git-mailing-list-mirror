From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 19:18:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610181910440.1971@xanadu.home>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
 <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
 <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
 <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 01:19:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaKgg-0002hN-T5
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWJRXTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 19:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWJRXTA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:19:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39885 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750774AbWJRXS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 19:18:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00GDRU3MHHB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 19:18:58 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29296>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Wed, 18 Oct 2006, Junio C Hamano wrote:
> > 
> > It should not be hard to write another program that generates a
> > packfile like pack-object does but taking a thin pack as its
> > input.  Then receive-pack can drive it instead of
> > unpack-objects.
> 
> Give me half an hour. It should be trivial to make "unpack-objects" write 
> the "unpacked" objects into a pack-file instead.

If you use builtin-unpack-objects.c from next, you'll be able to 
generate the pack index pretty easily as well, as all the needed info is 
stored in the obj_list array.  Just need to append objects remaining on 
the delta_list array to the end of the pack, sort the obj_list by sha1 
and write the index.

Pretty trivial indeed.


Nicolas
