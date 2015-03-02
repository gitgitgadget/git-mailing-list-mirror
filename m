From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Move commits not in origin to a branch
Date: Mon, 02 Mar 2015 15:54:25 +0100
Message-ID: <54F479A1.300@drmicha.warpmail.net>
References: <CAH_OBicENXL967L4LubDzrqq2qxuZSqye3o6SPAq6oKM0=94Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: shawn wilson <ag4ve.us@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 15:54:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSRk4-0005CL-N7
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 15:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbbCBOyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 09:54:35 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33256 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754674AbbCBOy2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 09:54:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id BDC7E209E9
	for <git@vger.kernel.org>; Mon,  2 Mar 2015 09:54:26 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 02 Mar 2015 09:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=v4A48udgWvp+tMbaesG/sV
	Iqer0=; b=Le4aaT25Lu89oA1Cj90G6nwkJNsA52uFOk5ig4zIGuwNepaVVpWVuh
	pR2Lz5+FbI/4AJL2Bzz/HI2ozc7JupbLH/RtR9P/JK9LVxEF+vtJzhkTahVivQfE
	d3F6t7IUGAlUd8dIux/JBHm9SMevUnp/h7JMXZ8m/JgxvYJvB2PSs=
X-Sasl-enc: Sl0sDkVBrRXWTXNRPdcYQGmOTHpmoMR9Z7Xeinp03wk/ 1425308066
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E77826801A2;
	Mon,  2 Mar 2015 09:54:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAH_OBicENXL967L4LubDzrqq2qxuZSqye3o6SPAq6oKM0=94Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264599>

shawn wilson venit, vidit, dixit 02.03.2015 14:25:
> How do I move commits I haven't pushed into a new branch?
> 
>  % git log origin..master --pretty=format:'%h'
> f7d3a19
> 1f186c9
> 66d99f6
> 
> Which I'd like to be in a new branch.
> 

Do you want them to be on the new branch as they are, i.e. as commits
built on top of master? Then

git branch mybranch master

will create a new branch "mybranch" which contains those commits. If you
want to "remove" them from master, then

git checkout master # unless you are there already
git reset --keep origin/master

to "rewind" master to commit "origin/master".

Michael
