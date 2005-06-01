From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: git-rev-list: proper lazy reachability
Date: Wed, 1 Jun 2005 21:02:08 +0200 (CEST)
Message-ID: <20050601190208.76289.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Wed Jun 01 21:04:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdYTB-0000Rf-1P
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 21:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFATEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVFATDr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 15:03:47 -0400
Received: from web26310.mail.ukl.yahoo.com ([217.146.176.21]:31933 "HELO
	web26310.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261259AbVFATCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 15:02:12 -0400
Received: (qmail 76291 invoked by uid 60001); 1 Jun 2005 19:02:08 -0000
Received: from [151.42.53.52] by web26310.mail.ukl.yahoo.com via HTTP; Wed, 01 Jun 2005 21:02:08 CEST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 31 May 2005, Linus Torvalds wrote:
> 
>>You should never see a parent before a child from git-rev-list.
> 
> 
> Actually, I take that back.
> 
...

> 
> The thing is, since B has such an "old" date, the traversal assumes that
> it is old and very low down in the tree, and that it's better off parsing
> other commits first, so it will never look more closely at B and notice
> that it has a parent that has already been parsed.
> 

If this is an exception, and I it is, peraphs can be treated in a special way.

As example, when adding a new parent to the pending list of parents to be processed in time-based
ordering, should be easy to inc a counter if  the last one is always the same, e.g. there is the
same very old node around, and check closer to it if the counter reach some allowed maximum.

I know it's a hack, and is not a solution in the general case, but also the last century developer
clock is very rare, more, it is a warning for a bad commit. 

Do not wait for the end of the toposort its a very big advantage for, e.g. GUI git viewers
launched on big trees with long histories.

Marco Costalba







	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
