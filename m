From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG?] 'git verify-pack -v' on multiple packs fails for all but
 the first pack
Date: Fri, 22 Aug 2008 09:49:50 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808220949080.1624@xanadu.home>
References: <200808221439.31219.johan@herland.net>
 <200808221527.21971.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWX2c-00025Z-Ph
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYHVNt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbYHVNt5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:49:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53866 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYHVNt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:49:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K60003UW9281780@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Aug 2008 09:49:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200808221527.21971.johan@herland.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93298>

On Fri, 22 Aug 2008, Johan Herland wrote:

> On Friday 22 August 2008, Johan Herland wrote:
> > (I don't have time to look into this right now, but will do so later
> > if nobody comes up with a solution in the meantime...)
> >
> > When running 'git verify-pack -v' on multiple packs (.idx files), it
> > fails for all packs, except the first, with exit code 128, and the
> > following single line:
> >
> > 	fatal: internal error: pack revindex fubar
> >
> > This does not happen when given only a single pack, or when given
> > multiple packs, but without '-v' option.
> >
> > To reproduce, simply do:
> >
> > 	git verify-pack -v .git/objects/pack/*.idx
> >
> > in any repo with more than one pack file.
> >
> > This happens with a fairly current 'next' (1.6.0.96.g2fad1). AFAICS,
> > it also happens in v1.6.0.
> 
> Bisection point to this commit:
> 
> commit 1f5c74f6cf918d317c73b328dcd4cf6f55c44d8a
> Author: Nicolas Pitre <nico@cam.org>
> Date:   Mon Jun 23 21:22:14 2008 -0400
> 
>     call init_pack_revindex() lazily

I'll have a look later today.


Nicolas
