From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 09:39:05 -0400
Message-ID: <81E2B4A6-3591-418D-9448-47648AF4A687@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain> <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com> <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net> <6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com> <Pine.LNX.4.64.0604220846040.2215@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 21:51:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXO92-0004gn-El
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWDVTvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWDVTvt
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:51:49 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58051 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751094AbWDVTvs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 15:51:48 -0400
Received: from nile.gnat.com (nile.gnat.com [205.232.38.5])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MDdcSt003476
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 13:39:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id D227448CCB3;
	Sat, 22 Apr 2006 09:39:07 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 13938-01-3; Sat, 22 Apr 2006 09:39:07 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 8BA1048CC17;
	Sat, 22 Apr 2006 09:39:07 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604220846040.2215@localhost.localdomain>
To: Nicolas Pitre <nico@cam.org>
X-Mailer: Apple Mail (2.749.3)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19048>


On Apr 22, 2006, at 08:51, Nicolas Pitre wrote:
> First, pack-objects tries to find the best object combinations
> producing the smallest delta.  Then there is a second pass
> where the best delta are actually written out.  When that
> message appears that means the delta size for the same object
> pair does not match between those two passes.

OK, thanks for that info. There are very few comments in the
code, or specs of either the file format used, or
for function arguments. I'll look a the code again with this
info.

What is the exact role of the max_size parameter that is
passed to diff_delta? I took it to mean return 0 if
the size of the delta would be bigger than max_size and
max_size is nonzero.

I only set *delta_size when returning a nonzero delta.

   -Geert
