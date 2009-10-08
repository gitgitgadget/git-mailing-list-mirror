From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git log -S not finding all commits?
Date: Fri, 09 Oct 2009 07:02:13 +0900
Message-ID: <20091009070213.6117@nanako3.lavabit.com>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Fri Oct 09 00:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw151-00087i-DL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 00:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbZJHWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756944AbZJHWCu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 18:02:50 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41934 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756090AbZJHWCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 18:02:49 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id AD0F411B8E8;
	Thu,  8 Oct 2009 17:02:13 -0500 (CDT)
Received: from 9973.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 0TJ3MIDR1WEN; Thu, 08 Oct 2009 17:02:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=EKot8Z3AhttzcS7KqNNTQ+kyNtaoa1FLMTmgopF/Ke/qvF/O9KvLHkC6+NgAhIvchXZ07ceKZI+cOMX4ZNdpitQYPVSAO2IzkJl7P0oNGJK5HsOYie4k9pNlyW+PsplJUJdmHngwG6K1hobX6eZDHe99k5KTxijN50Co6AKMCKw=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7ae12651.522df17b.4acda0f5.21a31@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129717>

Quoting Daniel <mjucde@o2.pl>

> $ git version
> git version 1.6.4.4
> $ mkdir a && cd a && git init
> $ echo "Free data" > a
> $ git add a
> $ git commit -m1
> $ echo "Free data allocated by other function" > a
> $ git commit -a -m2
> $ PAGER=cat git log -S'Free' --oneline
> 2f34241 1
>
> I would expect "git log" to show both 1 and 2 commit, but it prints only 1.
>
> Is it the correct behavior?

Junio described how various features in git were invented to realize the goal of "Linus's ultimate content tracking" in his blog http://gitster.livejournal.com/35628.html (and he extended on the article in a chapter in his book that was published in Japan last month).

The "pickaxe" search is one of such components. It is meant to be given the block of lines you are interested in the newer version and used to find the commit that changes anything in the given block of lines. For details, see his blog article (item no. 3) at the above URL (and other items as well, if you are interested in learning the history of other notable features).

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
