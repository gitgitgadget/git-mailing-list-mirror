From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 22:48:38 +0000
Organization: linutronix
Message-ID: <1115851718.22180.153.camel@tglx>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
	 <1115850619.22180.133.camel@tglx>
	 <2853.10.10.10.24.1115850996.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:41:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzsR-0002MK-F2
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEKWr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEKWr6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:47:58 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64898
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261295AbVEKWrs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:47:48 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 8273565C003;
	Thu, 12 May 2005 00:47:45 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 33081282A1;
	Thu, 12 May 2005 00:47:47 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2853.10.10.10.24.1115850996.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 18:36 -0400, Sean wrote:
> On Wed, May 11, 2005 6:30 pm, Thomas Gleixner said:
> 
> > At this point it is completely irrelevant if you pulled from A or B. The
> > originator of Head A is A forever.
> 
> But who cares what repository was used to create the object?   You can't
> talk to a repository.   What you want to know is who created the object,
> and Author/Committer completely solves that problem.

Maybe you have missed the point, where one Committer holds more than one
repository. See davem/net-2.6 and davem/sparc-2.6. Not to talk of
Russell King's and Greg's multiple repositories.
The Author is irrelevant, because one Author sends patches to more than
one maintainer. Author _cannot_ be a source of tracking information. If
you want to do heuristic guesses on Author/Committer pairs, then you
make the situation more complex than it is already.

> If on the otherhand you're trying to reliably track the chain-of-command
> that landed the object in your repository, your patch falls short.

As I said before it is completely irrelevant whether fast forward was
pulled into C directly from A or from B. 

Whats the relevant content of getting the same thing from A or B ? 

If you want to do this, you break the fast forward mechanism and
reinvent the pull ping-pong which is avoided by the fast forwards.

tglx


