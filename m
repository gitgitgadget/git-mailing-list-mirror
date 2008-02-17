From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 17 Feb 2008 13:44:01 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802171335470.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3y79nb8xk.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0802142054080.30505@racer.site>
 <200802142300.01615.jnareb@gmail.com>
 <alpine.LSU.1.00.0802142334480.30505@racer.site>
 <20080214235129.GU27535@lavos.net>
 <alpine.LSU.1.00.0802150007480.30505@racer.site>
 <alpine.LFD.1.00.0802142032030.2732@xanadu.home>
 <20080217081841.GS24004@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Downing <bdowning@lavos.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoVE-0007W9-Ht
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYBQSoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYBQSoE
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:44:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17153 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYBQSoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:44:02 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWE00B6VC1D6L10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 17 Feb 2008 13:44:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080217081841.GS24004@spearce.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74162>

On Sun, 17 Feb 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > 
> > I should really come around to fixing packed_object_info_detail() for 
> > the OBJ_OFS_DELTA case one day.
> 
> Please don't.
> 
> Obtaining the SHA-1 of your delta base would require unpacking your
> delta base and then doing a SHA-1 hash of it.  Or alternatively
> doing a search through the .idx for the object that starts at the
> requested OFS.

I intended to use the pack index of course.  And the code already exists 
in pack-objects as find_packed_object().

> Either way, its really expensive for a minor detail
> of output in verify-pack.

Not _that_ expensive actually.  Like I say, in pack-objects we do it all 
the time.

> But if you are going to do that, you may also want to fix the
> "*store_size = 0 /* notyet */" that's like 5 lines above.  :)

Yeah, that's easy too.


Nicolas
