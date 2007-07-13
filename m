From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] reduce git-pack-objects memory usage a little more
Date: Thu, 12 Jul 2007 20:45:02 -0500
Message-ID: <20070713014502.GF19073@lavos.net>
References: <alpine.LFD.0.999.0707121703240.32552@xanadu.home> <20070713014228.GE19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 03:45:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ADb-0000DZ-PY
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 03:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbXGMBpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 21:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbXGMBpM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 21:45:12 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:37420 "EHLO
	asav09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbXGMBpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 21:45:11 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav09.insightbb.com with ESMTP; 12 Jul 2007 21:45:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AglXAO51lkZKhvbzRmdsb2JhbACBS4VfiAoBAQE+
Received: by mail.lavos.net (Postfix, from userid 1000)
	id AF865309F31; Thu, 12 Jul 2007 20:45:02 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070713014228.GE19073@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52354>

On Thu, Jul 12, 2007 at 08:42:28PM -0500, Brian Downing wrote:
> This patch breaks pack-objects pretty horribly:
> 
> :; PATH=~/src/git:$PATH /usr/bin/time ~/src/git/git-repack -a -d -f

[that's Git I'm repacking here]

> :; ls -l .git/objects/pack
> total 153916
> -r--r--r-- 1 bdowning bdowning   1312136 2007-07-12 20:39 pack-9ac926ee1f5810c434707d3f816f5ad2cbd14668.idx
> -r--r--r-- 1 bdowning bdowning 156130933 2007-07-12 20:39 pack-9ac926ee1f5810c434707d3f816f5ad2cbd14668.pack
> 
> chain length = 1: 6182 objects
> chain length = 2: 66 objects
> chain length = 3: 27 objects
> chain length = 4: 20 objects
> chain length = 5: 15 objects
> chain length = 6: 9 objects
> chain length = 7: 5 objects
> chain length = 8: 5 objects
> chain length = 9: 6 objects
> chain length = 10: 4 objects
> chain length = 11: 6 objects
> chain length = 12: 4 objects
> chain length = 13: 3 objects
> chain length = 14: 3 objects
> chain length = 15: 2 objects
> chain length = 16: 2 objects
> chain length = 17: 1 object
> chain length = 18: 1 object
> chain length = 19: 1 object

-bcd
