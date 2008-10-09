From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH 1/2] Replace memset(0) with static initialization where
 possible
Date: Thu, 09 Oct 2008 17:12:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810091701380.26244@xanadu.home>
References: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0810091534430.26244@xanadu.home>
 <CqZt8k7g-Uov2ItkgRw6K65RC0ee37ZAckIrbwPLNwDiaHtigtevnA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko2pX-0001n3-JY
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbYJIVMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbYJIVMn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:12:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14586 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbYJIVMm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:12:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8H006Z0PK06WS0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Oct 2008 17:12:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <CqZt8k7g-Uov2ItkgRw6K65RC0ee37ZAckIrbwPLNwDiaHtigtevnA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97885>

On Thu, 9 Oct 2008, Brandon Casey wrote:

> Nicolas Pitre wrote:
> > So when claiming flexibility for the compiler to better optimize things, 
> > please make sure this is really what is happening through assembly dump 
> > inspection.
> 
> I didn't claim the compiler _would_ do a better job at optimizing if
> memset wasn't used (though my expectation is that it would do no worse,
> and I don't have assembly dumps to back that up).

My point is that such expectation might not always be true.

> I suggested it could
> give the compiler more flexibility. In some strange way you seem to
> agree with me and have given 3 examples of ways that compilers may
> optimize static initialization. :)

Actually the first example was a case of making things worse.

> Anyway, this is a nothing patch. There is no functional change.
> If readability is not improved, it is not worth applying. Of course, I
> don't plan on scanning through and converting all of the existing assignments
> which use { 0, } to use memset. I find a single step declaration/initialization
> simpler. Not sure why that seems to be the case in the git source for simple
> variables but not structures.

... because of that possible gcc making things worse I mentioned.


Nicolas
