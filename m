From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 14:33:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605051431390.24505@localhost.localdomain>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
 <7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
 <7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
 <7vejz8z80p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 20:33:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc56y-0003Xb-Ed
	for gcvg-git@gmane.org; Fri, 05 May 2006 20:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWEESdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 14:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWEESdF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 14:33:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60481 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751207AbWEESdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 14:33:04 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYT000AK271JT70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 May 2006 14:33:01 -0400 (EDT)
In-reply-to: <7vejz8z80p.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19625>

On Fri, 5 May 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> +	delta = NULL;
> >> +	deflated = deflate_it(two->ptr, two->size, &deflate_size);
> >> +	if (one->size && two->size) {
> >> +		delta = diff_delta(one->ptr, one->size,
> >> +				   two->ptr, two->size,
> >> +				   &delta_size, deflate_size);
> >
> > Here you probably want to use deflate_size-1 (deflate_size can't be 0).
> 
> I am not sure if -1 is worth here.
> 
> The delta is going to be deflated and hopefully gets a bit
> smaller, so if we really care that level of detail, it might be
> worth to do (deflate_size*3/2) or something like that here, use
> delta with or without deflate whichever is smaller, and mark the
> uncompressed delta with a different tag ("uncompressed delta"?).
> And for symmetry, to deal with uncompressible data, we may want
> to have "uncompressed literal" as well.

Nah...  Please just forget that.  ;-)


Nicolas
