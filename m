From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 18:05:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 18:06:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2VbB-00035Q-MT
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 18:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWGQQFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWGQQFa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 12:05:30 -0400
Received: from mail.gmx.net ([213.165.64.21]:35530 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750928AbWGQQF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 12:05:29 -0400
Received: (qmail invoked by alias); 17 Jul 2006 16:05:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 17 Jul 2006 18:05:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23974>

Hi,

On Mon, 17 Jul 2006, Linus Torvalds wrote:

> On Mon, 17 Jul 2006, Johannes Schindelin wrote:
> > 
> > But note that we usually use the whole contents of the mmap()ed file 
> > anyway.
> 
> Not for pack-files, though. You may have a half-gigabyte pack-file, and 
> only use a small small fraction of it.

Right.

> (You also never really rename them, so windows should be fine for that 
> case)

So we could introduce a second mmap() which is normally the same as 
mmap(), except for windows, where it is a rename() and unlink() safe 
version of mmap() by reading the thing into RAM. Not very pretty.

Ciao,
Dscho
