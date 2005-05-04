From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 17:47:27 -0400
Message-ID: <DE5D04E8-B182-45B1-AB9A-6AA178005FFD@adacore.com>
References: <200505030657.38309.alonz@nolaviz.org> <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org> <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain> <200505041156.19499.mason@suse.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 23:51:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTRlP-0003Z8-7x
	for gcvg-git@gmane.org; Wed, 04 May 2005 23:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVEDV44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVEDV44
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 17:56:56 -0400
Received: from nile.gnat.com ([205.232.38.5]:64489 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S261748AbVEDV4f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 17:56:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP
	id D784A9655; Wed,  4 May 2005 17:56:31 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 13336-03-9; Wed,  4 May 2005 17:56:31 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP
	id BDB5B9822; Wed,  4 May 2005 17:56:30 -0400 (EDT)
In-Reply-To: <200505041156.19499.mason@suse.com>
To: Chris Mason <mason@suse.com>
X-Mailer: Apple Mail (2.728)
X-Virus-Scanned: by amavisd-new at nile.gnat.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 From your tests it would seem that the zdelta version is the only one
to provide a uniform improvement over plain git. As it also seems the
simplest approach, I wonder why the consensus is that using xdiff
would be better?

   -Geert

On May 4, 2005, at 11:56, Chris Mason wrote:
> I did two additional runs, first where I fixed the delta chain  
> length at 1 as
> in the zdelta patch.   In this mode, if it tried to diff against a  
> delta it
> would find the delta's parent and diff against that instead.  Even  
> though
> zdelta had the same speeds for applying patches as xdiff(1), zdelta  
> used
> significantly more cpu (53m vs 40m).
>
> The next run was with the patch I've attached below, it allows  
> chains up to 16
> deltas in length.
>                              git         zdelta       xdiff  
> (1)      xdiff(16)
> apply                  150m       117m       117m         104m
> checkout             4m30s      3m41      4m43s        7m11s
> checkout (hot)     56s           12s         14s             16s
> space usage        2.5G         1G           1.2G           800m
>

