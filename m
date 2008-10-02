From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to remove a commit object?
Date: Thu, 02 Oct 2008 16:00:09 +0200
Message-ID: <48E4D3E9.8020906@drmicha.warpmail.net>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>	 <48D36DF4.3030607@drmicha.warpmail.net> <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:07:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOkB-0007sp-TX
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYJBOAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbYJBOAP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:00:15 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44577 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753026AbYJBOAO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 10:00:14 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 5A7FE17255F;
	Thu,  2 Oct 2008 10:00:13 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 02 Oct 2008 10:00:13 -0400
X-Sasl-enc: SkYklt6/dZtdWJbuRxg7r5AUykrm+/Vi9cCI1EYHmkvu 1222956012
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8CF3A2A6B8;
	Thu,  2 Oct 2008 10:00:12 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97333>

Klas Lindberg venit, vidit, dixit 02.10.2008 15:36:
> This doesn't seem to work for me. I will soon be in a situation where
> I need to selectively delete commits in such a way that they become
> completely irrecoverable. I.e. it is not enough to revert a commit.
> The *original* commit must be removed. And of course, the repo history
> is too complex to allow for rebasing followed by garbage collection or
> something like that.
> 
> The reason is that we consider opening a repository to external
> participants, but some commits contain stuff that we'd really rather
> not show to anyone else. Making the repository public without loosing
> history would then force us to either
> 
>  1. Recreate every commit in a new repo, sans the offending commits.
> Seems like hard work.
>  2. ?
> 
> Would it be feasible to write a tool that can selectively replace a
> specific commit in the commit DAG, or would that automatically
> invalidate every SHA key for every commit that follows the replaced
> original?

Yes, on the or part: If you change a commit then all commits "after"
that one (in terms of DAG connectedness) will need to be changed: each
contains a "backpointer" (to the parent commit(s)) which is changed.

I'm a bit confused: You rule out rebasing but don't mind recreating a
new repo. So repo size is not a problem, is it?

Michael
