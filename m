From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Don't allow newlines to occur in $Id:$ collapse
Date: Fri, 25 May 2007 09:47:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705250942500.3366@xanadu.home>
References: <200705251412.06196.andyparkins@gmail.com>
 <200705251413.42389.andyparkins@gmail.com>
 <20070525132800.GH6667@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Joshua N Pritikin <jpritikin@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 15:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hra8O-0003Ln-5u
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXEYNrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXEYNrH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:47:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14744 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbXEYNrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:47:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIL0084KNMGBG20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 09:47:04 -0400 (EDT)
In-reply-to: <20070525132800.GH6667@always.joy.eth.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48374>

On Fri, 25 May 2007, Joshua N Pritikin wrote:

> On Fri, May 25, 2007 at 02:13:42PM +0100, Andy Parkins wrote:
> > If a newline ever made it into an repository-side expanded $Id$ field,
> > the keyword would still be detected as a keyword and collapsed, before
> > rexpansion, e.g.
> > 
> >  $Id: all of this text would be removed, even if there
> >  were a newline in the middle of it$
> > 
> > This patch catches newlines in this case and abandons treating this as a
> > keyword expansion, this text would be left untouched in the working
> > checkout.
> 
> That's better but I would error out instead of silently ignoring it.
> Your choice.

Erroring out in such a case would simply make the system too obnoxious.

I don't think it is really worth aborting a commit just because you have 
a bad $Id:$ in one of your file.


Nicolas
