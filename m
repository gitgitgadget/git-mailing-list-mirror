From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 13:39:49 +0100
Message-ID: <4D5D1715.5020707@drmicha.warpmail.net>
References: <4D5CE3E7.5030101@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq3CK-0003hD-GW
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab1BQMm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:42:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35202 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755912Ab1BQMm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 07:42:58 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EC20220561;
	Thu, 17 Feb 2011 07:42:57 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 17 Feb 2011 07:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tB/l0KbbtR679INzspBl5NyNfsM=; b=lJLK8HFKcNku2cizxbYjORsiHgHLSjYS+cepBj6GbQ1zk/gXc+IExfPr1cPumwfAhaMqgFWvl5X2SG1xay8Oh53HM7LMxd6wECBwMGCj7D+AIB23Wc8GbcxBt4hGwClWIjReNcRhsV+6pxMWWXCQ7aIgn7BztqF1kwIzcD/Uw18=
X-Sasl-enc: 3RTJYvMbal6IeTvXYm/DEMeFs9qTaUBPgKn3scOQjjR3 1297946577
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1E5E544590F;
	Thu, 17 Feb 2011 07:42:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D5CE3E7.5030101@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167079>

Stefan Naewe venit, vidit, dixit 17.02.2011 10:01:
> Hi.
> 
> If I do:
> 
>  $ uname -a
> Linux as100897 2.6.26-2-686 #1 SMP Thu Nov 25 01:53:57 UTC 2010 i686 GNU/Linux
>  $ git version
> git version 1.7.4.1
>  $ ls -l NonExistentLocation
> ls: cannot access NonExistentLocation: No such file or directory
>  $ git clone NonExistentLocation
> Cloning into NonExistentLocation...
> warning: You appear to have cloned an empty repository.
>  $
> 
> I get a new (empty) git repository in 'NonExistentLocation':
> 
>  $ tree -a NonExistentLocation
> NonExistentLocation
> `-- .git
>     |-- HEAD
>     |-- branches
>     |-- config
>     |-- description
>     |-- hooks
>     |   |-- applypatch-msg.sample
>     |   |-- commit-msg.sample
>     |   |-- post-commit.sample
>     |   |-- post-receive.sample
>     |   |-- post-update.sample
>     |   |-- pre-applypatch.sample
>     |   |-- pre-commit.sample
>     |   |-- pre-rebase.sample
>     |   |-- prepare-commit-msg.sample
>     |   `-- update.sample
>     |-- info
>     |   `-- exclude
>     |-- objects
>     |   |-- info
>     |   `-- pack
>     `-- refs
>         |-- heads
>         `-- tags
> 
> 10 directories, 14 files
> 
> Is this the intended behaviour ?
> 
> Thanks,
>   Stefan

It is useful, and it even gives you a warning that it still might not be
what you intended. Would be funny if it were accidental. Indeed, a git
"log -S" on that warning reveals that it was introduced intentionally in

86ac751 (Allow cloning an empty repository, 2009-01-23)

Michael
