From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 19:16:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910151912470.20122@xanadu.home>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 01:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyZfA-0005qj-OW
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 01:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763264AbZJOXQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763249AbZJOXQ4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 19:16:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46045 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763189AbZJOXQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 19:16:55 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRK00JIEWN1CFF0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 19:16:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130438>

On Thu, 15 Oct 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >     $ git checkout origin/next ;# ditto
> >     $ git symbolic-ref HEAD
> >     refs/remotes/origin/next
> 
> Ok, after reading Daniel's message to remind us that "git fetch" after
> this will get us into trouble, I agree that detaching HEAD is inevitable.

Either the fetch should be refused just like a commit would, or HEAD 
gets detached automatically in that case.  Probably the former would be 
less confusing, otherwise the user might expect to see the updated 
remote branch after the fetch and not understand that a detached HEAD 
remained on the previous remote branch state.


Nicolas
