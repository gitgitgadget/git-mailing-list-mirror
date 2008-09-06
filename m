From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: file deletion in index lost after checkout -b
Date: Sat, 6 Sep 2008 13:11:08 -0400
Message-ID: <20080906171108.GA10924@jabba.hq.digizenstudio.com>
References: <20080901034414.GR6619@jabba.hq.digizenstudio.com> <7vljy7xgs5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 19:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc1Km-0005st-06
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 19:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYIFRLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYIFRLU
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 13:11:20 -0400
Received: from k2smtpout01-01.prod.mesa1.secureserver.net ([64.202.189.88]:41225
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752235AbYIFRLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 13:11:20 -0400
Received: (qmail 14294 invoked from network); 6 Sep 2008 17:11:17 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-01.prod.mesa1.secureserver.net (64.202.189.88) with ESMTP; 06 Sep 2008 17:11:15 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 2E388100A22;
	Sat,  6 Sep 2008 17:11:15 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VoEZdvbl6Iti; Sat,  6 Sep 2008 13:11:09 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-133-176.dc.dc.cox.net [70.174.133.176])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 8E67410008B;
	Sat,  6 Sep 2008 13:11:09 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 9259148E9A; Sat,  6 Sep 2008 13:11:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vljy7xgs5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95082>

On Thu, Sep 04, 2008 at 11:12:26PM -0700, Junio C Hamano wrote:
> [jc: please redirect an answer _meant for you_ off to the list with M-F-T header]

I changed mutt to not use M-F-T with the git list at all. Hope this one
turns out better.

> > The deletion of 2.txt appears lost during 'checkout -b foo', while the
> > modification and addition were both brought over. Is it a bug?
> 
> This behaviour is unchanged since early June 2005.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/4641/focus=4646
> 
> This is exactly the case marked as *0*, which both Linus and I said "it
> feels somewhat wrong but otherwise we cannot start from an empty index".
> 
> We may want to do better this time around, though.

I have since found out that:

1. file deletions in the working directory but not in index would not be forgotten. That
makes "file deletions in index" case rather a corner one.

2. "checkout -b -m" would do the right thing.

Cheers.
-- 
Jing
