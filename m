From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/6] packed deltas with offset to base instead of sha1
Date: Thu, 21 Sep 2006 00:04:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609202350450.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 06:04:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQFnR-0006Ej-Rn
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 06:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWIUEET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 00:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWIUEES
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 00:04:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65504 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751197AbWIUEEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 00:04:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5X007LXCN2T700@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 00:04:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27442>

The following patches are the result of my work to allow deltas to have
their base specified as an offset within a pack instead of a 20 byte 
sha1.

This turned to be somewhat more involved than I originally expected. 
Given the relative pack reduction resulting from that, I might have 
decided against doing this if I had known beforehand how much work was 
needed.

But since it is done now I think it is worth merging nevertheless.  Some 
parts are still pure code cleanups anyway.

Overall the larger projects are likely to benefit more as they have a 
larger proportion of deltas.  On the historic Linux archive the pack 
reduction is about 5%.


Nicolas
