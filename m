From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 17:29:43 +0100
Message-ID: <4D7E4277.8040202@drmicha.warpmail.net>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box> <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com> <op.vsb95dilbl4hj1@metalltrottel.fritz.box> <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com> <op.vscae5mbbl4hj1@metalltrottel.fritz.box> <4D7E38C6.4010804@drmicha.warpmail.net> <op.vsccqtbobl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Franz Liedke <franz@develophp.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 17:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzAhu-0004II-8K
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 17:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab1CNQdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 12:33:16 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34596 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738Ab1CNQdP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 12:33:15 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9190920E27;
	Mon, 14 Mar 2011 12:33:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 14 Mar 2011 12:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=aS6CwzIgaqDIV9QeyMq3vvhyUlk=; b=RA9IfC5mM6pdDAw31zKWunn1wwcSa0qj03pj2zOPQDgUhDkAZrpSJq1HxFPaO2Hk66EWDxVNZSM4ZuxePT8Zm7X9vQPopq41JcIjNZxIN8vwjRVRfmtWh8o9jIBDZgK95r6EhkLtznX9UJywWa9VVzVlsXvPZyLyeaJR2oYHuPg=
X-Sasl-enc: nghzQ4Jc9OYaCUXSIIXA7uqzKPGvTxlS96knXQunNd7K 1300120395
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0328D448F64;
	Mon, 14 Mar 2011 12:33:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <op.vsccqtbobl4hj1@metalltrottel.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168998>

Franz Liedke venit, vidit, dixit 14.03.2011 17:14:
> Hey Michael,
> 
> in fact, I have been making commits both from the command line and from  
> SmartGit from time to time, and yes, they were both running.
> This has never been the problem before.
> 

I don't know how smartgit reacts when you switch the branch in git while
smartgit is running, for example.

> I ran some sort of cleanup tool yesterday, possibly about the time when  
> the problem started (I only noticed it today). Something along the lines  
> of 'git gc' maybe, if I remember correctly. Could that be the cause?

git gc does not do any evil as long as you're not accessing the repo
with another client at the same time.

So, have you lost any commits? Maybe something like

git log --graph --abbrev-commit --pretty=oneline --decorate --all

will give you a clearer picture of where your commits went. If they're
not there then inspecting the reflog of HEAD may help:

git log -g --abbrev-commit --pretty=oneline --decorate HEAD

Michael
