From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 21:55:16 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711292142550.9605@xanadu.home>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <20071129150849.GA32296@coredump.intra.peff.net>
 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org>
 <20071130003512.GB11683@coredump.intra.peff.net>
 <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
 <20071130005852.GA12224@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixw2V-000243-Ec
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762237AbXK3CzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763920AbXK3CzT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:55:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34073 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761708AbXK3CzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 21:55:17 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00BYZTG48IF0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 21:55:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66611>

On Thu, 29 Nov 2007, Linus Torvalds wrote:

> Yes. I meant that we might as well keep all the git-xyz forms around, but 
> _only_ in the libexec directory (and make sure that the libexec directory 
> by default is *not* a binary directory), so that they'd normally not be 
> visible.
> 
> So then, people who want to use the old-fashioned git-xyz forms, because 
> they just really hate white-space or whatever, could choose to do one of 
> two things:
>  - either just change the default libexec directory to be the same as the 
>    binary install directory, and have all the git-xyz things in the same 
>    place they've always been.
>  - or just add $(gitlibexec) into their path.
> 
> but the default (which is what 99% of all people use) would be to not 
> show them. I also think that it makes sense to avoid wasting diskspace 
> with duplicate files, so in situations where you don't have hardlinks, 
> just don't install the git-xyz files at all by default (and again, maybe 
> we can have a option to the installer to do it for people who really are 
> very attached to the git-xyz format, and prefer to waste even a lot of 
> disk on it)
> 
> So I just think that the whole idiotic complaint that some people have 
> (that whole "git-<tab><tab>" shows "Display all 144 possibilities?" and 
> people are somehow using that as an argument that git is "complex") should 
> be something we strive to undo. I think the complaint is insane (because 
> the answer is "well, nobody forces you to _use_ all the power and scripts 
> we give you!"), but still, it's a complaint, so let's just assume the user 
> is right, and try to fix it.

Absolutely!

And despite Junio's appearance of some cowardliness on this issue :-)
I think we should have this right now instead of later. Like Junio said 
himself, this was planned for a while already, and poorly maintained 
external scripts are already failing due to other reasons anyway.


Nicolas
