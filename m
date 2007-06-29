From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] git add: respect core.filemode even with unmerged entriesin 
 the index
Date: Fri, 29 Jun 2007 08:57:05 +0200
Organization: eudaptics software gmbh
Message-ID: <4684AD41.9868C32F@eudaptics.com>
References: <20070625064017.GA2839@mellanox.co.il>  <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	     <20070625071752.GB15343@mellanox.co.il>  <Pine.LNX.4.64.0706250846200.4059@racer.site>
	    <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>  
	 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
	 <Pine.LNX.4.64.0706281506390.4438@racer.site> <4683C5D2.FDF4ED02@eudaptics.com>
	 <4683CA7A.7F8070D7@eudaptics.com> <Pine.LNX.4.64.0706281653260.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 29 08:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4APM-0007JC-GJ
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXF2G4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbXF2G4m
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:56:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:47893 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXF2G4l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:56:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I4APH-0001wK-LB; Fri, 29 Jun 2007 08:56:39 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8FDAE4E9; Fri, 29 Jun 2007 08:56:39 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.029
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51157>

Johannes Schindelin wrote:
> 
> When a merge left unmerged entries, git add failed to pick up the
> file mode from the index, when core.filemode == 0.
> 
> Noticed by Johannes Sixt.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
>         On Thu, 28 Jun 2007, Johannes Sixt wrote:
> 
>         > Johannes Sixt wrote:
>         >
>         > The deficiency is not in merge-recursive, but in 'git add'. The
>         > problem is that after a conflicted merge of an executable file
>         > 'git add' loses the +x bit even if core.filemode=false.
> 
>         How's that?

That's fine, thanks.

It covers the most common case that all three stages are in the index.
However, if only two stages are present, the file mode is still taken
from the file instead of from the index. As that easy to solve (at least
for the unambiguous case)?

-- Hannes
