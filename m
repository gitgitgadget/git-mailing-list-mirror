From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 13:59:55 +0100
Message-ID: <4D5D1BCB.3010003@drmicha.warpmail.net>
References: <4D5CE3E7.5030101@atlas-elektronik.com> <4D5D1715.5020707@drmicha.warpmail.net> <4D5D1A04.4090107@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 14:03:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq3Vo-0007YM-2M
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 14:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425Ab1BQNDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 08:03:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50651 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751759Ab1BQNDE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 08:03:04 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3B0FD20958;
	Thu, 17 Feb 2011 08:03:04 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Feb 2011 08:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1rl5h6YgO4/Z7OfEZ7hOUO5j3SE=; b=EFxUblxvyHIBd1G2rpCJ8tMAuqz5fgXqNdnH0Yk0/bo3VHZxBHnNoBU1oNEIhmngG/keRkvXzkXh8K/dGvLr5XHJJntKIOMuuDpoXZ3prRGzuxcR6xtZP/ohn65CH/unD3W3OwjHeD5nYY9Ms9wayFNUMqqyno1D56WabWhivUM=
X-Sasl-enc: 5DlruZkm/SY95S5XAi55sps2pM+n7kDvv4f1nXNr0A4c 1297947783
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9D44A409B8C;
	Thu, 17 Feb 2011 08:03:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D5D1A04.4090107@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167082>

Stefan Naewe venit, vidit, dixit 17.02.2011 13:52:
> On 2/17/2011 1:39 PM, Michael J Gruber wrote:
>>
>> It is useful, and it even gives you a warning that it still might not be
>> what you intended. Would be funny if it were accidental. Indeed, a git
>> "log -S" on that warning reveals that it was introduced intentionally in
>>
>> 86ac751 (Allow cloning an empty repository, 2009-01-23)
> 
> OK. But that's about 'cloning an empty repository'.
> 'NonExistentLocation' is not empty initially - it simply does
> not exist.
> 
> Contrast that to 'git clone http://url.does.not.exist'. You don't
> get an empty repository in 'url.does.not.exist' after running that.

OK, the transport layer errors out in that case.

Rereading Sverre's commit message, I'm still not sure whether this case
was intended or not. The test case covers existing empty repos only. So
I'm cc'ing him and holding back by documentation patch.

Sverre, with your 86ac751, the following two are equivalent (modulo a
warning) on a nonexisting dir:

git clone dir
git init dir

Is that intentional?

Michael
