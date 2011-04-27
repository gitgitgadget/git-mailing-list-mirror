From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] handle_alias: provide GIT_PREFIX to !alias
Date: Wed, 27 Apr 2011 11:36:28 +0200
Message-ID: <4DB7E39C.1040609@drmicha.warpmail.net>
References: <3422485b672000ecdc72d82ffce8c89f258831b9.1303893279.git.git@drmicha.warpmail.net> <4DB7CF72.3080205@drmicha.warpmail.net> <5058a9853a75bff71187f553e67632997761de44.1303893279.git.git@drmicha.warpmail.net> <BANLkTi=gjuOqLEArk_0Nj1faEu62dzjbZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matej Batic <matej.batic@ge.infn.it>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:36:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1Ak-0003JQ-S4
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab1D0Jgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 05:36:32 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55081 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756443Ab1D0Jgb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 05:36:31 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6EBCC20164;
	Wed, 27 Apr 2011 05:36:30 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 27 Apr 2011 05:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Z0e7h8KCFBSY8Sh2wg4QuqiBYOY=; b=aqo1lCbDPnVkMJQ6i6KRpgbE8vYzVX14vDSvhV+TzMpYvylFSKmqo8UJ6QjqMfkKsZa/rwsGRhqsvuKHibHBS6duuCu+9tb2XicrhjeOSvBGSPnjZrrsOXYfBdf1Y6w46+lLgFr5iEMsnDvrsYjYsMjBg3QRB4a3q7YrH5h36eo=
X-Sasl-enc: g+6dzzNFs+macPQ2ykAPZrB+JOq/81DZZ1OY9nKQ6QRP 1303896990
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B2404401720;
	Wed, 27 Apr 2011 05:36:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTi=gjuOqLEArk_0Nj1faEu62dzjbZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172206>

Nguyen Thai Ngoc Duy venit, vidit, dixit 27.04.2011 11:06:
> 2011/4/27 Michael J Gruber <git@drmicha.warpmail.net>:
>> @@ -589,6 +589,8 @@ it will be treated as a shell command.  For example, defining
>>  "gitk --all --not ORIG_HEAD".  Note that shell commands will be
>>  executed from the top-level directory of a repository, which may
>>  not necessarily be the current directory.
>> +'GIT_PREFIX' is set as returned by running 'git rev-parse --show-prefix'
>> +from the original current directory. See linkgit:git-rev-parse[1].
> 
> It made me wonder "but then why should not we just do GIT_PREFIX=`git
> rev-parse --show-prefix` in the alias?" then realized by the time we
> do that, it's already too late. Maybe
> 
>> +'GIT_PREFIX' is set as returned by running 'git rev-parse --show-prefix'
>> +before current directory is changed to top-level directory. See linkgit:git-rev-parse[1].
> 
> ?

Well, the text says already that the alias is not run from the "original
current directory", so it's two ways of saying the same thing.

Michael
