From: David Miller <davem@davemloft.net>
Subject: Re: [ANNOUNCE] GIT 1.6.0-rc2
Date: Mon, 15 Sep 2008 11:25:45 -0700 (PDT)
Message-ID: <20080915.112545.193713350.davem@davemloft.net>
References: <20080807.052648.239243998.davem@davemloft.net>
	<20080913.013330.29519747.davem@davemloft.net>
	<20080915171240.GB4787@efreet.light.src>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peterz@infradead.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: bulb@ucw.cz
X-From: git-owner@vger.kernel.org Mon Sep 15 20:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfImu-0000W2-Le
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 20:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbYIOSZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 14:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbYIOSZw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 14:25:52 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60507
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752569AbYIOSZv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 14:25:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id BC631C8C17E;
	Mon, 15 Sep 2008 11:25:45 -0700 (PDT)
In-Reply-To: <20080915171240.GB4787@efreet.light.src>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95926>

From: Jan Hudec <bulb@ucw.cz>
Date: Mon, 15 Sep 2008 19:12:40 +0200

> On Sat, Sep 13, 2008 at 01:33:30 -0700, David Miller wrote:
> > Wouldn't it make sense to put the bindir into PATH when we try to do
> > execv_git_cmd()?  The code has already put the gitexecdir into the
> > PATH at this point.
> 
> I don't think it gets to execv_git_cmd(). Git on local side will run
>     ssh <host> git upload-pack
> and it's ssh that can't find git in ~/bin (or maybe it's still using the
> dashed form for backward compatibility; the argument stands either way).

That's not the case I'm running into.  The initial GIT execution
works, it's when GIT forks up sub processes and tries to execute other
things that problem show up.

I added tracing and on the ssh remote system, and my PATH had the
GIT exec dir in my path when the problem triggers.
