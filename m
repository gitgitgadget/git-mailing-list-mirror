From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 12:58:06 +0200
Message-ID: <4D945E3E.9010006@drmicha.warpmail.net>
References: <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <4D9454D9.6060406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 13:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5FdJ-0006eb-4L
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 13:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab1CaLBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 07:01:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34020 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757291Ab1CaLBh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 07:01:37 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E0377202C1;
	Thu, 31 Mar 2011 07:01:36 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 31 Mar 2011 07:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zAWvj2foQKjr9YBSjg/KyHr4Xik=; b=G5/FGlOx+hFi9xSf++kRl6vPncBn1Drad6Hg1QYyyuGXAjIk4btaN7Irwkfs7lWvyVi9ekuf1Kf2qs8EulGzKI2jETjymKeEQEuXJZBWXh5DPcHl15zg2WggacXg+492HwctBHImLzj+op/XugiuC2ClpFELYUCvGEa7DTtEHWk=
X-Sasl-enc: 6v8PMa4O3I59t0rUmt94oLxDUZnIzkwIIIrfzkGynSDy 1301569296
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 228E940498F;
	Thu, 31 Mar 2011 07:01:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9454D9.6060406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170467>

Johannes Sixt venit, vidit, dixit 31.03.2011 12:18:
> Am 3/31/2011 11:17, schrieb Michael J Gruber:
>> By design, "git show commit -- path" is not "git show commit:path", and
>> there is no reason to change that. But "git show commit -- path" simply
>> returns nothing at all "most of the time" because it prunes by pathspec
>> even though it does not walk commits. This is pretty useless.
>>
>> So, turn off pruning (but keep diff limiting of course) so that "git
>> show commit -- path" shows the commit message and the diff that the
>> commit introduces to path (filtered by path); only the diff will be
>> empty "most of the time".
> 
> How does this interfere with git show --walk commit -- path? Will it now
> show all commits instead of just those that changed path?

Hmpft,

git show --walk origin/master
fatal: unrecognized argument: --walk

No, that is without my patch ;)

In other words: "ENOPARSEOPTS in revision.c", there is no "--walk".

Michael
