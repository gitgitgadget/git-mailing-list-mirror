From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Tue, 21 Apr 2009 13:28:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904211319570.6741@xanadu.home>
References: <cover.1240115957.git.cloos@jhcloos.com>
 <d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
 <alpine.LFD.2.00.0904210054190.6741@xanadu.home>
 <m3skk2szgv.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwJn0-0005on-Bg
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 19:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZDUR2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 13:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbZDUR2L
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 13:28:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11777 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbZDUR2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 13:28:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIG00G2DOISIAE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Apr 2009 13:28:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3skk2szgv.fsf@lugabout.jhcloos.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117140>

On Tue, 21 Apr 2009, James Cloos wrote:

> >>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:
> 
> Nicolas> On Sun, 19 Apr 2009, James Cloos wrote:
> >> When progress.c:throughput_string() is called, the variable total
> >> invariably has its twelve least significant bits set.  Ie, it is
> >> always the case that:
> >> 
> >> total & 0xFFF == 0xFFF
> 
> Nicolas> Could you please explain ow you come to that conclusion?
> 
> Empirical evidence.
> 
> Even since the current progress was added, it has always shown nn.99 KiB
> in that range.  I added an extra snprintf(3) to show total in hex and it
> always ends in FFF.

Empirical evidence on my side shows the opposite.  I just did a fetch in 
my kernel repo and got:

   Receiving objects: 100% (1373/1373), 223.36 KiB, done.

> I presume the progress function is getting called just before total hits
> a page boundry.  In any case, the empirical evidence is clear.  And only
> even seeing .99 is annoying.  Hense the proposed patch.

I must NACK your patches.  Presumptions are not good enough 
justification for such a change, especially if results can't be 
reproduced.  That doesn't mean the code is completely bug free of 
course, but finding the source of the bug affecting you would be a far 
better course of action than simply turning our back on it.  Maybe you 
can tell us more about your environment?


Nicolas
