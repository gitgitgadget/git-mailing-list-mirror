From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 21:15:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810312106310.13034@xanadu.home>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
 <20081031213114.GA21799@artemis.corp>
 <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
 <20081031232829.GC14786@spearce.org>
 <7v63n872bs.fsf@gitster.siamese.dyndns.org>
 <20081101001300.GE14786@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:16:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw56Q-0002cV-0w
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYKABPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYKABPS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:15:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20554 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYKABPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:15:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M00KFCRHAY7D0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 21:15:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081101001300.GE14786@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99699>

On Fri, 31 Oct 2008, Shawn O. Pearce wrote:

> I'm tempted to stick with int for the result type, but I don't
> want readers to confuse our result type of 0 == success, <0 ==
> failure with some case where we return a signed integral value as
> a result of a computation.

Does this actually happen ?

> I'm also debating the error handling.  Do we return the error
> code as the return value from the function, or do we stick it into
> some sort of thread-global like classic "errno", or do we ask the
> application to pass in a structure to us?

Passing a structure pointer for errors is adding overhead to the API in 
all cases, please don't do that.
Both the negative code and errno style are lightweight in the common "no 
error" case.  The errno style is probably more handy for those functions 
returning a pointer which should be NULL in the error case.


Nicolas
