From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Correcting forgetting to make a new branch
Date: Fri, 11 Mar 2011 16:49:23 +0100
Message-ID: <4D7A4483.5080209@drmicha.warpmail.net>
References: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:53:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4eC-0000Nb-F7
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab1CKPwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:52:55 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:54210 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752730Ab1CKPwy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Mar 2011 10:52:54 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B898320BE4;
	Fri, 11 Mar 2011 10:52:53 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 11 Mar 2011 10:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iid/XSk4vyOy/VwEeF2Gth8wfG0=; b=dbRmS1BrZ4EgUIm9uhNFl/AdVMKyqeUpF16jsAMKYgqsC/ow10dRBsh1Jsv5s5LNb6a9iTDip3VhOBuwkbY+MwGbF/N2QD4qb1QELbka2H37LiRkqWPb8VZwX+vb0tTH5cH4BDGYoszhMDrVMjMXYlnJ0y0fLqGa+AxHna8CCN0=
X-Sasl-enc: L+gUm0VcWMhc4B6QP5l8MtIQFdG7K2hqW+3TexTCJVNV 1299858773
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 473BF4405E2;
	Fri, 11 Mar 2011 10:52:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168914>

Howard Miller venit, vidit, dixit 11.03.2011 16:31:
> The scenario is that I have done work on a branch and made a number of
> commits. What I wanted to do was to start a new branch before I made
> these commits. Unfortunatel, I got distracted and forgot that I hadn't
> done it.
> 
> Is there are neat way to create the branch and 'move' the commits over?

It depends on which commit you wanted the new branch to start with. If
you have

...-*-*-*-X-*-*-*-*-A

on branch A and X is the commit where you meant to create a new branch B
starting at X you can simply

git checkout A
git branch B
git reset --hard X

or simply

git branch -m A B
git branch -f A X

If, on the other hand, you wanted to start B from a different commit Y,
you will need to rebase:

git branch B A
git branch -f A X
git rebase --onto Y A B

After backing up, of course ;)

Michael
