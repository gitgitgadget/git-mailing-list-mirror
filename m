From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 14:06:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905191403090.3301@localhost.localdomain>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain> <4A13030D.8000000@nortel.com>
 <alpine.LFD.2.01.0905191307320.3301@localhost.localdomain> <4A131D16.1030001@nortel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6WX6-0005Mg-IP
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 23:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbZESVHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZESVHL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 17:07:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42046 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754257AbZESVHH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 17:07:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JL6eZ8012095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 May 2009 14:06:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JL6dBi002645;
	Tue, 19 May 2009 14:06:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A131D16.1030001@nortel.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119569>



On Tue, 19 May 2009, Chris Friesen wrote:
> 
> The tagging would be done only by the "official" build process (which
> pulls from an "official" repository), not by each designer.  Typically
> the official builds would be done weekly, more frequently if requested.

Well, you can tag when you do that official build. Do you really do 
"official" builds from all branches? That sounds a bit insane.

Remember: you don't have to tag whatever is the "top" - tagging can happen 
later. Tagging at build-time is perfectly fine.

In fact, I'd suggest going even further. Don't tag the source branch when 
you build - tag it after it has passed whatever testing you do (I hope you 
_do_ have some extensive test-suite before release), and as you actually 
make it public (or whatever you do). Only at _that_ point, tag the tree 
with "release-$branch-$date" or something like that.

Remember: you don't have to tag the top-of branch. You can tag any commit, 
after-the-fact. So even if you've done other development since, just make 
sure to tag the commit you actually built and tested.

		Linus
