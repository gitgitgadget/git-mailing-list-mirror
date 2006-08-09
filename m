From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn added files to my commit?!
Date: Wed, 9 Aug 2006 06:16:50 -0700
Message-ID: <20060809131649.GA3152@localdomain>
References: <m2vep7yqzh.fsf@gmail.com> <20060805211337.GA31264@hand.yhbt.net> <m2fygazbdc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 09 15:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAnvk-0006K4-Jp
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 15:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWHINQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 09:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWHINQx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 09:16:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51937 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750754AbWHINQx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 09:16:53 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2C6357DC029;
	Wed,  9 Aug 2006 06:16:50 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed,  9 Aug 2006 06:16:50 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m2fygazbdc.fsf@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25120>

Sorry for the delayed response; and furthermore, I've barely slept the
past few days, so don't expect full coherency.

Seth Falcon <sethfalcon@gmail.com> wrote:
> [cc'ing the list in case others are seeing similar, etc]
> 
> I think this is related to git-svn eol handling.

It is... git-svn is issuing 'svn revert' before running 'svn up' which
means it's changing newlines between git commits.

I can't remember exactly why manual eol handling was needed in git-svn,
but I think it had to do with disabling keyword expansion and copying
from the original text-base files.  Of course, the 'svn revert' command
is there for a reason, too (looking at the comment in git-svn).

Perhaps getting rid of keyword killing and accepting expansions with the
command-line client is the simplest and safest way to go.

I've been using the SVN:: libraries exclusively for a while now and all
seems well, save for initial checkouts or big commits which are
significantly slower in some cases (I think using SVN::Delta for
downloads should fix this).

-- 
Eric Wong
