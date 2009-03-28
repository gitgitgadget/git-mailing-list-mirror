From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: How do I force git to forget about merging a binary file that is to  stay deleted on the target branch?
Date: Sat, 28 Mar 2009 19:23:00 +0900
Message-ID: <20090328192300.6117@nanako3.lavabit.com>
References: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 11:25:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnVj5-00038G-BG
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 11:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbZC1KXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 06:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZC1KXp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 06:23:45 -0400
Received: from karen.lavabit.com ([72.249.41.33]:57059 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbZC1KXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 06:23:44 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id A559D11B7A0;
	Sat, 28 Mar 2009 05:23:42 -0500 (CDT)
Received: from 3723.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 68U80YIFNT7U; Sat, 28 Mar 2009 05:23:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=gI0pwyHqsNwyCNhgY8ZZS64XFEW0IYt98zP6spJHAehp+iPg1r3+29M95Bma7JZMBSFPKPOQ4A1NxqY+nPTe5Rps5X88dem4oVvxkiJzHu3THrF9wpOa1WA9DMD7Zxd7PbG/I+tASrm6DMsx+/Yu/DLlKQS3VP4f+SAp1X/Cn/c=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114945>

Quoting Brent Goodrick <bgoodr@gmail.com>:

> How do I commit a merge but force git to forget about merging one file
> that I don't want on the target branch, when it is binary, and when it
> was changed on the source branch, but was deleted on the target branch
> (and should stay deleted on the target branch)?

I think the standard answer is "you don't".

Instead of using only two branches ('home' and 'work'), you use one common branch (perhaps 'master') that is meant to hold the changes and files that are sharable between two places, and maintain two branches ('home' and 'work') that are forked from the common branch. You treat them as if they are release branches and employ the "Never merging back" workflow (see gitster's journal around middle of January this year).

At home (or at work), you record your changes that are also relevant to the other place to the common branch ('master'), and you record changes that are specific to the location to either 'home' or 'work'. And merge 'master' to 'home' and 'work' as necessary, but never merge 'home' nor 'work' to anything else.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
