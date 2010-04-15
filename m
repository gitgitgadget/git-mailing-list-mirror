From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 15:48:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004151545240.7232@xanadu.home>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
 <20100415163607.GA4279@coredump.intra.peff.net>
 <7vhbnck618.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:48:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2V3G-0008BN-AX
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399Ab0DOTs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:48:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58538 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340Ab0DOTsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:48:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0X00GOVOCN5T60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Apr 2010 15:48:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vhbnck618.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145018>

On Thu, 15 Apr 2010, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think another way of addressing the same problem would be to redefine
> > "reachable" in this context as "reachable from any current ref".
> 
> I tend to agree, but I haven't thought through the case for entries that
> point at commits on detached HEAD.  My gut feeling is that unless they are
> connected to a real ref by now after all these expireunreachable days,
> they are "failed experiments" and deserve to get pruned, so "from any ref"
> would probably work well for them.

I'm a bit worried about this discussion.

What's the point of having a reflog for unreachable stuff if it is to be 
pruned faster than stuff that is already reachable without any reflog?


Nicolas
