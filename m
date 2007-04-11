From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] simple random data generator for tests
Date: Wed, 11 Apr 2007 13:52:33 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704111348040.28181@xanadu.home>
References: <alpine.LFD.0.98.0704111330120.28181@xanadu.home>
 <20070411174205.GQ5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbgzn-0005Bk-Nc
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 19:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbXDKRwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 13:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbXDKRwf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 13:52:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63679 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbXDKRwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 13:52:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGC000RCHNLPJC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Apr 2007 13:52:34 -0400 (EDT)
In-reply-to: <20070411174205.GQ5436@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44249>

On Wed, 11 Apr 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > ---
> >  Makefile         |    7 +++++--
> >  test-genrandom.c |   34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+), 2 deletions(-)
> >  create mode 100644 test-genrandom.c
> 
> A change to .gitignore would also be nice.  ;-)

Gah!

> > +	unsigned long count, next = 0;
> 
> What about wraparound?  Could this produce different results on a
> 32 bit system and a 64 bit system, due to the difference in size
> of unsigned long?

No, because the bits we extract are below 32 bits, and the multiply 
operation will always provide the same results in the low 32 bits 
regardless.


Nicolas
