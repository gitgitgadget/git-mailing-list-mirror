From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 13/10] tests for various pack index features
Date: Wed, 11 Apr 2007 08:57:09 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704110850010.28181@xanadu.home>
References: <alpine.LFD.0.98.0704101607390.28181@xanadu.home>
 <7vr6qrr51r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbcO5-0006DO-RL
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 14:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbXDKM5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXDKM5W
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 08:57:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15625 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbXDKM5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 08:57:21 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGC00LY03ZADJG0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Apr 2007 08:57:10 -0400 (EDT)
In-reply-to: <7vr6qrr51r.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44236>

On Tue, 10 Apr 2007, Junio C Hamano wrote:

> > +     for i in `seq -w 100`
> > +     do
> > +         echo $i >file_$i &&
> > +         dd if=/dev/urandom bs=8k count=1 >>file_$i &&
> > +         git-update-index --add file_$i || return 1
> > +     done &&
> 
> Is there a way for our tests to be a bit more stable than
> urandom?  I saw on the first run fsck was OOM-killed, but the
> second and subsequent run did not.  It's a bit hard to diagnose.

The problem here is that I really need large amount of random data that 
doesn't compress nor delta between objects.

Hmmm what we need is a random data generator that always produces the 
same thing.  I'll hack something to replace urandom.


Nicolas
