From: Nicolas Pitre <nico@cam.org>
Subject: Re: git problem: pack has bad object at offset 77100841: inflate
 returned -3
Date: Tue, 12 Aug 2008 21:17:49 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808122111180.9984@xanadu.home>
References: <ace3f33d0808060015t25d9c21epc31e48e3c1d041b1@mail.gmail.com>
 <20080806143310.GB28231@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 03:19:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT50w-0005Oc-7Z
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 03:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbYHMBR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 21:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYHMBR4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 21:17:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21661 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYHMBR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 21:17:56 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5I002L6M9PDAH4@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Aug 2008 21:17:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080806143310.GB28231@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92162>

On Wed, 6 Aug 2008, Shawn O. Pearce wrote:

> srinivas naga vutukuri <srinivas.vutukuri@gmail.com> wrote:
> > remote: Counting objects: 879862, done.
> > remote: Compressing objects: 100% (156686/156686), done.
> > fatal: pack has bad object at offset 77100841: inflate returned -3
> > fatal: index-pack failed
> > 
> > while doing "git clone" of linux kernel of latest 2.6.27-rc2.
> > But am able to do the latest stable successfully.
> ...
> > I am using cygwin, git 1.5.6.4
> 
> Where are you cloning from?
> 
> This is an indication that the data sent to your system from the
> remote side is corrupt.  Possibly a bad network link?
> 
> Remote side corruption should have been detected by the remote
> server as it was writing the data out.  The message above however
> came from your client, so the server seems to be OK.

Well, not exactly.  The server (git pack-objects) does skip some data 
integrity validation that the client (git index-pack) is doing anyway in 
order to cut cycles on the server machine.


Nicolas
