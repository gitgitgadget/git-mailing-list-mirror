From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] apply delta depth bias to already deltified objects
Date: Thu, 12 Jul 2007 11:44:58 -0500
Message-ID: <20070712164458.GC19073@lavos.net>
References: <alpine.LFD.0.999.0707120049120.32552@xanadu.home> <20070712152016.GB19073@lavos.net> <alpine.LFD.0.999.0707121146550.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:45:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91n0-0004hI-4g
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbXGLQpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 12:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbXGLQpK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:45:10 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:38725 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbXGLQpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 12:45:09 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 12 Jul 2007 12:45:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AutRAKX3lUZKhvbzRmdsb2JhbACBS4VfiAgBAQE+
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 5DC01309F31; Thu, 12 Jul 2007 11:44:58 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707121146550.32552@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52304>

On Thu, Jul 12, 2007 at 12:27:02PM -0400, Nicolas Pitre wrote:
> Better yet, the integer truncation error should be compensated for, with 
> this:
> 
>     max_size =
>         (trg_entry->delta_size * max_depth + max_depth - trg_entry->depth) /
>                     (max_depth - trg_entry->depth + 1);

Yep, with this, my degenerate case seems to find the optimum solution
(depth ~ 65) even at crazy maximum depths like 1000.

Looks good to me.

-bcd
