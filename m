From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] make the new block-sha1 the default
Date: Tue, 25 Aug 2009 13:33:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908251323280.6044@xanadu.home>
References: <alpine.LFD.2.00.0908242249420.6044@xanadu.home>
 <20090825041859.GA10033@coredump.intra.peff.net>
 <7vprakpett.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:33:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfztp-00076Q-KI
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 19:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbZHYRd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 13:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbZHYRd1
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 13:33:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54133 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbZHYRd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 13:33:27 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOY00ABD0RMM7O0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 25 Aug 2009 13:33:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vprakpett.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127031>

On Mon, 24 Aug 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Aug 24, 2009 at 11:04:37PM -0400, Nicolas Pitre wrote:
> >
> >> ... and remove support for linking against the openssl SHA1 code.
> >> 
> >> The block-sha1 implementation is not significantly worse and sometimes 
> >> even faster than the openssl SHA1 implementation.  This allows for
> >
> > Is there a reason not to leave the option of linking against openssl?
> 
> I think it is a valid question.  Why remove the _option_?

Indeed, there is no value in limiting the choice.

> I would certainly understand it if you made BLK_SHA1 the _default_, though.

Since this is a RFC, and because this is not a clear choice, I'll simply 
let others play with it and see for themselves.  Suffice to compile git 
with or without NO_OPENSSL defined.  Some people (such as Jeff) are 
finding the openssl SHA1 faster (irrespective of the -O0 issue), whereas 
Linus simply hammered on the block-sha1 version until it was faster than 
openssl for him (this is faster for me as well, on X86 and ARM).  Also 
those who initially found openssl to put a significant overhead on the 
dynamic linking should probably perform more measurements with and 
without NO_OPENSSL again.  If more positive results are presented then 
changing the default might make sense.


Nicolas
