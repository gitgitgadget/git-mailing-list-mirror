From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 10:41:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705271039170.3366@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <alpine.LFD.0.99.0705262223540.3366@xanadu.home>
 <56b7f5510705262131g2d4186a0q605abbcea624d42d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 16:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJwP-0002Rk-BY
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbXE0Ols (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXE0Ols
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:41:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55868 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbXE0Olr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:41:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIP0002PFHGJWB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 May 2007 10:41:40 -0400 (EDT)
In-reply-to: <56b7f5510705262131g2d4186a0q605abbcea624d42d@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48557>

On Sat, 26 May 2007, Dana How wrote:

> On 5/26/07, Nicolas Pitre <nico@cam.org> wrote:
> > In other words, I think the naughty blob could simply be recognized as
> > such and be referenced in a special list instead of being written out
> > initially.  Then when everything is believed to be written, the special
> > list can be walked to force write those naughty blob at last.  No need
> > to modify the current object order.
> This works as long as a naughty blob can't be a delta base for a nice blob
> (causing it to be pushed out early by the recursion in write_one()).
> I think that's a reasonable and understandable restriction.

Sure.  Or the delta can inherit the naughty property if its base is also 
naughty, which solves the problem nicely.


Nicolas
