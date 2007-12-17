From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 16:45:26 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
 <m3fxy5qwbq.fsf@roke.D-201>
 <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
 <20071214215206.GB7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
 <20071214223957.GC7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
 <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <7v3au16myj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:45:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Nma-000079-PO
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763068AbXLQVp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXLQVp3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:45:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27120 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766006AbXLQVp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:45:27 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT700EPVR3QPGG0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Dec 2007 16:45:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3au16myj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68631>

On Mon, 17 Dec 2007, Junio C Hamano wrote:

> This is mostly spilt milk under the bridge now, but I have to mildly
> disagree.
> 
> If we had core.usedeltabaseoffset instead of repack.usedeltabaseoffset,
> and made the format negotiation in fetch-pack protocol pay attention to
> that variable, Joel's coworker did not have to suffer if the repository
> explicitly asked OFS_DELTA not to be used.
> 
> Instead we unconditionally said "if you are downloading with the new
> client, we assume you would never be using older client to access that
> repository locally, if you did so, you are screwed."
> 
> IOW, I think e4fe4b8ef7cdde842a9e5e2594d0fba1367d9dd3 (let the GIT
> native protocol use offsets to delta base when possible) could have been
> a bit more careful in this respect.

Probably.  But this can hardly be called a "corruption" since nothing 
was actually lost, rather an incompatibility problem.

If, on the other hand, the latest Git version wasn't able to read it 
either then this is a different matter entirely.


Nicolas
