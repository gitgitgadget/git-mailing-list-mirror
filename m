From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 11:17:13 -0600
Message-ID: <20080212171713.GH27535@lavos.net>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LFD.1.00.0802110942310.2732@xanadu.home> <20080212082211.GE27535@lavos.net> <alpine.LFD.1.00.0802120910440.2732@xanadu.home> <20080212171403.GG27535@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOylS-0000xY-Pd
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbYBLRRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760016AbYBLRRQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:17:16 -0500
Received: from mxsf06.insightbb.com ([74.128.0.76]:46070 "EHLO
	mxsf06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759327AbYBLRRP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 12:17:15 -0500
X-IronPort-AV: E=Sophos;i="4.25,341,1199682000"; 
   d="scan'208";a="231144836"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf06.insightbb.com with ESMTP; 12 Feb 2008 12:17:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAF9jsUdKhvkY/2dsb2JhbACBWapo
X-IronPort-AV: E=Sophos;i="4.25,341,1199682000"; 
   d="scan'208";a="202512071"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 12 Feb 2008 12:17:13 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id ACF02309F21; Tue, 12 Feb 2008 11:17:13 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20080212171403.GG27535@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73676>

On Tue, Feb 12, 2008 at 11:14:03AM -0600, Brian Downing wrote:
> Sometimes I want a bounded window size with bounded memory usage; i.e. a
> maximum of 50 entries OR 256 megs worth.  That's for everyday repacking
> of my troublesome repository; without the window going down to less than
> 10 or so for the large files, it still takes way too long, but doing the
> whole thing at 10 makes for very poor packing.

(Yeah, the default depth is 10.  I admit to shooting from the hip a bit
in my description above, but I do really use that mode of operation, and
wouldn't like to lose it.)

-bcd
