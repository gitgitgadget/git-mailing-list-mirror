From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Deleting branches
Date: Fri, 26 Mar 2010 16:12:11 +0100
Message-ID: <4BACCECB.9040905@drmicha.warpmail.net>
References: <1269614480145-4804268.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 16:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBFg-0004Tz-80
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0CZPPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:15:04 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51822 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754168Ab0CZPPC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 11:15:02 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A57ADEA4AE;
	Fri, 26 Mar 2010 11:15:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 26 Mar 2010 11:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=S3NHCAYNzmvHwHsve7ZmyPQsPvg=; b=Yot0GwVKmUWxkPFia1J1j1HkpnLQmPsKbmMwmFXk34Z9WLpM/s3GQcrDCQVKH8pG2pJOQ6PUz+ExscW+qUeQJ+cJO3qrb5dKxbs/BQp9O2qltCuZHPg4WQ9Iwn8UN9UdOylIAKdFSy2uBc5fueteNxGA34qEWb8Kw2RJhTraLXQ=
X-Sasl-enc: R6/M8QtNOC25nMMUDHGzhnE9R0I2MxZ3XMLvgp2KQM/h 1269616501
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F01645C904;
	Fri, 26 Mar 2010 11:15:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <1269614480145-4804268.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143237>

jhapk venit, vidit, dixit 26.03.2010 15:41:
> 
> Hi,
> I wanted to see the all the branches of a remote repository and so in my
> .git/config file I had something like
> [remote "jeff"]
>         url = /nfs/kris/d1/people/jeff/cffc
>         fetch = +refs/heads/*:refs/remotes/jeff/*
> 
> But then I decided that I only need to see one particular_branch and I
> changed it to
> [remote "jeff"]
>         url = /nfs/kris/d1/people/jeff/cffc
>         fetch =
> +refs/heads/particular_branch:refs/remotes/jeff/particular_branch
> 
> But even now, when I do a $git branch -a, I see this
> [pradeep@scaramanga cffc]$ git branch -a
>   jeff
>   master
> * work
>   jeff/local
>   jeff/master
>   jeff/particular_branch
>   origin/HEAD
>   origin/master
>   origin/work
> 
> Why am I still getting the other jeff branches in my list

Because the config determines what is fetched, it does not delete
existing refs.

> and how do I
> delete them?
> THanks

git branch -Dr jeff/other_branch

Cheers,
Michael
