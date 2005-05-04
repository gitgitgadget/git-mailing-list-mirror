From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: commit-id fails after cg-init
Date: Wed, 04 May 2005 11:14:28 -0400
Message-ID: <4278E6D4.6060807@dwheeler.com>
References: <1115150585.28520.11.camel@dv> <20050503211301.GA15995@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>,
	Joel.Becker@oracle.com
X-From: git-owner@vger.kernel.org Wed May 04 17:09:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTLTw-0008Oj-59
	for gcvg-git@gmane.org; Wed, 04 May 2005 17:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVEDPOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 11:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEDPOh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 11:14:37 -0400
Received: from aibo.runbox.com ([193.71.199.94]:34511 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261882AbVEDPOd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 11:14:33 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DTLZy-0000xt-2n; Wed, 04 May 2005 17:14:26 +0200
Received: from [129.246.254.14] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DTLZx-0001wn-Om; Wed, 04 May 2005 17:14:25 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503211301.GA15995@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Joel Becker said:

> Well, cg-init in this case creates no objects.  I'd say,
>instead, it should create an empty tree object (representing a project
>with no files) and commit that.  That would be your initial commit, and
>would put something valid in heads/master.

That would actually make sense; commits would go all the way
back to the "empty tree" as the ultimate initial tree.

There's an interesting side-effect of this; I _think_ it's
fine but it might be worth thinking through. If all
new projects start with an empty tree, that creates a
"common root" that all projects can appeal to.
That means that in theory a merge between any two project root
trees can eventually find a common ancestor: the empty tree.
I _think_ that's okay... is it?

That also means that empty directories will end up with the
"empty tree" as well.  Is there a risk of multiple empty directories
causing problems later?  As far as I can tell, there aren't
any problems with that, and does seem logically sound.

--- David A. Wheeler



