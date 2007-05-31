From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] always start looking up objects in the last used pack first
Date: Wed, 30 May 2007 23:24:55 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705302320530.11491@xanadu.home>
References: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 31 05:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtbI8-0006ty-RZ
	for gcvg-git@gmane.org; Thu, 31 May 2007 05:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077AbXEaDY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 23:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbXEaDY7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 23:24:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12029 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077AbXEaDY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 23:24:58 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIV00AV2YTJGO20@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 May 2007 23:24:56 -0400 (EDT)
In-reply-to: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48798>

On Wed, 30 May 2007, Nicolas Pitre wrote:

> To test this I split the Linux repository into 66 packs and performed a
> "time git-rev-list --objects --all > /dev/null".  Best results are as 
> follows:
> 
> 	Pack Sort			w/o this patch	w/ this patch
> 	-------------------------------------------------------------
> 	recent objects last		26.4s		20.9s
> 	recent objects first		24.9s		18.4s
> 
> This shows that the pack order based on object age has some influence, 
> but that the last-used-pack heuristic is even more significant in 
> reducing object lookup.

For reference, the same operation on a fully packed into a single pack 
repository takes 17.1s.  So this looks damn good to me.


Nicolas
