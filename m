From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] compat: Add simplified merge sort implementation from glibc
Date: Sat, 2 Feb 2008 22:50:34 -0600
Message-ID: <20080203045033.GL26392@lavos.net>
References: <20080203011130.GK26392@lavos.net> <alpine.LSU.1.00.0802030231080.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 05:51:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLWoy-0001zI-2U
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 05:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbYBCEug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 23:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbYBCEug
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 23:50:36 -0500
Received: from mxsf01.insightbb.com ([74.128.0.71]:3173 "EHLO
	mxsf01.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbYBCEuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 23:50:35 -0500
X-IronPort-AV: E=Sophos;i="4.25,297,1199682000"; 
   d="scan'208";a="206666026"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf01.insightbb.com with ESMTP; 02 Feb 2008 23:50:34 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAIrWpEdKhvkY/2dsb2JhbACBWKp7
X-IronPort-AV: E=Sophos;i="4.25,297,1199682000"; 
   d="scan'208";a="197836287"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 02 Feb 2008 23:50:31 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 1F48C309F21; Sat,  2 Feb 2008 22:50:34 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802030231080.7372@racer.site>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72325>

On Sun, Feb 03, 2008 at 02:37:27AM +0000, Johannes Schindelin wrote:
> I should add that this is a stripped-down version of glibc's sort() (yes, 
> the GPL of glibc allows that we rip it, for all you license wieners out 
> there).
> 
> AFAIR the discussion about the different implementations of a sort 
> algorithm boiled down to one particular implementation being quicker than 
> what this patch has, but with dubious licensing, and the glibc 
> implementation without the modifications present in this patch being 
> slower.
> 
> So I would like this to go in, evidently, if only as a starting point for 
> people to play with sorting algorithms, to find the one which is optimal 
> for our general use (we have quite some uses where we put in _almost_ 
> sorted data, which seems to be the worst-case for many sorting 
> algorithms).

If this is what I am thinking of, the sort of dubious licensing was
faster than glibc's quicksort.  This patch, however, is simplified from
glibc's mergesort (which is what glibc uses for the qsort() call except
for very large arrays), and was determined to be faster than both.

See:

http://groups.google.com/group/msysgit/browse_frm/thread/3c2eb564b9d0a994

and the links from that thread for more information.

-bcd
